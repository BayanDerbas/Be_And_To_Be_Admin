import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/get_all_orders/orders_entity.dart';

part 'order_repsponse_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrdersResponseModel {
  @JsonKey(name: "delivery_orders")
  final List<OrderModel>? deliveryOrders;

  @JsonKey(name: "table_orders")
  final List<OrderModel>? tableOrders;

  @JsonKey(name: "self_orders")
  final List<OrderModel>? selfOrders;

  const OrdersResponseModel({
    this.deliveryOrders,
    this.tableOrders,
    this.selfOrders,
  });

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseModelToJson(this);

  OrdersResponseEntity toEntity() => OrdersResponseEntity(
    deliveryOrders: deliveryOrders?.map((e) => e.toEntity()).toList(),
    tableOrders: tableOrders?.map((e) => e.toEntity()).toList(),
    selfOrders: selfOrders?.map((e) => e.toEntity()).toList(),
  );
}

@JsonSerializable(explicitToJson: true)
class OrderModel {
  final int? id;
  final String? address;
  @JsonKey(name: "table_number") final String? tableNumber;
  final String? note;
  @JsonKey(name: "item_number") final int? itemNumber;
  @JsonKey(name: "total_price") final int? totalPrice;
  final int? accepted;
  @JsonKey(name: "created_at") final String? createdAt;

  final UserModel? user;
  final CouponModel? coupon;

  @JsonKey(name: "deliveryorderitem")
  final List<OrderItemModel>? deliveryItems;

  @JsonKey(name: "tableorderitem")
  final List<OrderItemModel>? tableItems;

  @JsonKey(name: "selforderitem")
  final List<OrderItemModel>? selfItems;

