import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_remote_data_source.dart';
import 'package:irhebo/app/network/end_points.dart';
import 'package:irhebo/app/resources/logger_colors.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/general_model.dart';
import 'package:irhebo/domain/models/slider_model.dart';

abstract class IntroRemoteDataSource extends BaseRemoteDataSourceImpl {
  IntroRemoteDataSource({required super.dio});
  Future<Either<BaseErrorModel, BaseResponseModel<List<SliderModel>>>>
      getSteps();

  Future<Either<BaseErrorModel, BaseResponseModel<GeneralModel>>> getGeneral();

  Future<Either<BaseErrorModel, BaseResponseModel<ConfigModel>>> getConfig();
}

class IntroRemoteDataSourceImp extends BaseRemoteDataSourceImpl
    implements IntroRemoteDataSource {
  IntroRemoteDataSourceImp({required super.dio});

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<List<SliderModel>>>>
      getSteps() async {
    try {
      final response = await performGetListRequest<SliderModel>(
        endpoint: AppEndpoints.steps,
        fromJson: SliderModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<GeneralModel>>>
      getGeneral() async {
    try {
      final response = await performGetRequest<GeneralModel>(
        endpoint: AppEndpoints.general,
        fromJson: GeneralModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }

  @override
  Future<Either<BaseErrorModel, BaseResponseModel<ConfigModel>>>
      getConfig() async {
    try {
      final response = await performGetRequest<ConfigModel>(
        endpoint: AppEndpoints.config,
        fromJson: ConfigModel.fromJson,
      );
      return response;
    } catch (err) {
      log("${AppLoggerColors.red} data source:  ${err.toString()}");
      rethrow;
    }
  }
}
