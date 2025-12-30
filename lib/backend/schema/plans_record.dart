import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlansRecord extends FirestoreRecord {
  PlansRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "user_ref" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "plan_type" field.
  String? _planType;
  String get planType => _planType ?? '';
  bool hasPlanType() => _planType != null;

  // "meals_per_week" field.
  int? _mealsPerWeek;
  int get mealsPerWeek => _mealsPerWeek ?? 0;
  bool hasMealsPerWeek() => _mealsPerWeek != null;

  // "servings" field.
  int? _servings;
  int get servings => _servings ?? 0;
  bool hasServings() => _servings != null;

  // "delivery_day" field.
  String? _deliveryDay;
  String get deliveryDay => _deliveryDay ?? '';
  bool hasDeliveryDay() => _deliveryDay != null;

  // "meal_refs" field.
  List<DocumentReference>? _mealRefs;
  List<DocumentReference> get mealRefs => _mealRefs ?? const [];
  bool hasMealRefs() => _mealRefs != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "updated_time" field.
  DateTime? _updatedTime;
  DateTime? get updatedTime => _updatedTime;
  bool hasUpdatedTime() => _updatedTime != null;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _userId = snapshotData['user_id'] as String?;
    _planType = snapshotData['plan_type'] as String?;
    _mealsPerWeek = castToType<int>(snapshotData['meals_per_week']);
    _servings = castToType<int>(snapshotData['servings']);
    _deliveryDay = snapshotData['delivery_day'] as String?;
    _mealRefs = getDataList(snapshotData['meal_refs']);
    _createdTime = snapshotData['created_time'] as DateTime?;
    _updatedTime = snapshotData['updated_time'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('plans');

  static Stream<PlansRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlansRecord.fromSnapshot(s));

  static Future<PlansRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlansRecord.fromSnapshot(s));

  static PlansRecord fromSnapshot(DocumentSnapshot snapshot) => PlansRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlansRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlansRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlansRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlansRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlansRecordData({
  DocumentReference? userRef,
  String? userId,
  String? planType,
  int? mealsPerWeek,
  int? servings,
  String? deliveryDay,
  DateTime? createdTime,
  DateTime? updatedTime,
  List<DocumentReference>? mealRefs,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'user_id': userId,
      'plan_type': planType,
      'meals_per_week': mealsPerWeek,
      'servings': servings,
      'delivery_day': deliveryDay,
      'created_time': createdTime,
      'updated_time': updatedTime,
      'meal_refs': mealRefs,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlansRecordDocumentEquality implements Equality<PlansRecord> {
  const PlansRecordDocumentEquality();

  @override
  bool equals(PlansRecord? e1, PlansRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userRef == e2?.userRef &&
        e1?.userId == e2?.userId &&
        e1?.planType == e2?.planType &&
        e1?.mealsPerWeek == e2?.mealsPerWeek &&
        e1?.servings == e2?.servings &&
        e1?.deliveryDay == e2?.deliveryDay &&
        listEquality.equals(e1?.mealRefs, e2?.mealRefs) &&
        e1?.createdTime == e2?.createdTime &&
        e1?.updatedTime == e2?.updatedTime;
  }

  @override
  int hash(PlansRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.userId,
        e?.planType,
        e?.mealsPerWeek,
        e?.servings,
        e?.deliveryDay,
        e?.mealRefs,
        e?.createdTime,
        e?.updatedTime
      ]);

  @override
  bool isValidKey(Object? o) => o is PlansRecord;
}
