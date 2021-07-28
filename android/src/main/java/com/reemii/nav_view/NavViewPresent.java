package com.reemii.nav_view;

import android.util.Log;

import com.amap.api.navi.model.AMapNaviPath;
import com.amap.api.navi.model.AMapNaviStep;
import com.amap.api.navi.model.NaviInfo;
import com.amap.api.navi.model.NaviLatLng;
import com.blankj.utilcode.util.SPUtils;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.reemii.nav_view.bean.RmNaviInfo;
import com.reemii.nav_view.bean.RmNaviPath;
import com.reemii.nav_view.bean.TraceBean;
import com.reemii.nav_view.bean.TraceResult;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;
import rxhttp.RxHttpPlugins;
import rxhttp.wrapper.param.RxHttp;

/**
 * Author: yyg
 * Date: 2019-12-26 10:22
 * Description:
 */
public class NavViewPresent {
    private static final String TAG = NavViewPresent.class.getSimpleName();
    private static final String TRACE_KEY = "naviPath";
    private static final String NAVI_INFO_KEY = "naviInfo";
    private static Gson mGson;
    private String sOrderId;
    private RmNaviInfo mCurrentRmNaviInfo;
    private TraceBean naviInfoTraceBean;
    private TraceBean naviPathTraceBean;
    private RmNaviInfo.Location mCurrentLocation;
    private List<RmNaviInfo.Location> currentLocations = new ArrayList<>();
    private String mDomain;
    private String mLocalDomain = "http://192.168.31.55:8081";
    private String mToken;

    private NavViewPresent(String orderId) {
        mGson = new Gson();
        sOrderId = orderId;
        mDomain = SPUtils.getInstance().getString("domain");
        mToken = SPUtils.getInstance().getString("token");
        RxHttp.setDebug(true);
    }

    public static NavViewPresent init(String orderId) {
        return new NavViewPresent(orderId);
    }

    public void uploadTrack(AMapNaviPath naviPath) {
        //===组织数据===
        RmNaviPath rmNaviPath = new RmNaviPath();
        rmNaviPath.allLength = naviPath.getAllLength();
        rmNaviPath.allTime = naviPath.getAllTime();
        rmNaviPath.stepsCount = naviPath.getStepsCount();
        rmNaviPath.center = new RmNaviPath.RmNaviLatLng(naviPath.getCenterForPath().getLatitude(), naviPath.getCenterForPath().getLongitude());
        rmNaviPath.startPoi = new RmNaviPath.RmNaviLatLng(naviPath.getStartPoint().getLatitude(), naviPath.getStartPoint().getLongitude());
        rmNaviPath.endPoi = new RmNaviPath.RmNaviLatLng(naviPath.getEndPoint().getLatitude(), naviPath.getEndPoint().getLongitude());
        rmNaviPath.pathid = naviPath.getPathid();

        List<RmNaviPath.RmNaviStep> steps = new ArrayList<>();
        for (AMapNaviStep step : naviPath.getSteps()) {
            RmNaviPath.RmNaviStep rmNaviStep = new RmNaviPath.RmNaviStep();
            rmNaviStep.mLength = step.getLength();
            rmNaviStep.mTime = step.getTime();
            rmNaviStep.mEndIndex = step.getEndIndex();
            rmNaviStep.mStartIndex = step.getStartIndex();
            List<RmNaviPath.RmNaviLatLng> rmNaviLatLngs = new ArrayList<>();
            for (NaviLatLng coord : step.getCoords()) {
                RmNaviPath.RmNaviLatLng rmNaviLatLng = new RmNaviPath.RmNaviLatLng();
                rmNaviLatLng.latitude = coord.getLatitude();
                rmNaviLatLng.longitude = coord.getLongitude();
                rmNaviLatLngs.add(rmNaviLatLng);
            }
            rmNaviStep.mCoords = rmNaviLatLngs;
            steps.add(rmNaviStep);
        }
        List<RmNaviPath.RmNaviLatLng> rmNaviLatLngList = new ArrayList<>();
        for (NaviLatLng naviLatLng : naviPath.getCoordList()) {
            RmNaviPath.RmNaviLatLng latLng = new RmNaviPath.RmNaviLatLng(naviLatLng.getLatitude(), naviLatLng.getLongitude());
            rmNaviLatLngList.add(latLng);
        }
        rmNaviPath.mSteps = steps;
        rmNaviPath.latLngList = rmNaviLatLngList;

        if (naviPathTraceBean == null) {
            naviPathTraceBean = new TraceBean();
        }
        naviPathTraceBean.setKey(TRACE_KEY);
        naviPathTraceBean.setOrder_id(sOrderId);
        naviPathTraceBean.setValue(mGson.toJson(rmNaviPath).replace("\\", ""));

        //=====上传轨迹信息====
        RxHttp.postJson(mDomain + "/staff/special/order/tripTrack/set?token=" + mToken)
                .addAll(mGson.toJson(naviPathTraceBean))
                .asObject(TraceResult.class)
                .subscribe(new Observer<TraceResult>() {
                    @Override
                    public void onSubscribe(Disposable d) {

                    }

                    @Override
                    public void onNext(TraceResult traceResult) {
                        Log.e(TAG, "onNext: " + traceResult.toString());
                        Log.e(TAG, "上传轨迹成功: ");
                    }

                    @Override
                    public void onError(Throwable e) {
                        Log.e(TAG, "onError: " + e.toString());
                        Log.e(TAG, "上传轨迹失败！ ");

                    }

                    @Override
                    public void onComplete() {

                    }
                });

    }

