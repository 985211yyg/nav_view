package com.reemii.nav_view;

import com.amap.api.navi.model.NaviLatLng;

import java.util.List;

/**
 * Author: yyg
 * Date: 2019-12-25 10:42
 * Description:
 */
public interface NavViewOptionSink {

    void setNavLatLngData(List<NaviLatLng> startNavLatLng,
                          List<NaviLatLng> endNavLatLng,
                          List<NaviLatLng> throughNavLatLng,
                          String destTitle,
                          String orderId);

}
