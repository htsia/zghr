<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.cont.web.ApproveRightBackingBean"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_approveRightBB}"/>
<html>
<head>
<title></title>
</head>
<script type="text/javascript" language="javascript">
 function checkSubmit(form2) {
        flag = true;
        var name = form2.all("form2:permitOrgNames").value;
        if (name == "" || name == null) {
            alert("被授权单位不能为空！");
            flag = false;
            return flag;
        }
        var name1 = form2.all("form2:authorizeLong").value;
        var name2 = form2.all("form2:authorizeShort").value;
        if (name1 == "否" && name2 == "否") {
            alert("审查中长期用工合同和审查短期用工合同必须至少有一项值为“是”");
            flag = false;
            return flag;
        }
        return flag;
    }
</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="审查授权" styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>

<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_approveRightBB.init_a}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="600">
    <h:panelGrid  border="0"  cellspacing="10" align="right" columns="3" columnClasses=",td02,">
         <h:commandLink id="link3" value="新签授权" action="cont_SignRight_jsf"></h:commandLink>
         <h:outputText value="审查授权"></h:outputText>
    </h:panelGrid>
</h:panelGrid>
<center>
<h:commandLink id="doQuery" action="#{cont_approveRightBB.queryAll}"></h:commandLink>
<x:dataTable value="#{cont_approveRightBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"
                     rowClasses="td_middle" styleClass="table03" width="600" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="授权单位"/></c:facet>
                <h:outputText value="#{list.authorizeOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="被授权单位"/></c:facet>
                <h:outputText value="#{list.permitOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="授权人"/></c:facet>
                <h:outputText value="#{list.authorizePersonId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="审查中长期用工合同"/></c:facet>
                <h:outputText value="#{list.authorizeLong}"/>
            </h:column>
             <h:column>
                <c:facet name="header"><h:outputText value="审查短期用工合同"/></c:facet>
                <h:outputText value="#{list.authorizeShort}"/>
            </h:column>

           <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton id="bnt" styleClass="button01" action="#{cont_approveRightBB.deleteSingle}" value="删除"
                                onclick="return confirm('确定要做删除吗？'); " >
                    <x:updateActionListener property="#{cont_approveRightBB.authorizeId}" value="#{list.authorizeId}"/>
                </h:commandButton>

            </h:column>
</x:dataTable>
<br/>
<hrdc:pageTag submitMethod="form1.all(\"form1:doQuery\").click()" />
</center>
</h:form>
<br/>
<h:form id="form2">
     <h:inputHidden id="authorizeId" value="#{cont_approveRightBB.bo.authorizeId}" />
     <h:panelGrid width="400" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
          <h:outputText styleClass="td_form_required" value="授权单位"></h:outputText>
          <h:inputText styleClass="input" value="#{cont_approveRightBB.bo.authorizeOrgId}" id="authorizeOrgId"  code="" dict="yes" dict_num="OU" readonly="true" alt="授权单位|0"/>
          <h:outputText styleClass="td_form_required" value="被授权单位"></h:outputText>
          <h:panelGroup>
              <h:inputHidden id="permitOrgIds" value="#{cont_approveRightBB.permitOrgIds}"/>
              <h:inputTextarea
                id="permitOrgNames"
                rows="5"
                cols="30"
                readonly="true"
                value="#{cont_approveRightBB.permitOrgNames}"/>
                <c:verbatim><input name="Submit" type="button" class="button_select" value=""
                   onclick="PopUpMutilOrgTwoControl(document.forms(1).all('form2:permitOrgIds'),document.forms(1).all('form2:permitOrgNames'),'1', '')"></c:verbatim>

          </h:panelGroup>
<%
    ApproveRightBackingBean bb = (ApproveRightBackingBean)request.getAttribute("cont_approveRightBB");
    if(bb.getRightLongFlag()){
%>
          <h:outputText styleClass="td_form_required" value="审查中长期"></h:outputText>
          <h:selectOneMenu value="#{cont_approveRightBB.bo.authorizeLong}" id="authorizeLong" style="width:50" >
              <c:selectItem itemValue="是" itemLabel="是" />
              <c:selectItem itemValue="否" itemLabel="否" />
          </h:selectOneMenu>
<%
    }else{
%>
         <h:outputText styleClass="td_form_required" value="审查中长期"></h:outputText>
         <h:selectOneMenu value="#{cont_approveRightBB.bo.authorizeLong}" id="authorizeLong" style="width:50" >
              <c:selectItem itemValue="否" itemLabel="否" />
         </h:selectOneMenu>
<%
    }
%>
<%
    if(bb.getRightShortFlag()){
%>
          <h:outputText styleClass="td_form_required" value="审查短期"></h:outputText>
          <h:selectOneMenu value="#{cont_approveRightBB.bo.authorizeShort}" id="authorizeShort" style="width:50" >
              <c:selectItem itemValue="是" itemLabel="是" />
              <c:selectItem itemValue="否" itemLabel="否" />
          </h:selectOneMenu>
<%
    }else{
%>
         <h:outputText styleClass="td_form_required" value="审查短期"></h:outputText>
         <h:selectOneMenu value="#{cont_approveRightBB.bo.authorizeShort}" id="authorizeShort" style="width:50" >
              <c:selectItem itemValue="否" itemLabel="否" />
         </h:selectOneMenu>
<%
    }
%>


     </h:panelGrid>

     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
         <h:commandButton styleClass="button01" value="保存" action="#{cont_approveRightBB.save}" onclick="if( checkSubmit(document.forms(1))&&forsubmit(document.forms(1))){}else{return false;}" disabled="#{cont_approveRightBB.rightFlag}" />
         <h:commandButton styleClass="button01" value="取消" action="#{cont_approveRightBB.cancel}"/>
     </h:panelGrid>
</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(1));
</script>
</c:verbatim>
</body>
</html>