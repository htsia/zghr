<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
	    function ctrScore(id){
	 	   window.showModalDialog("/xys/eva/StudentGradeInput.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
	        return true;
	    }
       
    </script>

<x:saveState value="#{regStrudentGradeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{regStrudentGradeBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->录入其他评价
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="显示全部"></h:outputText>
                <h:selectBooleanCheckbox value="#{regStrudentGradeBB.selectAll}" onclick="submit();" valueChangeListener="#{regStrudentGradeBB.queryAll}" />
                <h:outputText value="  "></h:outputText>
                <h:outputText value="记录数:#{regStrudentGradeBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{regStrudentGradeBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{regStrudentGradeBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{regStrudentGradeBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{regStrudentGradeBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{regStrudentGradeBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{regStrudentGradeBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{regStrudentGradeBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{regStrudentGradeBB.planList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="年度"/></c:facet>
            <h:outputText value="#{list.year}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="开始时间"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="结束时间"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="周期类型"/></c:facet>
            <h:outputText value="#{list.planType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划等级"/></c:facet>
            <h:outputText value="#{list.planGrade}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="分数保留位数"/></c:facet>
            <h:selectOneMenu value="#{list.scorePers}" disabled="true">
                <c:selectItem itemLabel="整数" itemValue="0"/>
                <c:selectItem itemLabel="一位小数" itemValue="1"/>
                <c:selectItem itemLabel="两位小数" itemValue="2"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="录入学生评价" onclick="ctrScore('#{list.planId}')" styleClass="button01" type="button" rendered="#{list.status=='2'}"></h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
