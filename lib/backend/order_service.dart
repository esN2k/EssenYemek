import '/backend/backend.dart';
import '/backend/plan_service.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderService {
  static const int pricePerServing = 79;

  static CollectionReference<Map<String, dynamic>> ordersCollection({
    FirebaseFirestore? firestore,
  }) {
    final db = firestore ?? FirebaseFirestore.instance;
    return db.collection('orders');
  }

  static Stream<List<OrdersRecord>> streamOrders(
    DocumentReference userRef, {
    FirebaseFirestore? firestore,
  }) {
    return ordersCollection(firestore: firestore)
        .where('user_ref', isEqualTo: userRef)
        .orderBy('created_time', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrdersRecord.fromSnapshot(doc)).toList());
  }

  static Future<List<OrdersRecord>> fetchOrders(
    DocumentReference userRef, {
    FirebaseFirestore? firestore,
  }) async {
    final snapshot = await ordersCollection(firestore: firestore)
        .where('user_ref', isEqualTo: userRef)
        .orderBy('created_time', descending: true)
        .get();
    return snapshot.docs.map((doc) => OrdersRecord.fromSnapshot(doc)).toList();
  }

  static Future<DocumentReference> createOrderFromPlan({
    required DocumentReference userRef,
    required FFAppState state,
    FirebaseFirestore? firestore,
  }) async {
    final db = firestore ?? FirebaseFirestore.instance;
    final ref = ordersCollection(firestore: db).doc();
    final mealRefs = state.planMeals
        .take(state.planMealsPerWeek)
        .toList(growable: false);
    final eta = PlanService.nextDeliveryDate(state.planDeliveryDay);
    final price = state.planMealsPerWeek * state.planServings * pricePerServing;
    await ref.set(
      createOrdersRecordData(
        userRef: userRef,
        userId: userRef.id,
        status: 'Haz\u0131rlan\u0131yor',
        eta: eta,
        createdTime: getCurrentTimestamp,
        planType: state.planType,
        mealsCount: state.planMealsPerWeek,
        servings: state.planServings,
        price: price,
        deliveryDay: state.planDeliveryDay,
        mealRefs: mealRefs,
      ),
    );
    return ref;
  }

  static Future<void> seedSampleOrders({
    required DocumentReference userRef,
    FirebaseFirestore? firestore,
  }) async {
    final db = firestore ?? FirebaseFirestore.instance;
    final now = DateTime.now();
    await ordersCollection(firestore: db).add(
      createOrdersRecordData(
        userRef: userRef,
        userId: userRef.id,
        status: 'Yolda',
        eta: now.add(const Duration(days: 1)),
        createdTime: now,
        planType: PlanService.defaultPlanType,
        mealsCount: 4,
        servings: 2,
        price: 632,
        deliveryDay: PlanService.defaultDeliveryDay,
        mealRefs: const [],
      ),
    );
    await ordersCollection(firestore: db).add(
      createOrdersRecordData(
        userRef: userRef,
        userId: userRef.id,
        status: 'Teslim',
        eta: now.subtract(const Duration(days: 6)),
        createdTime: now.subtract(const Duration(days: 7)),
        planType: PlanService.defaultPlanType,
        mealsCount: 5,
        servings: 2,
        price: 790,
        deliveryDay: PlanService.defaultDeliveryDay,
        mealRefs: const [],
      ),
    );
  }
}
