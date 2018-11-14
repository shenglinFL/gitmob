import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String login;
  int id;
  String node_id;
  String avatar_url;
  String gravatar_id;
  String url;
  String html_url;
  String followers_url;

  User(this.login, this.id, this.node_id, this.avatar_url, this.gravatar_id, this.url, this.html_url, this.followers_url);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}