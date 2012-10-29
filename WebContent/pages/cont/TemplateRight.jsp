<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_templateRightBB}"/>
<html>
<head>
<title></title>
</head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
<script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
<script type="text/javascript" language="javascript">
 function checkSubmit(form2) {
        flag = true;
        var name = form2.all("form2:permitOrgNames").value;
        if (name == "" || name == null) {
            alert("被授权单位不能为空！");
            flag = false;
        }
        return flag;
    }
</script>
<body>
<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" >
   <h:outputText value="合同授权 " styleClass="td_title" style="width:100%"></h:outputText>
</h:panelGrid>
<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_templateRightBB.init_a}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="600">
    <h:panelGrid  border="0"  cellspacing="10" align="right" columns="2" columnClasses=",,td02">
         <h:commandLink id="link3" value="新签授权" action="cont_SignRight_jsf"></h:commandLink>
         <h:commandLink id="link2" value="审批授权" action="cont_ApproveRight_jsf"></h:commandLink>
    </h:panelGrid>
</h:panelGrid>
<center>
<h:commandLink id="doQuery" action="#{cont_templateRightBB.queryAll}"></h:commandLink>
<x:dataTable value="#{cont_templateRightBB.bos}" var="list"  rowIndexVar="index"
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
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton id="bnt" styleClass="button01" action="#{cont_templateRightBB.deleteSingle}" value="删除"
                                onclick="return confirm('确定要做删除吗？'); " >
                    <x:updateActionListener property="#{cont_templateRightBB.authorizeId}" value="#{list.authorizeId}"/>
                </h:commandButton>
            </h:column>
</x:dataTable>
<br/>
<hrdc:pageTag submitMethod="form1.all(\"form1:doQuery\").click()" />
</center>
</h:form>
<br/>
<h:form id="form2">
     <h:inputHidden id="authorizeId" value="#{cont_templateRightBB.bo.authorizeId}"/>
     <h:panelGrid width="400" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
          <h:outputText styleClass="td_form_required"  value="授权单位"></h:outputText>
          <h:inputText styleClass="input" value="#{cont_templateRightBB.bo.authorizeOrgId}" id="authorizeOrgId"  code="" dict="yes" dict_num="OU" readonly="true" alt="授权单位|0"/>
          <h:outputText  styleClass="td_form_required" value="被授权单位"></h:outputText>
          <h:panelGroup>
              <h:inputHidden id="permitOrgIds" value="#{cont_templateRightBB.permitOrgIds}"/>
              <h:inputTextarea
                id="permitOrgNames"
                rows="5"
                cols="30"
                readonly="true"
                value="#{cont_templateRightBB.permitOrgNames}"/>
                <c:verbatim><input name="Submit" type="button" class="button_select" value=""
                   onclick="PopUpMutilOrgTwoControl(document.forms(1).all('form2:permitOrgIds'),document.forms(1).all('form2:permitOrgNames'),'1', '')"></c:verbatim>

          </h:panelGroup>
      </h:panelGrid>

     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
            <h:commandButton disabled="#{cont_templateRightBB.rightFlag}" styleClass="button01" value="保存" action="#{cont_templateRightBB.save}" onclick="if( checkSubmit(document.forms(1))&&forsubmit(document.forms(1))){}else{return false;}" />
            <h:commandButton styleClass="button01" value="取消" action="#{cont_templateRightBB.cancel}"/>
     </h:panelGrid>

</h:form>
<c:verbatim>
<script type="text/javascript" language="javascript">
    interpret(document.forms(1));
</script>
</c:verbatim>
</body>
</html>