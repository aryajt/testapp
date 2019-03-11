import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';


class LEDControlPanel extends StatefulWidget {
  @override
  _LEDControlPanelState createState() => _LEDControlPanelState();
}

class _LEDControlPanelState extends State<LEDControlPanel> {
  bool _value = false;

  void _onChanged(bool value) {
    setState(() {
      _value = value;
      if (value == false) {
        print("ChangedToFalseeeee");
        Publish("OFF,1");
      } else {
        print("ChangedToTrueeeeeee");
        Publish("ON,1");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Switch(
              value: _value,
              onChanged: (bool value) {
                _onChanged(value);
              }),
        ),
      ),
    );
  }
}

Publish(String Message) async {
  final MqttClient client =
      new MqttClient.withPort("62.193.12.161", "FromArya ", 1883);


//  final MqttConnectMessage connectMessage = new MqttConnectMessage()
//      .withClientIdentifier("FromArya")
//      .withWillTopic("test")
//      .withWillMessage(Message)
//      .withWillQos(MqttQos.exactlyOnce);
//  client.connectionMessage = connectMessage;
  try {
    await client.connect();
  } catch (e) {
    print("EXAMPLE::client exception - $e");
    client.disconnect();
  }
  final String pubTopic = "/leds/esp8266";
  final MqttClientPayloadBuilder builder = new MqttClientPayloadBuilder();
  builder.addString(Message);

  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);


  //client.disconnect();
}
