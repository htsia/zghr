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
                alert("必须录入拟分配单位");
                return false;
            }
            return forsubmit(document.forms(0));
        }
    </script>

<x:saveState value="#{emp_CadresImportBB}"/>
<h:form id="form1">
    <h:inputHidden id="addCadres" value="#{emp_CadresImportBB.processCadres}"/>
<c:verbatim>
    <table class="td_title" width="100%">
       <tr >
           <td>
</c:verbatim>
             <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-0362", "干部引进")%>
			</f:verbatim>
<c:verbatim>
           </td>
           <td align="right">
</c:verbatim>
               <h:commandButton value="保存" action="#{emp_CadresImportBB.saveProcessCadres}" onclick="return forSave();" styleClass="button01"></h:commandButton>
               <h:commandButton type="button" styleClass="button01" onclick="window.close()" value="返回"></h:commandButton>
<c:verbatim>
           </td>
        </tr>
    </table>
    <br>
</c:verbatim>
    <h:panelGrid columns="2"  align="center" width="90%" columnClasses="td_form01,td_form02" styleClass="table03">
        <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2144", "商调函编号")%>
		 </f:verbatim>
        <h:inputText readonly="true" id="no" value="#{emp_CadresImportBB.cadbo.applyLetterID}"/>

           <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2049", "人员姓名")%>
			</f:verbatim>
        <h:inputText readonly="true" id="name" value="#{emp_CadresImportBB.cadbo.name}"/>

        <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2145", "人员性别")%>
			</f:verbatim>
        <h:panelGroup>
            <h:inputText readonly="true" styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                         value="#{emp_CadresImportBB.cadbo.sex}"
                         alt="性别|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')"/>
        </h:panelGroup>

           <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2146", "原单位")%>
			</f:verbatim>
        <h:inputText id="oldOrg" readonly="true" value="#{emp_CadresImportBB.cadbo.oldOrg}"/>

        <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2153", "最晚报到时间")%>
			</f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="workonDate" value="#{emp_CadresImportBB.cadbo.workonDate}"
                         readonly="true" alt="最晚报到时间|1|d|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:workonDate')" />
        </h:panelGroup>

        <f:verbatim>
				<%=LanguageSupport.getResource("RYGL-2152", "拟分配单位")%>
			</f:verbatim>
        <h:panelGroup>
           <h:inputText styleClass="input" id="toOrg" value="#{emp_CadresImportBB.cadbo.orgID}" dict="yes" dict_num="OU"  code=""
                readonly="true"    alt="调往机构<|1|s|50||"/>
           <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgOnlyDlg('form1:toOrg',0,'')" />
        </h:panelGroup>

    </h:panelGrid>
</h:form>
    <script type="text/javascript">
       interpret(form1);
    </script>
