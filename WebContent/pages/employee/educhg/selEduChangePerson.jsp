<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<script type="text/javascript">
	function checkData(){
		var personIds=document.all("form1:personIds").value;
		if(personIds==null || personIds==''){
			alert("请选择人员");
			return false;
		}
		var newEdu=document.all("form1:newEdu").value;
		if(newEdu==null || newEdu==''){
			alert("请选择学历");
			return false;
		}
		return true;
	}
</script>
    <x:saveState value="#{empEduChangeMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empEduChangeMgrBB.initEdit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01>  <%=LanguageSupport.getResource("RYGL-2049", " 人员姓名 ")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea  value="#{empEduChangeMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden id="personIds" value="#{empEduChangeMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{empEduChangeMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>学历</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="newEdu" value="#{empEduChangeMgrBB.changeBo.newEdu}" dict="yes" dict_num="0365"  code=""
                            readonly="true"    alt="学历|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:newEdu')">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>学位</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="xuewei" value="#{empEduChangeMgrBB.changeBo.xuewei}" dict="yes" dict_num="0380"  code=""
                            readonly="true"    alt="学位|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:xuewei')">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>专业名称</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText value="#{empEduChangeMgrBB.changeBo.zhuanyeName}" styleClass="input"/>
<c:verbatim>
                </td>
            </tr>
			<tr nowrap>
                <td class=td_form01>入学时间</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="ruexueDate" value="#{empEduChangeMgrBB.changeBo.ruxueDate}"
                     readonly="true" alt="日期|1|d|50||"/>
<c:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,el:'form1:ruexueDate'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>学习形式</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="learnType" value="#{empEduChangeMgrBB.changeBo.learnType}" dict="yes" dict_num="0375"  code=""
                            readonly="true"    alt="学习形式|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:learnType')">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>学制</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText value="#{empEduChangeMgrBB.changeBo.xuezhi}" styleClass="input"/>
<c:verbatim>
                </td>
            </tr>
			<tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2234", " 毕业时间 ")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="eduDate" value="#{empEduChangeMgrBB.changeBo.eduDate}"
                     readonly="true" alt="日期|1|d|50||"/>
<c:verbatim>
                   <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,el:'form1:eduDate'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </td>
            </tr>
			<tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2233", " 毕业学校 ")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText value="#{empEduChangeMgrBB.changeBo.eduUni}" styleClass="input"/>
<c:verbatim>
                </td>
            </tr>
			
        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return checkData()" action="#{empEduChangeMgrBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>