<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String flag = (String) request.getAttribute("flag");
%>

    <script type="text/javascript">
        function SelectUniteOrg(){
            PopUpOrgDlgShowGroup('form1:uniteOrgId',2,'');
            document.all('form1:B705720').value =document.all('form1:uniteOrgId').value+"并入本机构";
            return false;
        }
        function forSelect(form1, rootId) {
            if (rootId == null) {
                rootId = "";
            }
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;
            if (checkAll(form1)) {
                retval = window.showModalDialog("/pages/employee/SelBackTreePerson.jsf?rootId=" + rootId+"&rightFlag=2", "", "dialogWidth:800px; dialogHeight:700px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
                pageCodeExchange(form1);
                document.all("form1:selPerson").click();
                return true;
            }
            return false;
        }
        function forPer() {
            if (document.all("per").style.display == "none") {
                document.all("per").style.display = "";
                document.forms(0).bper.value = "隐藏选择人员";
            } else {
                document.all("per").style.display = "none";
                document.forms(0).bper.value = "查看选择人员";
            }
        }
    </script>

<h:form id="form1">
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
    <tr>
        <td class="td_title"><img src="/images/tips.gif" alt="">
          <%=LanguageSupport.getResource("JGGL-0100","机构管理")+"->"%>
          <%=LanguageSupport.getResource("JGGL-0105","机构合并")%>
        </td>
    </tr>
</table>
<br>
</f:verbatim>
<h:commandButton id="selPerson" action="#{org_orgUniteBB.selPerson}" style="display:none"/>

<f:verbatim>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0" class="table03">
    <tr>
        <td width="90" class="td_form01 td_form_required">
         <%=LanguageSupport.getResource("JGGL-1011","被合并机构")%>  
        </td>
        <td class="td_form02">
</f:verbatim>
            <h:inputText styleClass="input" id="uniteOrgId" code="" dict="yes" dict_num="OU" readonly="true"
                         value="#{org_orgUniteBB.uniteOrgId}"
                         alt="被合并机构|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="SelectUniteOrg();">
        </td>
        <td width="90" class="td_form01 td_form_required">
         <%=LanguageSupport.getResource("JGGL-1012","合并机构")%> 
         
        </td>
        <td class="td_form02">　
</f:verbatim>
            <h:inputText styleClass="input" id="orgId" code="" dict="yes" dict_num="OU" readonly="true"
                         value="#{org_orgUniteBB.orgId}"
                         alt="合并机构|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpOrgDlgShowGroup('form1:orgId',2,'')">
        </td>
    </tr>
</table>
<br>
<table width="95%" align=center border=0 cellpadding=0 cellspacing=0>
    <tr nowrap>
        <td class="f04">
         <%=LanguageSupport.getResource("JGGL-1013","机构合并信息")%>
        </td>
    </tr>
</table>
<table width="95%" align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr nowrap>
        <td width="90" class="td_form01 td_form_required">
        <%=LanguageSupport.getResource("JGGL-1014","变动类别")%>
         </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B705701" dict="yes" code="" dict_num="0890" readonly="true"
                         value="#{org_orgUniteBB.orgchangevo.changeType}"
                         alt="变动类别|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B705701')"></td>
        <td class="td_form01 td_form_required">
         <%=LanguageSupport.getResource("JGGL-1015","变动时间")%> 
         </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B705725" value="#{org_orgUniteBB.orgchangevo.changeTime}"
                         readonly="true"
                         alt="变动时间|0|s|50||"/>

<f:verbatim>
            <input type="button" class="button_select"     onclick="PopUpCalendarDlg_OnlyMonth('form1:B705725')"></td>
    </tr>
    <tr nowrap>
        <td class="td_form01 td_form_required">
         <%=LanguageSupport.getResource("JGGL-1016","变动事项及原因")%>
         </td>
        <td class="td_form02" colspan="3">
</f:verbatim>
            <h:inputText styleClass="input" size="80" id="B705720" value="#{org_orgUniteBB.orgchangevo.changeResult}"
                         alt="变动原因|0|s|60||"/>
<f:verbatim>
        </td>
    </tr>
    <tr nowrap>
        <td class=td_form01>
        <%=LanguageSupport.getResource("JGGL-1017","批准文号")%>
         </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B705730" value="#{org_orgUniteBB.orgchangevo.changeNo}"
                         alt="批准文号|1|s|50||"/>
<f:verbatim>
        </td>
        <td class=td_form01>
         <%=LanguageSupport.getResource("JGGL-1018","批准单位")%> 
                
         </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B705733" value="#{org_orgUniteBB.orgchangevo.agreeUnit}"
                         alt="批准单位|1|s|50||"/></td>
<f:verbatim>
    </tr>
</table>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
        <td align="right">
            <input name="mod1" type="button" class="button01" value="<%=LanguageSupport.getResource("JGGL-1019","选择联动简历人员")%>"
                   onclick="forSelect(form1,document.all('form1:uniteOrgId').code)" style="display:none">
            <input name="bper" type="button" class="button01" value="<%=LanguageSupport.getResource("JGGL-1020","查看选择人员")%>"
                   onclick="forPer(form1)" style="display:none">
</f:verbatim>
            <h:commandButton value=" 保存 " styleClass="button01" onclick="return forsubmit(document.forms(0))"
                             action="#{org_orgUniteBB.saveUnite}"/>
<f:verbatim>
        </td>
    </tr>
</table>
<br>
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" id="per" <%if ("show".equals(flag)) {%>
       style="display:block" <%} else {%> style="display:none"<%}%>>
    <tr>
        <td align="center">
