<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
    function showResult(planId){
	    window.showModalDialog("/eva/EvaResultList.jsf?planId="+planId, "","dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
	    return true;
   }
    function caculatScore(id) {
        window.showModalDialog("/eva/EvaElectionResult.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function showTotal(orgId,id){
    	window.showModalDialog("/eva/ShowTotalEvaResultAnalyse.jsf?planOrg="+orgId+"&planID="+id, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
        function doSet(orgid,id) {
             window.showModalDialog("/eva/ShowEvaResultAnalyse.jsf?planOrg="+orgid+"&planID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.95+"px;center:center;resizable:yes;status:no;scroll:yes;");
             return true;
        }
        function doDeptSet(id){
        	window.showModalDialog("/eva/showEvaDeptResultAnalyse.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
        	return true;
        }
        function doSetDeptGrade(id){
        	window.showModalDialog("/eva/showGradeDeptResultAnalyse.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
        	return true;
        }
        function doTeamSet(id){
        	window.showModalDialog("/eva/showEvaTeamResultAnalyse.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
        	return true;
        }
        function doSetTeamGrade(id){
        	window.showModalDialog("/eva/showEvaTeamGradeAnalyse.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
        	return true;
        }
        function doSetGrade(orgid,gradeid,planid,evamodel) {
                if(evamodel=="0")
                {
                	window.showModalDialog("/eva/EvaGradeResultAnalyse.jsf?planOrg="+orgid+"&gradeID="+gradeid+"&planID="+planid+"&evaModel="+evamodel, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:no;status:no;scroll:no;");
                    return true;
                }
                else if(evamodel=="1")
                {
                	window.showModalDialog("/eva/ShowPostEvaResultAnalyse.jsf?planOrg="+orgid+"&gradeID="+gradeid+"&planID="+planid+"&evaModel="+evamodel, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.7+"px;center:center;resizable:no;status:no;scroll:no;");
                    return true;
                }
                else if(evamodel=="2"){
                	window.showModalDialog("/eva/ShowTaskEvaResultAnalyse.jsf?planOrg="+orgid+"&gradeID="+gradeid+"&planID="+planid+"&evaModel="+evamodel, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.7+"px;center:center;resizable:no;status:no;scroll:no;");
                    return true;
                }
            }
            
        function showResult(planId,evamodle){
            window.open("/eva/EvaResultList.jsf?planId="+planId+"&evaModle="+evamodle, "", 'height=500px, width=600px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
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
        <h:outputText value=" 绩效管理 -> 结果分析"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="1" align="center" width="98%">
        <h:dataTable value="#{eva_planExecuteBB.planList}" width="100%" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03"  >
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
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
                <c:facet name="header"><h:outputText value="考核模型"/></c:facet>
                <h:outputText value="#{list.evaModelDes}"/>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="考核客体类型"/></c:facet>
                <h:outputText value="#{list.objectTypeDes}"/>
        </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="量表结果分析"  styleClass="button01" onclick="doSet('#{list.orgId}','#{list.planId}')" rendered="#{list.evaModel=='0'&& list.planObjectType=='0'}">
                </h:commandButton>
                <h:commandButton value="部门考核结果分析 " styleClass="button01" onclick="doDeptSet('#{list.planId}')" rendered="#{list.evaModel=='0' && list.planObjectType=='1'}">
                </h:commandButton>
                <h:commandButton value="团队考核结果分析"  styleClass="button01" onclick="doTeamSet('#{list.planId}')" rendered="#{list.evaModel=='0' && list.planObjectType=='2'}">
                </h:commandButton>
                <h:commandButton value="量表层次分析"  styleClass="button01" onclick="doSetGrade('#{list.orgId}','#{list.planGrade}','#{list.planId}','#{list.evaModel}')" rendered="#{list.evaModel=='0' && list.planObjectType=='0'}">
                </h:commandButton>
                <h:commandButton value="部门考核层次分析"  styleClass="button01" onclick="doSetDeptGrade('#{list.planId}')" rendered="#{list.evaModel=='0' && list.planObjectType=='1'}">
                </h:commandButton>
                <h:commandButton value="团队考核层次分析"  styleClass="button01" onclick="doSetTeamGrade('#{list.planId}')" rendered="#{list.evaModel=='0' && list.planObjectType=='2'}">
                </h:commandButton>
                <h:commandButton value="岗位考核分析"  styleClass="button01" onclick="doSetGrade('#{list.orgId}','#{list.planGrade}','#{list.planId}','#{list.evaModel}')" rendered="#{list.evaModel=='1'}">
                </h:commandButton>
                <h:commandButton value="岗位考核结果"  styleClass="button01" onclick="return showResult('#{list.planId}','#{list.evaModel}');" rendered="#{list.evaModel=='1'}">
                </h:commandButton>
                <h:commandButton value="任务考核分析"  styleClass="button01" onclick="doSetGrade('#{list.orgId}','#{list.planGrade}','#{list.planId}','#{list.evaModel}')" rendered="#{list.evaModel=='2'}">
                </h:commandButton>
                <h:commandButton value="任务考核结果"  styleClass="button01" onclick="return showResult('#{list.planId}','#{list.evaModel}');" rendered="#{list.evaModel=='2'}">
                </h:commandButton>
                <h:commandButton value="投票结果分析"  styleClass="button01" onclick="caculatScore('#{list.planId}')" rendered="#{list.evaModel=='3'}">
            	</h:commandButton>
                <h:commandButton value="综合分析"  styleClass="button01" onclick="showTotal('#{list.orgId}','#{list.planId}')" rendered="#{list.isVirtual=='1'}">
                </h:commandButton>
                <h:commandButton value="查看结果"  styleClass="button01" onclick="return showResult('#{list.planId}');" rendered="#{list.evaModel=='3'&&list.notShowHr=='1'}"/>
            </h:column>

    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>