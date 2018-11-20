import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:gitmob/network/Network.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String login;
  int id;
  @JsonKey(name: "node_id")
  String nodeId;
  @JsonKey(name: "avatar_url")
  String avatarUrl;
  @JsonKey(name: "gravatar_id")
  String gravatarId;
  String url;
  @JsonKey(name: "html_url")
  String htmlUrl;
  @JsonKey(name: "followers_url")
  String followersUrl;
  @JsonKey(name: "gists_url")
  String gistsUrl;

  User(this.login, this.id, this.nodeId, this.avatarUrl, this.gravatarId, this.url, this.htmlUrl, this.followersUrl, this.gistsUrl);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  static Future<User> getUser() async {
    String path = "/users/shenglinFL";
    Response response = await Network.get(path);
    User user = User.fromJson(response.data);
    print("LOGIN: "+user.login);
    return user;
  }

}
