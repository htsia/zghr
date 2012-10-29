<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>

<f:verbatim>
    <script type="text/javascript">
        function doAudit(id) {
            window.showModalDialog("/eva/EvaPlanAuditEdit.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function viewAtt(id){
   	  	 window.open('/pages/eva/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
   	 }
    </script>
</f:verbatim>

<x:saveState value="#{eva_planBB}"/>
		<h:form id="form1">
        <h:inputHidden value = "#{eva_planBB.initPlanAudit}"></h:inputHidden>
        <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" ��Ч���� ->  �������˼ƻ�"/>
            </h:panelGroup>
       </h:panelGrid>
		<f:verbatim>
			<br>
		</f:verbatim>

		<h:panelGrid width="778" align="center" >
            <h:dataTable value="#{eva_planBB.planList}" width="100%" var="list" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03"  >
            <h:column>
                <c:facet name="header"><h:outputText value="�ƻ�����"/></c:facet>
                <h:outputText value="#{list.planName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="������"/></c:facet>
                <h:outputText value="#{list.createPersonName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ʼʱ��"/></c:facet>
                <h:outputText value="#{list.beginDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
                <h:outputText value="#{list.endDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����ģ��"/></c:facet>
                <h:outputText value="#{list.evaModelDes}"/>
            </h:column>
            <h:column>
            <c:facet name="header"><h:outputText value="��Ч�����ļ�"/></c:facet>
            <h:commandLink value="�鿴"   onclick="viewAtt('#{list.evaFile}')" rendered="#{list.haveEvaFile=='1'}">
            </h:commandLink>
        	</h:column>
        	<h:column>
                <c:facet name="header"><h:outputText value="���˿�������"/></c:facet>
                <h:outputText value="#{list.objectTypeDes}"/>
        </h:column>
         <h:column>
                <c:facet name="header"><h:outputText value="����С��λ"/></c:facet>
                <h:outputText value="#{list.scorePersDes}"/>
        </h:column>
         <h:column>
                <c:facet name="header"><h:outputText value="���Ȩ��С��λ"/></c:facet>
                <h:outputText value="#{list.levelPersDes}"/>
        </h:column>
			<h:column>
                 <c:facet name="header"><h:outputText value="����"/></c:facet>
                 <h:commandButton value="����" styleClass="button01" rendered="#{list.status=='1'}" onclick="return doAudit('#{list.planId}');"></h:commandButton>
            </h:column>
        </h:dataTable>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
