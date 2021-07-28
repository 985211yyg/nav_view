package com.reemii.nav_view.map_view;

import android.app.Activity;
import android.content.Context;

import com.amap.api.maps.model.LatLng;
import com.google.gson.Gson;
import com.reemii.nav_view.AmapUtils;
import com.reemii.nav_view.bean.OrderBean;
import com.reemii.nav_view.bean.PositionBean;

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
public class MapViewFactory extends PlatformViewFactory {

    private BinaryMessenger binaryMessenger;
    private Activity mActivity;
    private AtomicInteger state;
    private Gson mGson;

    public MapViewFactory(BinaryMessenger binaryMessenger, Activity context, AtomicInteger state) {
        super(new StandardMessageCodec());
        this.binaryMessenger = binaryMessenger;
        this.mActivity = context;
        this.state = state;
        mGson = new Gson();
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        MapViewBuilder mapViewBuilder = new MapViewBuilder();
        PlatformView platformView = mapViewBuilder.build(mActivity, viewId, binaryMessenger, state);
        if (args != null) {
            OrderBean orderBean = mGson.fromJson(args.toString(), OrderBean.class);

//            double[] start = AmapUtils.bd09_To_Gcj02(orderBean.getStart_lat(), orderBean.getStart_lng());
//            double[] dest = AmapUtils.bd09_To_Gcj02(orderBean.getDest_lat(), orderBean.getDest_lng());
            //后台传入的数据 没有转换了 就去掉gcj02 转换
            double[] start = {orderBean.getStart_lat(), orderBean.getStart_lng()};
            double[] dest ={orderBean.getDest_lat(), orderBean.getDest_lng()};

            mapViewBuilder.setMarkers(new PositionBean(new LatLng(start[0], start[1]), orderBean.getStart_place()),
                    new PositionBean(new LatLng(dest[0], dest[1]), orderBean.getDest_place()));
        }

        return platformView;
    }
}
