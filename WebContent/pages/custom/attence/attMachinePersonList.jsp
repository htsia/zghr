<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
      function process(){
			x = document.body.clientWidth / 2 - 150;
			y = document.body.clientHeight / 2;
			document.all('processbar').style.top = y;
			document.all('processbar').style.left = x;
			document.all('processbar').style.display = "";
      }
      function selIP(){
        var selId=window.showModalDialog("/custom/attence/attMachineList.jsf?machineType=1", "", "dialogWidth:600px; dialogHeight:500px; status:0;resizable:yes");
        if(selId==null || selId.length<=0){
        	return false;
        }else{
        	document.all("form1:IPStr").value=selId;
        }
    	process();
        return true;
      }
      function forSel() {
	    	PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
	    	var type = document.all("form1:personType").value;
	    	if(type==null || type==""){
	    		return false;
	    	}
	    	return true;
	   }
      function collect(){
    	  var p = confirm("ȷ��Ҫ�����ɼ�ָ����");
    	  if(p){
    		  process();
    		  return true;
    	  }
    	  return false;
      }
	  function setpwd(userID){
		  window.showModalDialog("/custom/attence/setAttPwd.jsf?userID="+userID, "", "dialogWidth:300px; dialogHeight:150px; status:0;resizable:yes");
	  }
	  function setManager(){
		  if(confirm('ȷ������Ϊ����Ա��')){
			  process();
			  return true;
		  }
		  return false;
	  }
	  function cancelManager(){
		  if(confirm('ȷ��ȡ������Ա��')){
			  process();
			  return true;
		  }
		  return false;
	  }
</script>
<x:saveState value="#{attMachinePersonMgrBB}"/>
<h:inputHidden value="#{attMachinePersonMgrBB.pageInit}"/>
<h:form id="form1">
	<h:inputHidden id="IPStr" value="#{attMachinePersonMgrBB.IPStr}"/>
	<h:inputHidden id="personType" value="#{attMachinePersonMgrBB.personType}"/>
    <h:inputHidden id="personTypeValue" value="#{attMachinePersonMgrBB.personTypeValue}"/>
    <f:verbatim>

    <table height=96% width=100%>
     <tr><td height=8>
     </f:verbatim>
     <h:outputText escape="false" value="<strong>����������</strong>" ></h:outputText>
     <h:commandButton value="�ɼ�ָ��" onclick="return collect();" styleClass="button01"  action="#{attMachinePersonMgrBB.collect}"/>
     <h:commandButton value="�ַ�" styleClass="button01" onclick="return selIP();" action="#{attMachinePersonMgrBB.issue}"/>
     <f:verbatim>
     </td>
     <td align="right">
    </f:verbatim>
        <h:outputText value="�Ѳ�ָ��"/>
        <h:selectBooleanCheckbox value="#{attMachinePersonMgrBB.collected}" onclick="submit();" valueChangeListener="#{attMachinePersonMgrBB.doCollected}"/>
        <h:outputText value="δ��ָ��"/>
        <h:selectBooleanCheckbox value="#{attMachinePersonMgrBB.uncollected}" onclick="submit();" valueChangeListener="#{attMachinePersonMgrBB.doUncollected}"/>
        <h:outputText value="������"/>
        <h:selectBooleanCheckbox value="#{attMachinePersonMgrBB.hasPwd}" onclick="submit();" valueChangeListener="#{attMachinePersonMgrBB.doHasPwd}"/>
        <h:outputText value="������"/>
        <h:selectBooleanCheckbox value="#{attMachinePersonMgrBB.notHasPwd}" onclick="submit();" valueChangeListener="#{attMachinePersonMgrBB.doNotHasPwd}"/>
        <h:outputText value="  "/>
        <h:outputText value="��������"/>
        <h:inputText value="#{attMachinePersonMgrBB.nameStr}" styleClass="input" size="10"/> 
        <h:commandButton styleClass="button01" value="��Ա���" onclick="return forSel();" action="#{attMachinePersonMgrBB.doQuery}"/>
        <h:commandButton styleClass="button01" value="��ѯ" action="#{attMachinePersonMgrBB.doQuery}"/>
    <f:verbatim>
     </td>
     </tr>
     <tr><td colspan=2 align="right" height=8>
    </f:verbatim>
         <h:panelGroup>
             <h:outputText value="��¼��:#{attMachinePersonMgrBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ҳ��:#{attMachinePersonMgrBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ÿҳ��#{attMachinePersonMgrBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="��ǰΪ��#{attMachinePersonMgrBB.pagevo.currentPage}ҳ"></h:outputText>
             <h:commandButton id="first" value="��ҳ" action="#{attMachinePersonMgrBB.first}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{attMachinePersonMgrBB.pre}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{attMachinePersonMgrBB.next}" styleClass="button01"></h:commandButton>
             <h:commandButton value="βҳ" action="#{attMachinePersonMgrBB.last}" styleClass="button01"></h:commandButton>
         </h:panelGroup>
