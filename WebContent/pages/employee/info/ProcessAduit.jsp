<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
    <%
            String ids = (String)request.getParameter("perIds");
    %>
<script type="text/javascript">
      function changeInfo(){
          if (document.all('form1:auditResult').value=='00901'){
               document.all('form1:auditMessage').value="�����͵���Ա������ͨ����";
          }
          else if (document.all('form1:auditResult').value=='00900'){
               document.all('form1:auditMessage').value="�����͵���Աδͨ��������";
          }
      }
</script>
    <x:saveState value="#{emp_personListBB}"/>
    <h:form id="form1">
        <c:verbatim>
        <input type="hidden" name="pids" value="<%=ids%>">
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td colspan=4>
             <strong>
                 <%=LanguageSupport.getResource("RYGL-2376","������ԱҪ��������ҵ��") %>
             </strong>
            <br>
               <%
                   String UnitID="";
                   String Namelist="";
                   String []pelist=ids.split(",");
                   for(int i=0;i<pelist.length;i++){
                       PersonBO pb=SysCacheTool.findPersonById(pelist[i]);
                       if (i==0) UnitID=pb.getOrgId();
                       if (Namelist.equals("")){
                         Namelist=pb.getName();
                      }
                      else{
                         Namelist=Namelist+","+ pb.getName();
                      }
                   }
                   Namelist="&nbsp;&nbsp;&nbsp;&nbsp;"+ Namelist;
                   out.println(Namelist);
               %>
               </td>
            </tr>
            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2203","�������") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:selectOneMenu id="auditResult" value="#{emp_personListBB.auditResult}" onchange="changeInfo();">
                         <c:selectItem itemLabel="����ͨ��" itemValue="00901"></c:selectItem>
                         <c:selectItem itemLabel="������ͨ��" itemValue="00900"></c:selectItem>
                     </h:selectOneMenu>
                     <h:commandButton value="ɾ�������Ƿ�����" styleClass="button01" onclick="return confirm('ȷ��Ҫɾ����������?');" action="#{emp_personListBB.deleteInvalid}"></h:commandButton>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2023","�������") %></td>
                <td class=td_form02 >
</c:verbatim>
                    <h:inputTextarea value="#{emp_personListBB.auditOpition}" rows="5" cols="60"></h:inputTextarea>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2377","�Զ�֪ͨ")%></td>
                <td class=td_form02 >
 </c:verbatim>
                    <h:selectBooleanCheckbox value="#{emp_personListBB.autoMessage}"></h:selectBooleanCheckbox>
                    <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2378","�Զ�����")%>
                    </f:verbatim>
                     <br>
                    <h:inputTextarea id="auditMessage" value="#{emp_personListBB.auditMessage}" rows="5" cols="60"></h:inputTextarea>
<c:verbatim>
                </td>
            </tr>

        </table>
        <br>
        <table  border=0 align=center cellpadding=0 cellspacing=0 width='100%'>
            <tr>
                <td align="center">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="return forsubmit(document.forms(0))" action="#{emp_personListBB.saveAudit}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>        
    </h:form>
