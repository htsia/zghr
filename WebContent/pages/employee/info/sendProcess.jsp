<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <x:saveState value="#{emp_PersonDismissBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{emp_PersonDismissBB.pageInit}"/>
        <%
            String ids = (String)request.getAttribute("perIds");
        %>
        <c:verbatim>
        <input type="hidden" name="pids" value="<%=ids%>">
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td colspan=4>
              <strong>
              以下人员要办理调往其他单位: 
             </strong><br>
               <%
                   if (ids!=null){
                       String Namelist="";
                       String []pelist=ids.split(",");
                       for(int i=0;i<pelist.length;i++){
                          PersonBO pb=SysCacheTool.findPersonById(pelist[i]);
                          if (Namelist.equals("")){
                             Namelist=pb.getName();
                          }
                          else{
                             Namelist=Namelist+","+ pb.getName();
                          }
                       }
                       Namelist="&nbsp;&nbsp;&nbsp;&nbsp;"+ Namelist;
                       out.println(Namelist);
                   }
               %>
               </td>
            </tr>
            <tr><td colspan=4 height=10></td></tr>
            <tr nowrap>
                <td width="90" class=td_form01>   <%=LanguageSupport.getResource("RYGL-2373","减员类别") %></td>
                <td class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                                 value="#{emp_PersonDismissBB.personchangevo.changeType}" alt="减员类别|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A016010','0200300010')">
                </td>

                <td width="90" class=td_form01> <%=LanguageSupport.getResource("RYGL-2374","减员日期") %></td>
                <td class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="A016020" value="#{emp_PersonDismissBB.personchangevo.changeDate}"
                                 alt="减员日期|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:A016020')">
                </td>
            </tr>

            <tr nowrap>
                   <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2210","调往机构") %></td>
                   <td class=td_form02 colspan="3">
 </c:verbatim>
                       <h:inputText styleClass="input" id="toOrg" value="#{emp_PersonDismissBB.changevo.toOrgId}" dict="yes" dict_num="OU"  code=""
                               readonly="true"    alt="调往机构|0|s|50||"/>
<c:verbatim>
                       <input type="button" class="button_select" onclick="PopUpOrgOnlyDlg('form1:toOrg',0,'')">
                   </td>
               </tr>
        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_PersonDismissBB.saveSend}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
 </h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
</script>