<f:verbatim>
     </td></tr> 
    <tr><td colspan=2>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
   </f:verbatim>
       <h:dataTable value="#{attMachinePersonMgrBB.list}" var="list" align="center"  id="dateList"
                    headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                    styleClass="table03" width="100%" >
           <h:column>
               <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
               <h:outputText value="#{list.personCode}"/>
           </h:column>
           <h:column>
               <c:facet name="header"><h:outputText value="����"/></c:facet>
               <h:outputText value="#{list.name}"/>
           </h:column>
           <h:column>
               <c:facet name="header"><h:outputText value="��������"/></c:facet>
               <h:outputText value="#{list.secDeptName}"/>
           </h:column>
           <h:column>
               <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
               <h:outputText value="#{list.deptName}"/>
           </h:column>
           <h:column>
               <c:facet name="header"><h:outputText value="ָ����Ϣ"/></c:facet>
               <h:outputText value="#{list.hasFingerDesc}"/>
               <h:outputText value="#{list.fingerCount}��" rendered="#{list.hasFingerDesc=='��'}"/>
           </h:column>
           <h:column>
               <c:facet name="header"><h:outputText value="��������"/></c:facet>
               <h:outputText value="#{list.passwordDesc}"/>
           </h:column>
           <h:column>
               <c:facet name="header"><h:outputText value="�Ƿ����Ա"/></c:facet>
               <h:outputText value="#{list.isManagerDesc}"/>
           </h:column>
           <h:column>
               <c:facet name="header"><h:outputText value="����"/></c:facet>
               <h:commandButton value="��Ϊ����Ա" onclick="return setManager();" styleClass="button01" action="#{attMachinePersonMgrBB.setManger}"
               	rendered="#{list.isManagerDesc=='��'}">
                   <x:updateActionListener property="#{attMachinePersonMgrBB.operUserID}" value="#{list.ID}"/>
               </h:commandButton>
               <h:commandButton value="ȡ������Ա" onclick="return cancelManager();" styleClass="button01" action="#{attMachinePersonMgrBB.cancelManger}"
               	rendered="#{list.isManagerDesc=='��'}">
                   <x:updateActionListener property="#{attMachinePersonMgrBB.operUserID}" value="#{list.ID}"/>
               </h:commandButton>
               <h:commandButton value="��������" onclick="return setpwd('#{list.ID}');" styleClass="button01"/>
               <f:verbatim><br/></f:verbatim>
               <h:commandButton value="�ϴ���Ϣ" onclick="process();" styleClass="button01"  action="#{attMachinePersonMgrBB.upload}">
                   <x:updateActionListener property="#{attMachinePersonMgrBB.operUserID}" value="#{list.ID}"/>
               </h:commandButton>
               <h:commandButton value="�ɼ�ָ��" onclick="process();" styleClass="button01"  action="#{attMachinePersonMgrBB.collect}">
                   <x:updateActionListener property="#{attMachinePersonMgrBB.operUserID}" value="#{list.ID}"/>
               </h:commandButton>
               <h:commandButton value="�ַ�" styleClass="button01" onclick="return selIP();" action="#{attMachinePersonMgrBB.issue}">
                  <x:updateActionListener property="#{attMachinePersonMgrBB.operUserID}" value="#{list.ID}"/>
               </h:commandButton>
           </h:column>
       </h:dataTable>
   <f:verbatim>
       </div>
   </td></tr>
   </table>
   </f:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
