<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
	function checkData(){
		if(document.all("form1:A001054").value==""||document.all("form1:A001054").value==null){
			alert("转正后人员类别不能为空！");
			return false;
		}else{
			return forsubmit(document.forms(0))
		}
	}
</script>
    <x:saveState value="#{empTraineeMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empTraineeMgrBB.initEdit}"/>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01>
             <%=LanguageSupport.getResource("RYGL-2049", "人员姓名")%>
            </td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{empTraineeMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden value="#{empTraineeMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{empTraineeMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>
            
             <tr nowrap>
               
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2129", "预计转正时间")%></td>
                <td class=td_form02 >
</c:verbatim>
                    <h:inputText styleClass="input" id="A001011" value="#{empTraineeMgrBB.changebo.planPassDate}"
                     readonly="true" alt="预计转正日期|1|d|50||"/>
<c:verbatim>
                   <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
                </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2220", "转正后人员类别")%></td>
                <td class=td_form02>
</c:verbatim>
                     <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{empTraineeMgrBB.changebo.passType}"
                     alt="员工类别|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
                </td>
            </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="checkData()" action="#{empTraineeMgrBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>