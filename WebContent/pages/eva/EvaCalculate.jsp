<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<f:verbatim>
    <script type="text/javascript">
        function caculatScore(id) {
            window.showModalDialog("/eva/EvaCaculat.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function addVirtralPlan(){
        	window.showModalDialog("/eva/addVirtralPlan.jsf", "", "dialogWidth:400px; dialogHeight:300px; status:0;resizable:yes");
   	     	return true;
        }
        function setVirtaulPlan(id){
        	window.showModalDialog("/eva/virtualEvaPlanList.jsf?planID="+id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
        	return true;
        }
        function querySetScore(id){
    		window.open("/eva/EvaMasterResult.jsf?planId="+id,"", "height="+screen.height*0.8+", width="+screen.width*0.85+", top=20,left=50, toolbar=no, menubar=no, location=center, status=no,resizable=yes,scrollbars=yes");
            return true;
    	}
        function setCaclMode(id){
    		window.open("/eva/EvaCaclModeList.jsf?planId="+id,"", "height="+screen.height*0.8+", width="+screen.width*0.85+", top=20,left=50, toolbar=no, menubar=no, location=center, status=no,resizable=yes,scrollbars=yes");
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
</f:verbatim>
<x:saveState value="#{eva_planExecuteBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_planExecuteBB.pageInit}"/>

    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 考核计算"/>
        </h:panelGroup>
    </h:panelGrid>
    <h:panelGrid columns="1" align="center" width="98%">
    	 <h:panelGrid columns="1" align="right" >
		<h:commandButton value="增加虚拟计划"  styleClass="button01" onclick="addVirtralPlan()"></h:commandButton>
		</h:panelGrid>
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
                <c:facet name="header"><h:outputText value="分数小数位"/></c:facet>
                <h:outputText value="#{list.scorePersDes}"/>
        </h:column>
         <h:column>
                <c:facet name="header"><h:outputText value="层次权重小数位"/></c:facet>
                <h:outputText value="#{list.levelPersDes}"/>
        </h:column>
        <h:column>
                <c:facet name="header"><h:outputText value="计算模式"/></c:facet>
                <h:selectOneMenu value="#{list.caclMode}" disabled="true" rendered="#{list.pruview=='1'}">
                     <c:selectItem itemLabel="默认计算模式" itemValue="0"></c:selectItem>
                     <c:selectItem itemLabel="配置计算模式" itemValue="1"></c:selectItem>
                </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="计算"  styleClass="button01" action="#{eva_planExecuteBB.calc}" rendered="#{list.evaModel!='3'&&list.status=='3'}" onclick="showProcessBar();">
               <x:updateActionListener property="#{eva_planExecuteBB.planID}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="设置"  styleClass="button01" onclick="setVirtaulPlan('#{list.planId}')" rendered="#{list.isVirtual=='1' && list.status=='3'}">
            </h:commandButton>
            <h:commandButton value="虚拟计划结果报批"  styleClass="button01" action="#{eva_planExecuteBB.forAuduitResult}" rendered="#{list.isVirtual=='1' && list.status=='3'}">
               <x:updateActionListener property="#{eva_planExecuteBB.planID}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="定性计算"  styleClass="button01" onclick="caculatScore('#{list.planId}')" rendered="#{list.evaModel=='3' && list.status=='3'}">
            </h:commandButton>
             <h:commandButton value="打分汇总情况"  styleClass="button01" onclick="querySetScore('#{list.planId}')" rendered="#{list.evaModel=='0'||list.evaModel=='3'}">
            </h:commandButton>
            <h:commandButton value="开始打分"  styleClass="button01" action="#{eva_planExecuteBB.beginMark}" rendered="#{list.status=='3'&& list.allowMark=='0'}">
               <x:updateActionListener property="#{eva_planExecuteBB.planID}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="结束打分"  styleClass="button01" action="#{eva_planExecuteBB.endMark}" rendered="#{list.status=='3'&& list.allowMark=='1'}">
               <x:updateActionListener property="#{eva_planExecuteBB.planID}" value="#{list.planId}"/>
            </h:commandButton>
             <h:commandButton value="切换计算模式"  styleClass="button01" action="#{eva_planExecuteBB.changeSetMode}" rendered="#{list.evaModel=='0'&& list.caclMode!='1'&& list.pruview=='1'}">
               <x:updateActionListener property="#{eva_planExecuteBB.planID}" value="#{list.planId}"/>
            </h:commandButton>
             <h:commandButton value="切换计算模式"  styleClass="button01" action="#{eva_planExecuteBB.changeCommonMode}" rendered="#{list.evaModel=='0'&& list.caclMode=='1'&& list.pruview=='1'}">
               <x:updateActionListener property="#{eva_planExecuteBB.planID}" value="#{list.planId}"/>
            </h:commandButton>
             <h:commandButton value="配置计算模式"  styleClass="button01" onclick="setCaclMode('#{list.planId}')" rendered="#{list.evaModel=='0'&&list.caclMode=='1'&& list.pruview=='1'}">
            </h:commandButton>
        </h:column>

    </h:dataTable>
    </h:panelGrid>
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