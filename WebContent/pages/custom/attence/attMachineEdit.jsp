<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
          function forsave(){
              if(document.all("form1:attname").value=="")
              {
                  alert("����д���ڻ�����");
                   return false;
              }
			  if(document.all("form1:ip").value=="")
              {
            	  alert("����д���ڻ�IP");
                  return false;
              }

              if(document.all("form1:ip").value!="")
              {
            	  var reg= /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/
            	  var vald = reg.exec(document.all("form1:ip").value);
		          if (vald == null) {
	            	  alert("���ڻ�IP�Ƿ�");
	                  return false;
		          }
              }
              return true;
           }         
          var status = document.all("form1:status").value;
			if(status!=null && status!=''){
				alert(status);
				self.close();
			}
      </script>
<x:saveState value="#{attMachineMgrBB}" />
<h:inputHidden value="#{attMachineMgrBB.editInit}"/>
<h:form id="form1">
	<h:inputHidden id="status" value="#{attMachineMgrBB.operStatus}"/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="���ڹ���-> ���ڻ�����" />
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid columns="1" width="100%" align="left">
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02" styleClass="table03" align="center" >
			<h:outputText value="���ڻ�����"/>
			<h:inputText id="attname" size="27" value="#{attMachineMgrBB.bo.machineName}"/>
			<h:outputText value="���ڻ�IP"/>
			<h:inputText id="ip" size="27" value="#{attMachineMgrBB.bo.machineIP}"></h:inputText>
			<h:outputText value="�Ƿ������ڻ�"/>
			<h:selectOneMenu value="#{attMachineMgrBB.bo.machineType}">
				<c:selectItem itemLabel="��" itemValue="0"/>
				<c:selectItem itemLabel="��" itemValue="1"/>
			</h:selectOneMenu>
		</h:panelGrid>
		<h:panelGrid align="right">
			<h:commandButton value="����" onclick="return forsave();"  action="#{attMachineMgrBB.save}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>
</h:form>


