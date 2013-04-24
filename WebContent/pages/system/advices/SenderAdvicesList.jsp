<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script language="javascript">
    function addAdvice(){
        window.showModalDialog("/system/AddAdvices.jsf", null, "dialogWidth:630px; dialogHeight:440px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>
<x:saveState value="#{self_advicesListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{self_advicesListBB.initSender}" />
    <c:verbatim>
        <table height=98% width=98% align="center">
            <tr><td height=8>
    </c:verbatim>
        <h:panelGrid align="center" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
        <h:panelGroup>
          <h:graphicImage value="/images/tips.gif" />
          <h:outputText value=" 建议列表2"/>
        </h:panelGroup>

        <h:panelGrid columns="1"  cellpadding="2" align="right" border="0" >
              <h:panelGroup>
                  <h:selectBooleanCheckbox value="#{self_advicesListBB.all}" onclick="submit();" valueChangeListener="#{self_advicesListBB.changeAll}"></h:selectBooleanCheckbox>
                  <h:outputText escape="false" value="显示全部&nbsp;&nbsp;"></h:outputText>
                  <h:commandButton value="提新建议" onclick="return addAdvice();"  styleClass="button01" />
                  <h:commandButton type="button" styleClass="button01" value="返回"  onclick="window.close();" />
             </h:panelGroup>
        </h:panelGrid>
   </h:panelGrid>
    <c:verbatim>
            </td></tr>

            <tr valign="top">
                <td>
    </c:verbatim>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
        <h:dataTable value="#{self_advicesListBB.advList}" var="list" width="100%"  id="dateList"
                     headerClass="td_top"
                     styleClass="table03" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center" align="center">
            <h:column>
                <f:facet name="header">
                    <h:outputText value="发送日期" />
                </f:facet>
                <h:outputText style="width:80px" value="#{list.advSenddate}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="标题" />
                </f:facet>
                <h:outputText style="width:80px" value="#{list.advSubject}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="内容" />
                </f:facet>
                <h:outputText value="#{list.advContent}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="是否回复" />
                </f:facet>
                <h:outputText value="#{list.advReplyed}" />
            </h:column>


            <h:column>
                <f:facet name="header">
                    <h:outputText value="回复时间" />
                </f:facet>
                <h:outputText value="#{list.advReplyDate}" />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="回复内容" />
                </f:facet>
                <h:outputText value="#{list.advReplyContent}" />
            </h:column>
            <h:column>
                <f:facet name="header">
                    <h:outputText style="width:40px" value="操作" />
                </f:facet>
				<h:commandButton value="删除" onclick="return confirm('确定要删除吗');" action="#{self_advicesListBB.delete}"  styleClass="button01">
					<x:updateActionListener value="#{list.advID}" property="#{self_advicesListBB.operID}"/>
				</h:commandButton>
            </h:column>
        </h:dataTable>
        </div>
    <c:verbatim>
                </td>
            </tr>
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
