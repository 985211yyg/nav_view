package com.reemii.nav_view.bean

/**
 * Author: yyg
 * Date: 2020/3/17 10:28
 * Description:
 */
class LocationBean(var lat: Double, var lng: Double,var  name:String) {
    override fun toString(): String {
        return "LocationBean(lat=$lat, lng=$lng, name='$name')"
    }
}