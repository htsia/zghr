<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

    <x:saveState value="#{emp_PersonChgBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_PersonChgBB.pageInit}"/>
        <%
            String ids = (String)request.getAttribute("perIds");
        %>
<f:verbatim>
        <input type="hidden" name="pids" value="<%=ids%>">
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td colspan=4> <strong>
                                    
                <%=LanguageSupport.getResource("RYGL-2208", " 以下人员申请办理调往系统内其它单位")%>
                               
                               </strong><br>
               <%
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
               %>
               </td>
            </tr>
            <tr><td height=8 colspan=4></td></tr>
            <tr nowrap>
                <td width="90" class=td_form01>
                  <%=LanguageSupport.getResource("RYGL-2209", "  调动原因")%>
               </td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="reason" code="" dict="yes" dict_num="0210"
                                 value="#{emp_PersonChgBB.personchangevo.chgReason}" alt="调动原因|0|s|50||"/>
<f:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:reason','')">
                </td>
                <td width="90" class=td_form01> <%=LanguageSupport.getResource("RYGL-2163", " 申请日期")%></td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="date" value="#{emp_PersonChgBB.personchangevo.applyDate}"
                                 alt="申请日期|0|s|50||"/>
<f:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:date')"></td>
            </tr>
             <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2210", " 调往机构")%></td>
                <td class=td_form02 colspan="3">
</f:verbatim>
                    <h:inputText styleClass="input" id="toOrg" value="#{emp_PersonChgBB.personchangevo.toOrgId}" dict="yes" dict_num="OU"  code=""
                            readonly="true"    alt="调往机构<|1|s|50||"/>
<f:verbatim>
                    <input type="button" class="button_select" onclick="PopUpOrgOnlyDlg('form1:toOrg',0,'')">
                </td>
            </tr>
        </table>
        <br>

        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</f:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_PersonChgBB.save}" /></td>
<f:verbatim>
            </tr>
        </table>
</f:verbatim>
    </h:form>
