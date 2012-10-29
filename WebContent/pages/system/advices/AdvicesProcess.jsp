<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<base target="_self">
<script language="javascript">
    function doReply(advID){
        window.showModalDialog("/system/ReplyAdvices.jsf?advID="+advID, null, "dialogWidth:630px; dialogHeight:560px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>
<x:saveState value="#{self_advicesListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{self_advicesListBB.initRec}" />
    <h:panelGrid align="center" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
        <h:panelGroup>
          <h:graphicImage value="/images/tips.gif" />
           <f:verbatim>
          		<%=LanguageSupport.getResource("XTGL-1106","建议列表")%>
			</f:verbatim>
        </h:panelGroup>

        <h:panelGrid columns="1"  cellpadding="2" align="right" 	border="0" >
              <h:panelGroup>
                  <h:selectBooleanCheckbox value="#{self_advicesListBB.all}" onclick="submit();" valueChangeListener="#{self_advicesListBB.changeAll}"></h:selectBooleanCheckbox>
                   <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1107","显示全部")%>
				   </f:verbatim>
                  <h:outputText escape="false" value="&nbsp;&nbsp;"></h:outputText>
             </h:panelGroup>
        </h:panelGrid>
   </h:panelGrid>


    <h:panelGrid width="98%" align="center">
    <h:dataTable value="#{self_advicesListBB.advList}" var="list" width="100%"   id="dateList"
                 headerClass="td_top"
                 styleClass="table03" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center" align="center">
        <h:column>
            <f:facet name="header">
                   <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1108","发送日期")%>
				   </f:verbatim>
            </f:facet>
            <h:outputText style="width:80px" value="#{list.advSenddate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                 <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1109","发送人")%>
				   </f:verbatim>
            </f:facet>
            <h:outputText value="#{list.advSendName}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                  <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1110","欲发机构")%>
				   </f:verbatim>
            </f:facet>
            <h:outputText value="#{list.advOrgName}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                    <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1105","标题")%>
				   </f:verbatim>
            </f:facet>
            <h:outputText style="width:80px" value="#{list.advSubject}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                  <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1111","内容")%>
				   </f:verbatim>
               
            </f:facet>
            <h:outputText value="#{list.advContent}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                  <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1112","是否回复")%>
				   </f:verbatim>
               
            </f:facet>
            <h:outputText value="#{list.advReplyed}" />
        </h:column>


        <h:column>
            <f:facet name="header">
           <f:verbatim>
		          		<%=LanguageSupport.getResource("XTGL-1113","回复时间")%>
	       </f:verbatim>
            </f:facet>
            <h:outputText value="#{list.advReplyDate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                  
           <f:verbatim>
		       <%=LanguageSupport.getResource("XTGL-1114","回复内容")%>
	       </f:verbatim>
            </f:facet>
            <h:outputText value="#{list.advReplyContent}" />
        </h:column>
        <h:column>
            <f:facet name="header"> 
             <f:verbatim>
		      	 <%=LanguageSupport.getResource("YXGL-1026","操作")%>
	        </f:verbatim>      
            </f:facet>
            <h:commandButton value="回复" styleClass="button01" onclick="doReply('#{list.advID}')" rendered="#{list.advReplyed!='是'}"></h:commandButton>
        </h:column>
    </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
