import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlanService {
  static const String defaultPlanType = 'Dengeli';
  static const int defaultMealsPerWeek = 4;
  static const int defaultServings = 2;
  static const String defaultDeliveryDay = 'Sal\u0131';

  static DocumentReference<Map<String, dynamic>> planDocRef(
    DocumentReference userRef, {
    FirebaseFirestore? firestore,
  }) {
    final db = firestore ?? FirebaseFirestore.instance;
    return db.collection('plans').doc(userRef.id);
  }

  static Stream<PlansRecord?> streamPlan(
    DocumentReference userRef, {
    FirebaseFirestore? firestore,
  }) {
    return planDocRef(userRef, firestore: firestore).snapshots().map(
          (doc) => doc.exists ? PlansRecord.fromSnapshot(doc) : null,
        );
  }

  static Future<PlansRecord?> fetchPlan(
    DocumentReference userRef, {
    FirebaseFirestore? firestore,
  }) async {
    final doc = await planDocRef(userRef, firestore: firestore).get();
    if (!doc.exists) {
      return null;
    }
    return PlansRecord.fromSnapshot(doc);
  }

  static Future<void> ensurePlan(
    DocumentReference userRef, {
    FirebaseFirestore? firestore,
  }) async {
    final ref = planDocRef(userRef, firestore: firestore);
    final doc = await ref.get();
    if (doc.exists) {
      return;
    }
    await ref.set(
      createPlansRecordData(
        userRef: userRef,
        userId: userRef.id,
        planType: defaultPlanType,
        mealsPerWeek: defaultMealsPerWeek,
        servings: defaultServings,
        deliveryDay: defaultDeliveryDay,
        mealRefs: const [],
        createdTime: getCurrentTimestamp,
        updatedTime: getCurrentTimestamp,
      ),
    );
  }

  static Future<void> savePlanFromState({
    required FFAppState state,
    required DocumentReference userRef,
    FirebaseFirestore? firestore,
  }) async {
    final ref = planDocRef(userRef, firestore: firestore);
    final doc = await ref.get();
    final trimmedMeals = state.planMeals
        .take(state.planMealsPerWeek)
        .toList(growable: false);
    if (trimmedMeals.length != state.planMeals.length) {
      state.update(() {
        state.planMeals = trimmedMeals;
      });
    }
    final data = createPlansRecordData(
      userRef: userRef,
      userId: userRef.id,
      planType: state.planType,
      mealsPerWeek: state.planMealsPerWeek,
      servings: state.planServings,
      deliveryDay: state.planDeliveryDay,
      mealRefs: trimmedMeals,
      createdTime: doc.exists ? null : getCurrentTimestamp,
      updatedTime: getCurrentTimestamp,
    );
    await ref.set(data, SetOptions(merge: true));
  }

  static void applyPlanToState({
    required FFAppState state,
    required PlansRecord plan,
  }) {
    state.update(() {
      state.planType = plan.planType.isNotEmpty
          ? plan.planType
          : defaultPlanType;
      state.planMealsPerWeek = plan.mealsPerWeek != 0
          ? plan.mealsPerWeek
          : defaultMealsPerWeek;
      state.planServings = plan.servings != 0 ? plan.servings : defaultServings;
      state.planDeliveryDay = plan.deliveryDay.isNotEmpty
          ? plan.deliveryDay
          : defaultDeliveryDay;
      state.planMeals = plan.mealRefs;
    });
  }

  static void clearPlanState(FFAppState state) {
    state.update(state.clearPlanData);
  }

  static DateTime nextDeliveryDate(String dayName) {
    final now = DateTime.now();
    final targetWeekday = _weekdayFromName(dayName);
    var daysAhead = (targetWeekday - now.weekday) % 7;
    if (daysAhead == 0) {
      daysAhead = 7;
    }
    return now.add(Duration(days: daysAhead));
  }

  static int _weekdayFromName(String dayName) {
    switch (dayName) {
      case 'Pazartesi':
        return DateTime.monday;
      case 'Sal\u0131':
        return DateTime.tuesday;
      case '\u00c7ar\u015famba':
        return DateTime.wednesday;
      case 'Per\u015fembe':
        return DateTime.thursday;
      case 'Cuma':
        return DateTime.friday;
      case 'Cumartesi':
        return DateTime.saturday;
      case 'Pazar':
        return DateTime.sunday;
      default:
        return DateTime.tuesday;
    }
  }

  static Future<void> seedSamplePlan({
    required DocumentReference userRef,
    FirebaseFirestore? firestore,
  }) async {
    final db = firestore ?? FirebaseFirestore.instance;
    final mealsSnapshot =
        await db.collection('meals').limit(defaultMealsPerWeek).get();
    final mealRefs = mealsSnapshot.docs.map((doc) => doc.reference).toList();
    await planDocRef(userRef, firestore: db).set(
      createPlansRecordData(
        userRef: userRef,
        userId: userRef.id,
        planType: defaultPlanType,
        mealsPerWeek: mealRefs.isNotEmpty ? mealRefs.length : defaultMealsPerWeek,
        servings: defaultServings,
        deliveryDay: defaultDeliveryDay,
        mealRefs: mealRefs,
        createdTime: getCurrentTimestamp,
        updatedTime: getCurrentTimestamp,
      ),
      SetOptions(merge: true),
    );
  }
}
