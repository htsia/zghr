<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
    	function querySetScore(id){
    		window.open("/eva/EvaMasterResult2.jsf?planId="+id,"", "height="+screen.height*0.8+", width="+screen.width*0.85+", top=20,left=50, toolbar=no, menubar=no, location=center, status=no,resizable=yes,scrollbars=yes");
            return true;
    	}
        function doSetScore(id) {
            window.showModalDialog("/eva/EvaScoreSet.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doSetDeptScore(id){
        	window.showModalDialog("/eva/EvaDeptListScore.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doSetTeamScore(id){
        	window.showModalDialog("/eva/EvaTeamListScore.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function querySelection(id){
        	window.showModalDialog("/eva/evaObjectSeletion.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function viewAtt(id){
   	  	 window.open('/pages/eva/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
   	  }
    </script>
</f:verbatim>
<x:saveState value="#{eva_planExecuteBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_planExecuteBB.pageInit}"/>

    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 考核打分"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%">
        <h:dataTable value="#{eva_planExecuteBB.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle,td_middle_center,td_middle_center"
                 styleClass="table03"  >
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>

 		<h:column>
                <c:facet name="header"><h:outputText value="考核模型"/></c:facet>
                <h:outputText value="#{list.evaModelDes}"/>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="考核客体类型"/></c:facet>
                <h:outputText value="#{list.objectTypeDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="创建人"/></c:facet>
            <h:outputText value="#{list.createPersonName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endDate}"/>
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="绩效考核文件"/></c:facet>
            <h:commandLink value="查看"   onclick="viewAtt('#{list.evaFile}')" rendered="#{list.haveEvaFile=='1'}">
            </h:commandLink>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="分数小数位"/></c:facet>
                <h:outputText value="#{list.scorePersDes}"/>
        </h:column>
         <h:column>
                <c:facet name="header"><h:outputText value="层次权重小数位"/></c:facet>
                <h:outputText value="#{list.levelPersDes}"/>
        </h:column>
		
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="打分情况"  styleClass="button01" onclick="querySetScore('#{list.planId}')" rendered="#{list.evaModel=='0'}">
                </h:commandButton>
                <h:commandButton value="打分"  styleClass="button01" onclick="doSetScore('#{list.planId}')" rendered="#{list.evaModel=='0' && list.status=='3'&& list.planObjectType=='0' && list.allowMark=='1' &&list.notShowHr!='1'}">
                </h:commandButton>
                <h:commandButton value="部门打分"  styleClass="button01" onclick="doSetDeptScore('#{list.planId}')" rendered="#{list.evaModel=='0' && list.status=='3'&& list.planObjectType=='1' && list.allowMark=='1' &&list.notShowHr!='1'}">
                </h:commandButton>
                <h:commandButton value="团队打分"  styleClass="button01" onclick="doSetTeamScore('#{list.planId}')" rendered="#{list.evaModel=='0' && list.status=='3'&& list.planObjectType=='2' && list.allowMark=='1' &&list.notShowHr!='1'}">
                </h:commandButton>
                <h:commandButton value="投票情况"  styleClass="button01" onclick="querySelection('#{list.planId}')" rendered="#{list.evaModel=='3'&&list.notShowHr!='1'}">
                </h:commandButton>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>