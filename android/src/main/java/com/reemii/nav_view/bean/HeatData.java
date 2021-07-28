package com.reemii.nav_view.bean;

import java.util.List;

/**
 * Author: yyg
 * Date: 2020/3/6 17:56
 * Description:
 */
public class HeatData {


    /**
     * code : 0
     * msg :
     * data : [{"lng":102.699240746876,"id":"df6d186ad0934bfbb0cd5d2965aa4dd2","lat":25.001337122695},{"lng":99.18700391485243,"id":"c068ea35e0bf475bb898a7d75a8aded2","lat":25.158649562850055},{"lng":99.18364420572917,"id":"77e429180ddd454cacb6173c0e8793db","lat":25.108397352430554},{"lng":99.177016,"id":"aee2bc02e7494647bd3372777560f387","lat":25.145941},{"lng":102.70590381586383,"id":"af866a7a650f4b60a77d951935bc95b9","lat":25.009632825799947},{"lng":99.19970052083333,"id":"4db5af314a7b4f9c9d4d8da9fdc72f16","lat":25.115581868489585},{"lng":99.192150272299,"id":"2448b60221dd400d899718baa3564f61","lat":25.1139511930377},{"lng":99.16511085765686,"id":"de28061423e24bd4a3d0d69ccac12966","lat":25.096806811053515},{"lng":99.165456,"id":"212dd22baf654269bd32c5e79218d24d","lat":25.096521},{"lng":98.876527,"id":"3595311f66364bd9b19f1a1e20a83a5a","lat":25.44899},{"lng":99.1653660011181,"id":"7ec768752c904d9f915ca9fc67e973ed","lat":25.0962486560289},{"lng":99.16524,"id":"0cda2809553a457098d011720167e100","lat":25.096739},{"lng":99.17412189506406,"id":"d54755f778984fa69480d27be85eb28c","lat":25.098012537177137},{"lng":99.1650523052443,"id":"470b455332b947608df4626f00da3207","lat":25.0961510122833},{"lng":98.6927149467655,"id":"b15f1aaee330488ca790fc1e41060c68","lat":24.5872979198243},{"lng":99.1570323275973,"id":"84f5a6e919574b7d800fd9afcda32149","lat":25.0183649230871},{"lng":99.1650890065018,"id":"cf5dad9cbb56452cb1697f4188a68259","lat":25.0960932477077},{"lng":99.165514,"id":"db588ec12f6c4d2b9a6a073c38e58d41","lat":25.096444},{"lng":102.66917628415027,"id":"d9f2910f07b741d98d6f1e82cc65888a","lat":25.09042333727091},{"lng":102.781913,"id":"9c0baab647994ca1beaee2f2babc8b2a","lat":24.972218},{"lng":102.744453,"id":"b732e6b7e97a4696be5121a3e2672fea","lat":25.047763},{"lng":98.876535,"id":"4375e668295c4a8682d99e9b5b1fa6ff","lat":25.449},{"lng":102.742975,"id":"66baf8819d6b4cbda53d45535ca32862","lat":25.069758},{"lng":104.298973,"id":"2d10afb7b0044299a971cb89769a307c","lat":26.858611}]
     */

    private int code;
    private String msg;
    private List<DataBean> data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {
        /**
         * lng : 102.699240746876
         * id : df6d186ad0934bfbb0cd5d2965aa4dd2
         * lat : 25.001337122695
         */

        private double lng;
        private String id;
        private double lat;

        public double getLng() {
            return lng;
        }

        public void setLng(double lng) {
            this.lng = lng;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public double getLat() {
            return lat;
        }

        public void setLat(double lat) {
            this.lat = lat;
        }
    }
}
