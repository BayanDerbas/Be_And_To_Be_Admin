import 'package:be_and_to_be_admin/core/networks/failures.dart';
import 'package:be_and_to_be_admin/features/coupons/data/data_sources/coupons_service.dart';
import 'package:be_and_to_be_admin/features/coupons/data/models/add_coupon/add_coupon_response.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/add_coupon/add_coupon_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/delete_coupon/delete_coupon_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_expires_date_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_min_order_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/entities/editing/edit_percent_value_entity.dart';
import 'package:be_and_to_be_admin/features/coupons/domain/repositories/coupons_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/get_coupons/coupons_entity.dart';

class CouponsRepositoryImpl implements CouponsRepository {
  final CouponsService service;

  CouponsRepositoryImpl(this.service);

  @override
  Future<Either<Failure, CouponsEntity>> getAllCoupons() async {
    try {
      final response = await service.getCoupons();
      print("Success from Repo_impl : ${response.data}");
      return Right(response.data);
    } on DioException catch (e) {
      print("Failure from Repo_impl : ${e.message}");
      return Left(Failure.fromDioError(e));
    } catch (e) {
      print("Failure from Repo_impl : ${e.toString()}");
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddCouponResponseEntity>> addCoupon({
    required String code,
    required int min_order,
    required int percent_value,
    required String expires_date,
  }) async {
    try {
      final response = await service.addCoupon(
        code: code,
        min_order: min_order,
        percent_value: percent_value,
        expires_date: expires_date,
      );
      final data = response.data;
      late AddCouponResponseEntity entity;

      if (data is Map<String, dynamic>) {
        entity = AddCouponResponse.fromJson(data);
      } else if (data is List && data.isNotEmpty) {
        entity = AddCouponResponseEntity(message: data.toString());
      } else {
        entity = AddCouponResponseEntity(message: "Unexpected response format");
      }
      return Right(entity);
    } on DioException catch (e) {
      return Left(Failure.fromDioError(e));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditExpiresDateEntity>> editExpiresDate({required String expires_at, required int coupon_id})async{
    try{
      final response = await service.editExpiresDate(expires_at: expires_at, coupon_id: coupon_id);
      final data = response.data;
      late EditExpiresDateEntity entity;
      if(data is List && data.isNotEmpty){
        entity = EditExpiresDateEntity(message: data.toString());
      } else {
        entity = EditExpiresDateEntity(message: "Unexpected response format");
      }
      return Right(entity);
    } on DioException catch(e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditMinOrderEntity>> editMinOrder({required int min_order, required int coupon_id}) async {
    try{
      final response = await service.editMinOrder(min_order: min_order, coupon_id: coupon_id);
      final data = response.data;
      late EditMinOrderEntity entity;
      if(data is List && data.isNotEmpty){
        entity = EditMinOrderEntity(message: data.toString());
      } else {
        entity = EditMinOrderEntity(message: "Unexpected response format");
      }
      return Right(entity);
    } on DioException catch(e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EditPercentValueEntity>> editPercentValue({required int value, required int coupon_id}) async{
    try{
      final response = await service.editPercentValue(value: value, coupon_id: coupon_id);
      final data = response.data;
      late EditPercentValueEntity entity;
      if(data is List && data.isNotEmpty){
        entity = EditPercentValueEntity(message: data.toString());
      } else {
        entity = EditPercentValueEntity(message: "Unexpected response format");
      }
      return Right(entity);
    } on DioException catch(e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteCouponEntity>> deleteCoupon({required int coupon_id}) async{
    try{
      final response = await service.deleteCoupon(coupon_id);
      final data = response.data;
      late DeleteCouponEntity entity;
      if(data is List && data.isNotEmpty){
        entity = DeleteCouponEntity(message: data.toString());
      } else {
        entity = DeleteCouponEntity(message: "Unexpected response format");
      }
      return Right(entity);
    } on DioException catch(e){
      return Left(Failure.fromDioError(e));
    } catch(e){
      return Left(Failure(e.toString()));
    }
  }
}

