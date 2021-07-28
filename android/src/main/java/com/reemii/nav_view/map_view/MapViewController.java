package com.reemii.nav_view.map_view;

import android.app.Activity;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.amap.api.maps.AMap;
import com.amap.api.maps.CameraUpdateFactory;
import com.amap.api.maps.TextureMapView;
import com.amap.api.maps.model.BitmapDescriptorFactory;
import com.amap.api.maps.model.CustomMapStyleOptions;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.LatLngBounds;
import com.amap.api.maps.model.MarkerOptions;
import com.amap.api.maps.model.MyLocationStyle;
import com.reemii.nav_view.NavViewPlugin;
import com.reemii.nav_view.R;
import com.reemii.nav_view.bean.PositionBean;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * Author: yyg
 * Date: 2020-01-10 11:44
 * Description:
 */
public class MapViewController implements PlatformView, MethodChannel.MethodCallHandler, MapViewOptionSink {
    private View rootView;
    private View startView;
    private View destView;
    private TextView startPlace, endPlace;
    private TextureMapView mapView;
    private AMap aMap;
    private MyLocationStyle myLocationStyle;
    private MethodChannel methodChannel;
    private AtomicInteger mActivityState;
    private Activity mActivity;

    public MapViewController(Activity context, int viewId, BinaryMessenger binaryMessenger, AtomicInteger atomicInteger) {
        methodChannel = new MethodChannel(binaryMessenger, "com.reemii.nav_view.channel/" + String.valueOf(viewId));
        methodChannel.setMethodCallHandler(this);
        mActivity = context;
        rootView = LayoutInflater.from(context).inflate(R.layout.map_view, null);
        startView = LayoutInflater.from(context).inflate(R.layout.start_view, null);
        startPlace = startView.findViewById(R.id.start_place);
        destView = LayoutInflater.from(context).inflate(R.layout.end_view, null);
        endPlace = destView.findViewById(R.id.dest_place);
        mapView = rootView.findViewById(R.id.mapView);
        mActivityState = atomicInteger;
        aMap = mapView.getMap();
        myLocationStyle = new MyLocationStyle();
//        myLocationStyle.myLocationType(MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER);//连续定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动。（1秒1次定位）如果不设置myLocationType，默认也会执行此种模式。
        myLocationStyle.showMyLocation(true);
        aMap.getUiSettings().setMyLocationButtonEnabled(true);
        aMap.setMyLocationEnabled(false);
        aMap.setMyLocationStyle(myLocationStyle); //设置定位蓝点的Style
        aMap.setCustomMapStyle(new CustomMapStyleOptions()
                .setEnable(true)
                .setStyleData(readFile("style.data"))
                .setStyleExtraData(readFile("style_extra.data")));
        mapView.onCreate(null);

    }


    private byte[] readFile(String name) {
        try {
            InputStream inputStream = mActivity.getAssets().open(name);
            byte[] data = new byte[inputStream.available()];
            inputStream.read(data);
            inputStream.close();
            return data;
        } catch (IOException e) {

        }
        return null;
    }

    //初始化状态
    public void init() {
        switch (mActivityState.get()) {
            case NavViewPlugin.CREATED:
                break;
            case NavViewPlugin.STARTED:
                break;
            case NavViewPlugin.RESUMED:
                mapView.onResume();
                break;
            case NavViewPlugin.PAUSED:
                mapView.onPause();
                break;
            case NavViewPlugin.STOPPED:
                break;
            case NavViewPlugin.DESTROYED:
                mapView.onDestroy();
                break;
        }

    }

    @Override
    public void setMarkers(@NotNull List<PositionBean> latlngs) {


    }

    @Override
    public void moveToPostion(@NotNull LatLng latLng) {

    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {

    }

    @Override
    public View getView() {
        return rootView;
    }

    @Override
    public void dispose() {

    }

    @Override
    public void setMarkers(@NotNull PositionBean start, @NotNull PositionBean dest) {
        aMap.clear();
        startPlace.setText(start.getName());
        endPlace.setText(dest.getName());
        aMap.addMarker(new MarkerOptions().position(start.getMLatLng())
                .icon(BitmapDescriptorFactory.fromView(startView))
                .anchor(0f, 1f)
                .zIndex(0)
                .setFlat(true));
        aMap.addMarker(new MarkerOptions().position(dest.getMLatLng())
                .icon(BitmapDescriptorFactory.fromView(destView))
                .anchor(0f, 1f).zIndex(0)
                .setFlat(true));
        //纬度大的在后面
        if (start.getMLatLng().latitude > dest.getMLatLng().latitude) {
            aMap.animateCamera(CameraUpdateFactory.newLatLngBounds(new LatLngBounds(dest.getMLatLng(), start.getMLatLng()), 250), null);
        } else {
            aMap.animateCamera(CameraUpdateFactory.newLatLngBounds(new LatLngBounds(start.getMLatLng(), dest.getMLatLng()), 250), null);
        }
    }
}
