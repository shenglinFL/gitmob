import 'package:dio/dio.dart';
import 'package:gitmob/Model/User.dart';
import 'package:gitmob/common/Config/Config.dart';
import 'package:gitmob/common/Config/DebugNetworkConfig.dart';


class Network {
  static getURL(String path) async {
    String urlString = Network.builder(path);
    print("URL: "+urlString);

    Dio dio = new Dio();
    Response response = await dio.get(urlString);

    print(response.toString());

    User user = User.fromJson(response.data);
    print("name:"+user.login+"url:"+user.html_url);
  }

  static builder(String path) {
    return Config.BASE_URL + path + "?" + "client_id=" + DebugNetworkConfig.CLIENT_ID + "&" + "client_secret=" + DebugNetworkConfig.CLIENT_SECRET;
  }
}