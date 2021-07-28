package com.reemii.nav_view;

import android.app.Activity;
import android.content.Context;

import com.amap.api.navi.model.NaviLatLng;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;

/**
 * Author: yyg
 * Date: 2019-12-25 10:42
 * Description:
 */
public class NavViewBuilder implements NavViewOptionSink {
    private List<NaviLatLng> startNavLatLng, endNavLatLng, throughNavLatLng;
    private String destTitle;
    private String mOrderId;

    @Override
    public void setNavLatLngData(List<NaviLatLng> startNavLatLng, List<NaviLatLng> endNavLatLng, List<NaviLatLng> throughNavLatLng, String destTitle, String orderId) {
        this.endNavLatLng = endNavLatLng;
        this.startNavLatLng = startNavLatLng;
        this.throughNavLatLng = throughNavLatLng;
        this.destTitle = destTitle;
        this.mOrderId = orderId;
    }

    NavViewController build(Activity context, int ViewId, BinaryMessenger messenger, AtomicInteger activityState) {
        final NavViewController controller = new NavViewController(context, messenger, ViewId, activityState);
        controller.init();
        controller.setNavLatLngData(startNavLatLng, endNavLatLng, throughNavLatLng, destTitle,mOrderId);
        return controller;
    }

}
