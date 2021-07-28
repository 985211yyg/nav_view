package com.reemii.nav_view.map_view

import com.amap.api.maps.model.LatLng
import com.reemii.nav_view.bean.PositionBean

/**
 * Author: yyg
 * Date: 2020-01-09 11:03
 * Description:
 */

public interface MapViewOptionSink {
    //添加图标
    fun setMarkers(latlngs: MutableList<PositionBean>)
    fun setMarkers(start: PositionBean, dest: PositionBean)
    fun moveToPostion(latLng: LatLng)
}