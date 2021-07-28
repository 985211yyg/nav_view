import 'package:flutter/services.dart';

class LocationController {
  MethodChannel methodChannel;
  EventChannel eventChannel;

  LocationController.initByViewId(int viewID) {
    methodChannel =
        MethodChannel('com.reemii.location_view.channel/' + viewID.toString());
  }

  void movePosition(Map<String, dynamic> data) {
    methodChannel.invokeMethod('movePosition', data);
  }

  void navSingle(Map<String, dynamic> data) {
    methodChannel.invokeMethod('navSingle', data);
  }

  void navRoute(String data) {
    methodChannel.invokeMethod('navRoute', data);
  }
}
