<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
        function doSet(id) {
            window.open("/eva/EvaObjectSet.jsf?planID="+id, null, "height="+screen.height*0.9+", width="+screen.width*0.9+", toolbar= no, menubar=no, scrollbars=yes, resizable=yes, location=no, status=no,top=50,left=100");
            return true;
        }
        function doSet1(id) {
            window.showModalDialog("/eva/EvaAimCheckSet.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doSet2(id) {
            window.showModalDialog("/eva/EvaTaskSet.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doSetDept(id) {
            window.showModalDialog("/eva/EvaDeptList.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doSetTeam(id) {
            window.showModalDialog("/eva/EvaTeamList.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doMangerTemMaster(id) {
            window.showModalDialog("/eva/TemMasterManager.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function viewAtt(id){
   	  	 window.open('/pages/eva/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
   	  }
     	  function aduitGroupSet(id){
     		 window.showModalDialog("/eva/AuditGroupMgr.jsf?planId="+id, "", "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px; status:0;resizable:yes");
   		  	 return true;
     	  }
    </script>
</f:verbatim>
<x:saveState value="#{eva_planExecuteBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_planExecuteBB.pageInit}"/>

    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ��Ч���� -> ������������"/>
        </h:panelGroup>
    </h:panelGrid>
	<h:panelGrid columns="1" align="center" width="98%">
        <h:dataTable value="#{eva_planExecuteBB.planList}" width="100%" var="list" align="center" id="dateList"
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
                <c:facet name="header"><h:outputText value="���˿�������"/></c:facet>
                <h:outputText value="#{list.objectTypeDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��Ч�����ļ�"/></c:facet>
            <h:commandLink value="�鿴"   onclick="viewAtt('#{list.evaFile}')" rendered="#{list.haveEvaFile=='1'}">
            </h:commandLink>
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
                <h:commandButton value="����"  styleClass="button01" onclick="doSet('#{list.planId}')" rendered="#{(list.evaModel=='0'|| list.evaModel=='3') && list.status!='6' && list.planObjectType=='0'}">
                </h:commandButton>
                <h:commandButton value="����"  styleClass="button01" onclick="doSet1('#{list.planId}')" rendered="#{list.evaModel=='1' && list.status!='6'}">
                </h:commandButton>
                <h:commandButton value="����"  styleClass="button01" onclick="doSet2('#{list.planId}')" rendered="#{list.evaModel=='2' && list.status!='6'}">
                </h:commandButton>
                <h:commandButton value="���ò���"  styleClass="button01" onclick="doSetDept('#{list.planId}')" rendered="#{(list.evaModel=='0'||list.evaModel=='3')&& list.status!='6' && list.planObjectType=='1'}">
                </h:commandButton>
                <h:commandButton value="�����Ŷ�"  styleClass="button01" onclick="doSetTeam('#{list.planId}')" rendered="#{(list.evaModel=='0'||list.evaModel=='3') && list.status!='6' && list.planObjectType=='2'}">
                </h:commandButton>
                <h:commandButton value="��ʱ�������"  styleClass="button01" onclick="doMangerTemMaster('#{list.planId}')" rendered="#{list.evaModel=='0' && list.status!='6' && list.planObjectType=='0'}">
                </h:commandButton>
                <h:commandButton value="�����Ź���"  styleClass="button01" onclick="aduitGroupSet('#{list.planId}')" rendered="#{(list.evaModel=='0'||list.evaModel=='3') && list.status!='6'}">
                </h:commandButton>
                
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>