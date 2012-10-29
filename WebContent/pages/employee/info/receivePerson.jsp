<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doProcess(ID){
            window.showModalDialog("/employee/info/doReceive.jsf?personID="+ID, null, "dialogWidth:350px; dialogHeight:250px;center:center;resizable:no;status:no;");
            return true;
        }
    </script>

<x:saveState value="#{emp_CadresImportBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrgEdit" value="#{emp_CadresImportBB.receiveList}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
           <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2380","接收处理") %>
         </f:verbatim>
       </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:dataTable value="#{emp_CadresImportBB.personList}" var="list" align="center"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header">
         <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2148","处理日期") %>
         </f:verbatim>  
               </c:facet>
                <h:outputText value="#{list.addDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"> <f:verbatim>
            <%=LanguageSupport.getResource("MSG-0010","姓名") %>
         </f:verbatim>  </c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                 <f:verbatim>
            <%=LanguageSupport.getResource("MSG-0012","性别") %>
         </f:verbatim>  
                </c:facet>
                <h:outputText value="#{list.sex}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
            <%=LanguageSupport.getResource("MSG-0013","出生日期") %>
         </f:verbatim>  
                </c:facet>
                <h:outputText value="#{list.birthday}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2146","原单位") %>
         </f:verbatim>  
         </c:facet>
                <h:outputText value="#{list.oldOrg}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
           <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2152","拟分配单位") %>
         </f:verbatim>  
                </c:facet>
                <h:outputText value="#{list.orgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
          <f:verbatim>
            <%=LanguageSupport.getResource("RYGL-2150","办理状态") %>
         </f:verbatim>  
              </c:facet>
                <h:outputText value="#{list.stautsDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header">]
                 <f:verbatim>
            <%=LanguageSupport.getResource("YXGL-1026","操作") %>
         </f:verbatim>  
                </c:facet>
                <h:panelGroup>
                    <h:commandButton styleClass="button01" action="#{emp_CadresImportBB.doqueryReceive}"  value="办理接收" onclick="doProcess('#{list.personid}')"></h:commandButton>
                </h:panelGroup>
            </h:column>

        </h:dataTable>
</h:form>
