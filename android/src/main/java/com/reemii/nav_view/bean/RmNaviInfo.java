package com.reemii.nav_view.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Author: yyg
 * Date: 2019-09-12 11:46
 * Description:
 */
public class RmNaviInfo {
    public int RouteRemainDis;  //分段总距
    public int RouteRemainTime;  //分段总时间
    public int SegRemainDis;  //剩余距离
    public int SegRemainTime;  //剩余时间
    public int CurSegIndex; ///当前所在的segment段的index,从0开始
    public int CurrentSpeed;//当前速度
    private List<Location> Locations;
    private Location CurrentLocation;
    public long InfoIndex;

    public List<Location> getLocations() {
        return Locations;
    }

    public Location getCurrentLocation() {
        return CurrentLocation;
    }

    public void setCurrentLocation(Location currentLocation) {
        CurrentLocation = currentLocation;
    }

    public long getInfoIndex() {
        return InfoIndex;
    }

    public void setInfoIndex(long infoIndex) {
        this.InfoIndex = infoIndex;
    }

    public List<Location> getCurrentLocations() {
        return Locations;
    }

    public void setLocations(List<Location> currentLocations) {
        if (Locations == null) {
            Locations = new ArrayList<>();
        }
        if (currentLocations == null) {
            currentLocations = new ArrayList<>();
        }
        Locations.clear();
        Locations.addAll(currentLocations);
    }

    public int getCurrentSpeed() {
        return CurrentSpeed;
    }

    public void setCurrentSpeed(int currentSpeed) {
        CurrentSpeed = currentSpeed;
    }

    public int getRouteRemainDis() {
        return RouteRemainDis;
    }

    public void setRouteRemainDis(int routeRemainDis) {
        RouteRemainDis = routeRemainDis;
    }

    public int getRouteRemainTime() {
        return RouteRemainTime;
    }

    public void setRouteRemainTime(int routeRemainTime) {
        RouteRemainTime = routeRemainTime;
    }

    public int getSegRemainDis() {
        return SegRemainDis;
    }

    public void setSegRemainDis(int segRemainDis) {
        SegRemainDis = segRemainDis;
    }

    public int getSegRemainTime() {
        return SegRemainTime;
    }

    public void setSegRemainTime(int segRemainTime) {
        SegRemainTime = segRemainTime;
    }

    public int getCurSegIndex() {
        return CurSegIndex;
    }

    public void setCurSegIndex(int curSegIndex) {
        CurSegIndex = curSegIndex;
    }

    public static class Location {

        public Location(double latitude, double longitude) {
            this.latitude = latitude;
            this.longitude = longitude;
        }

        public Location() {
        }

        public double latitude;
        public double longitude;

        public double getLatitude() {
            return latitude;
        }

        public void setLatitude(double latitude) {
            this.latitude = latitude;
        }

        public double getLongitude() {
            return longitude;
        }

        public void setLongitude(double longitude) {
            this.longitude = longitude;
        }

        @Override
        public String toString() {
            return "Location{" +
                    "latitude=" + latitude +
                    ", longitude=" + longitude +
                    '}';
        }
    }
}