</f:verbatim>
            <h:dataTable width="100%" value="#{org_orgUniteBB.personlist}" var="list"
                         border="0"
                         align="center" headerClass="td_top" rowClasses="td_middle"
                         styleClass="table03">
                <h:column>
                    <c:facet name="header"><c:verbatim escape="false">
                        <input type="checkbox"
                                name="chkAll"
                                onclick="selectAll(document.form1.chkAll,document.form1.chk)"/>
                    </c:verbatim></c:facet>
                    <c:verbatim escape="false"><div align=center><input type="checkbox"
                        name="chk" value="</c:verbatim>
                    <h:outputText value="#{list.personId}"/><c:verbatim>"></div></c:verbatim>
                    <c:verbatim escape="false"><input
                        type="hidden" name="perName"
                        value="</c:verbatim><h:outputText value="#{list.name}"/><c:verbatim
                        escape="false">"></c:verbatim>
                </h:column>
                <h:column>
                    <c:facet name="header">
                         <f:verbatim>
                             <%=LanguageSupport.getResource("MSG-0010","姓名")%>
                         </f:verbatim>
                     </c:facet>
                    <h:outputText value="#{list.name}"/>
                </h:column>
                <h:column>
                    <c:facet name="header">
                         <f:verbatim>
                             <%=LanguageSupport.getResource("MSG-0012","性别")%>
                         </f:verbatim>
                         </c:facet>
                    <h:outputText value="#{list.sex}"/>
                </h:column>
                <h:column>
                    <c:facet name="header"> 
                          <f:verbatim>
                             <%=LanguageSupport.getResource("MSG-0013","出生日期")%>
                         </f:verbatim> 
                         </c:facet>
                    <h:outputText value="#{list.birth}"/>
                </h:column>
                <h:column>
                    <c:facet name="header">
                      <f:verbatim>
                             <%=LanguageSupport.getResource("JGGL-1024","所属机构")%> 
                         </f:verbatim> 
                    </c:facet>
                    <h:outputText value="#{list.orgId}"/>
                </h:column>
                <h:column>
                    <c:facet name="header">
                    <f:verbatim>
                             <%=LanguageSupport.getResource("JGGL-1025","所属部门")%> 
                         </f:verbatim> 
                   </c:facet>
                    <h:outputText value="#{list.deptId}"/>
                </h:column>
            </h:dataTable>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
