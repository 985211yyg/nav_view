package com.reemii.nav_view;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.net.ConnectivityManager;
import android.os.Build;
import android.os.Bundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;

import com.amap.api.fence.GeoFence;
import com.amap.api.fence.GeoFenceClient;
import com.amap.api.fence.GeoFenceListener;
import com.amap.api.location.DPoint;
import com.amap.api.maps.AMap;
import com.amap.api.maps.model.BitmapDescriptorFactory;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.MarkerOptions;
import com.amap.api.navi.AMapNavi;
import com.amap.api.navi.AMapNaviListener;
import com.amap.api.navi.AMapNaviView;
import com.amap.api.navi.AMapNaviViewOptions;
import com.amap.api.navi.enums.AMapNaviOnlineCarHailingType;
import com.amap.api.navi.enums.AMapNaviViewShowMode;
import com.amap.api.navi.enums.NaviType;
import com.amap.api.navi.enums.SoundQuality;
import com.amap.api.navi.model.AMapCalcRouteResult;
import com.amap.api.navi.model.AMapLaneInfo;
import com.amap.api.navi.model.AMapModeCrossOverlay;
import com.amap.api.navi.model.AMapModelCross;
import com.amap.api.navi.model.AMapNaviCameraInfo;
import com.amap.api.navi.model.AMapNaviCross;
import com.amap.api.navi.model.AMapNaviInfo;
import com.amap.api.navi.model.AMapNaviLocation;
import com.amap.api.navi.model.AMapNaviPath;
import com.amap.api.navi.model.AMapNaviRouteNotifyData;
import com.amap.api.navi.model.AMapNaviTrafficFacilityInfo;
import com.amap.api.navi.model.AMapServiceAreaInfo;
import com.amap.api.navi.model.AimLessModeCongestionInfo;
import com.amap.api.navi.model.AimLessModeStat;
import com.amap.api.navi.model.NaviInfo;
import com.amap.api.navi.model.NaviLatLng;
import com.amap.api.services.core.LatLonPoint;
import com.amap.api.services.geocoder.GeocodeResult;
import com.amap.api.services.geocoder.GeocodeSearch;
import com.amap.api.services.geocoder.RegeocodeQuery;
import com.amap.api.services.geocoder.RegeocodeResult;
import com.autonavi.tbt.TrafficFacilityInfo;
import com.blankj.utilcode.util.ToastUtils;
import com.reemii.nav_view.bean.RmNaviInfo;

import java.io.ByteArrayOutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

/**
 * Author: yyg
 * Date: 2019-12-24 17:05
 * Description:
 */
