import 'package:flutter/services.dart';

class MapController {
  MethodChannel mapChannel;

  // 工厂模式
  factory MapController() => _getInstance();

  static MapController get instance => _getInstance();
  static MapController _instance;

  MapController._internal() {
    // 初始化
  }

  static MapController _getInstance() {
    if (_instance == null) {
      _instance = new MapController._internal();
    }
    return _instance;
  }

  void initView(String viewId) {
    mapChannel = MethodChannel("com.reemii.nav_view.channel/" + viewId);
  }
}
