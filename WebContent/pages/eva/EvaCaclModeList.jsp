<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
 <script type="text/javascript">
 function queryMaster(objId){
     window.showModalDialog("/eva/queryMasterList.jsf?objectID="+objId,"", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:yes;scroll:yes;");
     return true;
 }
 </script>
<x:saveState value="#{eva_planExecuteBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{eva_planExecuteBB.initCtr}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{eva_planExecuteBB.ctrList}" var="list" align="center" id="dateList"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="ģ��"/></c:facet>
            <h:outputText value="#{list.templateId}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="������������"/></c:facet>
            <h:outputText value="#{list.masterType}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����ģʽ"/></c:facet>
            <h:selectOneMenu value="#{list.caclMode}" disabled="true">
                <c:selectItem itemLabel="ȫ������" itemValue="0"/>
                <c:selectItem itemLabel="ȥ����߷ֺ���ͷ�" itemValue="1"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ֵ���ģʽ"/></c:facet>
            <h:selectOneMenu value="#{list.selScoreMode}" disabled="true">
                <c:selectItem itemLabel="ȫ������" itemValue="0"/>
                <c:selectItem itemLabel="��������" itemValue="1"/>
                <c:selectItem itemLabel="ȫ����ȥ" itemValue="2"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
           <h:commandButton value="�л�����ģʽ"  styleClass="button01" action="#{eva_planExecuteBB.setCommonMode}" rendered="#{list.caclMode=='1'}">
                   <x:updateActionListener property="#{eva_planExecuteBB.itemId}" value="#{list.itemId}" />
           </h:commandButton>
            <h:commandButton value="�л�����ģʽ"  styleClass="button01" action="#{eva_planExecuteBB.setOtherMode}" rendered="#{list.caclMode=='0'}">
                   <x:updateActionListener property="#{eva_planExecuteBB.itemId}" value="#{list.itemId}" />
           </h:commandButton>
            <h:commandButton value="ȫ������"  styleClass="button01" action="#{eva_planExecuteBB.setOtherMode1}" rendered="#{list.selScoreMode!='0'}">
                   <x:updateActionListener property="#{eva_planExecuteBB.itemId}" value="#{list.itemId}" />
           </h:commandButton>
            <h:commandButton value="��������"  styleClass="button01" action="#{eva_planExecuteBB.setOtherMode2}" rendered="#{list.selScoreMode!='1'}">
                   <x:updateActionListener property="#{eva_planExecuteBB.itemId}" value="#{list.itemId}" />
           </h:commandButton>
            <h:commandButton value="ȫ����ȥ"  styleClass="button01" action="#{eva_planExecuteBB.setOtherMode3}" rendered="#{list.selScoreMode!='2'}">
                   <x:updateActionListener property="#{eva_planExecuteBB.itemId}" value="#{list.itemId}" />
           </h:commandButton>
        </h:column>
    </x:dataTable>
	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
