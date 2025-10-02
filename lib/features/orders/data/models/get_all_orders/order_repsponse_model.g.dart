// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_repsponse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersResponseModel _$OrdersResponseModelFromJson(Map<String, dynamic> json) =>
    OrdersResponseModel(
      deliveryOrders:
          (json['delivery_orders'] as List<dynamic>?)
              ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      tableOrders:
          (json['table_orders'] as List<dynamic>?)
              ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      selfOrders:
          (json['self_orders'] as List<dynamic>?)
              ?.map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$OrdersResponseModelToJson(
  OrdersResponseModel instance,
) => <String, dynamic>{
  'delivery_orders': instance.deliveryOrders?.map((e) => e.toJson()).toList(),
  'table_orders': instance.tableOrders?.map((e) => e.toJson()).toList(),
  'self_orders': instance.selfOrders?.map((e) => e.toJson()).toList(),
};

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  id: (json['id'] as num?)?.toInt(),
  address: json['address'] as String?,
  tableNumber: json['table_number'] as String?,
  note: json['note'] as String?,
  itemNumber: (json['item_number'] as num?)?.toInt(),
  totalPrice: (json['total_price'] as num?)?.toInt(),
  accepted: (json['accepted'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  user:
      json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
  coupon:
      json['coupon'] == null
          ? null
          : CouponModel.fromJson(json['coupon'] as Map<String, dynamic>),
  deliveryItems:
      (json['deliveryorderitem'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  tableItems:
      (json['tableorderitem'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  selfItems:
      (json['selforderitem'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$OrderModelToJson(
  OrderModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'address': instance.address,
  'table_number': instance.tableNumber,
  'note': instance.note,
  'item_number': instance.itemNumber,
  'total_price': instance.totalPrice,
  'accepted': instance.accepted,
  'created_at': instance.createdAt,
  'user': instance.user?.toJson(),
  'coupon': instance.coupon?.toJson(),
  'deliveryorderitem': instance.deliveryItems?.map((e) => e.toJson()).toList(),
  'tableorderitem': instance.tableItems?.map((e) => e.toJson()).toList(),
  'selforderitem': instance.selfItems?.map((e) => e.toJson()).toList(),
};

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num?)?.toInt(),
  fullname: json['fullname'] as String?,
  phonenumber: json['phonenumber'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'fullname': instance.fullname,
  'phonenumber': instance.phonenumber,
};

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: (json['id'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toInt(),
      extra: (json['extra'] as num?)?.toInt(),
      type:
          json['type'] == null
              ? null
              : TypeModel.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'price': instance.price,
      'extra': instance.extra,
      'type': instance.type?.toJson(),
    };

TypeModel _$TypeModelFromJson(Map<String, dynamic> json) => TypeModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  meal:
      json['meal'] == null
          ? null
          : MealModel.fromJson(json['meal'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TypeModelToJson(TypeModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'meal': instance.meal?.toJson(),
};

MealModel _$MealModelFromJson(Map<String, dynamic> json) =>
    MealModel(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) => CouponModel(
  id: (json['id'] as num?)?.toInt(),
  code: json['code'] as String?,
  value: json['value'] as String?,
  minOrder: json['min_order'] as String?,
  expiresAt: json['expires_at'] as String?,
);

Map<String, dynamic> _$CouponModelToJson(CouponModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'value': instance.value,
      'min_order': instance.minOrder,
      'expires_at': instance.expiresAt,
    };
