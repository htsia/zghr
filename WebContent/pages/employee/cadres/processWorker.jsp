<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forSave() {
            if (document.all('form1:toOrg').value==""){
                alert("����¼������䵥λ");
                return false;
            }
            return forsubmit(document.forms(0));
        }
    </script>

<x:saveState value="#{emp_WorkImportBB}"/>
<h:form id="form1">
    <h:inputHidden id="addCadres" value="#{emp_WorkImportBB.processWork}"/>
    <c:verbatim>
    <table class="td_title" width="100%">
       <tr >
           <td>
</c:verbatim>
             <h:graphicImage value="/images/tips.gif" />
              <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-0350", "ͳһ�й�")%>
			</f:verbatim>
<c:verbatim>
           </td>
           <td align="right">
</c:verbatim>
               <h:commandButton value="����" action="#{emp_WorkImportBB.saveProcessWork}" onclick="return forSave();" styleClass="button01"></h:commandButton>
               <h:commandButton type="button" styleClass="button01" onclick="window.close()" value="����"></h:commandButton>
<c:verbatim>
           </td>
        </tr>
    </table>
    <br>
</c:verbatim>

    <h:panelGrid columns="2"  align="center" width="90%" columnClasses="td_form01,td_form02" styleClass="table03">
         <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2049", "��Ա����")%>
			</f:verbatim>
        
        <h:inputText readonly="true" id="name" value="#{emp_WorkImportBB.cadbo.name}"/>

         <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2145", "��Ա�Ա�")%>
			</f:verbatim>
        <h:panelGroup>
            <h:inputText readonly="true" styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                         value="#{emp_WorkImportBB.cadbo.sex}"
                         alt="�Ա�|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')"/>
        </h:panelGroup>

         <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2146", "ԭ��λ")%>
			</f:verbatim>
        <h:inputText id="oldOrg" readonly="true" value="#{emp_WorkImportBB.cadbo.oldOrg}"/>

          <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2153", "������ʱ��")%>
			</f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="workonDate" value="#{emp_WorkImportBB.cadbo.workonDate}"
                         readonly="true" alt="������ʱ��|1|d|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:workonDate')" />
        </h:panelGroup>

       <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2152", "����䵥λ")%>
			</f:verbatim>
        <h:panelGroup>
           <h:inputText styleClass="input" id="toOrg" value="#{emp_WorkImportBB.cadbo.orgID}" dict="yes" dict_num="OU"  code=""
                readonly="true"    alt="��������<|1|s|50||"/>
           <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgOnlyDlg('form1:toOrg',0,'')" />
        </h:panelGroup>

    </h:panelGrid>
</h:form>
    <script type="text/javascript">
       interpret(form1);
    </script>
