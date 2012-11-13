<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%
     response.setHeader("progma", "no-cache");
     response.setHeader("Cache-Control", "no-cache");
     response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
     String superId = CommonFuns.filterNull(request.getParameter("superId"));
     String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
%>

    <script type="text/javascript">
        function doOK(){
           if (checkMutilSelect(document.form1.selected_ids)){
               var str="";
               if (document.form1.selected_ids.length == null) {
                   str=document.form1.selected_ids.value;
               } else {
                   for (var i = 0; i < document.form1.selected_ids.length; i++) {
                       if (document.form1.selected_ids[i].checked) {
                           if (str=="") {
                               str=document.form1.selected_ids[i].value;
                           }
                           else{
                               str+=","+document.form1.selected_ids[i].value;
                           }
                       }
                   }
               }
               window.returnValue = str;
               window.close();
           }
           else{
               alert("请选择人员!");
               return false;
           }
        }
        function doCancel(){
            window.returnValue = "";
            window.close();
        }
    </script>

<h:form id="form1" >
    <c:verbatim>
    <table width="98%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif" alt="">恢复工资发放</td>
            <td class="td_title" align="right">
</c:verbatim>
                <h:commandButton value="确定" onclick="doOK();" type="button" styleClass="button01"></h:commandButton>
                <h:commandButton value="取消" onclick="doCancel();" type="button" styleClass="button01"></h:commandButton>
<c:verbatim>
            </td>
        </tr>

        <tr>
        <td valign="top" colspan=2>
            <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td >
</c:verbatim>
                        <x:dataTable width="100%" value="#{wage_computeBB.personList}" var="list" border="1"
                                     align="center" rowIndexVar="index" headerClass="td_top" rowClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" styleClass="table03">
                            <h:column>
                                 <c:facet name="header">
                                     <c:verbatim escape="false">
                                     <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                                     </c:verbatim>
                                </c:facet>
                                 <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                                 <h:outputText value="#{list.personId}"/>
                                <c:verbatim>"></c:verbatim>
                             </h:column>
							<h:column>
								<f:facet name="header">
									<h:outputText value="序号" />
								</f:facet>
								<h:outputText value="#{index+1}"></h:outputText>
							</h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="员工编号"/></c:facet>
                                <h:outputText value="#{list.personCode}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                                <h:outputText value="#{list.name}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="薪资部门"/></c:facet>
                                <h:outputText value="#{list.deptSort}"/>
                            </h:column>
                        </x:dataTable>
<c:verbatim>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>
</c:verbatim>    
</h:form>