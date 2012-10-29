<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
    function forAdd() {
        window.showModalDialog("/lead/HtmlFileEdit.jsf?OrgID"+document.all('form1:orgID').value, null, "dialogWidth:430px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModify(ID) {
        var v=window.showModalDialog("/lead/HtmlFileEdit.jsf?OrgID="+document.all('form1:orgID').value+"&FileID="+ID, null, "dialogWidth:430px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function toconfirm(){
          if (confirm(' 确定要删除吗 ?'))
             return true;
          else
             return false;
    }
    function changeOrg(){
        PopUpOrgOnlyDlgTwoControl('form1:orgID','form1:orgName',2);
        document.all('form1').submit();
    }
</script>

  <x:saveState id="htmlBackingBean" value="#{htmlBackingBean}"/>
  <h:form id="form1">
    <h:inputHidden value="#{htmlBackingBean.pageInit}"  />
	<h:panelGrid width="98%" align="center" border="0"  cellpadding="2" cellspacing="0" columns="2" styleClass="td_title">
        <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value=" html文本管理"/>
        </h:panelGroup>

	   <h:panelGrid align="right" columns="4">
           <h:commandButton id="id_add" value="增加" styleClass="button01"    onclick="forAdd()"  />
           <h:outputText value="    " />
	  </h:panelGrid>
	</h:panelGrid>

      <c:verbatim><br></c:verbatim>
      <h:outputText value="当前单位："></h:outputText>
      <h:inputText readonly="true" id="orgName" value="#{htmlBackingBean.orgName}"/>
      <h:inputHidden id="orgID" value="#{htmlBackingBean.orgID}"></h:inputHidden>
      <h:commandButton type="button" styleClass="button_select" onclick="changeOrg();" />
      <c:verbatim><br></c:verbatim>

    <h:dataTable value="#{htmlBackingBean.htmlList}"
            headerClass="td_top" styleClass="table03"  id="dateList"
            var="timelist" width="95%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" align="center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="上传时间" style="width:120px"/>
				</f:facet>
				<h:outputText id="showname"  value="#{timelist.archivesDate}" style="width:120px;border:0px"/>
			</h:column>
			
        <h:column>
            <f:facet name="header">
                <h:outputText value="单位" style="width:120px"/>
            </f:facet>
            <h:outputText id="org"  value="#{timelist.orgName}" style="width:120px;border:0px"/>
        </h:column>

			<h:column  >
				<f:facet name="header">
					<h:outputText value="模型类型" style="width:80px" />
				</f:facet>
                <h:outputText id="storeTable"  value="#{timelist.resName}" style="width:120px;border:0px"/>
			</h:column>


        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton action="#{htmlBackingBean.delete}" styleClass="button01" value="删除" onclick="return toconfirm();">
                    <x:updateActionListener property="#{htmlBackingBean.fileID}" value="#{timelist.fileId}"></x:updateActionListener>
                </h:commandButton>
                <h:commandButton type="button" styleClass="button01" value="修改" onclick="forModify('#{timelist.fileId}');"/>
            </h:panelGrid>
        </h:column>

        </h:dataTable>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

