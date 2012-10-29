<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
	function checkData(){
		if(document.all("form1:A067705").value==""||document.all("form1:A067705").value==null){
			alert("拟定培养方向不能为空！");
			return false;
		}else{
			return forsubmit(document.forms(0))
		}
	}
	
</script>
    <x:saveState value="#{empResverPersonMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empResverPersonMgrBB.initEdit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01><%=LanguageSupport.getResource("RYGL-2049","人员姓名")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{empResverPersonMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden value="#{empResverPersonMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{empResverPersonMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>
             <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2258","培养方向")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A067705" value="#{empResverPersonMgrBB.forJob}" dict="yes" dict_num="0391"  code=""
                            readonly="true"    alt="培养方向|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A067705')">
                </td>
            </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="checkData()" action="#{empResverPersonMgrBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>