    private long lastUpdateTime = 0L;
    private final long lastUpdateInterval = 10 * 1000L;

    //一秒一次
    public void uploadNaviInfo(final NaviInfo naviInfo) {
        long currentTime = System.currentTimeMillis();
        if (currentTime - lastUpdateTime < lastUpdateInterval) {
            return;
        }
        lastUpdateTime = currentTime;
        //更新行驶信息
        if (mCurrentRmNaviInfo == null) {
            mCurrentRmNaviInfo = new RmNaviInfo();
        }
        mCurrentRmNaviInfo.setSegRemainTime(naviInfo.getCurStepRetainTime());
        mCurrentRmNaviInfo.setSegRemainDis(naviInfo.getCurStepRetainDistance());
        mCurrentRmNaviInfo.setRouteRemainTime(naviInfo.getPathRetainTime());
        mCurrentRmNaviInfo.setRouteRemainDis(naviInfo.getPathRetainDistance());
        mCurrentRmNaviInfo.setCurSegIndex(naviInfo.getCurStep());
        mCurrentRmNaviInfo.setCurrentSpeed(naviInfo.getCurrentSpeed());
        if (mCurrentLocation == null) {
            mCurrentLocation = new RmNaviInfo.Location(naviInfo.m_Latitude, naviInfo.m_Longitude);
        }
        mCurrentRmNaviInfo.setCurrentLocation(mCurrentLocation);
        if (naviInfoTraceBean == null) {
            naviInfoTraceBean = new TraceBean();
        }
        naviInfoTraceBean.setOrder_id(sOrderId);
        naviInfoTraceBean.setKey(NAVI_INFO_KEY);
        //上传信息
        mCurrentRmNaviInfo.setInfoIndex(System.currentTimeMillis());
//        mCurrentRmNaviInfo.setLocations(currentLocations);
        // 道格拉斯洋臣说这样改就可以减少司乘同显的数据量
        mCurrentRmNaviInfo.setLocations(null);
        naviInfoTraceBean.setValue(mGson.toJson(mCurrentRmNaviInfo).replace("\\", ""));
        //上传行驶信息
        RxHttp.postJson(mDomain + "/staff/special/order/tripTrack/set?token=" + mToken)
                .addAll(mGson.toJson(naviInfoTraceBean))
                .asObject(TraceResult.class)
                .subscribe(new Observer<TraceResult>() {
                    @Override
                    public void onSubscribe(Disposable d) {

                    }

                    @Override
                    public void onNext(TraceResult traceResult) {
                        Log.e(TAG, "onNext: " + traceResult);
                        Log.e(TAG, "上传行驶信息成功: ");
                    }

                    @Override
                    public void onError(Throwable e) {
                        Log.e(TAG, "上传行驶信息onError: " + e.toString());
                    }

                    @Override
                    public void onComplete() {

                    }
                });

    }

    //一秒多次
    public void uploadCurrentLocation(RmNaviInfo.Location location) {
        //添加位置信息
        currentLocations.add(location);
        //更新当前位置
        if (mCurrentLocation == null) {
            mCurrentLocation = new RmNaviInfo.Location();
        }
        mCurrentLocation.setLatitude(location.latitude);
        mCurrentLocation.setLongitude(location.longitude);
    }

}
