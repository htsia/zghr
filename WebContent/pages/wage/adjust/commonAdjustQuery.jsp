
<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function setItem(id){
        window.showModalDialog("/wage/adjust/CommonAdjustEdit.jsf?itemID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    function doOK(id){
        window.showModalDialog("/wage/adjust/validateAdjust.jsf?itemID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    function setRule(){
        window.showModalDialog("/wage/adjust/OrgAdjustItemSet.jsf?Action=set", null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return false;
    }
    function selperson(){
    	var item = document.getElementsByName("selectItem");
        var selId="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	var id=item[i].value;
                	var ids=id.split("-");
                	selId+=ids[0]+",";
                }
            }
        }
        if(selId==""){
        	alert("��ѡ����Ա");
        	return false;
        }
        document.all("form1:selectedItemIDs").value=selId;
        return true;
    }
    function selperson2(){
    	var item = document.getElementsByName("selectItem");
        var itemIDs="";
        var userIDs="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	var id=item[i].value;
                	var ids=id.split("-");
                	itemIDs+=ids[0]+",";
                	userIDs+=ids[1]+",";
                }
            }
        }
        if(itemIDs==""){
        	alert("��ѡ����Ա");
        	return false;
        }
        window.showModalDialog("/custom/wage/batchValidateAdjust.jsf?act=init&IDs="+itemIDs+"-"+userIDs, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    function selperson3(){
    	var item = document.getElementsByName("selectItem");
        var selId="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	var id=item[i].value;
                	var ids=id.split("-");
                	selId+=ids[0]+",";
                }
            }
        }
        if(selId==""){
        	alert("��ѡ����Ա");
        	return false;
        }
        if(confirm('ȷ��ȫ��ɾ����')){
	        document.all("form1:selectedItemIDs").value=selId;
	        return true;
        }
        return false;
    }
