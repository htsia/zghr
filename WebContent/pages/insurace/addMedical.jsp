<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <x:saveState value="#{ins_medicalPayOffBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{ins_medicalPayOffBB.initEdit}"/>
       <c:verbatim>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95% >
            <tr>
                <td width="90" class=td_form01>年龄低限</td>
                <td  class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input"  value="#{ins_medicalPayOffBB.medicalbo.agelow}" />
<c:verbatim>
                </td>
           </tr>

            <tr>
                 <td width="90" class=td_form01>年龄高限</td>
                 <td  class=td_form02>
</c:verbatim>
                        <h:inputText styleClass="input"    value="#{ins_medicalPayOffBB.medicalbo.agehigh}" />
<c:verbatim>
                </td>
            </tr>

            <tr>
                 <td width="90" class=td_form01>单位缴费进入个人账号(%)</td>
                 <td  class=td_form02>
</c:verbatim>
                        <h:inputText styleClass="input"    value="#{ins_medicalPayOffBB.medicalbo.unitRate}" />
<c:verbatim>
                </td>
            </tr>

            <tr>
                 <td width="90" class=td_form01>个人缴费(%)</td>
                 <td  class=td_form02>
</c:verbatim>
                       <h:inputText styleClass="input"    value="#{ins_medicalPayOffBB.medicalbo.personRate}" />
<c:verbatim>
                </td>
            </tr>


            <tr>
                <td colspan=2 align="right">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{ins_medicalPayOffBB.saveMedical}" />
<c:verbatim>
                </td>
            </tr>
        </table>
 </c:verbatim>
    </h:form>
