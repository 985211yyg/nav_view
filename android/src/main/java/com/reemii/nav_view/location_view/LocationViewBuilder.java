package com.reemii.nav_view.location_view;

import android.app.Activity;

import com.amap.api.maps.model.LatLng;
import com.reemii.nav_view.bean.LocationBean;
import com.reemii.nav_view.bean.PositionBean;
import com.reemii.nav_view.map_view.LocationViewOptionSink;

import org.jetbrains.annotations.NotNull;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.plugin.common.BinaryMessenger;

/**
 * Author: yyg
 * Date: 2020-01-10 11:42
 * Description:
 */
public class LocationViewBuilder implements LocationViewOptionSink {
    private LocationViewController mLocationViewController;

    LocationViewController build(Activity activity, int viewId, BinaryMessenger messenger, AtomicInteger activityState) {
        mLocationViewController = new LocationViewController(activity, viewId, messenger, activityState);
        mLocationViewController.init();
        return mLocationViewController;
    }

    @Override
    public void setMarkers(@NotNull List<LocationBean> latlngs) {
        if (latlngs.size() == 0) return;
        mLocationViewController.setMarkers(latlngs);
    }

    @Override
    public void moveToPostion(@NotNull LatLng latLng) {
    }

}
