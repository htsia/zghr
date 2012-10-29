<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function foradd() {
            window.showModalDialog("/system/SelfLevelEdit.jsf", null, "dialogWidth:530px; dialogHeight:350px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(itemID) {
            window.showModalDialog("/system/SelfLevelEdit.jsf?itemID="+itemID, null, "dialogWidth:530px; dialogHeight:350px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{sys_selflevelListBB}"/>
	<h:form id="form1">
       <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2" align="center">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
               <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-0900","ϵͳ���� ")%> -> 
                   <%=LanguageSupport.getResource("XTGL-1073","����Ȩ�޼������")%>  
               </f:verbatim>
            </h:panelGroup>

           <h:panelGrid columns="1"  align="right">
               <h:panelGroup>
                   <h:commandButton value="����"  styleClass="button01" onclick="return foradd();"/>
               </h:panelGroup>
           </h:panelGrid>

       </h:panelGrid>

        <f:verbatim>
			<br>
		</f:verbatim>

		<h:dataTable value="#{sys_selflevelListBB.levelList}" var="bulist" id="dateList"
                     columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     width="98%"  headerClass="td_top"
                     styleClass="table03"  align="center">
            <h:column>
				<f:facet name="header">  
				 <f:verbatim>
                   <%=LanguageSupport.getResource("JGGL-1058","����")%>  
                 </f:verbatim>
				</f:facet>
				<h:outputText style="width:80px" value="#{bulist.itemName}" />
			</h:column>

            <h:column>
				<f:facet name="header">
				    <f:verbatim>
                   <%=LanguageSupport.getResource("YXGL-1024","����")%>  
                 </f:verbatim>
				</f:facet>
				<h:outputText value="#{bulist.itemDes}" />
			</h:column>

			<h:column>
				<f:facet name="header">
				   <f:verbatim>
                   <%=LanguageSupport.getResource("YXGL-1026","����")%>  
                 </f:verbatim>
				</f:facet>
                <h:commandButton value="�޸�" styleClass="button01" onclick="forModify('#{bulist.itemID}')"></h:commandButton>
                <h:commandButton value="ɾ��"  styleClass="button01" action="#{sys_selflevelEditBB.Delete}">
                   <x:updateActionListener property="#{sys_selflevelEditBB.itemID}" value="#{bulist.itemID}"/>
                </h:commandButton>
            </h:column>

        </h:dataTable>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
