package com.reemii.nav_view.location_view;

import android.app.Activity;
import android.content.Context;
import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.reemii.nav_view.bean.LocationBean;

import java.lang.reflect.Type;
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
public class LocationViewFactory extends PlatformViewFactory {

    private BinaryMessenger binaryMessenger;
    private Activity mActivity;
    private AtomicInteger state;
    private Gson mGson;

    public LocationViewFactory(BinaryMessenger binaryMessenger, Activity context, AtomicInteger state) {
        super(new StandardMessageCodec());
        this.binaryMessenger = binaryMessenger;
        this.mActivity = context;
        this.state = state;
        mGson = new Gson();
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        LocationViewBuilder locationViewBuilder = new LocationViewBuilder();
        PlatformView platformView = locationViewBuilder.build(mActivity, viewId, binaryMessenger, state);
        List<LocationBean> locationBeanList = new ArrayList<>();
        if (args != null) {
            Type type = new TypeToken<List<LocationBean>>() {
            }.getType();
            locationBeanList.addAll(mGson.fromJson((String) args, type));
            locationViewBuilder.setMarkers(locationBeanList);
        }
        return platformView;
    }
}
