package com.reemii.nav_view;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.amap.api.navi.model.NaviLatLng;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * Author: yyg
 * Date: 2019-12-24 16:42
 * Description:
 */
public class NavViewFactory extends PlatformViewFactory {
    public static final String TAG = NavViewFactory.class.getSimpleName();
    private final BinaryMessenger mBinaryMessenger;
    private AtomicInteger mActivityState;
    private Activity mActivity;
    private List<NaviLatLng> startNavLatLng, endNavLatLng, throughNavLatLng;
    private String destTitle = "";
    private String orderId = "";


    public NavViewFactory(BinaryMessenger messenger, AtomicInteger activityState, Activity activity) {
        super(StandardMessageCodec.INSTANCE);
        this.mBinaryMessenger = messenger;
        mActivityState = activityState;
        this.mActivity = activity;
    }

    /**
     * @param context
     * @param viewId  view的id
     * @param args    从flutter直接传过来的参数
     * @return
     */
    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        //接受参数
        Map<String, Object> data = (Map<String, Object>) args;
        Log.e(">>>>>>>>导航信息", "create: " + data.toString());
        if (data.containsKey("startNavLatLng")) {
            List<Double> statData = (List<Double>) data.get("startNavLatLng");
            startNavLatLng = new ArrayList<>();
            startNavLatLng.add(new NaviLatLng(statData.get(0), statData.get(1)));
        }
        if (data.containsKey("endNavLatLng")) {
            List<Double> statData = (List<Double>) data.get("endNavLatLng");
            endNavLatLng = new ArrayList<>();
            endNavLatLng.add(new NaviLatLng(statData.get(0), statData.get(1)));
        }
        if (data.containsKey("destTitle")) {
            destTitle = (String) data.get("destTitle");
        }
        if (data.containsKey("orderId")) {
            orderId = (String) data.get("orderId");
        }
        final NavViewBuilder navViewBuilder = new NavViewBuilder();
        navViewBuilder.setNavLatLngData(startNavLatLng, endNavLatLng, null, destTitle, orderId);
        return navViewBuilder.build(mActivity, viewId, mBinaryMessenger, mActivityState);
    }


}
