package com.reemii.nav_view.heatmap;

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
import com.amap.api.maps.model.HeatmapTileProvider;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.LatLngBounds;
import com.amap.api.maps.model.MarkerOptions;
import com.amap.api.maps.model.MyLocationStyle;
import com.amap.api.maps.model.TileOverlayOptions;
import com.blankj.utilcode.util.FileIOUtils;
import com.blankj.utilcode.util.FileUtils;
import com.google.gson.Gson;
import com.reemii.nav_view.NavViewPlugin;
import com.reemii.nav_view.R;
import com.reemii.nav_view.bean.HeatData;
import com.reemii.nav_view.bean.PositionBean;
import com.reemii.nav_view.map_view.HeatMapOptionSink;

import org.jetbrains.annotations.NotNull;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
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
public class HeatHeatMapController implements PlatformView, MethodChannel.MethodCallHandler, HeatMapOptionSink {
    private View rootView;
    private TextureMapView mapView;
    private AMap aMap;
    private MyLocationStyle myLocationStyle;
    private MethodChannel methodChannel;
    private AtomicInteger mActivityState;
    private Activity mActivity;

    public HeatHeatMapController(Activity context, int viewId, BinaryMessenger binaryMessenger, AtomicInteger atomicInteger) {
        methodChannel = new MethodChannel(binaryMessenger, "com.reemii.heat_map.channel/" + String.valueOf(viewId));
        methodChannel.setMethodCallHandler(this);
        mActivity = context;
        rootView = LayoutInflater.from(context).inflate(R.layout.heat_map, null);
        mapView = rootView.findViewById(R.id.heatMap);
        mActivityState = atomicInteger;
        aMap = mapView.getMap();
        myLocationStyle = new MyLocationStyle();
        //定位
        myLocationStyle.myLocationType(MyLocationStyle.LOCATION_TYPE_LOCATE);
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
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "init":
                aMap.clear();
                HeatData heatData = new Gson().fromJson((String) call.arguments, HeatData.class);
                ArrayList<LatLng> latLngs = new ArrayList<>();
                for (HeatData.DataBean datum : heatData.getData()) {
                    latLngs.add(new LatLng(datum.getLat(), datum.getLng()));

                }
                // 构建热力图 HeatmapTileProvider
                HeatmapTileProvider.Builder builder = new HeatmapTileProvider.Builder();
                builder.data(latLngs); // 设置热力图绘制的数据
                // 初始化 TileOverlayOptions
                TileOverlayOptions tileOverlayOptions = new TileOverlayOptions();
                tileOverlayOptions.tileProvider(builder.build()); // 设置瓦片图层的提供者
                // 向地图上添加 TileOverlayOptions 类对象
                aMap.addTileOverlay(tileOverlayOptions);
                aMap.animateCamera(CameraUpdateFactory.newLatLng(new LatLng(25.111802, 99.167133)));
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

    @Override
    public void setMarkers(@NotNull List<LatLng> latlngs) {

    }
}
