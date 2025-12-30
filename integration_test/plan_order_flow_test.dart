import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:essen_yemek/app_state.dart';
import 'package:essen_yemek/backend/order_service.dart';
import 'package:essen_yemek/backend/plan_service.dart';
import 'package:essen_yemek/backend/schema/orders_record.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Plan save and order creation flow', (tester) async {
    FFAppState.reset();
    final firestore = FakeFirebaseFirestore();
    final userRef = firestore.collection('users').doc('user-flow');
    final state = FFAppState();
    final mealRefs = List.generate(
      3,
      (index) => firestore.collection('meals').doc('meal-${index + 1}'),
    );

    state.planType = 'Dengeli';
    state.planMealsPerWeek = 3;
    state.planServings = 2;
    state.planDeliveryDay = 'Sali';
    state.planMeals = mealRefs;

    await PlanService.savePlanFromState(
      state: state,
      userRef: userRef,
      firestore: firestore,
    );

    final plan = await PlanService.fetchPlan(userRef, firestore: firestore);
    expect(plan, isNotNull);
    expect(plan!.mealRefs.length, 3);

    final orderRef = await OrderService.createOrderFromPlan(
      userRef: userRef,
      state: state,
      firestore: firestore,
    );

    final orderDoc = await orderRef.get();
    final order = OrdersRecord.fromSnapshot(orderDoc);
    expect(order.mealsCount, 3);
    expect(order.servings, 2);
    expect(order.price, 3 * 2 * OrderService.pricePerServing);
  });
}
