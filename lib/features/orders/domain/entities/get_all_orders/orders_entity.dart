import 'package:equatable/equatable.dart';

class OrdersResponseEntity extends Equatable {
  final List<OrderEntity>? deliveryOrders;
  final List<OrderEntity>? tableOrders;
  final List<OrderEntity>? selfOrders;

  const OrdersResponseEntity({
    this.deliveryOrders,
    this.tableOrders,
    this.selfOrders,
  });

  @override
  List<Object?> get props => [deliveryOrders, tableOrders, selfOrders];
}

class OrderEntity extends Equatable {
  final int? id;
  final String? address;
  final String? tableNumber;
  final String? note;
  final int? itemNumber;
  final int? totalPrice;
  final int? accepted;
  final String? createdAt;
  final UserEntity? user;
  final CouponEntity? coupon;
  final List<OrderItemEntity>? items;
  final int? branch_id;

  const OrderEntity({
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
    this.items,
    this.branch_id
  });

  @override
  List<Object?> get props => [
    id,
    address,
    tableNumber,
    note,
    itemNumber,
    totalPrice,
    accepted,
    createdAt,
    user,
    coupon,
    items,
  ];
}

class UserEntity extends Equatable {
  final int? id;
  final String? fullname;
  final String? phonenumber;

  const UserEntity({this.id, this.fullname, this.phonenumber});

  @override
  List<Object?> get props => [id, fullname, phonenumber];
}

class OrderItemEntity extends Equatable {
  final int? id;
  final int? amount;
  final int? price;
  final int? extra;
  final String? typeName;
  final String? mealName;

  const OrderItemEntity({
    this.id,
    this.amount,
    this.price,
    this.extra,
    this.typeName,
    this.mealName,
  });

  @override
  List<Object?> get props => [id, amount, price, extra, typeName, mealName];
}

class CouponEntity extends Equatable {
  final int? id;
  final String? code;
  final String? value;
  final String? minOrder;
  final String? expiresAt;

  const CouponEntity({
    this.id,
    this.code,
    this.value,
    this.minOrder,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [id, code, value, minOrder, expiresAt];
}



// class OrderEntity extends Equatable {
//   final int? id;
//   final String? address;
//   final String? tableNumber;
//   final String? note;
//   final int? itemNumber;
//   final int? totalPrice;
//   final int? accepted;
//   final String? createdAt;
//   final UserEntity? user;
//   final List<OrderItemEntity>? items;
//   final CouponEntity? coupon;
//
//   const OrderEntity({
//     this.id,
//     this.address,
//     this.tableNumber,
//     this.note,
//     this.itemNumber,
//     this.totalPrice,
//     this.accepted,
//     this.createdAt,
//     this.user,
//     this.items,
//     this.coupon,
//   });
//
//   @override
//   List<Object?> get props => [
//     id,
//     address,
//     tableNumber,
//     note,
//     itemNumber,
//     totalPrice,
//     accepted,
//     createdAt,
//     user,
//     items,
//     coupon,
//   ];
// }
//
// class UserEntity extends Equatable {
//   final int? id;
//   final String? fullname;
//   final String? phonenumber;
//
//   const UserEntity({
//     this.id,
//     this.fullname,
//     this.phonenumber,
//   });
//
//   @override
//   List<Object?> get props => [id, fullname, phonenumber];
// }
//
// class OrderItemEntity extends Equatable {
//   final int? id;
//   final int? amount;
//   final int? price;
//   final int? extra;
//   final String? mealName;
//   final String? typeName;
//
//   const OrderItemEntity({
//     this.id,
//     this.amount,
//     this.price,
//     this.extra,
//     this.mealName,
//     this.typeName,
//   });
//
//   @override
//   List<Object?> get props => [id, amount, price, extra, mealName, typeName];
// }
//
// class CouponEntity extends Equatable {
//   final int? id;
//   final String? code;
//   final String? value;
//   final String? minOrder;
//   final String? expiresAt;
//
//   const CouponEntity({
//     this.id,
//     this.code,
//     this.value,
//     this.minOrder,
//     this.expiresAt,
//   });
//
//   @override
//   List<Object?> get props => [id, code, value, minOrder, expiresAt];
// }


// class OrderEntity extends Equatable {
//   final int? id;
//   final String? address;
//   final String? tableNumber;
//   final String? note;
//   final int? itemNumber;
//   final int? totalPrice;
//   final int? accepted;
//   final String? createdAt;
//   final UserEntity? user;
//   final List<OrderItemEntity>? items;
//   final CouponEntity? coupon;
//
//   const OrderEntity({
//     this.id,
//     this.address,
//     this.tableNumber,
//     this.note,
//     this.itemNumber,
//     this.totalPrice,
//     this.accepted,
//     this.createdAt,
//     this.user,
//     this.items,
//     this.coupon,
//   });
//
//   @override
//   List<Object?> get props => [
//     id,
//     address,
//     tableNumber,
//     note,
//     itemNumber,
//     totalPrice,
//     accepted,
//     createdAt,
//     user,
//     items,
//     coupon,
//   ];
// }
//
// class UserEntity extends Equatable {
//   final int? id;
//   final String? fullname;
//   final String? phonenumber;
//
//   const UserEntity({
//     this.id,
//     this.fullname,
//     this.phonenumber,
//   });
//
//   @override
//   List<Object?> get props => [id, fullname, phonenumber];
// }
//
// class OrderItemEntity extends Equatable {
//   final int? id;
//   final int? amount;
//   final int? price;
//   final String? mealName;
//   final String? typeName;
//   final int? extra;
//
//   const OrderItemEntity({
//     this.id,
//     this.amount,
//     this.price,
//     this.mealName,
//     this.typeName,
//     this.extra,
//   });
//
//   @override
//   List<Object?> get props => [id, amount, price, mealName, typeName, extra];
// }
//
// class CouponEntity extends Equatable {
//   final int? id;
//   final String? code;
//   final String? value;
//   final String? minOrder;
//   final String? expiresAt;
//
//   const CouponEntity({
//     this.id,
//     this.code,
//     this.value,
//     this.minOrder,
//     this.expiresAt,
//   });
//
//   @override
//   List<Object?> get props => [id, code, value, minOrder, expiresAt];
// }