<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function showProcessBar() {
   	    x = document.body.clientWidth / 2 - 150;
   	    y = document.body.clientHeight / 2;
   	    document.all('processbar').style.top = y;
   	    document.all('processbar').style.left = x;
   	    document.all('processbar').style.display = "";
   	 }
    function setDiv(objId){
	    window.showModalDialog("/xys/eva/DeptKpiDiv.jsf?objId="+objId+"&planId="+document.all("form1:planId").value, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
	    return false;
    }
    function setSpread(){
	    window.showModalDialog("/xys/eva/SetSpread.jsf?planId="+document.all("form1:planId").value, null, "dialogWidth:"+screen.width*0.7+"px;dialogHeight:"+screen.height*0.7+"px;center:center;resizable:no;status:no;scroll:yes;");
	    return false;
    }
    function setDeptSpread(dept){
	    window.showModalDialog("/xys/eva/SetSpreadDept.jsf?planId="+document.all("form1:planId").value+"&deptId="+dept, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
	    return false;
    }
    function exportDeptKpi(){
    	window.open("/pages/xys/eva/DeptKpiExport.jsp?planId="+document.all("form1:planId").value);
    }


    function importDeptKpi(){
        window.showModalDialog("/xys/eva/importDeptKpi.jsf?planId="+document.all("form1:planId").value, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
	    return true;
    }
    </script>

<x:saveState value="#{xys_evaPlanCaclBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaPlanCaclBB.initDeptObj}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{xys_evaPlanCaclBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title" height="10px"><img src="/images/tips.gif">
                      绩效管理 ->部门KPI计算
           </td>
           <td class="td_title" height="10px">
                </c:verbatim>
                <h:commandButton value=" 计算部门打分 " action="#{xys_evaPlanCaclBB.caclDept}" styleClass="button01" onclick="showProcessBar();" rendered="#{xys_evaPlanCaclBB.deptDesabled=='0'}"></h:commandButton>
                <h:commandButton value=" 强制分布设置 " styleClass="button01" onclick="setSpread()" type="button"></h:commandButton>
                <h:commandButton value=" 应用强制分布 " action="#{xys_evaPlanCaclBB.useSpread}" styleClass="button01" onclick="showProcessBar();" rendered="#{xys_evaPlanCaclBB.deptDesabled=='0'}"></h:commandButton>
                <c:verbatim>
           </td>
           <td class="td_title" height="10px">
                </c:verbatim>
                <h:commandButton value=" 导入考核分数"  styleClass="button01"  onclick="return importDeptKpi();"></h:commandButton>
                <h:commandButton value=" 导出Excel"  styleClass="button01"  onclick="exportDeptKpi();" type="button"></h:commandButton>
                <c:verbatim>
           </td>
        </tr>
    </table>
    <br>
       <table height=90% width=100% align="center">
       <tr><td height=8>
       </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{xys_evaPlanCaclBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xys_evaPlanCaclBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xys_evaPlanCaclBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xys_evaPlanCaclBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xys_evaPlanCaclBB.first3}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xys_evaPlanCaclBB.pre3}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xys_evaPlanCaclBB.next3}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xys_evaPlanCaclBB.last3}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
      &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
     <x:dataTable value="#{xys_evaPlanCaclBB.deptList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="上上级"/></c:facet>
            <h:outputText value="#{list.scorePreLeader}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="直接上级"/></c:facet>
            <h:outputText value="#{list.scoreLeader}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="其他上级"/></c:facet>
            <h:outputText value="#{list.scoreOtherLeader}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="得分"/></c:facet>
            <h:outputText value="#{list.score}" escape="false"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="考核等级"/></c:facet>
            <h:outputText value="#{list.gradeItem}" />
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="设置分解KPI人员" onclick="setDiv('#{list.objId}')" styleClass="button01" type="button"></h:commandButton>
            <h:commandButton value="等级分布设置" onclick="setDeptSpread('#{list.deptId}')" styleClass="button01" type="button"></h:commandButton>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
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
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
