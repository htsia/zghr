<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function setScore(id) {
            window.showModalDialog("/xys/eva/Person360ScoreSet.jsf?objId="+id, null, "dialogWidth:"+screen.width+"px;dialogHeight:"+screen.height+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
        }
    </script>

<x:saveState value="#{person_360AuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_360AuditBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title" height="10px"><img src="/images/tips.gif">
                      绩效管理 ->同事能力态度评分
           </td>
        </tr>
    </table>
    <br>
       <table width=100% align="center">
       <tr><td height=8 valign="top"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本部门人员列表:</b>
	  </td></tr>
	   <tr><td valign="top">
	</c:verbatim>
     <x:dataTable value="#{person_360AuditBB.objList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <x:column width="5%">
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </x:column>
        <x:column width="20%">
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </x:column>
         <x:column width="5%">
            <c:facet name="header"><h:outputText value="年度"/></c:facet>
            <h:outputText value="#{list.year}"/>
        </x:column>
        <x:column width="20%">
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </x:column>
         <x:column width="10%">
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </x:column>
        <x:column width="20%">
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </x:column>
        <x:column width="10%">
            <c:facet name="header"><h:outputText value="得分"/></c:facet>
            <h:outputText value="#{list.score}"/>
        </x:column>
        <x:column width="10%">
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="打分" onclick="return setScore('#{list.objId}');"  styleClass="button01"></h:commandButton>
        </x:column>
    </x:dataTable>
    <c:verbatim>
	
	</td></tr>
	<tr><td height=8 valign="top"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;其他部门人员列表:</b>
	  </td></tr>
	   <tr><td valign="top">
	</c:verbatim>
     <x:dataTable value="#{person_360AuditBB.objList2}" var="list" align="center" id="dateList2" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%">
        <x:column width="5%">
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </x:column>
         <x:column width="20%">
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </x:column>
         <x:column width="5%">
            <c:facet name="header"><h:outputText value="年度"/></c:facet>
            <h:outputText value="#{list.year}"/>
        </x:column>
        <x:column width="20%">
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </x:column>
         <x:column width="10%">
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </x:column>
        <x:column width="20%">
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </x:column>
        <x:column width="10%">
            <c:facet name="header"><h:outputText value="得分"/></c:facet>
            <h:outputText value="#{list.score}"/>
        </x:column>
        <x:column width="10%">
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="打分" onclick="return setScore('#{list.objId}');"  styleClass="button01"></h:commandButton>
        </x:column>
    </x:dataTable>
    <c:verbatim>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
   setDataTableOver("form1:dateList2");
</script>
