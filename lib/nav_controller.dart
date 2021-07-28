import 'dart:typed_data';

import 'package:flutter/services.dart';

class NavController {
  MethodChannel methodChannel;
  EventChannel eventChannel;
  bool isCreated = true;

  NavController.initByViewId(int viewID, {InfoSetting infoSetting}) {
    methodChannel =
        MethodChannel('com.reemii.nav_view.channel/' + viewID.toString());
    eventChannel =
        EventChannel('com.reemii.nav_view.Event/' + viewID.toString());

    if (infoSetting != null) initInfoSettingCb(infoSetting);
  }

  //计算导航线路
  void calculateRoute() {
    methodChannel.invokeMethod('nav/calcuteRoute');
  }

  //开始导航
  void startNav() {
    methodChannel.invokeMethod('nav/startNav');
  }

  //解析地址
  Future<String> parsingAddress(Map<String, dynamic> location) {
    return methodChannel.invokeMethod('nav/parsingAddress', location);
  }

  //设置标题
  Future setTitle(String title) {
    return methodChannel.invokeMethod('nav/setTitle', title);
  }

  // 显示整条路线 和当前位置 切换
  Future<void> showModeCrossChange() =>
      methodChannel.invokeMethod('nav/showModeAction');

  /// 设置导航偏好
  /// ios:"[\"avoidCost\": false, \"avoidHighway\": true, \"prioritiseHighway\": false, \"multipleRoute\": false, \"avoidCongestion\": true]"
  Future<int> setStrategyConvert(Map<String, bool> arg) =>
      methodChannel.invokeMethod('nav/strategyConvert', arg);

  Future<bool> dispose() {
    if (isCreated) {
      isCreated = false;
      return methodChannel.invokeMethod('nav/dispose');
    }
    return Future.value(isCreated);
  }

  void initInfoSettingCb(InfoSetting infoSetting) {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "setNaviInfo":
          infoSetting.setInfoConfig(call.arguments);
          break;

        case "setNaviTurnTipIcon":
          infoSetting.setTurnImage(call.arguments);
          break;
        case "setNaviCrossTipIcon":
          infoSetting.setCrossImage(call.arguments);
          break;
      }
    });
  }
}

abstract class InfoSetting {
  /// 导航信息图标
  /// IOS实现方式
  /// 图片转data -> flutterBytes
  /// let imgData = crossImage.pngData()
  /// let flutterData = FlutterStandardTypedData(bytes: imgData ?? Data())
  void setTurnImage(Uint8List imageBytes);

  /// config传递字段
  /// {
  ///     "residueTime": "剩余 \(remainDistance)公里 \(remainTime)分钟",
  ///     "nextRoudDis": "\(naviInfo?.segmentRemainDistance ?? 0)",
  ///     "roudeName": naviInfo?.nextRoadName ?? "无名道路",
  ///     "overTime": formatTime(date: Date.init(timeIntervalSince1970: TimeInterval.init(exactly: date)!))
  /// }
  void setInfoConfig(Map<dynamic, dynamic> config);

  /// 导航路线提示图片
  /// 类似 导航信息图标
  void setCrossImage(Uint8List imageBytes);
}
