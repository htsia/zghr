<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function add(rootid){
             if(document.all("form1:planMode").value=="0"){
                 if(document.all("form1:templateID").value=="-1"){
                 alert("ѡ�񿼺�ģ�壡");
                 return false;
                }
             }else{
            	 PopUpMutilOrgOneControl('form1:deptIds','1',rootid);
            	 document.all("form1:deptIds").value=document.all("form1:deptIds").code;
             }
         }
         function setMaster(id){
             window.showModalDialog("/eva/setDeptMaster.jsf?objectID="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
             return false;
         }
         function setLevelPurview(id){
        	 window.showModalDialog("/eva/setLevelPurview.jsf?objectID="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
        	 return false;
         }
         function setDefaultLevelPurview(){
        	 var planid=document.all("form1:planId").value;
        	 window.showModalDialog("/eva/setDefaultLevelPurview.jsf?planid="+planid, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
        	 return false;
         }
         function batchSetMaster(){
       	  var str=" |";
             chk=document.forms(0).selectItem;
             if (checkMutilSelect(chk)){
                 var size = chk.length;
                 if (size == null) {
                     if (chk.checked) {
                         str+=chk.value;
                     }
                 } else {
                     for (var i = 0; i < size; i++) {
                         if (chk[i].checked) {
                             if (i==0){
                                 str+=chk[i].value;
                             }
                             else{
                                 str+=","+chk[i].value;
                             }
                         }
                     }
                 }
                if(str != null && str!=""){
               	 var vars=str.split("|");
               	 var planid=document.all("form1:planID").value;
               	 window.showModalDialog("/eva/selEvaGroup.jsf?objectIDs="+vars[1]+"&planId="+planid, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
               	 return false;
               }
             }
         }
          
    </script>

<x:saveState value="#{evaDeptSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaDeptSetBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{evaDeptSetBB.planId}"></h:inputHidden>
    <h:inputHidden id="planMode" value="#{evaDeptSetBB.planMode}"></h:inputHidden>
    <h:inputHidden id="orgId" value="#{evaDeptSetBB.orgId}"></h:inputHidden>
    <h:inputText id="deptIds" value="#{evaDeptSetBB.deptIds}" style="display:none;" code="" dict="yes" dict_num="OU"></h:inputText>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> ��Ч����-> ���ſ�������</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         
          <h:panelGrid align="right" columns="2">
          		
             	<h:panelGroup>
             	<h:commandButton value="����ȱʡ�㼶Ȩ��"  onclick="setDefaultLevelPurview();"  styleClass="button01" rendered="#{evaDeptSetBB.isPurview=='1'}"/>
             	<h:outputText value="  "></h:outputText>
             	<h:commandButton value="������������"  onclick="batchSetMaster();"  styleClass="button01"/>
             	<h:outputText value="  "></h:outputText>
                <h:outputText value="����ģ�壺" rendered="#{evaDeptSetBB.planMode=='0'}"></h:outputText>
                <h:selectOneMenu id="templateID" value="#{evaDeptSetBB.templateId}" onchange="submit();" valueChangeListener="#{evaDeptSetBB.changeTemp}" rendered="#{evaDeptSetBB.planMode=='0'}">
                   <c:selectItems value="#{evaDeptSetBB.templates}"></c:selectItems>
           		</h:selectOneMenu>
           		<h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{evaDeptSetBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{evaDeptSetBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{evaDeptSetBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{evaDeptSetBB.pagevo.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{evaDeptSetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaDeptSetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaDeptSetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{evaDeptSetBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return add('#{evaDeptSetBB.orgId}')" styleClass="button01" action="#{evaDeptSetBB.addObject}"></h:commandButton>
         </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{evaDeptSetBB.objectList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.objectID}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>
        <h:column rendered="#{evaDeptSetBB.planMode=='0'}">
            <c:facet name="header"><h:outputText value="ģ������"/></c:facet>
            <h:outputText value="#{list.templateName}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="��������" onclick="setMaster('#{list.objectID}');" styleClass="button01" type="button"></h:commandButton>
            <h:commandButton value="ɾ��"  styleClass="button01" action="#{evaDeptSetBB.delete}">
            	 <x:updateActionListener property="#{evaDeptSetBB.objectID}" value="#{list.objectID}"/>
            </h:commandButton>
            <h:commandButton value="���Ȩ��" onclick="setLevelPurview('#{list.objectID}');" styleClass="button01" type="button" rendered="#{evaDeptSetBB.isPurview=='1'}"></h:commandButton>
       </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
