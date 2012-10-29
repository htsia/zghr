<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script language="javascript">
       function check() {
          var perent = document.all('form1:parentid').value;
          if(perent == ""){
            alert("请选择父节点");
            return false ;
              }
       }
    </script>
<x:saveState value="#{Rpt_DefineListBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{Rpt_DefineListBB.initset}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="上级目录节点"></h:outputText>
			<h:panelGroup>
                <h:inputText id="parentname" readonly="true" value="#{Rpt_DefineListBB.rptclassbo.prptcodeName}" />
                <h:inputHidden id="parentid" value="#{Rpt_DefineListBB.rptclassbo.prptcode}" />
                <h:commandButton type="button" styleClass="button_select" 
                onclick="PopUpRptDefineListsss(document.all('form1:parentid'),document.all('form1:parentname'))"/>
        </h:panelGroup>

            <h:outputText value="目录名称"/>
            <h:inputText id="name" value="#{Rpt_DefineListBB.rptclassbo.rptDesc}" />

        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{Rpt_DefineListBB.SaveSet}"
                        onclick="return check();"      />
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
