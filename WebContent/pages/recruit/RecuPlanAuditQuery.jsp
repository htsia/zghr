<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }

    function forViewPost(id) {
        windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
    }
</script>
<c:verbatim><base target='_self'></c:verbatim>
<x:saveState value="#{recu_planeditBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{recu_planeditBB.initAudit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 招聘管理 -> 招聘计划审批"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>

    <h:panelGrid align="center" width="98%" columns="1">
    	<h:panelGrid columns="2" cellspacing="2" columnClasses="td_form01,td_form02" styleClass="table03">
            <h:outputText value="审批意见"/>
            <h:inputText id="shenpiyijian" styleClass="input" readonly="true" value="#{recu_planeditBB.planbo.approveResult}" />
            <h:outputText value="原因"/>
            <h:inputTextarea value="#{recu_planeditBB.planbo.approveReason}" rows="3" cols="80" readonly="true" styleClass="input"/>
		</h:panelGrid>
        
        <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="名称"/>
            <h:inputText id="name" readonly="true" styleClass="input" value="#{recu_planeditBB.planbo.planName}" />

            <h:outputText value="创建日期"/>
            <h:panelGroup>
            <h:inputText id="createDate" styleClass="input" readonly="true" value="#{recu_planeditBB.planbo.createDate}" alt="开始日期|0|d|50||"/>
			</h:panelGroup>
            
            <h:outputText value="开始日期"/>
            <h:panelGroup>
                <h:inputText styleClass="input"  id="beginDate" value="#{recu_planeditBB.planbo.startDate}"
                             readonly="true" alt="开始日期|0|d|50||"/>
            </h:panelGroup>

            <h:outputText value="结束日期"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="endDate" value="#{recu_planeditBB.planbo.endDate}"
                             readonly="true" alt="结束日期|0|d|50||"/>
            </h:panelGroup>

            <h:outputText value="周期类型"/>
            <h:panelGroup>
                <h:inputText styleClass="input" id="planType" code="" dict="yes" dict_num="0650"
                             readonly="true" value="#{recu_planeditBB.planbo.planType}"
                             alt="周期类型|0|s|50||"/>
             </h:panelGroup>
             
           </h:panelGrid>

		<x:dataTable value="#{recu_planeditBB.detailList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center"
                     styleClass="table03" >
        	<h:column>
                <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
                <h:commandLink onclick="forViewPost('#{list.postId}')" rendered="#{recu_planeditBB.planbo.planMethod=='1'}">
                <h:outputText value="#{list.postName}"/>
                </h:commandLink>
                <h:commandLink onclick="forViewPost('#{list.postid}')" rendered="#{recu_planeditBB.planbo.planMethod=='0'}">
                 <h:outputText value="#{list.postname}"/>
                </h:commandLink>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="需求人数"/></c:facet>
                <h:outputText value="#{list.needCount}"/>
            </h:column>
		</x:dataTable>
        <h:panelGrid columns="1" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="招聘计划描述"/>
            <h:outputText escape="false" value="#{recu_planeditBB.planbo.description}" />
        </h:panelGrid>

    </h:panelGrid>
</h:form>
