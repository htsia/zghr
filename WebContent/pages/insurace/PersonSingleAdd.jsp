<%@page import="com.hr319wg.util.CommonFuns"%>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function selectAll() {
            for(var i=0;i<document.all('form1:baseinfo').length;i++){
			   var item = document.all('form1:baseinfo')[i];
			   if(item.value!="A754020" && item.value!="A754202" && item.value!="A754040" && item.value!="A754200"){
					item.checked=true;
			   }
            }
            return false;
         }
         function deSelectAll() {
             for(var i=0;i<document.all('form1:baseinfo').length;i++){
				 var item = document.all('form1:baseinfo')[i];
				 if(item.value!="A754020" && item.value!="A754202" && item.value!="A754040" && item.value!="A754200"){
					item.checked=false;
			   }
             }
            return false;
         }
         function selectDept(){
             PopUpOrgDlgShowGroup('form1:A754002',null,null, '1');
             return false;
         }
         document.getElementById("form1:B731701").value="<%=CommonFuns.getSysDate("yyyy-MM-dd")%>";
    </script>

    <x:saveState value="#{ins_PersonInfoBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{ins_PersonInfoBB.initSingleEdit}"/>
        <%
            String ids = (String)request.getParameter("perIds");
        %>
        <c:verbatim>
        <br>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95% class="table02">
            <tr><td colspan=4> <strong>以下人员要办理新参保业务:</strong><br>
</c:verbatim>
                     <h:outputLabel value="#{ins_PersonInfoBB.namelist}"></h:outputLabel>
<c:verbatim>
               </td>
            </tr>
            <tr><td colspan=4 height=10></td></tr>

            <tr nowrap>
                <td width="90" class=td_form01>缴费地</td>
                <td  class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="A754002" code="" dict="yes" dict_num="OU"
                            readonly="true" value="#{ins_PersonInfoBB.caclpersonType}" alt="缴费地|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_org" onclick="return selectDept();">
                </td>
                <td width="90" class=td_form01>增加日期</td>
                <td  class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="B731701" value="#{ins_PersonInfoBB.changeDate}"
                                 alt="增加日期|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:B731701')">
                </td>
            </tr>

            <tr>
                <td width="90" class=td_form01>是否自付</td>
                <td  class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="selfPay" code="" dict="yes" dict_num="0090" value="#{ins_PersonInfoBB.selfPay}" alt="是否自付|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:selfPay','')" >
                </td>
            </tr>
            <tr>
                <td width="90" class="td_form01">
                    参加保险情况<br><br>
 </c:verbatim>
                    <h:commandButton type="button" styleClass="button01" value="全部参保" onclick="selectAll()"></h:commandButton><c:verbatim><br><br></c:verbatim>
                    <h:commandButton type="button" styleClass="button01" value="全不参保" onclick="deSelectAll()"></h:commandButton><c:verbatim><br></c:verbatim>
<c:verbatim>
                </td>
                <td class="td_form02" colspan="3">
 </c:verbatim>
                    <h:selectManyCheckbox id="baseinfo" value="#{ins_PersonInfoBB.inputList}" layout="pageDirection">
                        <c:selectItems value="#{ins_PersonInfoBB.levelList}"></c:selectItems>
                    </h:selectManyCheckbox>
<c:verbatim>
                </td>
            </tr>

            <tr><td colspan=4 height=20></td></tr>
            <tr>
                <td colspan=4 align="right">
 </c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{ins_PersonInfoBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
/*
	for(var i=0;i<document.all('form1:baseinfo').length;i++){
	   var item = document.all('form1:baseinfo')[i];
	   if(item.value=="A754020" || item.value=="A754202" || item.value=="A754040" || item.value=="A754200"){
			item.parentNode.style.display="none";
	   }
	}
	*/
</script>