import 'package:dio/dio.dart';
import 'package:gitmob/common/config/Config.dart';
import 'package:gitmob/common/config/DebugNetworkConfig.dart';
import 'package:gitmob/common/config/DebugConfig.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';


void networkDebug(dynamic object) {
  if (DebugConfig.NETWORK_LOG_ENABLE) {
    print(object);
  }
}

class ResultData {
  var data;
  bool result;
  int code;
  var headers;

  ResultData(this.data, this.result, this.code, {this.headers});
}


class Network {

  static String builderWithClient(String path, [Map<String, dynamic> queryParameters = const {}]) {
    Uri uri = Uri.parse(Config.BASE_URL);
    Map<String, dynamic> queryParams = Map.from(queryParameters);
    queryParams.addAll(const {
      "client_id": DebugNetworkConfig.CLIENT_ID,
      "client_secret": DebugNetworkConfig.CLIENT_SECRET
    });
    uri = uri.replace(path: path, queryParameters: queryParams);
    networkDebug("URI: $uri");
    return uri.toString();
  }

  static String builderWithAccessTokens(String path, [Map<String, dynamic> queryParameters = const {}]) {
    Uri uri = Uri.parse(Config.BASE_URL);
    Map<String, dynamic> queryParams = Map.from(queryParameters);
    queryParams.addAll(const {
      "access_token": DebugNetworkConfig.ACCESS_TOKEN
    });
    uri = uri.replace(path: path, queryParameters: queryParams);
    networkDebug("URI: $uri");
    return uri.toString();
  }

  static String builder(String path, [Map<String, dynamic> queryParameters = const {}]) {
    Uri uri = Uri.parse(Config.BASE_URL);
    uri = uri.replace(path: path, queryParameters: queryParameters);
    print("URI: $uri");
    return uri.toString();
  }

  static Future<Response> request(String method, String path, {data, Options options,CancelToken cancelToken}) async {

    var str = DebugNetworkConfig.USER+":"+DebugNetworkConfig.PASSWORD;
    var bytes = Utf8Encoder().convert(str);
    var base64 = Base64Encoder().convert(bytes);
    String authString = "Basic "+base64;
    Map<String, dynamic> header = Map<String, dynamic>();
    header["Authorization"] = authString;

    Options dioOptions= new Options(
        method: method,
        baseUrl: Config.BASE_URL,
        connectTimeout:5000,
        receiveTimeout:3000,
        headers: header
    );
    networkDebug(data);
    Dio dio = new Dio(dioOptions);
    Response response;
    try {
      //404
      networkDebug("path:"+path+" options:"+dioOptions.toString()+" data:"+data.toString());
      response = await dio.request(path,options: dioOptions,data: data);
      print("123123123: "+response.toString());
      print("123123123: "+response.headers.toString());
    } on DioError catch(e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print("resonse.data => "+e.response.data.toString());
        print("resonse.headers => "+e.response.headers.toString());
        print("resonse.request => "+e.response.request.toString());
        networkDebug('请求异常: ' + e.toString());
        networkDebug('请求异常,data: ' + e.response.toString());
        networkDebug('请求异常url: ' + path);
      } else{
        // Something happened in setting up or sending the request that triggered an Error
        print("request => "+e.response?.request.toString());
        print("message => "+e.message);
        networkDebug('请求异常: ' + e.toString());
        networkDebug('请求异常,data: ' + e.response?.toString());
        networkDebug('请求异常url: ' + path);
      }
      
      networkDebug("======="+e.response?.toString());
    }
    return response;
  }



  static Future<Response> get(String path, [Map<String, dynamic> queryParameters = const {}]) async {
    String urlString = Network.builder(path, queryParameters);//builderWithClient(path, queryParameters);
    Response response = await Network.request("GET", urlString);
    return response;

  }

  static Future<Response> post(String path, [Map<String, dynamic> queryParameters = const {}, Map<String, dynamic> data = const {}]) async {

    FormData formData = new FormData.from(data);

    String urlString = Network.builder(path, queryParameters);
    Response response = await Network.request("POST", urlString, data: formData);
    return response;

  }


  static Future<Response> put(String path, [Map<String, dynamic> queryParameters = const {}, Map<String, dynamic> data = const {}]) async {
    FormData formData = new FormData.from(data);

    String urlString = Network.builder(path, queryParameters);
    Response response = await Network.request(
        "PUT", urlString, data: formData);
    return response;
  }


}