  const OrderModel({
    this.id,
    this.address,
    this.tableNumber,
    this.note,
    this.itemNumber,
    this.totalPrice,
    this.accepted,
    this.createdAt,
    this.user,
    this.coupon,
    this.deliveryItems,
    this.tableItems,
    this.selfItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  OrderEntity toEntity() => OrderEntity(
    id: id,
    address: address,
    tableNumber: tableNumber,
    note: note,
    itemNumber: itemNumber,
    totalPrice: totalPrice,
    accepted: accepted,
    createdAt: createdAt,
    user: user?.toEntity(),
    coupon: coupon?.toEntity(),
    items: deliveryItems?.map((e) => e.toEntity()).toList() ??
        tableItems?.map((e) => e.toEntity()).toList() ??
        selfItems?.map((e) => e.toEntity()).toList(),
  );
}

@JsonSerializable()
class UserModel {
  final int? id;
  final String? fullname;
  final String? phonenumber;

  const UserModel({this.id, this.fullname, this.phonenumber});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserEntity toEntity() =>
      UserEntity(id: id, fullname: fullname, phonenumber: phonenumber);
}

@JsonSerializable(explicitToJson: true)
class OrderItemModel {
  final int? id;
  final int? amount;
  final int? price;
  final int? extra;

  @JsonKey(name: 'type')
  final TypeModel? type;

  const OrderItemModel({this.id, this.amount, this.price, this.extra, this.type});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItemEntity toEntity() => OrderItemEntity(
    id: id,
    amount: amount,
    price: price,
    extra: extra,
    mealName: type?.meal?.name,
    typeName: type?.name,
  );
}

@JsonSerializable(explicitToJson: true)
class TypeModel {
  final int? id;
  final String? name;
  final MealModel? meal;

  const TypeModel({this.id, this.name, this.meal});

  factory TypeModel.fromJson(Map<String, dynamic> json) =>
      _$TypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TypeModelToJson(this);
}

@JsonSerializable()
class MealModel {
  final int? id;
  final String? name;

  const MealModel({this.id, this.name});

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  Map<String, dynamic> toJson() => _$MealModelToJson(this);
}

@JsonSerializable()
class CouponModel {
  final int? id;
  final String? code;
  final String? value;
  @JsonKey(name: "min_order") final String? minOrder;
  @JsonKey(name: "expires_at") final String? expiresAt;

  const CouponModel({this.id, this.code, this.value, this.minOrder, this.expiresAt});

  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  Map<String, dynamic> toJson() => _$CouponModelToJson(this);

  CouponEntity toEntity() => CouponEntity(
    id: id,
    code: code,
    value: value,
    minOrder: minOrder,
    expiresAt: expiresAt,
  );
}

// @JsonSerializable(explicitToJson: true)
// class OrdersResponseModel {
//   @JsonKey(name: 'delivery_orders', defaultValue: [])
//   final List<OrderModel> deliveryOrders;
//
//   @JsonKey(name: 'table_orders', defaultValue: [])
//   final List<OrderModel> tableOrders;
//
//   @JsonKey(name: 'self_orders', defaultValue: [])
//   final List<OrderModel> selfOrders;
//
//   OrdersResponseModel({
//     required this.deliveryOrders,
//     required this.tableOrders,
//     required this.selfOrders,
//   });
//
//   factory OrdersResponseModel.fromJson(Map<String, dynamic> json) =>
//       _$OrdersResponseModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OrdersResponseModelToJson(this);
// }
//
// @JsonSerializable(explicitToJson: true)
// class OrderModel extends OrderEntity {
//   @override
//   final int? id;
//
//   @override
//   final String? address;
//
//   @JsonKey(name: 'table_number')
//   @override
//   final String? tableNumber;
//
//   @override
//   final String? note;
//
//   @JsonKey(name: 'item_number')
//   @override
//   final int? itemNumber;
//
//   @JsonKey(name: 'total_price', fromJson: _totalPriceFromJson)
//   @override
//   final int? totalPrice;
//
//   @override
//   final int? accepted;
//
//   @JsonKey(name: 'created_at')
//   @override
//   final String? createdAt;
//
//   @override
//   final UserModel? user;
//
//   @JsonKey(name: 'deliveryorderitem', defaultValue: [])
//   final List<OrderItemModel> deliveryItems;
//
//   @JsonKey(name: 'tableorderitem', defaultValue: [])
//   final List<OrderItemModel> tableItems;
//
//   @JsonKey(name: 'selforderitem', defaultValue: [])
//   final List<OrderItemModel> selfItems;
//
//   @override
//   List<OrderItemModel> get items =>
//       deliveryItems.isNotEmpty
//           ? deliveryItems
//           : tableItems.isNotEmpty
//           ? tableItems
//           : selfItems;
//
//   @override
//   final CouponModel? coupon;
//
//   OrderModel({
//     this.id,
//     this.address,
//     this.tableNumber,
//     this.note,
//     this.itemNumber,
//     this.totalPrice,
//     this.accepted,
//     this.createdAt,
//     this.user,
//     this.deliveryItems = const [],
//     this.tableItems = const [],
//     this.selfItems = const [],
//     this.coupon,
//   }) : super(
//     id: id,
//     address: address,
//     tableNumber: tableNumber,
//     note: note,
//     itemNumber: itemNumber,
//     totalPrice: totalPrice,
//     accepted: accepted,
//     createdAt: createdAt,
//     user: user,
//     items: deliveryItems.isNotEmpty
//         ? deliveryItems
//         : tableItems.isNotEmpty
//         ? tableItems
//         : selfItems,
//     coupon: coupon,
//   );
//
//   factory OrderModel.fromJson(Map<String, dynamic> json) =>
//       _$OrderModelFromJson(json);
//
//   static int _totalPriceFromJson(dynamic value) {
//     if (value is num) return value.toInt();
//     if (value is String) return int.tryParse(value) ?? 0;
//     return 0;
//   }
//
//   Map<String, dynamic> toJson() => _$OrderModelToJson(this);
// }
//
// @JsonSerializable()
// class OrderItemModel extends OrderItemEntity {
//   @override
//   @JsonKey(defaultValue: 0)
//   final int id;
//
//   @override
//   @JsonKey(defaultValue: 0)
//   final int? amount;
//
//   @JsonKey(fromJson: _priceFromJson)
//   @override
//   final int? price;
//
//   @JsonKey(name: 'mealName', defaultValue: '')
//   @override
//   final String? mealName;
//
//   @JsonKey(name: 'typeName', defaultValue: '')
//   @override
//   final String? typeName;
//
//   @JsonKey(defaultValue: 0)
//   @override
//   final int? extra;
//
//   const OrderItemModel({
//     required this.id,
//     required this.amount,
//     required this.price,
//     required this.mealName,
//     required this.typeName,
//     required this.extra,
//   }) : super(
//     id: id,
//     amount: amount,
//     price: price,
//     mealName: mealName,
//     typeName: typeName,
//     extra: extra,
//   );
//
//   // دالة fromJson مخصصة لتطبيق null safety على الـ nested objects (type و meal)
//   factory OrderItemModel.fromJson(Map<String, dynamic> json) => _$OrderItemModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
//
//   // دالة مخصصة لتحويل الـ price إلى int
//   static int _priceFromJson(dynamic value) {
//     if (value is num) return value.toInt();
//     if (value is String) return int.tryParse(value) ?? 0;
//     return 0;
//   }
// }
//
// // 3. UserModel
// @JsonSerializable()
// class UserModel extends UserEntity {
//   @override
//   @JsonKey(defaultValue: 0)
//   final int id;
//
//   @JsonKey(defaultValue: '')
//   @override
//   final String? fullname;
//
//   @JsonKey(defaultValue: '')
//   @override
//   final String? phonenumber;
//
//   const UserModel({
//     required this.id,
//     required this.fullname,
//     required this.phonenumber,
//   }) : super(id: id, fullname: fullname, phonenumber: phonenumber);
//
//   factory UserModel.fromJson(Map<String, dynamic> json) =>
//       _$UserModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserModelToJson(this);
// }
//
// // 4. CouponModel
// @JsonSerializable()
// class CouponModel extends CouponEntity {
//   @override
//   @JsonKey(defaultValue: 0)
//   final int id;
//
//   @JsonKey(defaultValue: '')
//   @override
//   final String? code;
//
//   @JsonKey(defaultValue: '')
//   @override
//   final String? value;
//
//   @JsonKey(name: 'min_order', defaultValue: '')
//   @override
//   final String? minOrder;
//
//   @JsonKey(name: 'expires_at', defaultValue: '')
//   @override
//   final String expiresAt;
//
//   const CouponModel({
//     required this.id,
//     required this.code,
//     required this.value,
//     required this.minOrder,
//     required this.expiresAt,
//   }) : super(
//     id: id,
//     code: code,
//     value: value,
//     minOrder: minOrder,
//     expiresAt: expiresAt,
//   );
//
//   factory CouponModel.fromJson(Map<String, dynamic> json) =>
//       _$CouponModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CouponModelToJson(this);
// }