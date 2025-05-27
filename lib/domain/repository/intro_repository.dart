import 'package:dartz/dartz.dart';
import 'package:irhebo/app/base/base_models/base_error_model.dart';
import 'package:irhebo/app/base/base_models/base_response_model.dart';
import 'package:irhebo/app/base/base_repository.dart';
import 'package:irhebo/data/intro_remote_data_source.dart';
import 'package:irhebo/domain/models/config_model.dart';
import 'package:irhebo/domain/models/general_model.dart';
import 'package:irhebo/domain/models/slider_model.dart';

class IntroRepository extends BaseRepositoryImpl {
  final IntroRemoteDataSource introRemoteDataSource;

  IntroRepository({
    required this.introRemoteDataSource,
    required super.networkInfo,
  }) : super(baseRemoteDataSource: introRemoteDataSource);

  Future<Either<BaseErrorModel, BaseResponseModel<List<SliderModel>>>>
      getSteps() async {
    try {
      final result = await introRemoteDataSource.getSteps();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<GeneralModel>>>
      getGeneral() async {
    try {
      final result = await introRemoteDataSource.getGeneral();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<BaseErrorModel, BaseResponseModel<ConfigModel>>>
      getConfig() async {
    try {
      final result = await introRemoteDataSource.getConfig();
      result.fold((l) => {}, (r) => {});
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
