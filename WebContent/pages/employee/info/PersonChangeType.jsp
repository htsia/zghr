<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <x:saveState value="#{emp_typeChangeBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{emp_typeChangeBB.pageInit}"/>
        <%
            String ids = (String)request.getAttribute("perIds");
            String newtype=request.getParameter("newtype");
            String operId=request.getParameter("OperId");
        %>
<c:verbatim>
        <input type="hidden" name="pids" value="<%=ids%>">
        <input type="hidden" name="operId" value="<%=operId%>">
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td colspan=2>
             <strong>
             <%= LanguageSupport.getResource("RYGL-2367", "办理人员如下 ")%> 
             :</strong><br>
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
            <tr><td colspan=2 height=10></td></tr>

            <tr nowrap>
                <td width="120" class=td_form01> <%= LanguageSupport.getResource("RYGL-2368", "变更后人员类别")%> </td>
                <td class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                                 value="#{emp_typeChangeBB.afterType}" alt="变更后人员类别|0|s|50||"/>

<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054','<%=newtype%>');" >
                </td>
            </tr>

    <tr>
        <td width="120" class=td_form01>
</c:verbatim>
            <h:outputText value="变更时间"></h:outputText>
<c:verbatim>
        </td>
        <td class=td_form02>
 </c:verbatim>
            <h:inputText styleClass="input" id="eventDate" readonly="true"
                         value="#{emp_typeChangeBB.eventDate}" alt="eventDate|0|s|50||" />

            <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCalendarDialog('form1:eventDate')" />
<c:verbatim>
        </td>
    </tr>

    <tr>
        <td width="120" class=td_form01>
</c:verbatim>
            <h:outputText value="操作时间"></h:outputText>
<c:verbatim>
        </td>
        <td class=td_form02>
 </c:verbatim>
            <h:inputText styleClass="input" id="operateDate" readonly="true"
                         value="#{emp_typeChangeBB.operateDate}" alt="processDate|0|s|50||" />

            <h:commandButton type="button" styleClass="button_select"  onclick="PopUpCalendarDialog('form1:operateDate')" />
<c:verbatim>
        </td>
    </tr>

            <tr>
                <td width="120" class=td_form01>
</c:verbatim>
                    <h:outputText value="#{emp_typeChangeBB.afterStatusTitle}" rendered="#{emp_typeChangeBB.a001725Used}"></h:outputText>
<c:verbatim>
                </td>
                <td class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="A001725" code="" dict="yes" dict_num="0145"
                                 value="#{emp_typeChangeBB.afterStatus}" alt="A001725|0|s|50||" rendered="#{emp_typeChangeBB.a001725Used}"/>

                    <h:commandButton type="button" styleClass="button_select" rendered="#{emp_typeChangeBB.a001725Used}" onclick="PopUpCodeDlgOneControl('form1:A001725','')" />
<c:verbatim>
                </td>
            </tr>
        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 >
            <tr>
                <td align="right">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_typeChangeBB.saveRetire}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
