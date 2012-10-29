<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim><base target="_self"></c:verbatim>
<script language="javascript">
    function addForum(){
        window.showModalDialog("/system/AddForum.jsf", null, "dialogWidth:630px; dialogHeight:440px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function openQuestion(ID){
        window.showModalDialog("/system/OpenQuestion.jsf?fomID="+ID, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
</script>
<x:saveState value="#{self_forumListBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{self_forumListBB.pageInit}" />
    <c:verbatim>
    <table width=98% height=98% align="center">
     <tr><td height=8>
</c:verbatim>
        <h:panelGrid align="center" styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
            <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-0956","论坛管理 ")%>  
             </f:verbatim>
            </h:panelGroup>

            <h:panelGrid columns="1"  cellpadding="2" align="right" 	border="0" >
                  <h:panelGroup>
                      <h:commandButton value="发新帖" onclick="return addForum();"  styleClass="button01" />
                 </h:panelGroup>
            </h:panelGrid>
       </h:panelGrid>
<c:verbatim>
     </td></tr>

    <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
            <h:dataTable value="#{self_forumListBB.forumList}" var="list" width="100%"   id="dateList"
                         headerClass="td_top"
                         styleClass="table03" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center" align="center">
                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
			                 <%=LanguageSupport.getResource("XTGL-1108","发帖日期")%>  
			             </f:verbatim>
                    </f:facet>
                    <h:outputText style="width:80px" value="#{list.submitTime}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
			                 <%=LanguageSupport.getResource("XTGL-1105","标题")%>  
			             </f:verbatim>
                    </f:facet>
                    <h:outputText style="width:80px" value="#{list.subject}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
			                 <%=LanguageSupport.getResource("XTGL-1111","内容")%>  
			             </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{list.content}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
			                 <%=LanguageSupport.getResource("XTGL-1115","作者")%>  
			             </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{list.nickName}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                          <f:verbatim>
			                 <%=LanguageSupport.getResource("XTGL-1116","回复数")%>  
			             </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{list.ansCounter}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                         <f:verbatim>
			                 <%=LanguageSupport.getResource("XTGL-1117","人气数")%>  
			             </f:verbatim>
                    </f:facet>
                    <h:outputText value="#{list.hiteCounter}" />
                </h:column>

                <h:column>
                    <f:facet name="header">
                           <f:verbatim>
			                 <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
			             </f:verbatim>
                    </f:facet>
                    <h:commandButton styleClass="button01" value="打开" onclick="return openQuestion('#{list.fomID}');"></h:commandButton>
                    <h:commandButton value="删除" action="#{self_forumListBB.DeleteForum}" styleClass="button01" onclick="return confirm('确定要删除吗?')">
                        <x:updateActionListener property="#{self_forumListBB.forumID}" value="#{list.fomID}"></x:updateActionListener>
                    </h:commandButton>
                </h:column>
            </h:dataTable>
<c:verbatim>
         </div>
    </td></tr>
    </table>
</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>