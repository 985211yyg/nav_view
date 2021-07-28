package com.reemii.nav_view.heatmap;

import android.app.Activity;

import com.amap.api.maps.model.LatLng;
import com.reemii.nav_view.map_view.HeatMapOptionSink;

import org.jetbrains.annotations.NotNull;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;

/**
 * Author: yyg
 * Date: 2020-01-10 11:42
 * Description:
 */
public class HeatHeatMapBuilder implements HeatMapOptionSink {
    private HeatHeatMapController mHeatHeatMapController;

    HeatHeatMapController build(Activity activity, int viewId, BinaryMessenger messenger, AtomicInteger activityState) {
        mHeatHeatMapController = new HeatHeatMapController(activity, viewId, messenger, activityState);
        mHeatHeatMapController.init();
        return mHeatHeatMapController;
    }

    @Override
    public void setMarkers(@NotNull List<LatLng> latlngs) {

    }
}
