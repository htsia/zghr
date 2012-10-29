<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
	function checkIn(){
		if(document.all("form1:title").value==""||document.all("form1:title").value==null){
			alert("标题不能为空！");
			return false;
		}else{
			forsubmit(document.forms(0)); 	
		}
	}
	function showProcessBar() {
	    x = document.body.clientWidth / 2 - 150;
	    y = document.body.clientHeight / 2;
	    document.all('processbar').style.top = y;
	    document.all('processbar').style.left = x;
	    document.all('processbar').style.display = "";
	 }
</script>

<x:saveState value="#{ResumeManageRecuitBB}" />
<h:form id="form1" enctype="multipart/form-data">
      <h:inputHidden id="initEdit" value="#{ResumeManageRecuitBB.initMaterEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" 简历管理 ->证书和个人材料 "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <h:outputText value="标题"></h:outputText>
               <h:inputText id="title" value="#{ResumeManageRecuitBB.materbo.title}"></h:inputText>
               <h:outputText value="材料"></h:outputText>
                <h:panelGroup>
              		<x:inputFileUpload styleClass="input" id="excelFile" value="#{ResumeManageRecuitBB.excelFile}"  storage="file" size="25" />
 					<h:commandButton value="上传"  styleClass="button01" action="#{ResumeManageRecuitBB.uploadFile}" onclick="showProcessBar();"/>
              </h:panelGroup>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="保存"  action="#{ResumeManageRecuitBB.saveMater}"  onclick="return checkIn()" styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
      <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
  </h:form>

