import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/ListOfDevices.dart' as mainpage;

final String ip = "http://62.193.12.161/IotDevices/Register.php";

String UserId;
String firstname_Input, lastname_Input,username_Input,email_Input,cellphone_Input,phone_Input,password_Input,reEnterPassword_Input;
TextEditingController firstname, lastname,username,email,cellphone,phone,password,reEnter_Password;


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {

  @override
  void initState() {
    firstname = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        //  body: new Center(
        body: new Column(
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(70.0)),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (v) => setState(() {
                firstname_Input = v;
              }),
              controller: firstname,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "نام",
              ),
            ),
          //  new Padding(padding: EdgeInsets.only(top: 30.0)),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => setState(() {
                lastname_Input = input;
              }),
              controller: lastname,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "نام خانوادگی",
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => setState(() {
                username_Input = input;
              }),
              controller: username,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "نام کاربری",
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => setState(() {
                email_Input = input;
              }),
              controller: email,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "ایمیل",
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => setState(() {
                cellphone_Input = input;
              }),
              controller: cellphone,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "تلفن ثابت",
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => setState(() {
                phone_Input = input;
              }),
              controller: phone,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "تلفن همراه",
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => setState(() {
                password_Input = input;
              }),
              controller: password,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "رمز عبور",
              ),
            ),
            new TextField(
              keyboardType: TextInputType.text,
              onChanged: (input) => setState(() {
                reEnterPassword_Input = input;
              }),
              controller: reEnter_Password,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                hintText: "تکرار رمز عبور",
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
                  print(firstname_Input + "," + lastname_Input);
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
  //TODO:emal regex check
  if(password_Input==reEnterPassword_Input && firstname_Input.isNotEmpty && lastname_Input.isNotEmpty &&
      username_Input.isNotEmpty &&email_Input.isNotEmpty &&cellphone_Input.isNotEmpty&&
  phone_Input.isNotEmpty&&password_Input.isNotEmpty&&reEnterPassword_Input.isNotEmpty
  ) {
    http.post(ip, body: {
      "Data": "$firstname_Input" + "," + "$lastname_Input"+","+username_Input+","+email_Input+","+cellphone_Input
      +","+phone_Input+","+password_Input}).then((response) {
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
}

_UserId(String response) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("UserId", response);
  String uid = (prefs.getString('userid'));
  print("UserId:$uid");
}
