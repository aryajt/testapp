import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/ListOfDevices.dart' as mainpage;

var UserId;
var url = "http://62.193.12.161/IotDevices/Login.php";
String username_Input, password_Input;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username, password;

  @override
  void initState() {
    username = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //  body: new Center(
        body: new Column(
      children: <Widget>[
        new Padding(padding: EdgeInsets.only(top: 70.0)),
        new TextField(
          keyboardType: TextInputType.text,
          onChanged: (v) => setState(() {
                username_Input = v;
              }),
          controller: username,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            hintText: "نام کاربری",
          ),
        ),
        new Padding(padding: EdgeInsets.only(top: 30.0)),
        new TextField(
          keyboardType: TextInputType.text,
          onChanged: (input) => setState(() {
                password_Input = input;
              }),
          controller: password,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10.0),
            hintText: "رمز عبور",
          ),
        ),
        new Padding(padding: EdgeInsets.only(top: 50.0)),
        new RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
          child: new Text("ورود"),
          onPressed: () {
            PostData(context);
            setState(() {
              print(username_Input + "," + password_Input);
            });
          },
        ),
      ],
    )
        //  )
        );
  }
}

void PostData(BuildContext context) async {
  http.post(url, body: {
    "Data": "$username_Input" + "," + "$password_Input"
  }).then((response) {
    if (!response.body.endsWith(".")) {
      _UserId(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainpage.HomePage()),
      );
    }
    print("response : ${response.body}");
  });
}

_UserId(String response) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("UserId", response);
  String uid = (prefs.getString('UserId'));
  print("UserId:$uid");
}
