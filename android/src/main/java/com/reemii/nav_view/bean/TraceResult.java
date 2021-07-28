package com.reemii.nav_view.bean;

/**
 * Author: yyg
 * Date: 2020/2/27 16:21
 * Description:
 */
public class TraceResult {

    /**
     * id : 5
     * order_id : 111111111
     * key : 87654321
     * value : 上传行驶信息
     */

    private int id;
    private String order_id;
    private String key;
    private String value;

    @Override
    public String toString() {
        return "TraceResult{" +
                "id=" + id +
                ", order_id='" + order_id + '\'' +
                ", key='" + key + '\'' +
                ", value='" + value + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getOrder_id() {
        return order_id;
    }

    public void setOrder_id(String order_id) {
        this.order_id = order_id;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
