import 'package:gitmob/network/Network.dart';

class AuthorizationModel {
  static login() async {

//    String path = "/users/shenglinFL";
//
//    Network.get(path);
//    var q = Map<String, dynamic>();
//    q["a"]="123";
//    Response response = await Network.get(path, q);
//    Map m = Map.from(response.data);
//    print("data:$m ");

  }

  static authorizations() async {
    
// 获取token??
    Map<String, dynamic> data = const {
      "scopes": [
        "public_repo"
      ],
      "note": "admin script"
    };
    Network.post("/authorizations", null, data);




// 查看star
//    Network.get("user/starred/flutterchina/flukit");

    // 设置star
//    Map<String, dynamic> data = const {
//      "ignored": "true",
//      "subscribed": "true"
//    };
//    Network.put("/repos/flutterchina/flukit/subscription",data);
  }
}