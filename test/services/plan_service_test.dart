import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:essen_yemek/app_state.dart';
import 'package:essen_yemek/backend/plan_service.dart';
import 'package:essen_yemek/backend/schema/plans_record.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    FFAppState.reset();
  });

  test('ensurePlan creates a default plan document', () async {
    final firestore = FakeFirebaseFirestore();
    final userRef = firestore.collection('users').doc('user-1');

    await PlanService.ensurePlan(userRef, firestore: firestore);

    final plan = await PlanService.fetchPlan(userRef, firestore: firestore);
    expect(plan, isNotNull);
    expect(plan!.userId, 'user-1');
    expect(plan.planType, PlanService.defaultPlanType);
    expect(plan.mealsPerWeek, PlanService.defaultMealsPerWeek);
    expect(plan.servings, PlanService.defaultServings);
    expect(plan.deliveryDay, PlanService.defaultDeliveryDay);
  });

  test('savePlanFromState trims meals and persists values', () async {
    final firestore = FakeFirebaseFirestore();
    final userRef = firestore.collection('users').doc('user-2');
    final state = FFAppState();
    final mealRefs = List.generate(
      6,
      (index) => firestore.collection('meals').doc('meal-${index + 1}'),
    );

    state.planType = 'Fit';
    state.planMealsPerWeek = 4;
    state.planServings = 2;
    state.planDeliveryDay = 'Cuma';
    state.planMeals = mealRefs;

    await PlanService.savePlanFromState(
      state: state,
      userRef: userRef,
      firestore: firestore,
    );

    expect(state.planMeals.length, 4);

    final plan = await PlanService.fetchPlan(userRef, firestore: firestore);
    expect(plan, isNotNull);
    expect(plan!.planType, 'Fit');
    expect(plan.mealsPerWeek, 4);
    expect(plan.servings, 2);
    expect(plan.deliveryDay, 'Cuma');
    expect(plan.mealRefs.length, 4);
  });

  test('applyPlanToState hydrates app state', () {
    final firestore = FakeFirebaseFirestore();
    final planRef = firestore.collection('plans').doc('user-3');
    final mealRefs = [
      firestore.collection('meals').doc('meal-a'),
    ];

    final plan = PlansRecord.getDocumentFromData(
      {
        'plan_type': 'Vegan',
        'meals_per_week': 3,
        'servings': 1,
        'delivery_day': 'Pazar',
        'meal_refs': mealRefs,
      },
      planRef,
    );

    final state = FFAppState();
    PlanService.applyPlanToState(state: state, plan: plan);

    expect(state.planType, 'Vegan');
    expect(state.planMealsPerWeek, 3);
    expect(state.planServings, 1);
    expect(state.planDeliveryDay, 'Pazar');
    expect(state.planMeals, mealRefs);
  });
}
