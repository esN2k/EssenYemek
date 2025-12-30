import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:essen_yemek/app_state.dart';
import 'package:essen_yemek/backend/order_service.dart';
import 'package:essen_yemek/backend/schema/orders_record.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FFAppState.reset();
  });

  test('createOrderFromPlan writes order with computed price', () async {
    final firestore = FakeFirebaseFirestore();
    final userRef = firestore.collection('users').doc('user-1');
    final state = FFAppState();
    final mealRefs = List.generate(
      4,
      (index) => firestore.collection('meals').doc('meal-${index + 1}'),
    );

    state.planType = 'Dengeli';
    state.planMealsPerWeek = 4;
    state.planServings = 2;
    state.planDeliveryDay = 'Sal\u0131';
    state.planMeals = mealRefs;

    final orderRef = await OrderService.createOrderFromPlan(
      userRef: userRef,
      state: state,
      firestore: firestore,
    );

    final orderDoc = await orderRef.get();
    final order = OrdersRecord.fromSnapshot(orderDoc);

    expect(order.userId, 'user-1');
    expect(order.planType, 'Dengeli');
    expect(order.mealsCount, 4);
    expect(order.servings, 2);
    expect(order.price, 4 * 2 * OrderService.pricePerServing);
    expect(order.status, 'Haz\u0131rlan\u0131yor');
    expect(order.mealRefs.length, 4);
    expect(order.createdTime, isNotNull);
  });

  test('streamOrders returns newest order first', () async {
    final firestore = FakeFirebaseFirestore();
    final userRef = firestore.collection('users').doc('user-2');
    final now = DateTime(2025, 1, 10);
    final older = now.subtract(const Duration(days: 2));

    await firestore.collection('orders').add(
      createOrdersRecordData(
        userRef: userRef,
        userId: userRef.id,
        status: 'Teslim',
        createdTime: older,
        planType: 'Dengeli',
        mealsCount: 4,
        servings: 2,
        price: 632,
        deliveryDay: 'Sal\u0131',
        mealRefs: const [],
      ),
    );
    await firestore.collection('orders').add(
      createOrdersRecordData(
        userRef: userRef,
        userId: userRef.id,
        status: 'Yolda',
        createdTime: now,
        planType: 'Dengeli',
        mealsCount: 5,
        servings: 2,
        price: 790,
        deliveryDay: 'Sal\u0131',
        mealRefs: const [],
      ),
    );

    final orders = await OrderService.streamOrders(
      userRef,
      firestore: firestore,
    ).first;

    expect(orders.length, 2);
    expect(orders.first.createdTime, now);
  });
}
