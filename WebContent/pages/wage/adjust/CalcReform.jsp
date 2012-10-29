<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function selPerson(){
	window.showModalDialog("/wage/adjust/addPerson.jsf", null, "dialogWidth:600px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson(){
	  var str=" |";
    chk=document.forms(0).selectItem;
    if (checkMutilSelect(chk)){
        var size = chk.length;
        if (size == null) {
            if (chk.checked) {
                str+=chk.value;
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (chk[i].checked) {
                    if (i==0){
                        str+=chk[i].value;
                    }
                    else{
                        str+=","+chk[i].value;
                    }
                }
            }
        }
       if(str != null && str!=""){
      	 var vars=str.split("|");
      	 document.all("form1:personStr").value = vars[1];
      }
    }
}

</script>

<x:saveState value="#{wageReformCaclMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wageReformCaclMgrBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 工资套改 -> 套改计算"/>
      				<f:verbatim>
               </td>
               <td align="left" class=td_title >
               	 </f:verbatim>
               	 	<h:commandButton value="增加人员"  styleClass="button01" onclick="return selPerson()"></h:commandButton>
               	 	<h:outputText value="  "></h:outputText>
               	 	<h:commandButton value="提取信息" action="#{wageReformCaclMgrBB.fechMessage}" styleClass="button01" onclick="selectPerson()"></h:commandButton>
               	 	<h:outputText value="  "></h:outputText>
               	 	<h:commandButton value="计算" action="#{wageReformCaclMgrBB.calculate}" styleClass="button01" onclick="selectPerson()"></h:commandButton>
               	 	<h:outputText value="  "></h:outputText>
               	 	<h:commandButton value="生效结束" action="#{wageReformCaclMgrBB.efictFinish}" styleClass="button01" onclick="selectPerson()"></h:commandButton>
               	 	<h:outputText value="  "></h:outputText>
               	 	<h:commandButton value="不生效结束" action="#{wageReformCaclMgrBB.finish}" styleClass="button01" onclick="selectPerson()"></h:commandButton>
               	 	<h:outputText value="  "></h:outputText>
      			<f:verbatim>
               </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">
            </td>
            <td align="right">
</f:verbatim>
				<h:panelGroup>
                <h:outputText value="记录数:#{wageReformCaclMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{wageReformCaclMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{wageReformCaclMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{wageReformCaclMgrBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{wageReformCaclMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{wageReformCaclMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{wageReformCaclMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{wageReformCaclMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{wageReformCaclMgrBB.reformJobWageList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="2000" >
            <x:column width="40">
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.dataId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
            </x:column>
           
            <x:column width="80">
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.personId}"/>
            </x:column>

            <x:column width="100">
                <c:facet name="header"><h:outputText value="套改名称"/></c:facet>
                <h:outputText value="#{list.setId}"/>
            </x:column>
			<x:column width="100">
                <c:facet name="header"><h:outputText value="计算时间"/></c:facet>
                <h:outputText value="#{list.caclDate}"/>
            </x:column>
            <x:column width="100">
                <c:facet name="header"><h:outputText value="职务级别"/></c:facet>
                <h:outputText value="#{list.jobLevel}"/>
            </x:column>

            <x:column width="150">
                <c:facet name="header"><h:outputText value="前一级职务级别"/></c:facet>
                <h:outputText value="#{list.lastJobLevel}"/>
            </x:column>

            <x:column width="100">
                <c:facet name="header"><h:outputText value="职称级别"/></c:facet>
                <h:outputText value="#{list.titleLevel}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="前一级职称级别"/></c:facet>
                <h:outputText value="#{list.lastTitleLevel}"/>
            </x:column>
            <x:column width="120">
                <c:facet name="header"><h:outputText value="工人技术等级"/></c:facet>
                <h:outputText value="#{list.workerLevel}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="前一级工人技术等级"/></c:facet>
                <h:outputText value="#{list.lastWorkerLevel}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="岗位工资级别"/></c:facet>
                <h:outputText value="#{list.curPostWage}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="级别工资"/></c:facet>
                <h:outputText value="#{list.curLevelWage}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="基本工资总额"/></c:facet>
                <h:outputText value="#{list.curTotal}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="前任岗位工资级别"/></c:facet>
                <h:outputText value="#{list.lastPostWage}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="前任级别工资"/></c:facet>
                <h:outputText value="#{list.lastLevelWage}"/>
            </x:column>
            <x:column width="150">
                <c:facet name="header"><h:outputText value="前任基本工资总额"/></c:facet>
                <h:outputText value="#{list.lastTotal}"/>
            </x:column>
            <x:column width="100">
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </x:column>
            
        </x:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>