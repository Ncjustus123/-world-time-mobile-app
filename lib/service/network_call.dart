import 'package:chopper/chopper.dart';

part 'network_call.chopper.dart';

@ChopperApi(baseUrl: "")
abstract class AuthenticationClient extends ChopperService {
  @Post(
    path: EndPoint.GET_TOKEN,
    // headers: {"content-type": "application/x-www-form-urlencoded"}
  )
  Future<Response> login(@Body() Map<String, dynamic> json);

  @Get(path: EndPoint.getProfile)
  Future<Response> getProfile();

  @Get(path: EndPoint.updateProfile)
  Future<Response> updateProfile(@Body()Map<String,dynamic> json);
  // @Post(path: EndPoint.getPaymentReference)
  // Future<Response> getPaymentReference(@Body() Map json);

  // @Get(path: EndPoint.getSpecialShipmentPerLocation)
  // Future<Response> getSpecialItemsPerLocation(
  //   @Query("departureLatitude") String departureLatitude,
  //   @Query("departureLongitude") String departureLongitude,
  //   @Query("destinationLatitude") String destinationLatitude,
  //   @Query("destinationLongitude") String destinationLongitude,
  // );

  static AuthenticationClient create({String token}) {
    print(token);
    final client = ChopperClient(
        baseUrl: EndPoint.baseurl,
        services: [
          _$AuthenticationClient(),
        ],
        converter: JsonConverter(),
        interceptors: [
          HttpLoggingInterceptor(),
          CurlInterceptor(),
          (token != null)
              ? HeadersInterceptor({
                  "Authorization": "Bearer $token",
                })
              : HeadersInterceptor({}),
        ]);
    return _$AuthenticationClient(client);
  }
}

class EndPoint {
  static const String getPaymentReference = "";
  static const String GET_TOKEN = "/api/token";
  static const String baseurl = "http://libmotapidev.azurewebsites.net";
  static const String getProfile = "/api/Account/GetProfile";
  static const String updateProfile = '/UpdateProfile';
}
