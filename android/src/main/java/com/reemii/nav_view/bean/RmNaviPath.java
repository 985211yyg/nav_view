package com.reemii.nav_view.bean;

import java.util.List;

/**
 * Author: yyg
 * Date: 2019-09-12 11:45
 * Description:
 */
public class RmNaviPath {

    public int allLength;            ///导航路径总长度(单位:米)
    public int allTime;              ///导航路径所需的时间(单位:秒)
    public int stepsCount;           ///导航路线上分段的总数
    public List<RmNaviStep> mSteps;   ///导航路线的所有分段    ===》AMapNaviStep
    public List<RmNaviLatLng> latLngList;  ///导航路线的所有形状点  ===>NaviLatLng
    public RmNaviLatLng startPoi;    ///路线方案的起点坐标
    public RmNaviLatLng endPoi;      ///路线方案的终点坐标
    public long pathid;             ///当前路线的唯一标识ID
    public RmNaviLatLng center;     ///导航路线的中心点，即导航路径的最小外接矩形对角线的交点

    public static class RmNaviStep {
        public int mLength; //分段长度
        public int mTime;  //分段时间
        public int mStartIndex;  //开始索引
        public int mEndIndex;  //终止索引
        public List<RmNaviLatLng> mCoords;  //分段所有坐标

        public int getLength() {
            return mLength;
        }

        public void setLength(int length) {
            mLength = length;
        }

        public int getTime() {
            return mTime;
        }

        public void setTime(int time) {
            mTime = time;
        }

        public int getStartIndex() {
            return mStartIndex;
        }

        public void setStartIndex(int startIndex) {
            mStartIndex = startIndex;
        }

        public int getEndIndex() {
            return mEndIndex;
        }

        public void setEndIndex(int endIndex) {
            mEndIndex = endIndex;
        }

        public List<RmNaviLatLng> getCoords() {
            return mCoords;
        }

        public void setCoords(List<RmNaviLatLng> coords) {
            mCoords = coords;
        }
    }


    public static class RmNaviLatLng {
        public double latitude;  //经度
        public double longitude;   //维度


        public RmNaviLatLng(double latitude, double longitude) {
            this.latitude = latitude;
            this.longitude = longitude;
        }

        public RmNaviLatLng() {
        }



        public double getLatitude() {
            return latitude;
        }

        public void setLatitude(long latitude) {
            this.latitude = latitude;
        }

        public double getLongitude() {
            return longitude;
        }

        public void setLongitude(long longitude) {
            this.longitude = longitude;
        }
    }


    public int getAllLength() {
        return allLength;
    }

    public void setAllLength(int allLength) {
        this.allLength = allLength;
    }

    public int getAllTime() {
        return allTime;
    }

    public void setAllTime(int allTime) {
        this.allTime = allTime;
    }

    public int getStepsCount() {
        return stepsCount;
    }

    public void setStepsCount(int stepsCount) {
        this.stepsCount = stepsCount;
    }

    public List<RmNaviStep> getSteps() {
        return mSteps;
    }

    public void setSteps(List<RmNaviStep> steps) {
        mSteps = steps;
    }

    public List<RmNaviLatLng> getLatLngList() {
        return latLngList;
    }

    public void setLatLngList(List<RmNaviLatLng> latLngList) {
        this.latLngList = latLngList;
    }

    public RmNaviLatLng getStartPoi() {
        return startPoi;
    }

    public void setStartPoi(RmNaviLatLng startPoi) {
        this.startPoi = startPoi;
    }

    public RmNaviLatLng getEndPoi() {
        return endPoi;
    }

    public void setEndPoi(RmNaviLatLng endPoi) {
        this.endPoi = endPoi;
    }

    public long getPathid() {
        return pathid;
    }

    public void setPathid(long pathid) {
        this.pathid = pathid;
    }

    public RmNaviLatLng getCenter() {
        return center;
    }

    public void setCenter(RmNaviLatLng center) {
        this.center = center;
    }



}
