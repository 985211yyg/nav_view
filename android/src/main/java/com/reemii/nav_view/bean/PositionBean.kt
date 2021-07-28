package com.reemii.nav_view.bean

import com.amap.api.maps.model.LatLng

/**
 * Author: yyg
 * Date: 2020-01-10 17:06
 * Description:
 */
class PositionBean(var mLatLng: LatLng, var name: String) {
    override fun toString(): String {
        return "PositionBean{" +
                "mLatLng=" + mLatLng.toString() +
                ", name='" + name + '\'' +
                '}'
    }

}