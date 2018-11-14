import 'package:dio/dio.dart';
import 'package:gitmob/common/Config/Config.dart';
import 'package:gitmob/common/Config/DebugNetworkConfig.dart';
import 'package:gitmob/common/config/DebugConfig.dart';

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});
}

class Network {

//  final Map<String, dynamic> queryParameters = Map<String, dynamic>();

  static String builder(String path, [Map<String, dynamic> queryParameters = const {}]) {

    Uri uri = Uri.parse(Config.BASE_URL);

    Map<String, dynamic> queryParams = Map.from(queryParameters);
    queryParams.addAll(const {
      "client_id": DebugNetworkConfig.CLIENT_ID,
      "client_secret": DebugNetworkConfig.CLIENT_SECRET
    });
    uri = uri.replace(path: path, queryParameters: queryParams);

    print("URI: $uri");
    return uri.toString();
  }

  static Future<Response> get(String path, [Map<String, dynamic> queryParameters = const {}]) async {
    String urlString = Network.builder(path, queryParameters);
    Dio dio = new Dio();
    //    Response response = await dio.get(urlString);

    Response response;
    try {
      response = await dio.get(urlString);//dio.request(urlString, data: null, options: null);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
//        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (DebugConfig.NETWORK_LOG_ENABLE) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + urlString);
      }
//      return new ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
    }
    return response;
  }

  static post() {

  }

}