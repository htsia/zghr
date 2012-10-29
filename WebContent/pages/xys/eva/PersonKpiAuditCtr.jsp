<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
	    function ctrScore(id){
	 	   window.showModalDialog("/xys/eva/ScoreCtrList.jsf?type=2&planId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
	        return true;
	    }
	    function showError(id){
		 	   window.showModalDialog("/xys/eva/ShowGradeError.jsf?objType=2&planId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
		       return true;
	    }
       function queryScore(id){
            window.showModalDialog("/xys/eva/PersonKpiQryIndex.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function dataCtr(id){
    	   window.showModalDialog("/xys/eva/PersonKpiDataCtr.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       function showProcessBar() {
   	    x = document.body.clientWidth / 2 - 150;
   	    y = document.body.clientHeight / 2;
   	    document.all('processbar').style.top = y;
   	    document.all('processbar').style.left = x;
   	    document.all('processbar').style.display = "";
   	 }
    </script>

<x:saveState value="#{person_KpiAuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_KpiAuditCtrBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 绩效管理 ->个人KPI考核监控
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
                <h:selectBooleanCheckbox value="#{person_KpiAuditCtrBB.selectAll}" onclick="submit();" valueChangeListener="#{person_KpiAuditCtrBB.queryAll}" />
                <h:outputText value="  "></h:outputText>
                <h:outputText value="记录数:#{person_KpiAuditCtrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{person_KpiAuditCtrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{person_KpiAuditCtrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{person_KpiAuditCtrBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{person_KpiAuditCtrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{person_KpiAuditCtrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{person_KpiAuditCtrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{person_KpiAuditCtrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{person_KpiAuditCtrBB.planList}" var="list" align="center" id="dateList"
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
            <h:panelGrid columns="3" align="center">
            <h:commandButton value="等级比例控制" onclick="ctrScore('#{list.planId}')" styleClass="button01" type="button" rendered="#{list.status=='2'}"></h:commandButton>
            <h:commandButton value="开始打分" action="#{person_KpiAuditCtrBB.beginGrade}" styleClass="button01" 
            rendered="#{list.status=='2'&&list.personKpiStatus!='1'}" onclick="showProcessBar()">
                  <x:updateActionListener property="#{person_KpiAuditCtrBB.planId}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="结束打分" action="#{person_KpiAuditCtrBB.endGrade}" styleClass="button01" rendered="#{list.status=='2'&&list.personKpiStatus=='1'}">
                  <x:updateActionListener property="#{person_KpiAuditCtrBB.planId}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="错误日志" onclick="showError('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            </h:panelGrid>
            <h:panelGrid columns="2" align="center">
            <h:commandButton value="数据合法性监控" onclick="dataCtr('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="查看打分情况" onclick="queryScore('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
        	</h:panelGrid>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
