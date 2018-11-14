import 'package:gitmob/network/Network.dart';

class AuthorizationModel {
  static login() async {

    String path = "/users/shenglinFL";

    Network.getURL(path);

//    try {
//      response = await dio.request(url, data: null, options: null);
//    } on DioError catch (e) {
//      Response errorResponse;
//      if (e.response != null) {
//        errorResponse = e.response;
//      } else {
//        errorResponse = new Response(statusCode: 666);
//      }
//      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
//        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
//      }
//      if (Config.DEBUG) {
//        print('请求异常: ' + e.toString());
//        print('请求异常url: ' + url);
//      }
//      return new ResultData(Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
//    }
  }
}