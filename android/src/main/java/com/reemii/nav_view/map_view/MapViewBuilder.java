package com.reemii.nav_view.map_view;

import android.app.Activity;

import com.amap.api.maps.model.LatLng;
import com.reemii.nav_view.bean.PositionBean;

import org.jetbrains.annotations.NotNull;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;

/**
 * Author: yyg
 * Date: 2020-01-10 11:42
 * Description:
 */
public class MapViewBuilder implements MapViewOptionSink {
    private MapViewController mMapViewController;

    MapViewController build(Activity activity, int viewId, BinaryMessenger messenger, AtomicInteger activityState) {
        mMapViewController = new MapViewController(activity, viewId, messenger, activityState);
        mMapViewController.init();
        return mMapViewController;
    }

    @Override
    public void setMarkers(@NotNull List<PositionBean> latlngs) {
        if (latlngs.size() == 0) return;
        mMapViewController.setMarkers(latlngs);
    }

    @Override
    public void moveToPostion(@NotNull LatLng latLng) {

    }

    @Override
    public void setMarkers(@NotNull PositionBean start, @NotNull PositionBean dest) {
        mMapViewController.setMarkers(start, dest);
    }
}
