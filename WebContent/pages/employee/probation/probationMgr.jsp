<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function changeStatus(){
    disPlayProcessBar();
    document.all("form1").submit();
}
function SetProbation() {
    window.showModalDialog("/employee/probation/OrgProbationEdit.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function modifyDate(pid) {
    window.showModalDialog("/employee/probation/probationPassdateEdit.jsf?personId="+pid, null, "dialogWidth:350px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
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
function selectPerson3(){
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
	    	if(confirm("确定要生效吗")){
		    	var vars=str.split("|");
		    	document.all("form1:personStr").value = vars[1];
		    	return true;
	    	}else{
	    		return false;
	    	}
	    }
	  }else{
		  alert("请选择人员");
		  return false;
	  }
}
function selectPerson2(perid){
    window.showModalDialog("/employee/probation/probationWageEdit.jsf?personId="+perid, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson4(perid){
    window.showModalDialog("/employee/probation/probationWageEdit2.jsf?personId="+perid, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function showTable(changId){
    if (document.all("form1:ReportID").value=='' || document.all("form1:ReportID").value=='-1'){
        alert("请先选择表格样式！");
        return false;
    }
    url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+changId+"&ORGUID=&Parameter=&Title=";
	window.open(url);
}
</script>

<x:saveState value="#{empprobastionmgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{empprobastionmgrBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                     <f:verbatim>
                     	    <%=LanguageSupport.getResource("RYGL-0300", "人员管理")%>->
              				<%=LanguageSupport.getResource("RYGL-2429", "转正管理")%>
                     </f:verbatim>
      				<f:verbatim>
               </td>
               <td align="left" class=td_title>
              </f:verbatim> 
               		<h:outputText value="试用期"/>
					<h:outputText value="#{empprobastionmgrBB.passMonth}"/>
               		<h:outputText value="个月,见习期"/>
					<h:outputText value="#{empprobastionmgrBB.passMonth2}"/>
					<h:outputText value="个月  "></h:outputText>
					<h:commandButton value="设置"  styleClass="button01" onclick="return SetProbation()"/>
                	<h:outputText value="  "></h:outputText>
					<h:commandButton value="报批"  styleClass="button01" onclick="selectPerson();" action="#{empprobastionmgrBB.approvid}" rendered="#{empprobastionmgrBB.mustApprov=='0'}"/>
                	<h:outputText value="  "></h:outputText>
                	<h:commandButton value="人事信息生效"  styleClass="button01" onclick="return selectPerson3();" action="#{empprobastionmgrBB.shengxiao}"/>
               <f:verbatim>
                    <%
                        if ("0".equals(Constants.EMP_DIRECT_PROBATION)) {
                            out.println("<input type='button' class='button01' value='流程说明' onclick='showWorkDefine(\"" + WFTypeBO.RYGL_PROBATION + "\")'>");
                        }
                    %>
               </td>
               <td align="right" class=td_title >
               </f:verbatim>
              			<h:outputText value="试用"/>
                        <h:selectBooleanCheckbox value="#{empprobastionmgrBB.newProbation}" onclick="changeStatus();" valueChangeListener="#{empprobastionmgrBB.queryNewProbation}" />
              			<h:outputText value="见习"/>
                        <h:selectBooleanCheckbox value="#{empprobastionmgrBB.newProbation2}" onclick="changeStatus();" valueChangeListener="#{empprobastionmgrBB.queryNewProbation2}" />
                        <h:outputText value="报批" rendered="#{empprobastionmgrBB.mustApprov=='0'}"/>
                        <h:selectBooleanCheckbox value="#{empprobastionmgrBB.apprving}" onclick="changeStatus();" valueChangeListener="#{empprobastionmgrBB.queryApprving}" rendered="#{empprobastionmgrBB.mustApprov=='0'}"/>
                        <h:outputText value="批准" rendered="#{empprobastionmgrBB.mustApprov=='0'}"/>
                        <h:selectBooleanCheckbox value="#{empprobastionmgrBB.apprived}" onclick="changeStatus();" valueChangeListener="#{empprobastionmgrBB.queryApprived}" rendered="#{empprobastionmgrBB.mustApprov=='0'}"/>
                        <h:outputText value="生效"/>
                        <h:selectBooleanCheckbox value="#{empprobastionmgrBB.efficent}" onclick="changeStatus();" valueChangeListener="#{empprobastionmgrBB.queryEfficent}" />
                        <h:outputText value="辞退" rendered="#{empprobastionmgrBB.mustApprov=='0'}"/>
                        <h:selectBooleanCheckbox value="#{empprobastionmgrBB.refuse}" onclick="changeStatus();" valueChangeListener="#{empprobastionmgrBB.queryRefuse}" rendered="#{empprobastionmgrBB.mustApprov=='0'}"/>
      			<f:verbatim>
               </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr>
    </f:verbatim>
            <h:outputText escape="false" value="<strong>姓名、简拼或编号:</strong>"></h:outputText>
            <h:inputText value="#{empprobastionmgrBB.name}"></h:inputText>

            <h:outputText escape="false" value="<strong>预计转正时间:</strong>"></h:outputText>
            <h:inputText value="#{empprobastionmgrBB.time}" id="time" readonly="true" alt="日期|1|d|50||"></h:inputText>
 			<f:verbatim>
 				<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:time')">
 			</f:verbatim>
 			 <f:verbatim>
              	 <%=LanguageSupport.getResource("XTGL-1242", "至")%>
             </f:verbatim>
 			<h:inputText value="#{empprobastionmgrBB.time2}" id="time2" readonly="true" alt="日期|1|d|50||"></h:inputText>
 			<f:verbatim>
 				<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:time2')">
 			</f:verbatim>
 			<h:commandButton value="查询" styleClass="button01" action="#{empprobastionmgrBB.queryPersonList}"></h:commandButton>
<f:verbatim>
            </td>
            </tr>

            <tr>
            <td align="right">
</f:verbatim>
				<h:panelGroup>
				<h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{empprobastionmgrBB.regTableList}"/>
           	    </h:selectOneMenu>
                <h:outputText value=" "></h:outputText>
                <f:verbatim>
					 <%=LanguageSupport.getResource("COMM-1043", "记录数")%>:
              	</f:verbatim>
                <h:outputText value="#{empprobastionmgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
				   <%=LanguageSupport.getResource("COMM-1044", "页数")%>:
              	</f:verbatim>
	            <h:outputText value="#{empprobastionmgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
					 <%=LanguageSupport.getResource("COMM-1045", "每页有")%>
			    </f:verbatim>
	            <h:outputText value="#{empprobastionmgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
			       <%=LanguageSupport.getResource("COMM-1046", "当前为第")%>
				 </f:verbatim>
	            <h:outputText value="#{empprobastionmgrBB.mypage.currentPage}"></h:outputText>
	            <f:verbatim>
				    <%=LanguageSupport.getResource( "COMM-1047", "页")%>
				 </f:verbatim>
	            <h:commandButton value="首页" action="#{empprobastionmgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{empprobastionmgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{empprobastionmgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{empprobastionmgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{empprobastionmgrBB.personList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.personId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
            </h:column>
           
            <h:column>
                <c:facet name="header"><h:outputText value="姓名" style="width:60px"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                <h:outputText value="#{list.sex}"/>
            </h:column>            
            <h:column>
                <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="所在岗位"/></c:facet>
                <h:outputText value="#{list.postName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="岗位级别"/></c:facet>
                <h:outputText value="#{list.postLevel}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="人员类别"/></c:facet>
                <h:outputText value="#{list.personType}"/>
            </h:column>
             <h:column>
                <c:facet name="header"><h:outputText value="入校时间"/></c:facet>
                <h:outputText value="#{list.unitTime}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="预计转正日期"/></c:facet>
                <h:outputText value="#{list.planPassDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="转正倒计天数"/></c:facet>
                <h:outputText value="#{list.haveDays}"/>
            </h:column>
			<h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:panelGrid columns="3">
                <h:commandButton value="删除信息" onclick="return confirm('确定要删除吗?');" action="#{empprobastionmgrBB.delete}" styleClass="button01" rendered="#{list.status=='0' || list.status=='5'}">
                	<x:updateActionListener value="#{list.personId}" property="#{empprobastionmgrBB.personId}"></x:updateActionListener>
                </h:commandButton>
                <h:commandButton value="调整时间" onclick="return modifyDate('#{list.personId}')" styleClass="button01" rendered="#{list.status!='3'&&list.status!='4'}"></h:commandButton>
                <h:commandButton value="查看流程" onclick="return showWorkFlowLogByLinkID('#{list.personId}')" styleClass="button01" rendered="#{empprobastionmgrBB.mustApprov=='0'}"></h:commandButton>

                <h:commandButton value="拟定薪资" styleClass="button01" onclick="return selectPerson2('#{list.personId}');" rendered="#{list.status=='0' || list.status=='5'}"/>
                <h:commandButton value="显示表格" styleClass="button01" onclick="return showTable('#{list.personId}');"/>
                </h:panelGrid>
            </h:column>
        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
