package com.hr319wg.attence.pojo.bo;


public class AttenceDayLogBO {
    private String personId;  //人员编号
    private String personName;
    private String attCard;
    private String subID;     //子集标示
    private String record;    //是否当前记录
    private String attenceDate; //年月日
    private String realityTime; //实际出勤
    private String shouldTime;  //应出勤
    private String attenceRate; //日出勤率
    private String lateTime;    //迟到次数
    private String earlyTime;   //早退次数
    private String awayTime;    //旷工次数
    private String leaveReasons;    //事假
    private String leaveSick;    //病假
    private String leaveMaternity;    //产假
    private String leaveWedding;    //婚假
    private String leaveHome;    //探亲假
    private String leaveYear;    //年假
    private String leaveIndustrialInjury;    //工伤假
    private String leaveArrangingFuneral;    //丧假
    private String evcctionValue;  //出差
    private String outWorkValue;  //公出
    private String publicHolidayValue; //公假
    private String timeOffValue; //倒休
    private String workAddValue; //工作日延时加班
    private String weekAddValue; //双休日加班
    private String feastAddValue; //节假日加班

    public String getValueByCode(String code){
      if("704".equals(code)){
            return lateTime;
      }else if("705".equals(code)){
            return earlyTime;
      }else if("706".equals(code)){
            return awayTime;
      }else if("707".equals(code)){
            return leaveReasons;
      }else if("708".equals(code)){
            return leaveSick;
      }else if("709".equals(code)){
            return leaveMaternity;
      }else if("710".equals(code)){
            return leaveWedding;
      }else if("711".equals(code)){
            return leaveHome;
      }else if("712".equals(code)){
            return leaveYear;
      }else if("713".equals(code)){
            return  leaveIndustrialInjury;
      }else if("714".equals(code)){
            return leaveArrangingFuneral;
      }else if("715".equals(code)){
            return evcctionValue;
      }else if("716".equals(code)){
            return  outWorkValue;
      }else if("717".equals(code)){
            return publicHolidayValue;
      }else if("718".equals(code)){
            return timeOffValue;
      }else if("719".equals(code)){
           return workAddValue;
      }else if("720".equals(code)){
           return weekAddValue;
      }else if("721".equals(code)){
          return feastAddValue;
      }
      return "";
    }
    private float getValue(String value){
       return Float.parseFloat(value);
    }
    public String returnCodeByInstance(){
        if(null!=lateTime&&getValue(lateTime)>0){
            return "704";
        }else if(null!=earlyTime&&getValue(earlyTime)>0){
            return "705";
        }else if(null!=awayTime&&getValue(awayTime)>0){
            return "706";
        }else if(null!=leaveReasons&&getValue(leaveReasons)>0){
            return "707";
        }else if(null!=leaveSick&&getValue(leaveSick)>0){
            return "708";
        }else if(null!=leaveMaternity&&getValue(leaveMaternity)>0){
            return "709";
        }else if(null!=leaveWedding&&getValue(leaveWedding)>0){
            return "710";
        }else if(null!=leaveHome&&getValue(leaveHome)>0){
            return "711";
        }else if(null!=leaveYear&&getValue(leaveYear)>0){
            return "712";
        }else if(null!=leaveIndustrialInjury&&getValue(leaveIndustrialInjury)>0){
            return "713";
        }else if(null!=leaveArrangingFuneral&&getValue(leaveArrangingFuneral)>0){
            return "714";
        }else if(null!=evcctionValue&&getValue(evcctionValue)>0){
            return "715";
        }else if(null!=outWorkValue&&getValue(outWorkValue)>0){
            return "716";
        }else if(null!=publicHolidayValue&&getValue(publicHolidayValue)>0){
            return "717";
        }else if(null!=timeOffValue&&getValue(timeOffValue)>0){
            return "718";
        }else if(null!=workAddValue&&getValue(workAddValue)>0){
            return "719";
        }else if(null!=weekAddValue&&getValue(weekAddValue)>0){
            return "720";
        }else if(null!=feastAddValue&&getValue(feastAddValue)>0){
            return "721";
        }
        return "00";
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public String getSubID() {
        return subID;
    }

    public void setSubID(String subID) {
        this.subID = subID;
    }

    public String getRecord() {
        return record;
    }

    public void setRecord(String record) {
        this.record = record;
    }

    public String getAttenceDate() {
        return attenceDate;
    }

    public void setAttenceDate(String attenceDate) {
        this.attenceDate = attenceDate;
    }

    public String getRealityTime() {
        return realityTime;
    }

    public void setRealityTime(String realityTime) {
        this.realityTime = realityTime;
    }

    public String getShouldTime() {
        return shouldTime;
    }

    public void setShouldTime(String shouldTime) {
        this.shouldTime = shouldTime;
    }

    public String getAttenceRate() {
        return attenceRate;
    }

    public void setAttenceRate(String attenceRate) {
        this.attenceRate = attenceRate;
    }

    public String getLateTime() {
        return lateTime;
    }

    public void setLateTime(String lateTime) {
        this.lateTime = lateTime;
    }

    public String getEarlyTime() {
        return earlyTime;
    }

    public void setEarlyTime(String earlyTime) {
        this.earlyTime = earlyTime;
    }

    public String getAwayTime() {
        return awayTime;
    }

    public void setAwayTime(String awayTime) {
        this.awayTime = awayTime;
    }

    public String getAttCard() {
        return attCard;
    }

    public void setAttCard(String attCard) {
        this.attCard = attCard;
    }

    public String getLeaveReasons() {
        return leaveReasons;
    }

    public void setLeaveReasons(String leaveReasons) {
        this.leaveReasons = leaveReasons;
    }

    public String getLeaveSick() {
        return leaveSick;
    }

    public void setLeaveSick(String leaveSick) {
        this.leaveSick = leaveSick;
    }

    public String getLeaveMaternity() {
        return leaveMaternity;
    }

    public void setLeaveMaternity(String leaveMaternity) {
        this.leaveMaternity = leaveMaternity;
    }

    public String getLeaveWedding() {
        return leaveWedding;
    }

    public void setLeaveWedding(String leaveWedding) {
        this.leaveWedding = leaveWedding;
    }

    public String getLeaveHome() {
        return leaveHome;
    }

    public void setLeaveHome(String leaveHome) {
        this.leaveHome = leaveHome;
    }

    public String getLeaveYear() {
        return leaveYear;
    }

    public void setLeaveYear(String leaveYear) {
        this.leaveYear = leaveYear;
    }

    public String getLeaveIndustrialInjury() {
        return leaveIndustrialInjury;
    }

    public void setLeaveIndustrialInjury(String leaveIndustrialInjury) {
        this.leaveIndustrialInjury = leaveIndustrialInjury;
    }

    public String getLeaveArrangingFuneral() {
        return leaveArrangingFuneral;
    }

    public void setLeaveArrangingFuneral(String leaveArrangingFuneral) {
        this.leaveArrangingFuneral = leaveArrangingFuneral;
    }

    public String getEvcctionValue() {
        return evcctionValue;
    }

    public void setEvcctionValue(String evcctionValue) {
        this.evcctionValue = evcctionValue;
    }

    public String getOutWorkValue() {
        return outWorkValue;
    }

    public void setOutWorkValue(String outWorkValue) {
        this.outWorkValue = outWorkValue;
    }

    public String getPublicHolidayValue() {
        return publicHolidayValue;
    }

    public void setPublicHolidayValue(String publicHolidayValue) {
        this.publicHolidayValue = publicHolidayValue;
    }

    public String getTimeOffValue() {
        return timeOffValue;
    }

    public void setTimeOffValue(String timeOffValue) {
        this.timeOffValue = timeOffValue;
    }

    public String getWorkAddValue() {
        return workAddValue;
    }

    public void setWorkAddValue(String workAddValue) {
        this.workAddValue = workAddValue;
    }

    public String getWeekAddValue() {
        return weekAddValue;
    }

    public void setWeekAddValue(String weekAddValue) {
        this.weekAddValue = weekAddValue;
    }

    public String getFeastAddValue() {
        return feastAddValue;
    }

    public void setFeastAddValue(String feastAddValue) {
        this.feastAddValue = feastAddValue;
    }


}

