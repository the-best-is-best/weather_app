import 'package:dartz/dartz.dart';
import 'package:weather_app/app/extensions/extesnsion_string.dart';
import 'package:weather_app/data/data_src/remote_data_src.dart';
import 'package:weather_app/data/mapper/forcast_weather_response_mapper.dart';
import 'package:weather_app/data/network/network_info.dart';
import '../../../domain/models/weather_model.dart';
import '../../network/error_handler.dart';
import '../../network/failure.dart';

Future<Either<Failure, List<WeatherModel>>> getForcastWeatherByCityNameImpl(
    {required NetworkInfo networkInfo,
    required RemoteDataSrc remoteDataSrc,
    required String cityName}) async {
  if (await networkInfo.isConnected) {
    try {
      var response =
          await remoteDataSrc.getFiveDaysThreeHoursForcastData(cityName);
      if (response.cod!.toInt() >= 200 && response.cod!.toInt() <= 299) {
        //success
        // return either right
        // return data
        return Right(response.toDomain());
      } else {
        // return either left
        // return error
        return Left(Failure(response.cod!.toInt(), "Error server"));
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  } else {
    //failure
    // return either left
    return Left(await DataRes.NO_INTERNET_CONNECTION.getFailure());
  }
}
