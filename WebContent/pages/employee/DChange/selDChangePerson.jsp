<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
	function checkData(){
		if(document.all("form1:A001054").value==""||document.all("form1:A001054").value==null){
			alert("ת������Ա�����Ϊ�գ�");
			return false;
		}else if(document.all("form1:A001715").value==""||document.all("form1:A001715").value==null){
			alert("ת�����λ����Ϊ�գ�");
			return false;
		}else if(document.all("form1:A001011").value==""||document.all("form1:A001011").value==null){
			alert("��¼��Ԥ��ת��ʱ��");
			return false;
		}else{
			return forsubmit(document.forms(0))
		}
	}
</script>
    <x:saveState value="#{empDchangeMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empDchangeMgrBB.initEdit}"/>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01>
            <%=LanguageSupport.getResource("RYGL-2049", " ��Ա���� ")%>
             </td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{empDchangeMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden value="#{empDchangeMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="ѡ��" onclick="return fPopUpBackPerTreeDlg('');" action="#{empDchangeMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>
            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2220", " ת������Ա��� ")%></td>
                <td class=td_form02>
</c:verbatim>
                     <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empDchangeMgrBB.empPerTypechangbo.passType}"
                     alt="Ա�����|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
                </td>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2222", "ת�����λ")%></td>
                <td class=td_form02 >
</c:verbatim>
                  <h:inputText styleClass="input" id="A001715" code="" dict="yes" dict_num="PO"
                     readonly="true" value="#{empDchangeMgrBB.empPerTypechangbo.passPost}"
                     alt="��λ|1|s|50||"/>
<c:verbatim>
                   <input type="button" class="button_select" onclick="fPopUpPostDlg('form1:A001715')"></td>
                </td>
            </tr>
             <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource("RYGL-2126", "ת�����λ����")%></td>
                <td class=td_form02 >
</c:verbatim>
                    <h:inputText styleClass="input" id="A001712" value="#{empDchangeMgrBB.empPerTypechangbo.passPostType}" dict="yes" dict_num="#{empDchangeMgrBB.job}"  code=""
                            readonly="true"    alt="��ְ��|1|s|50||"/>
<c:verbatim>
                   <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001712')">
                </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2129", "Ԥ��ת��ʱ��")%></td>
                <td class=td_form02 >
</c:verbatim>
                    <h:inputText styleClass="input" id="A001011" value="#{empDchangeMgrBB.empPerTypechangbo.planPassDate}"
                     readonly="true" alt="Ԥ��ת������|1|d|50||"/>
<c:verbatim>
                   <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
                </td>
            </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="����" onclick="checkData()" action="#{empDchangeMgrBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>