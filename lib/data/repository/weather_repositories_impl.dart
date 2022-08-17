import 'package:weather_app/domain/models/weather_model.dart';
import 'package:weather_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/domain/repository/weather_repositories.dart';
import '../data_src/remote_data_src.dart';
import '../network/network_info.dart';
import 'get_weather/get_current_weather_impl.dart';
import 'get_weather/get_forcast_weather_impl.dart';

class RepositoriesImpl extends Repositories {
  final RemoteDataSrc _remoteDataSrc;
  final NetworkInfo _networkInfo;

  RepositoriesImpl(this._remoteDataSrc, this._networkInfo);
  @override
  Future<Either<Failure, WeatherModel>> getWetherByCityName(
      String cityName) async {
    return await getWeatherByCityNameImpl(
        cityName: cityName,
        networkInfo: _networkInfo,
        remoteDataSrc: _remoteDataSrc);
  }

  @override
  Future<Either<Failure, List<WeatherModel>>> getForcastWeatherByCityName(
      String cityName) async {
    return await getForcastWeatherByCityNameImpl(
        cityName: cityName,
        networkInfo: _networkInfo,
        remoteDataSrc: _remoteDataSrc);
  }
}
