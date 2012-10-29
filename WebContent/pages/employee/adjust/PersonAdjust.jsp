<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

    <x:saveState value="#{emp_PersonDismissBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_PersonDismissBB.pageInit}"/>
        <c:verbatim>
        <%
            String ids = (String)request.getAttribute("perIds");
        %>
        <input type="hidden" name="pids" value="<%=ids%>">
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td colspan=4> <strong>
                   <%=LanguageSupport.getResource( "RYGL-2019", "以下人员要办理调换部门岗位业务")%>
            </strong><br>
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
                <td class=td_form01>
                   <%=LanguageSupport.getResource( "RYGL-2019", "调入部门")%>
               </td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A016030" value="#{emp_PersonDismissBB.chgs}" dict="yes" dict_num="OU"  code=""
                            readonly="true"    alt="调入部门|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A016030',2,'')">
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01>
                    <%=LanguageSupport.getResource( "RYGL-2020", "新岗位")%>
                </td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A001715" value="#{emp_PersonDismissBB.posts}" dict="yes" dict_num="PO"  code=""
                            readonly="true"    alt="新岗位|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="fPopUpPostDlg('form1:A001715')">
                </td>
            </tr>

        </table>
        <br>
        <table  border=0 align=center cellpadding=0 cellspacing=0 width='100%'>
            <tr>
                <td align="center">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_PersonDismissBB.saveAdjust}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