</script>
    <x:saveState value="#{wage_commonAdjustBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{wage_commonAdjustBB.pageInit}"/>
        <h:inputHidden id="selectedItemIDs" value="#{wage_commonAdjustBB.itemID}"/>
        <c:verbatim>
        <table width="98%" height="100%" align="center" cellpadding="0" cellspacing="0">
            <tr><td height="1">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
       			</c:verbatim>
					<h:outputText escape="false" value="<strong>��ǰ������#{wage_commonAdjustBB.orgName}</strong>"/>
		            <h:outputText value="  �������ţ�"/>
		            <h:inputText value="#{wage_commonAdjustBB.name}" size="15"/>
					<h:outputText value="  ����ʱ���"/>
					<h:inputText value="#{wage_commonAdjustBB.time}" id="time" styleClass="input Wdate" size="15"
							readonly="true" alt="����|1|d|50||" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:time'})"
							onkeypress ="enterKeyDown('form1:time')"/>
					<h:outputText value="��"/>
					<h:inputText value="#{wage_commonAdjustBB.time2}" id="time2" styleClass="input Wdate" size="15"
							readonly="true" alt="����|1|d|50||" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:time2'})"
							onkeypress ="enterKeyDown('form1:time2')"/>
				    <h:commandButton value="��ѯ" styleClass="button01"  onclick="return disPlayProcessBar();"
							action="#{wage_commonAdjustBB.doQuery}"></h:commandButton>
   				<f:verbatim>
               </td>
               <td align="right" class=td_title >
               </f:verbatim>
	               <h:commandButton onclick="return selperson2();" action="#{wage_commonAdjustBB.doOK}" styleClass="button01" value="ȫ����Ч"/>
	               <h:commandButton onclick="return selperson3();" action="#{wage_commonAdjustBB.doDelete}" styleClass="button01" value="ȫ��ɾ��"/>
      			<c:verbatim>
               </td>
            </tr>
        </table>
        </c:verbatim>
        <h:panelGrid align="right" styleClass="locked_top">
         <h:panelGroup>
             <h:outputText value="��Ч"/>
             <h:selectBooleanCheckbox value="#{wage_commonAdjustBB.appro}" onclick="submit();" valueChangeListener="#{wage_commonAdjustBB.setIsAppro}" />
             <h:outputText value="  "/>
             <h:outputText value="��¼��:#{wage_commonAdjustBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ҳ��:#{wage_commonAdjustBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ÿҳ��#{wage_commonAdjustBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="��ǰΪ��#{wage_commonAdjustBB.pagevo.currentPage}ҳ"></h:outputText>
             <h:commandButton value="��ҳ" action="#{wage_commonAdjustBB.first}" styleClass="button01"/>
             <h:commandButton value="��ҳ" action="#{wage_commonAdjustBB.pre}" styleClass="button01"/>
             <h:commandButton value="��ҳ" action="#{wage_commonAdjustBB.next}" styleClass="button01"/>
             <h:commandButton value="βҳ" action="#{wage_commonAdjustBB.last}" styleClass="button01"/>
         </h:panelGroup>
     </h:panelGrid>
        <c:verbatim>
            </td></tr>
            <tr><td><div style='width:100%;height:98%;overflow:auto' id=datatable>
        </c:verbatim>
            <h:dataTable value="#{wage_commonAdjustBB.adjustList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle,td_middle_center,td_middle_center"
                 styleClass="table03" width="95%" >
                 <h:column>
		        <f:facet name="header">
		            <f:verbatim escape="false">
		                <input type="checkbox" name="all"
		                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
		            </f:verbatim>
		        </f:facet>
		        <f:verbatim escape="false">
		            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim><h:outputText value="#{list.adjustbo.itemID}-#{list.adjustbo.personID}"/><f:verbatim escape="false">"/></div></f:verbatim>
		    </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                    <h:outputText value="#{list.adjustbo.applyDate}"/>
                </h:column>
		        <h:column>
		            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
		            <h:outputText value="#{list.adjustbo.personCode}"/>
		        </h:column>
		        <h:column>
		            <c:facet name="header"><h:outputText value="����"/></c:facet>
		            <h:outputText value="#{list.adjustbo.personName}"/>
		        </h:column>
                <h:column>
                    <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
                    <h:outputText value="#{list.adjustbo.orgName}"/>
                </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="�������"/></c:facet>
                <h:outputText value="#{list.adjustbo.adjustType}"/>
            </h:column>
                

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText escape="false" value="#{list.adjustDes}"/>
        </h:column>

                <h:column>
                    <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                    <h:outputText value="#{list.adjustbo.statusDes}"/>
                </h:column>
        <h:column >
            <c:facet name="header" ><h:outputText value="����" style="width:120px"/></c:facet>
                <h:commandButton value="�ⶨ" styleClass="button01" onclick="return setItem('#{list.adjustbo.itemID}');"  rendered="#{list.adjustbo.status=='0'}"/>
                <h:commandButton value="ɾ��" onclick="return confirm('ȷ��ɾ����');" styleClass="button01" action="#{wage_commonAdjustBB.doDelete}">
                    <x:updateActionListener property="#{wage_commonAdjustBB.itemID}" value="#{list.adjustbo.itemID}"/>
                 </h:commandButton>
                <h:commandButton value="����" styleClass="button01"  action="#{wage_commonAdjustBB.doApply}" rendered="#{list.adjustbo.status=='0' && sys_commonInfoBB.wage_adjust_mode!='1'}">
                    <x:updateActionListener property="#{wage_commonAdjustBB.itemID}" value="#{list.adjustbo.itemID}"/>
                 </h:commandButton>
                <h:commandButton value="�鿴����" styleClass="button01"  type="button" rendered="#{sys_commonInfoBB.wage_adjust_mode!='1'}" onclick="showWorkFlowLogByLinkID('#{list.adjustbo.itemID}');"/>
                <h:commandButton value="��Ч" styleClass="button01" onclick="return doOK('#{list.adjustbo.itemID}');" rendered="#{list.adjustbo.status=='2' || (list.adjustbo.status=='0' && sys_commonInfoBB.wage_adjust_mode=='1')}"/>
        </h:column>

    </h:dataTable>
        <c:verbatim>
        </div></td></tr></table>
        </c:verbatim>
    </h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>