public class NavViewController implements PlatformView,
        MethodChannel.MethodCallHandler,
        AMapNaviListener,
        NavViewOptionSink {
    private static final String TAG = NavViewController.class.getSimpleName();
    public static final String GEOFENCE_BROADCAST_ACTION = "com.location.apis.geofencedemo.broadcast";

    private static final String F_METHOD_SET_NAVI_INFO = "setNaviInfo";
    private static final String F_METHOD_SET_TURN_TIP_ICON = "setNaviTurnTipIcon";
    private static final String F_METHOD_SET_CROSS_TIP_ICON = "setNaviCrossTipIcon";

    private static final String A_METHOD_SET_NAV_CONFIG = "setNaviCrossTipIcon";
    private static final String A_METHOD_SWITCH_ROUTE_CURRENT = "setNaviCrossTipIcon";


    private View mRootView;
    private MethodChannel mMethodChannel;
    private EventChannel mEventChannel;
    private EventChannel.EventSink mEventSink;
    private Activity mContext;
    private AtomicInteger mActivityState;
    private NavViewPresent mNavViewPresent;
    //=============
    private AMapNavi mAMapNavi;                       //???????????????
    private AMapNaviView mAMapNaviView;               //??????view
    private AMap mAMap;                               //??????view????????????
    private GeocodeSearch mGeocodeSearch;             //?????????????????????????????????
    private AMapModeCrossOverlay mModeCrossOverlay;   //????????????????????????
    private List<NaviLatLng> startNavLatLng, endNavLatLng, throughNavLatLng;
    private AMapNaviPath mCurrentPath;
    private LatLng mCurrentLatLng;
    //========
    private MethodChannel.Result mResult;
    private boolean isOnTrip = false;

    //??????????????????
    protected NaviLatLng mEndLatlng = new NaviLatLng(22.652, 113.966);
    //??????????????????
    protected NaviLatLng mStartLatlng = new NaviLatLng(22.540332, 113.939961);
    //???????????????????????????
    protected final List<NaviLatLng> sList = new ArrayList<NaviLatLng>();
    //???????????????????????????
    protected final List<NaviLatLng> eList = new ArrayList<NaviLatLng>();
    //??????????????????
    private GeoFenceClient mGeoFenceClient;
    //location receiver
    private BroadcastReceiver mGeoFenceReceiver;


    public NavViewController(Activity context, BinaryMessenger messenger, int viewId, AtomicInteger activityState) {
        Log.e(TAG, "?????????NavViewController: ");
        mContext = context;
        mActivityState = activityState;
        mRootView = LayoutInflater.from(mContext).inflate(R.layout.nav_view, null);
        mAMapNaviView = mRootView.findViewById(R.id.flutter_nav_navView);
        mMethodChannel = new MethodChannel(messenger, "com.reemii.nav_view.channel/" + String.valueOf(viewId));
        mEventChannel = new EventChannel(messenger, "com.reemii.nav_view.Event/" + String.valueOf(viewId));
        mMethodChannel.setMethodCallHandler(this);
        mEventChannel.setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                mEventSink = events;
            }

            @Override
            public void onCancel(Object arguments) {

            }
        });
        mGeocodeSearch = new GeocodeSearch(context);
        initNavView();
        initGeoFence();
        initListener();
    }

    private void initGeoFence() {
        mGeoFenceClient = new GeoFenceClient(mContext);
        //??????????????????????????????
        mGeoFenceClient.setActivateAction(GeoFenceClient.GEOFENCE_IN);
        mGeoFenceReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (intent.getAction().equals(GEOFENCE_BROADCAST_ACTION)) {
                    //??????????????????
                    //??????Bundle
                    Bundle bundle = intent.getExtras();
                    //?????????????????????
                    int status = bundle.getInt(GeoFence.BUNDLE_KEY_FENCESTATUS);
                    if (status == GeoFenceClient.GEOFENCE_IN) {
                        mEventSink.success("GEOFENCE_IN");
                    }
                }
            }
        };
        //????????????????????? ????????????
        mGeoFenceClient.setGeoFenceListener(new GeoFenceListener() {
            @Override
            public void onGeoFenceCreateFinished(List<GeoFence> list, int errorCode, String s) {
                if (errorCode == GeoFence.ADDGEOFENCE_SUCCESS) {
                    //??????????????????
                    mGeoFenceClient.createPendingIntent(GEOFENCE_BROADCAST_ACTION);
                    //????????????
                    IntentFilter filter = new IntentFilter(
                            ConnectivityManager.CONNECTIVITY_ACTION);
                    filter.addAction(GEOFENCE_BROADCAST_ACTION);
                    mContext.registerReceiver(mGeoFenceReceiver, filter);

                } else {
                    ToastUtils.showShort("???????????????????????????");
                }

            }
        });


    }

    private void initListener() {
        //????????????????????????
        mGeocodeSearch.setOnGeocodeSearchListener(new GeocodeSearch.OnGeocodeSearchListener() {
            @Override
            public void onRegeocodeSearched(RegeocodeResult regeocodeResult, int resultCode) {
                //??????????????????
                if (resultCode == 1000) {
                    //??????
                    mResult.success(regeocodeResult.getRegeocodeAddress().getFormatAddress());

                } else {
                    mResult.error(String.valueOf(resultCode), "??????????????????,???????????????!", null);
                }
            }

            @Override
            public void onGeocodeSearched(GeocodeResult geocodeResult, int i) {

            }
        });

    }


    //????????????flutter?????????
    @Override
    public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
        mResult = result;
        switch (call.method) {
            //????????????
            case "nav/calcuteRoute":
                Log.e(TAG, "onMethodCall: ????????????");
                int strategy = 0;
                try {
                    strategy = mAMapNavi.strategyConvert(true, false, false, true, false);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                mAMapNavi.calculateDriveRoute(startNavLatLng, endNavLatLng, null, strategy);
                break;
            //?????????????????????????????????,??????????????????????????????
            case "nav/passengerLocation":
                mAMap.addMarker(new MarkerOptions()
                        .position(new LatLng(22.652, 113.966))
                        .icon(BitmapDescriptorFactory.fromResource(R.drawable.ic_passenger))
                        .title("????????????"));
                break;
            case "nav/startNav":
                Log.e(TAG, "onMethodCall: ????????????");
                mAMapNavi.startNavi(NaviType.GPS);

                // ?????????????????????
                DPoint endPoint = new DPoint();
                endPoint.setLatitude(mEndLatlng.getLatitude());
                endPoint.setLongitude(mEndLatlng.getLongitude());
                mGeoFenceClient.addGeoFence(endPoint, 100, "12345");

                result.success("");
                break;

            case "nav/parsingAddress":
                Log.e(TAG, "onMethodCall: ????????????");
                Map<String, Double> location = (Map<String, Double>) call.arguments;
                mGeocodeSearch.getFromLocationAsyn(new RegeocodeQuery(new LatLonPoint(location.get("lat"),
                        location.get("lng")), 200, GeocodeSearch.AMAP));
                break;
            case "nav/dispose":
                Log.e(TAG, "onMethodCall: dispose");
                dispose();
                result.success(true);
                break;
            case "nav/strategyConvert":
                Log.e(TAG, "onMethodCall: strategyConvert");
                Map<String, Boolean> strategyMap = (Map<String, Boolean>) call.arguments;
                strategy = 0;
                try {
                    strategy = mAMapNavi.strategyConvert(
                            strategyMap.get("avoidCongestion"),
                            strategyMap.get("avoidHighway"),
                            strategyMap.get("avoidCost"),
                            strategyMap.get("prioritiseHighway"),
                            strategyMap.get("multipleRoute"));
                } catch (Exception e) {
                    e.printStackTrace();
                }
                mAMapNavi.calculateDriveRoute(startNavLatLng, endNavLatLng, null, strategy);
                break;
            case "nav/showModeAction":
                Log.e(TAG, "onMethodCall: showModeAction");
                if (mAMapNaviView.isRouteOverviewNow()) {
                    mAMapNaviView.setShowMode(AMapNaviViewShowMode.SHOW_MODE_LOCK_CAR);
                } else {
                    mAMapNaviView.setShowMode(AMapNaviViewShowMode.SHOW_MODE_DISPLAY_OVERVIEW);
                }
                result.success(true);
                break;


        }

    }

    //=======
    private void initNavView() {
        mAMapNaviView.onCreate(null);
        AMapNaviViewOptions options = mAMapNaviView.getViewOptions();
        options.setLayoutVisible(false);
        options.setLeaderLineEnabled(Color.RED);
        options.setAfterRouteAutoGray(true);
        options.setTrafficBarEnabled(true);
        options.setModeCrossDisplayShow(false);
        options.setAutoChangeZoom(true);  //????????????
        options.setDrawBackUpOverlay(true);
        options.setAutoDrawRoute(true);  //?????????????????????
        options.setAutoLockCar(true); //6???????????????????????????
        mAMapNaviView.setViewOptions(options);

        mAMap = mAMapNaviView.getMap();
        mModeCrossOverlay = new AMapModeCrossOverlay(mContext, mAMap);
        mGeocodeSearch = new GeocodeSearch(mContext);
        mAMapNavi = AMapNavi.getInstance(mContext);
        mAMapNavi.addAMapNaviListener(this);  //????????????
        mAMapNavi.setUseInnerVoice(true);  //??????????????????
        //????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????
        mAMapNavi.setAMapNaviOnlineCarHailingType(AMapNaviOnlineCarHailingType.TRANSPORT);
        mAMapNavi.setSoundQuality(SoundQuality.High_Quality);

    }

    //???????????????
    void init() {
        Log.e(TAG, "init: " + String.valueOf(mActivityState.get()));
        switch (mActivityState.get()) {
            case NavViewPlugin.CREATED:
                break;
            case NavViewPlugin.RESUMED:
                break;
            case NavViewPlugin.STARTED:
                break;
            case NavViewPlugin.PAUSED:
                break;
            case NavViewPlugin.STOPPED:
                break;
            case NavViewPlugin.DESTROYED:
//                mAMapNavi.stopSpeak();
//                mAMapNavi.stopNavi();
//                mAMapNavi.destroy();
//                mAMapNaviView.onDestroy();
                break;


        }
    }

    //====????????????????????????===
    @Override
    public void setNavLatLngData(List<NaviLatLng> startNavLatLng, List<NaviLatLng> endNavLatLng, List<NaviLatLng> throughNavLatLng, String desTitle, String orderId) {
        this.startNavLatLng = startNavLatLng;
        this.endNavLatLng = endNavLatLng;
        this.throughNavLatLng = throughNavLatLng;
        mNavViewPresent = NavViewPresent.init(orderId);
    }


    //??????????????????
    @RequiresApi(api = Build.VERSION_CODES.JELLY_BEAN_MR1)
    @Override
    public View getView() {
        Log.e(TAG, "getView: ");
        return mRootView;
    }

    //????????????view??????????????????    ????????????????????????
    @Override
    public void onFlutterViewAttached(View flutterView) {
        Log.e(TAG, "onFlutterViewAttached: ");
    }


    //???????????????????????? ??????????????????????????????????????????????????????
    @Override
    public void onFlutterViewDetached() {
        Log.e(TAG, "onFlutterViewDetached: ");
    }

    //????????????
    @Override
    public void dispose() {
        Log.e(TAG, "dispose: ");
        if (mAMapNaviView != null) {
            mAMapNaviView.onDestroy();
            mAMapNaviView = null;
        }
        if (mAMapNavi != null) {
            mAMapNavi.stopSpeak();
            mAMapNavi.stopNavi();
            mAMapNavi.destroy();
            mAMapNavi = null;
        }
        //clear
        mGeoFenceClient.removeGeoFence();
        if (isOnTrip) {
            mContext.unregisterReceiver(mGeoFenceReceiver);
            mGeoFenceReceiver = null;
        }

    }


    @Override
    public void onInitNaviFailure() {
        Log.e(TAG, "onInitNaviFailure: ");

    }

    @Override
    public void onInitNaviSuccess() {
        Log.e(TAG, "onInitNaviSuccess: ");
    }

    @Override
    public void onCalculateRouteSuccess(AMapCalcRouteResult aMapCalcRouteResult) {
        Log.e(TAG, "onCalculateRouteSuccess: ");
        mCurrentPath = mAMapNavi.getNaviPath();

        //????????????????????????????????????
        mEventSink.success("calculateSuccess");
        mNavViewPresent.uploadTrack(mCurrentPath);

        Map<String, String> infoConfig = new HashMap<>();
        infoConfig.put("residueTime", "?????? " + BigDecimal.valueOf((double) mCurrentPath.getAllLength() / 1000).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "?????? " +
                mCurrentPath.getAllTime() / 60 + "??????");
        infoConfig.put("nextRoudDis", String.valueOf(0));
        infoConfig.put("roudeName", mCurrentPath.getMainRoadInfo());
        long arriveTime = System.currentTimeMillis() + mCurrentPath.getAllTime() * 1000;
        infoConfig.put("overTime", new SimpleDateFormat("HH:mm", Locale.CHINA).format(new Date(arriveTime)));
        mMethodChannel.invokeMethod(F_METHOD_SET_NAVI_INFO, infoConfig);
    }

    @Override
    public void onCalculateRouteFailure(AMapCalcRouteResult aMapCalcRouteResult) {
        Log.e(TAG, "onCalculateRouteFailure: ????????????"+aMapCalcRouteResult.getErrorDetail());
        mEventSink.error("calculateFailed", "calculateFailed", null);
    }

    /**
     * @param ints
     * @deprecated
     */
    @Override
    public void onCalculateRouteSuccess(int[] ints) {

    }


    /**
     * @param i
     * @deprecated
     */
    @Override
    public void onCalculateRouteFailure(int i) {

    }

    //????????????
    @Override
    public void onNaviInfoUpdate(NaviInfo naviInfo) {
//        mNavTime.setText(String.format("??????%s??????   ??????%s??????", new BigDecimal((double) naviInfo.getPathRetainDistance() / 1000)
//                .setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue(), naviInfo.getPathRetainTime() / 60));
//        mNextTurnTipView.setIconType(naviInfo.getIconType());
//        mNavCurrentDistance.setText(naviInfo.getCurStepRetainDistance() + "???");
//        mNavRoadName.setText(naviInfo.getNextRoadName());
//        mNavTotalDistance.setText("??????" + new BigDecimal((double) naviInfo.getPathRetainDistance() / 1000).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "??????");
//        mNavTotalTime.setText("??????" + naviInfo.getPathRetainTime() / 60 + "??????");
//        mNavTotalArrivedTime.setText("??????" + TimeUtils.getString(new Date(), new SimpleDateFormat("HH:mm"), naviInfo.getPathRetainTime(), TimeConstants.SEC) + "??????");
        if (naviInfo.getIconBitmap() != null) {
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            naviInfo.getIconBitmap().compress(Bitmap.CompressFormat.JPEG, 80, stream);
            byte[] byteArray = stream.toByteArray();
            mMethodChannel.invokeMethod(F_METHOD_SET_TURN_TIP_ICON, byteArray);
        }

        Map<String, String> infoConfig = new HashMap<>();
        infoConfig.put("residueTime", "?????? " + BigDecimal.valueOf((double) naviInfo.getPathRetainDistance() / 1000).setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue() + "?????? " +
                naviInfo.getPathRetainTime() / 60 + "??????");
        infoConfig.put("nextRoudDis", String.valueOf(naviInfo.getCurStepRetainDistance()));
        infoConfig.put("roudeName", TextUtils.isEmpty(naviInfo.getNextRoadName()) ? "????????????" : naviInfo.getNextRoadName());
        long arriveTime = System.currentTimeMillis() + naviInfo.getPathRetainTime() * 1000;
        infoConfig.put("overTime", new SimpleDateFormat("HH:mm", Locale.CHINA).format(new Date(arriveTime)));
        mMethodChannel.invokeMethod(F_METHOD_SET_NAVI_INFO, infoConfig);
        //???????????????
        mNavViewPresent.uploadNaviInfo(naviInfo);
    }

    //????????????
    @Override
    public void onLocationChange(AMapNaviLocation aMapNaviLocation) {
        mCurrentLatLng = new LatLng(aMapNaviLocation.getCoord().getLatitude(), aMapNaviLocation.getCoord().getLongitude());
        mNavViewPresent.uploadCurrentLocation(new RmNaviInfo.Location(aMapNaviLocation.getCoord().getLatitude(), aMapNaviLocation.getCoord().getLongitude()));
    }


    @Override
    public void onStartNavi(int i) {
        Log.e(TAG, "onStartNavi: " + i + "");

    }

    @Override
    public void onTrafficStatusUpdate() {

    }


    /**
     * @param i
     * @param s
     * @deprecated
     */
    @Override
    public void onGetNavigationText(int i, String s) {

    }

    @Override
    public void onGetNavigationText(String s) {
        mAMapNavi.playTTS(s, true);
    }

    @Override
    public void onEndEmulatorNavi() {

    }

    @Override
    public void onArriveDestination() {

    }

    /**
     * @deprecated
     */
    @Override
    public void onReCalculateRouteForYaw() {

    }

    /**
     * @deprecated
     */
    @Override
    public void onReCalculateRouteForTrafficJam() {

    }

    @Override
    public void onArrivedWayPoint(int i) {

    }

    @Override
    public void onGpsOpenStatus(boolean b) {

    }


    /**
     * @param aMapNaviInfo
     * @deprecated
     */
    @Override
    public void onNaviInfoUpdated(AMapNaviInfo aMapNaviInfo) {

    }

    @Override
    public void updateCameraInfo(AMapNaviCameraInfo[] aMapNaviCameraInfos) {

    }

    @Override
    public void updateIntervalCameraInfo(AMapNaviCameraInfo aMapNaviCameraInfo, AMapNaviCameraInfo aMapNaviCameraInfo1, int i) {

    }

    @Override
    public void onServiceAreaUpdate(AMapServiceAreaInfo[] aMapServiceAreaInfos) {

    }

    @Override
    public void showCross(AMapNaviCross aMapNaviCross) {

    }

    @Override
    public void hideCross() {

    }

    @Override
    public void showModeCross(AMapModelCross aMapModelCross) {
        mModeCrossOverlay.showCrossOverlay(aMapModelCross.getPicBuf1());
        mMethodChannel.invokeMethod(F_METHOD_SET_CROSS_TIP_ICON, aMapModelCross.getPicBuf1());
    }

    @Override
    public void hideModeCross() {
        mModeCrossOverlay.hideCrossOverlay();

    }

    /**
     * @param aMapLaneInfos
     * @param bytes
     * @param bytes1
     * @deprecated
     */
    @Override
    public void showLaneInfo(AMapLaneInfo[] aMapLaneInfos, byte[] bytes, byte[] bytes1) {

    }

    @Override
    public void showLaneInfo(AMapLaneInfo aMapLaneInfo) {

    }

    @Override
    public void hideLaneInfo() {

    }

    /**
     * @param i
     * @deprecated
     */
    @Override
    public void notifyParallelRoad(int i) {

    }

    /**
     * @param aMapNaviTrafficFacilityInfos
     * @deprecated
     */
    @Override
    public void OnUpdateTrafficFacility(AMapNaviTrafficFacilityInfo[] aMapNaviTrafficFacilityInfos) {

    }

    /**
     * @param aMapNaviTrafficFacilityInfo
     * @deprecated
     */
    @Override
    public void OnUpdateTrafficFacility(AMapNaviTrafficFacilityInfo aMapNaviTrafficFacilityInfo) {

    }

    /**
     * @param trafficFacilityInfo
     * @deprecated
     */
    @Override
    public void OnUpdateTrafficFacility(TrafficFacilityInfo trafficFacilityInfo) {

    }

    /**
     * @param aimLessModeStat
     * @deprecated
     */
    @Override
    public void updateAimlessModeStatistics(AimLessModeStat aimLessModeStat) {

    }

    /**
     * @param aimLessModeCongestionInfo
     * @deprecated
     */
    @Override
    public void updateAimlessModeCongestionInfo(AimLessModeCongestionInfo aimLessModeCongestionInfo) {

    }

    @Override
    public void onPlayRing(int i) {

    }


    @Override
    public void onNaviRouteNotify(AMapNaviRouteNotifyData aMapNaviRouteNotifyData) {

    }

//    @Override
//    public void onGpsSignalWeak(boolean b) {
//
//    }

}
