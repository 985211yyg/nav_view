package com.reemii.nav_view.heatmap;

import android.app.Activity;
import android.content.Context;

import com.amap.api.maps.model.LatLng;
import com.google.gson.Gson;
import com.reemii.nav_view.AmapUtils;
import com.reemii.nav_view.bean.HeatData;
import com.reemii.nav_view.bean.OrderBean;
import com.reemii.nav_view.bean.PositionBean;
import com.reemii.nav_view.map_view.MapViewBuilder;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * Author: yyg
 * Date: 2020-01-10 14:03
 * Description:
 */
public class HeatMapFactory extends PlatformViewFactory {

    private BinaryMessenger binaryMessenger;
    private Activity mActivity;
    private AtomicInteger state;

    public HeatMapFactory(BinaryMessenger binaryMessenger, Activity context, AtomicInteger state) {
        super(new StandardMessageCodec());
        this.binaryMessenger = binaryMessenger;
        this.mActivity = context;
        this.state = state;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        HeatHeatMapController controller = new HeatHeatMapBuilder().build(mActivity, viewId, binaryMessenger, state);
        return controller;
    }
}
