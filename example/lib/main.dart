import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:easygeolocation/easygeolocation.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    print('initState method');
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    var locationData;
    var permitionStatus;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      locationData = await Easygeolocation.getCurrentPosition;
      permitionStatus = locationData["status"];
      print(locationData);
    } on PlatformException {
      locationData = 'Failed to get platform version.';
    }
    // if (permitionStatus == 'requestPermition') return;
    // print('requestPermition but not in if ' + permitionStatus);
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if ( permitionStatus == 'notDetermined') {
      const timeout = const Duration(seconds: 3);
      new Timer(timeout, initPlatformState);
      return;
    }
    if (permitionStatus != 'ok') return;
    if (!mounted) return;

    setState(() {
      _platformVersion = 'geolocation is ${locationData["latitude"]}, ${locationData["longitude"]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
