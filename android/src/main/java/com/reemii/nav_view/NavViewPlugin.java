package com.reemii.nav_view;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import androidx.annotation.NonNull;

import com.reemii.nav_view.heatmap.HeatMapFactory;
import com.reemii.nav_view.location_view.LocationViewFactory;
import com.reemii.nav_view.map_view.MapViewFactory;

import java.util.concurrent.atomic.AtomicInteger;

import io.flutter.app.FlutterApplication;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

/**
 * NavViewPlugin
 */
public class NavViewPlugin implements FlutterPlugin, ActivityAware, Application.ActivityLifecycleCallbacks {
    public static final String TAG = NavViewPlugin.class.getSimpleName();
    public static final int CREATED = 1;
    public static final int STARTED = 2;
    public static final int RESUMED = 3;
    public static final int PAUSED = 4;
    public static final int STOPPED = 5;
    public static final int DESTROYED = 6;
    private final AtomicInteger state = new AtomicInteger(0);
    private int activityHashCode;

    private static final String NAV_VIEW = "com.reemii.navView";
    private static final String MAP_VIEW = "com.reemii.mapView";
    private static final String HEAT_MAP = "com.reemii.heatMap";
    private static final String LOCATION_VIEW = "com.reemii.locationView";
    private FlutterPluginBinding mFlutterPluginBinding;
    private ActivityPluginBinding mActivityPluginBinding;
    private NavViewFactory mNavViewFactory;


    //新版自动调用
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        mFlutterPluginBinding = flutterPluginBinding;
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    //======activity的生命周期======
    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        activityHashCode = binding.getActivity().hashCode();
        mActivityPluginBinding = binding;
        binding.getActivity().getApplication().registerActivityLifecycleCallbacks(this);
        if (mFlutterPluginBinding.getApplicationContext() instanceof FlutterApplication) {
            //注册导航view
            mFlutterPluginBinding
                    .getPlatformViewRegistry()
                    .registerViewFactory(NAV_VIEW, new NavViewFactory(mFlutterPluginBinding.getBinaryMessenger(),
                            state, binding.getActivity()));
            //注册地图view
            mFlutterPluginBinding.getPlatformViewRegistry().registerViewFactory(MAP_VIEW,
                    new MapViewFactory(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity(), state));
            //注册热力图
            mFlutterPluginBinding.getPlatformViewRegistry().registerViewFactory(HEAT_MAP,
                    new HeatMapFactory(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity(), state));
            //注册位置图
            mFlutterPluginBinding.getPlatformViewRegistry().registerViewFactory(LOCATION_VIEW,
                    new LocationViewFactory(mFlutterPluginBinding.getBinaryMessenger(), binding.getActivity(), state));
        }


    }


    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }


    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {
        if (mActivityPluginBinding != null) {
            mActivityPluginBinding.getActivity().getApplication().unregisterActivityLifecycleCallbacks(this);
        }
    }


    //====生命周期====
    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        if (activity.hashCode() != activityHashCode) {
            return;
        }
        state.set(CREATED);
    }

    @Override
    public void onActivityStarted(Activity activity) {
        if (activity.hashCode() != activityHashCode) {
            return;
        }
        state.set(STARTED);
    }

    @Override
    public void onActivityResumed(Activity activity) {
        if (activity.hashCode() != activityHashCode) {
            return;
        }
        state.set(RESUMED);
    }

    @Override
    public void onActivityPaused(Activity activity) {
        if (activity.hashCode() != activityHashCode) {
            return;
        }
        state.set(PAUSED);
    }

    @Override
    public void onActivityStopped(Activity activity) {
        if (activity.hashCode() != activityHashCode) {
            return;
        }
        state.set(STOPPED);
    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
    }

    @Override
    public void onActivityDestroyed(Activity activity) {
        if (activity.hashCode() != activityHashCode) {
            return;
        }
        activity.getApplication().unregisterActivityLifecycleCallbacks(this);
        state.set(DESTROYED);
    }
}
