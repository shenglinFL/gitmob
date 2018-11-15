import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitmob/Model/AuthorizationModel.dart';
import 'package:gitmob/Model/User.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:after_layout/after_layout.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> with AfterLayoutMixin<UserView>{

  User _user;

//  var _avatarImage = Image(image: null,);
  //new Image(image: ImageProvider());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    if (_user == null) {
//      print("INIT_USER_VIEW");
//      getUser();
//    }

  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (_user == null) {
      print("INIT_USER_VIEW");
      getUser();
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          height: 200,
          color: Colors.blue,
          child: new Center(
            child: new CachedNetworkImage(imageUrl: _user?.avatarUrl ?? ""),
          ),
        ),
        new Container(
          height: 200,
          child: new Center(
            child: new CupertinoButton(child: Text("POST"), onPressed: () async{
              AuthorizationModel.authorizations();
            }),
          ),
        ),
      ],
    );
//    return new Center(
//      child: Text(_user?.login ?? ""),
//    );
  }

  getUser() async {
    User user = await User.getUser();
    setState(() {
      _user = user;
//      _avatarImage = CachedNetworkImage(imageUrl: user.avatarUrl);
    });
  }
}


