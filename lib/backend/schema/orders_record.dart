import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrdersRecord extends FirestoreRecord {
  OrdersRecord._(
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

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "eta" field.
  DateTime? _eta;
  DateTime? get eta => _eta;
  bool hasEta() => _eta != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "plan_type" field.
  String? _planType;
  String get planType => _planType ?? '';
  bool hasPlanType() => _planType != null;

  // "meals_count" field.
  int? _mealsCount;
  int get mealsCount => _mealsCount ?? 0;
  bool hasMealsCount() => _mealsCount != null;

  // "servings" field.
  int? _servings;
  int get servings => _servings ?? 0;
  bool hasServings() => _servings != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "delivery_day" field.
  String? _deliveryDay;
  String get deliveryDay => _deliveryDay ?? '';
  bool hasDeliveryDay() => _deliveryDay != null;

  // "meal_refs" field.
  List<DocumentReference>? _mealRefs;
  List<DocumentReference> get mealRefs => _mealRefs ?? const [];
  bool hasMealRefs() => _mealRefs != null;

  void _initializeFields() {
    _userRef = snapshotData['user_ref'] as DocumentReference?;
    _userId = snapshotData['user_id'] as String?;
    _status = snapshotData['status'] as String?;
    _eta = snapshotData['eta'] as DateTime?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _planType = snapshotData['plan_type'] as String?;
    _mealsCount = castToType<int>(snapshotData['meals_count']);
    _servings = castToType<int>(snapshotData['servings']);
    _price = castToType<int>(snapshotData['price']);
    _deliveryDay = snapshotData['delivery_day'] as String?;
    _mealRefs = getDataList(snapshotData['meal_refs']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OrdersRecord.fromSnapshot(s));

  static Future<OrdersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OrdersRecord.fromSnapshot(s));

  static OrdersRecord fromSnapshot(DocumentSnapshot snapshot) => OrdersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OrdersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OrdersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OrdersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OrdersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOrdersRecordData({
  DocumentReference? userRef,
  String? userId,
  String? status,
  DateTime? eta,
  DateTime? createdTime,
  String? planType,
  int? mealsCount,
  int? servings,
  int? price,
  String? deliveryDay,
  List<DocumentReference>? mealRefs,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user_ref': userRef,
      'user_id': userId,
      'status': status,
      'eta': eta,
      'created_time': createdTime,
      'plan_type': planType,
      'meals_count': mealsCount,
      'servings': servings,
      'price': price,
      'delivery_day': deliveryDay,
      'meal_refs': mealRefs,
    }.withoutNulls,
  );

  return firestoreData;
}

class OrdersRecordDocumentEquality implements Equality<OrdersRecord> {
  const OrdersRecordDocumentEquality();

  @override
  bool equals(OrdersRecord? e1, OrdersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userRef == e2?.userRef &&
        e1?.userId == e2?.userId &&
        e1?.status == e2?.status &&
        e1?.eta == e2?.eta &&
        e1?.createdTime == e2?.createdTime &&
        e1?.planType == e2?.planType &&
        e1?.mealsCount == e2?.mealsCount &&
        e1?.servings == e2?.servings &&
        e1?.price == e2?.price &&
        e1?.deliveryDay == e2?.deliveryDay &&
        listEquality.equals(e1?.mealRefs, e2?.mealRefs);
  }

  @override
  int hash(OrdersRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.userId,
        e?.status,
        e?.eta,
        e?.createdTime,
        e?.planType,
        e?.mealsCount,
        e?.servings,
        e?.price,
        e?.deliveryDay,
        e?.mealRefs
      ]);

  @override
  bool isValidKey(Object? o) => o is OrdersRecord;
}
