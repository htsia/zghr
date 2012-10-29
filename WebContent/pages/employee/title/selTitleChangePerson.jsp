<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>

<script type="text/javascript">
	function checkData(){
		var personIds=document.all("form1:personIds").value;
		if(personIds==null || personIds==''){
			alert("请选择人员");
			return false;
		}
		var zhicheng=document.all("form1:zhicheng").value;
		if(zhicheng==null || zhicheng==''){
			alert("请选择职务名称");
			return false;
		}
		return true;
	}
</script>
    <x:saveState value="#{empTitleChangeBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empTitleChangeBB.initEdit}"/>
        <h:inputHidden id="postId" value=""></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01>人员姓名</td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea  value="#{empTitleChangeBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden id="personIds" value="#{empTitleChangeBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{empTitleChangeBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>职务名称</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="zhicheng" value="#{empTitleChangeBB.changeBo.zhicheng}" dict="yes" dict_num="0355"  code=""
                            readonly="true" alt="职务名称|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:zhicheng')">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>聘任时间</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="pinrenDate" value="#{empTitleChangeBB.changeBo.pinrenDate}"
                     readonly="true" alt="日期|1|d|50||"/>
<c:verbatim>
				    <img onclick="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true,el:'form1:pinrenDate'})" src="../../images/search.gif" class="button_select" width="16" height="22" align="absmiddle">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>聘任文件号</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText value="#{empTitleChangeBB.changeBo.pinrenNum}" styleClass="input"/>
<c:verbatim>
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>是否最高</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="isMost" value="#{empTitleChangeBB.changeBo.isMost}" dict="yes" dict_num="0090"  code=""
                            readonly="true" alt="是否最高|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:isMost')">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>是否聘任</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="isPinren" value="#{empTitleChangeBB.changeBo.isPinren}" dict="yes" dict_num="0090"  code=""
                            readonly="true" alt="是否聘任|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:isPinren')">
                </td>
            </tr>
            <tr nowrap>
                <td class=td_form01>备注</td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText value="#{empTitleChangeBB.changeBo.remark}" styleClass="input"/>
<c:verbatim>
                </td>
            </tr>
        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return checkData()" action="#{empTitleChangeBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>