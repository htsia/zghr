<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript">
       function DoSelectAll(isSelect){
            var size = document.all('form1:inputField').length;
            for (var i = 0; i < size; i++) {
                document.all('form1:inputField')[i].checked=isSelect;
            }
        }
       function forsave(){
    	   if(!checkMutilSelect(form1.all('form1:inputField'))){
    		   alert('请选择输入项');
    		   return false;
    	   }
    	   return true;
       }
    </script>
<!-- BaseRateInputEditBackingBean -->
<x:saveState value="#{ins_brieBB}"/>
<h:form id="form1">
<h:inputHidden value="#{ins_brieBB.pageInit}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=20 class="td_title"><img src="/images/tips.gif">保险管理 -> 录入保险基数</td>
        </tr>
    </table>
    <br/>
	</c:verbatim>
    <h:panelGrid columns="2" width="95%"  styleClass="table03" align="center" columnClasses="td_top,td_top,td_top">

        <h:outputText escape="false" value="<strong>选择输入项：</strong>"/>
        <h:selectManyCheckbox value="#{ins_brieBB.selectFields}" layout="pageDirection" id="inputField">
            <c:selectItems value="#{ins_brieBB.fieldsList}"/>
        </h:selectManyCheckbox>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="1" cellspacing="3" style="margin-left:20px;">
        <h:panelGroup>
            <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
            <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
            <h:commandButton styleClass="button01" value="确认" action="#{ins_brieBB.queryPersonInput2}"
                             onclick="return forsave();"/>
            <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
        </h:panelGroup>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="1" cellspacing="0" align="center" width="95%" >
        <h:outputText escape="false" value="<strong>已选择人员列表</strong>"/>
        <h:dataTable value="#{ins_brieBB.personlist}" var="list" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="所在单位"/></c:facet>
                <h:outputText value="#{list.orgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   interpret(document.forms(0));
   setDataTableOver("form1:dateList");
</script>