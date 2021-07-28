package com.reemii.nav_view.location_view;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TextView;

import com.amap.api.maps.AMap;
import com.amap.api.maps.CameraUpdateFactory;
import com.amap.api.maps.TextureMapView;
import com.amap.api.maps.model.BitmapDescriptor;
import com.amap.api.maps.model.BitmapDescriptorFactory;
import com.amap.api.maps.model.CustomMapStyleOptions;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.LatLngBounds;
import com.amap.api.maps.model.MarkerOptions;
import com.amap.api.maps.model.MyLocationStyle;
import com.amap.api.maps.model.Poi;
import com.amap.api.navi.AmapNaviPage;
import com.amap.api.navi.AmapNaviParams;
import com.amap.api.navi.AmapNaviType;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.reemii.nav_view.AmapUtils;
import com.reemii.nav_view.NavViewPlugin;
import com.reemii.nav_view.R;
import com.reemii.nav_view.bean.LocationBean;
import com.reemii.nav_view.bean.PositionBean;
import com.reemii.nav_view.map_view.LocationViewOptionSink;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
public class LocationViewController implements PlatformView, MethodChannel.MethodCallHandler, LocationViewOptionSink {
    private View rootView;
    private View locationView;
    private TextView locationName;
    private TextureMapView mapView;
    private AMap aMap;
    private MyLocationStyle myLocationStyle;
    private MethodChannel methodChannel;
    private AtomicInteger mActivityState;
    private Activity mActivity;
    private Poi startPoi, endPoi;
    private List<Poi> passPoiList = new ArrayList<>();
    private ArrayList<MarkerOptions> markerOptionsList = new ArrayList<>();


    public LocationViewController(Activity context, int viewId, BinaryMessenger binaryMessenger, AtomicInteger atomicInteger) {
        methodChannel = new MethodChannel(binaryMessenger, "com.reemii.location_view.channel/" + String.valueOf(viewId));
        methodChannel.setMethodCallHandler(this);
        mActivity = context;
        rootView = LayoutInflater.from(context).inflate(R.layout.map_view, null);

        mapView = rootView.findViewById(R.id.mapView);
        mActivityState = atomicInteger;
        aMap = mapView.getMap();
        myLocationStyle = new MyLocationStyle();
        myLocationStyle.myLocationType(MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER);
        //连续定位、且将视角移动到地图中心点，定位点依照设备方向旋转，并且会跟随设备移动。（1秒1次定位）如果不设置myLocationType，默认也会执行此种模式。
        myLocationStyle.showMyLocation(true);
        aMap.getUiSettings().setMyLocationButtonEnabled(true);
        aMap.setMyLocationEnabled(true);
        aMap.setMyLocationStyle(myLocationStyle); //设置定位蓝点的Style
        mapView.onCreate(null);
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
    public void setMarkers(@NotNull List<LocationBean> latlngs) {
        aMap.clear();
        markerOptionsList.clear();
        for (LocationBean latlng : latlngs) {
            markerOptionsList.add(new MarkerOptions()
                    .position(new LatLng(latlng.getLat(), latlng.getLng()))
                    .icon(BitmapDescriptorFactory.fromBitmap(convertViewToBitmap(latlng.getName())))
                    .anchor(0f, 1f)
                    .zIndex(0)
                    .setFlat(true));
        }
        aMap.addMarkers(markerOptionsList, true);

    }

    private Bitmap convertViewToBitmap(String name) {
        locationView = LayoutInflater.from(mActivity).inflate(R.layout.location_view, null);
        locationName = locationView.findViewById(R.id.location_name);
        locationName.setText(name);
        locationView.measure(View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED),
                View.MeasureSpec.makeMeasureSpec(0, View.MeasureSpec.UNSPECIFIED));
        locationView.layout(0, 0, locationView.getMeasuredWidth(), locationView.getMeasuredHeight());
        locationView.buildDrawingCache();
        return locationView.getDrawingCache();

    }


    @Override
    public void moveToPostion(@NotNull LatLng latLng) {
        aMap.animateCamera(CameraUpdateFactory.newLatLng(latLng));
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "movePosition":
                Map<String, Object> data = (Map<String, Object>) call.arguments;
                moveToPostion(new LatLng((double) data.get("lat"), (double) data.get("lng")));
                break;

            case "navSingle":
                Map<String, Object> location = (Map<String, Object>) call.arguments;
                double[] realLocation = AmapUtils.bd09_To_Gcj02((double) location.get("lat"), (double) location.get("lng"));
                AmapNaviPage.getInstance().showRouteActivity(mActivity,
                        new AmapNaviParams(null, null, new Poi((String) location.get("address"), new LatLng(realLocation[0], realLocation[1]), ""),
                                AmapNaviType.DRIVER), null);
                break;

            case "navRoute":
                passPoiList.clear();
                startPoi = null;
                endPoi = null;
                List<LocationBean> locationBeanList = new ArrayList<>();
                if (call.arguments != null) {
                    Type type = new TypeToken<List<LocationBean>>() {
                    }.getType();
                    locationBeanList.addAll(new Gson().fromJson((String) call.arguments, type));
                }

                if (locationBeanList.size() == 2) {
                    startPoi = new Poi(locationBeanList.get(0).getName(), new LatLng(locationBeanList.get(0).getLat(), locationBeanList.get(0).getLng()), "");
                    endPoi = new Poi(locationBeanList.get(1).getName(), new LatLng(locationBeanList.get(1).getLat(), locationBeanList.get(1).getLng()), "");

                } else if (locationBeanList.size() == 3) {
                    startPoi = new Poi(locationBeanList.get(0).getName(), new LatLng(locationBeanList.get(0).getLat(), locationBeanList.get(0).getLng()), "");
                    passPoiList.add(new Poi(locationBeanList.get(1).getName(), new LatLng(locationBeanList.get(1).getLat(), locationBeanList.get(1).getLng()), ""));
                    endPoi = new Poi(locationBeanList.get(2).getName(), new LatLng(locationBeanList.get(2).getLat(), locationBeanList.get(2).getLng()), "");

                } else {
                    startPoi = new Poi(locationBeanList.get(0).getName(), new LatLng(locationBeanList.get(0).getLat(), locationBeanList.get(0).getLng()), "");
                    locationBeanList.remove(0);
                    endPoi = new Poi(locationBeanList.get(locationBeanList.size() - 1).getName(),
                            new LatLng(locationBeanList.get(locationBeanList.size() - 1).getLat(),
                                    locationBeanList.get(locationBeanList.size() - 1).getLng()), "");
                    locationBeanList.remove(locationBeanList.size() - 1);
                    for (LocationBean locationBean : locationBeanList) {
                        passPoiList.add(new Poi(locationBean.getName(), new LatLng(locationBean.getLat(), locationBean.getLng()), ""));
                    }
                }
                AmapNaviPage.getInstance().showRouteActivity(mActivity,
                        new AmapNaviParams(startPoi, passPoiList, endPoi,
                                AmapNaviType.DRIVER), null);
                break;
        }

    }

    @Override
    public View getView() {
        return rootView;
    }

    @Override
    public void dispose() {
        aMap.clear();
        mapView.onDestroy();
    }


}
