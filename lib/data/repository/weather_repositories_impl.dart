import 'package:weather_app/data/mapper/weather_response_mapper.dart';
import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/repository/weather_repositories.dart';

import '../data_src/remote_data_src.dart';
import '../network/error_handler.dart';
import '../network/network_info.dart';

class RepositoriesImpl extends Repositories {
  final RemoteDataSrc _remoteDataSrc;
  final NetworkInfo _networkInfo;

  RepositoriesImpl(this._remoteDataSrc, this._networkInfo);
  @override
  Future<Either<Failure, WeatherModel>> getWetherByCityName(
      String cityName) async {
    if (await _networkInfo.isConnected) {
      try {
        var response = await _remoteDataSrc.getWeatherByCityName(cityName);

        //success
        // return either right
        // return data
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //failure
      // return either left
      return Left(await DataRes.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
