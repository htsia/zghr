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
            if (document.all('form1:name').value==""){
                alert("����¼������");
                return false;
            }
            if (document.all('form1:oldOrg').value==""){
                alert("����¼��ԭ��λ");
                return false;
            }
            return forsubmit(document.forms(0));
        }
    </script>

<x:saveState value="#{emp_WorkImportBB}"/>
<h:form id="form1">
    <c:verbatim>
    <table class="td_title" width="100%">
       <tr >
           <td>
              <img src="/images/tips.gif" alt="" >
                <%=LanguageSupport.getResource("RYGL-0350","ͳһ�й�")%>  
           </td>
           <td align="right">
</c:verbatim>
               <h:commandButton value="����" action="#{emp_WorkImportBB.saveWork}" onclick="return forSave();" styleClass="button01"></h:commandButton>
               <h:commandButton type="button" styleClass="button01" onclick="window.close()" value="����"></h:commandButton>
<c:verbatim>
           </td>
        </tr>
    </table>
    <br>
 </c:verbatim>
    <h:panelGrid columns="2"  align="center" width="90%" columnClasses="td_form01,td_form02" styleClass="table03">
        <f:verbatim>
         <%=LanguageSupport.getResource("RYGL-2049","��Ա����")%> 
        </f:verbatim>
        <h:inputText id="name" value="#{emp_WorkImportBB.cadbo.name}"/>

        <f:verbatim>
         <%=LanguageSupport.getResource("RYGL-2145","��Ա�Ա�")%> 
        </f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                         readonly="true" value="#{emp_WorkImportBB.cadbo.sex}"
                         alt="�Ա�|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')"/>
        </h:panelGroup>
        <f:verbatim>
         <%=LanguageSupport.getResource("RYGL-1015","���֤��")%> 
        </f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="A001077" value="#{emp_WorkImportBB.cadbo.pid}"   alt="���֤��|0|s|50||"/>
        </h:panelGroup>

         <f:verbatim>
         <%=LanguageSupport.getResource("RYGL-2146","ԭ��λ")%> 
        </f:verbatim>
        <h:inputText id="oldOrg" value="#{emp_WorkImportBB.cadbo.oldOrg}"/>
    </h:panelGrid>
</h:form>
