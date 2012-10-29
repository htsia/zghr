<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
	function checkData(){
		if(document.all("form1:A001716").value==""){
			alert("新岗位级别不能为空！");
			return false;
		}else{
			return forsubmit(document.forms(0))
		}
	}
    function selPost(){
        fPopUpPostDlg(document.all("form1:A001715"),null,null);
    }

</script>
    <x:saveState value="#{empbeginnerMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empbeginnerMgrBB.initAddEdit}"/>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr>
             <td class=td_form01>
                <%=LanguageSupport.getResource("RYGL-2049", "人员姓名")%>
             </td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{empbeginnerMgrBB.personNames}" rows="3" cols="50"></h:inputTextarea>
			   <h:inputHidden value="#{empbeginnerMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{empbeginnerMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>

    <tr nowrap>
       <td class=td_form01>转正后岗位名称</td>
       <td class=td_form02 colspan="3">
   </c:verbatim>
           <h:inputText styleClass="input" id="A001715" value="#{empbeginnerMgrBB.empbeginnerbo.passPost}" dict="yes" dict_num="PO"  code=""
                   readonly="true"    alt="转正后岗位|1|s|50||"/>
   <c:verbatim>
           <input type="button" class="button_post" onclick="selPost();">
       </td>
   </tr>

             <tr nowrap>
                <td class=td_form01>  <%=LanguageSupport.getResource("RYGL-2126", "转正后岗位级别")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A001716" value="#{empbeginnerMgrBB.empbeginnerbo.passPostLevel}" dict="yes" dict_num="2238"  code=""
                            readonly="true"    alt="转正后岗位级别|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001716')">
                </td>
            </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 >
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="checkData()" action="#{empbeginnerMgrBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>