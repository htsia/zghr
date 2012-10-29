package com.hr319wg.eva.pojo.bo;

public class EvaGradersBO {
	private String objectId;
	private String personId;
	private String s1;
	private String s2;
	private String s3;
	private String s4;
	private String s5;
	private String s6;
	private String s7;
	private String s8;
	private String s9;
	private String s10;
	private String f1;
	private String f2;
	private String f3;
	private String f4;
	private String f5;
	private String f6;
	private String f7;
	private String f8;
	private String f9;
	private String f10;
	private String s;
	private String f;
	
	public String getSvalueByIndix(int index){
		switch(index){
		case 1: return s1;
		case 2: return s2;
		case 3: return s3;
		case 4: return s4;
		case 5: return s5;
		case 6: return s6;
		case 7: return s7;
		case 8: return s8;
		case 9: return s9;
		case 10: return s10;
		default: return "";
		}
	}
	public String getFvalueByIndex(int index){
		switch(index){
		case 1: return f1;
		case 2: return f2;
		case 3: return f3;
		case 4: return f4;
		case 5: return f5;
		case 6: return f6;
		case 7: return f7;
		case 8: return f8;
		case 9: return f9;
		case 10: return f10;
		default: return "";
		}
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getObjectId() {
		return objectId;
	}
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}
	public String getS1() {
		return s1;
	}
	public void setS1(String s1) {
		this.s1 = s1;
	}
	public String getS2() {
		return s2;
	}
	public void setS2(String s2) {
		this.s2 = s2;
	}
	public String getS3() {
		return s3;
	}
	public void setS3(String s3) {
		this.s3 = s3;
	}
	public String getS4() {
		return s4;
	}
	public void setS4(String s4) {
		this.s4 = s4;
	}
	public String getS5() {
		return s5;
	}
	public void setS5(String s5) {
		this.s5 = s5;
	}
	public String getS6() {
		return s6;
	}
	public void setS6(String s6) {
		this.s6 = s6;
	}
	public String getS7() {
		return s7;
	}
	public void setS7(String s7) {
		this.s7 = s7;
	}
	public String getS8() {
		return s8;
	}
	public void setS8(String s8) {
		this.s8 = s8;
	}
	public String getS9() {
		return s9;
	}
	public void setS9(String s9) {
		this.s9 = s9;
	}
	public String getS10() {
		return s10;
	}
	public void setS10(String s10) {
		this.s10 = s10;
	}
	public String getF1() {
		return f1;
	}
	public void setF1(String f1) {
		this.f1 = f1;
	}
	public String getF2() {
		return f2;
	}
	public void setF2(String f2) {
		this.f2 = f2;
	}
	public String getF3() {
		return f3;
	}
	public void setF3(String f3) {
		this.f3 = f3;
	}
	public String getF4() {
		return f4;
	}
	public void setF4(String f4) {
		this.f4 = f4;
	}
	public String getF5() {
		return f5;
	}
	public void setF5(String f5) {
		this.f5 = f5;
	}
	public String getF6() {
		return f6;
	}
	public void setF6(String f6) {
		this.f6 = f6;
	}
	public String getF7() {
		return f7;
	}
	public void setF7(String f7) {
		this.f7 = f7;
	}
	public String getF8() {
		return f8;
	}
	public void setF8(String f8) {
		this.f8 = f8;
	}
	public String getF9() {
		return f9;
	}
	public void setF9(String f9) {
		this.f9 = f9;
	}
	public String getF10() {
		return f10;
	}
	public void setF10(String f10) {
		this.f10 = f10;
	}
	public String getS() {
		return s;
	}
	public void setS(String s) {
		this.s = s;
	}
	public String getF() {
		return f;
	}
	public void setF(String f) {
		this.f = f;
	}
}
