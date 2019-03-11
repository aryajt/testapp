import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final String ip = "http://62.193.12.161/IotDevices/sensors_plants.php";

void main() {
  runApp(MaterialApp(
    home: LTH_Data(),
  ));
}

class LTH_Data extends StatefulWidget {
  @override
  _LTH_DataState createState() => _LTH_DataState();
}

class _LTH_DataState extends State<LTH_Data> {
  Map data;
  List LTHData;

  Future getData() async {
    http.post(ip, body: {"Mac": "2"}).then((response) {
      data = json.decode(response.body);
      setState(() {
        LTHData = data["records"];
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
      body: ListView.builder(
        itemCount: LTHData == null ? 0 : LTHData.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
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
                      "${LTHData[index]["Light"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${LTHData[index]["Temperature"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${LTHData[index]["Humidity"]}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



// void Log () async {
//  http.post(ip, body: {"UserId": "1" })
//      .then((response) {
//    print("List_Of_Devices : ${response.body}");
//  });
//}
