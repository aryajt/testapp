import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:testapp/ControlPanels/LEDControlPanel.dart' as LEDControlPanel;
import 'package:testapp/ControlPanels/LTHControlPanel.dart' as LTHControlPanel;
import 'package:shared_preferences/shared_preferences.dart';


final String ip = "http://62.193.12.161/IotDevices/DataToJson.php";

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List userData;

  Future getData() async {
//    http.Response response = await http.get("https://reqres.in/api/users?page=2");
//    data = json.decode(response.body);
//    setState(() {
//      userData = data["data"];
//    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = (prefs.getString('UserId'));
    http.post(ip, body: {"UserId": uid}).then((response) {
      data = json.decode(response.body);
      setState(() {
        userData = data["records"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      floatingActionButton: new FloatingActionButton(
//          elevation: 0.0,
//          child: new Icon(Icons.add),
//          backgroundColor: new Color(0xFFE57373),
//          onPressed: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(
//                //  builder: (context) => AddDevice.CameraApp()),
//            );
//          }),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () =>
                Navigation_Push("${userData[index]["DeviceType"]}", context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
//                  CircleAvatar(
//                    backgroundImage: NetworkImage(userData[index]["avatar"]),
//                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${userData[index]["DeviceName"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void Navigation_Push(String device_Type, BuildContext context) {
  //LED device Control Panel
  if (device_Type == "air conditioner") {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LEDControlPanel.LEDControlPanel()),
    );
  }
  //LTH device Control Panel
  else if (device_Type == "L.T.H") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LTHControlPanel.LTH_Data()),
    );
  }
}

// void Log () async {
//  http.post(ip, body: {"UserId": "1" })
//      .then((response) {
//    print("List_Of_Devices : ${response.body}");
//  });
//}
