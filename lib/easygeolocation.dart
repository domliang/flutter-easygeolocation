import 'dart:async';

import 'package:flutter/services.dart';

class Easygeolocation {
  static const MethodChannel _channel =
      const MethodChannel('easygeolocation');

  static Future<Map> get getCurrentPosition async {
    var version = await _channel.invokeMethod('getCurrentPosition');
    return version;
  }
}
