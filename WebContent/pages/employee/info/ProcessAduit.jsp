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
               document.all('form1:auditMessage').value="您报送的人员已审批通过！";
          }
          else if (document.all('form1:auditResult').value=='00900'){
               document.all('form1:auditMessage').value="您报送的人员未通过审批！";
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
                 <%=LanguageSupport.getResource("RYGL-2376","以下人员要办理审批业务") %>
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
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2203","审批结果") %></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:selectOneMenu id="auditResult" value="#{emp_personListBB.auditResult}" onchange="changeInfo();">
                         <c:selectItem itemLabel="审批通过" itemValue="00901"></c:selectItem>
                         <c:selectItem itemLabel="审批不通过" itemValue="00900"></c:selectItem>
                     </h:selectOneMenu>
                     <h:commandButton value="删除此条非法数据" styleClass="button01" onclick="return confirm('确定要删除该数据吗?');" action="#{emp_personListBB.deleteInvalid}"></h:commandButton>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2023","审批意见") %></td>
                <td class=td_form02 >
</c:verbatim>
                    <h:inputTextarea value="#{emp_personListBB.auditOpition}" rows="5" cols="60"></h:inputTextarea>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2377","自动通知")%></td>
                <td class=td_form02 >
 </c:verbatim>
                    <h:selectBooleanCheckbox value="#{emp_personListBB.autoMessage}"></h:selectBooleanCheckbox>
                    <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2378","自动发送")%>
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
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_personListBB.saveAudit}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>        
    </h:form>
