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
            <tr><td colspan=4> <strong>������ԱҪ�����²α�ҵ��:</strong><br>
</c:verbatim>
                     <h:outputLabel value="#{ins_PersonInfoBB.namelist}"></h:outputLabel>
<c:verbatim>
               </td>
            </tr>
            <tr><td colspan=4 height=10></td></tr>

            <tr nowrap>
                <td width="90" class=td_form01>�������</td>
                <td  class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="A754002" code="" dict="yes" dict_num="0202"
                                 value="#{ins_PersonInfoBB.caclpersonType}" alt="�������|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A754002','')" >
                </td>
                <td width="90" class=td_form01>�������</td>
                <td  class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="B731702" code="" dict="yes" dict_num="0200"
                                 value="#{ins_PersonInfoBB.changeType}" alt="�������|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B731702','02010001')" >
                </td>
            </tr>
      
            <tr>
                <td width="90" class=td_form01>��������</td>
                <td  class=td_form02>
 </c:verbatim>
                    <h:inputText styleClass="input" id="B731701" value="#{ins_PersonInfoBB.changeDate}"
                                 alt="��������|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:B731701')">
                </td>
                 <td width="90" class=td_form01>������λ</td>
                 <td  class=td_form02>
 </c:verbatim>
                        <h:inputText styleClass="input" id="B731703" value="#{ins_PersonInfoBB.depName}" alt="������λ|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="90" class=td_form01>������Ա���</td>
                <td  class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="A754003" code="" dict="yes" dict_num="0203" value="#{ins_PersonInfoBB.personType}" alt="������Ա���|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A754003','')" >
                </td>                
                <td width="90" class=td_form01>�䶯ԭ��</td>
                <td  class=td_form02>
 </c:verbatim>
                	<h:inputText styleClass="input" id="B731209" value="#{ins_PersonInfoBB.changeReason}" alt="�䶯ԭ��|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td width="90" class="td_form01">
                    �μӱ������<c:verbatim><br><br></c:verbatim>
 </c:verbatim>
                    <h:commandButton type="button" styleClass="button01" value="ȫ���α�" onclick="selectAll()"></h:commandButton><c:verbatim><br><br></c:verbatim>
                    <h:commandButton type="button" styleClass="button01" value="ȫ���α�" onclick="deSelectAll()"></h:commandButton><c:verbatim><br></c:verbatim>
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
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="return forsubmit(document.forms(0))" action="#{ins_PersonInfoBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
	for(var i=0;i<document.all('form1:baseinfo').length;i++){
	   var item = document.all('form1:baseinfo')[i];
	   if(item.value=="A754020" || item.value=="A754202" || item.value=="A754040" || item.value=="A754200"){
			item.parentNode.style.display="none";
	   }
	}
</script>