package com.hr319wg.xys.eva.pojo.bo;

/**
 * Created by IntelliJ IDEA.
 * User: Administrator
 * Date: 12-6-2
 * Time: ����3:54
 * To change this template use File | Settings | File Templates.
 */
public class Xys360KeyBO {
    // 1����2̬��
    public static final String KEY_TYPE_NL="1";
    public static final String KEY_TYPE_TD="2";

    private String keyId;
    private String libId;
    private String keyName;
    private String keyType;
    private String keyDesc;

    private String keyTypeDes;

    public void initRow(){
        this.keyId=null;
        this.libId="";
        this.keyName="";
        this.keyType="";
        this.keyDesc="";
    }

    public String getKeyTypeDes() {
        if(keyType.equals(KEY_TYPE_NL)){
            keyTypeDes="����";
        }else if(keyType.equals(KEY_TYPE_TD)){
            keyTypeDes="̬��";
        }
        return keyTypeDes;
    }

    public void setKeyTypeDes(String keyTypeDes) {
        this.keyTypeDes = keyTypeDes;
    }

    public String getKeyId() {
        return keyId;
    }

    public void setKeyId(String keyId) {
        this.keyId = keyId;
    }

    public String getLibId() {
        return libId;
    }

    public void setLibId(String libId) {
        this.libId = libId;
    }

    public String getKeyName() {
        return keyName;
    }

    public void setKeyName(String keyName) {
        this.keyName = keyName;
    }

    public String getKeyType() {
        return keyType;
    }

    public void setKeyType(String keyType) {
        this.keyType = keyType;
    }

    public String getKeyDesc() {
        return keyDesc;
    }

    public void setKeyDesc(String keyDesc) {
        this.keyDesc = keyDesc;
    }
}
