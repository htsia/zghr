<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<script type="text/javascript">
	function checkData(){
        if(document.all("form1:A705705").value==""){
			alert("新职务不能为空");
			return false;
		}else{
			return forsubmit(document.forms(0))
		}
	}
</script>
    <x:saveState value="#{empApporDisMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empApporDisMgrBB.initEdit}"/>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01>
          	  <%=LanguageSupport.getResource( "RYGL-2049", " 人员姓名")%>
             </td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{empApporDisMgrBB.personNames}" rows="3" cols="30"></h:inputTextarea>
			   <h:inputHidden value="#{empApporDisMgrBB.personIds}"></h:inputHidden>
               <h:commandButton styleClass="button01" value="选择" onclick="return fPopUpBackPerTreeDlg('');" action="#{empApporDisMgrBB.selPerson}" />
<c:verbatim>
               </td>
            </tr>

             <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource( "RYGL-2026", "新职务")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A705705" value="#{empApporDisMgrBB.empappointdissbo.newJob}" dict="yes" dict_num="#{empApporDisMgrBB.job}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
<c:verbatim>
                    <input type="button" id="btnA705705" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A705705')">
                    <script type="text/javascript">
                        <%
                            InfoItemBO A705705=SysCacheTool.findInfoItem("","A705705");
                            if (A705705!=null && InfoItemBO.DATA_TYPE_STRING.equals(A705705.getItemDataType())){
                               out.println("document.all('form1:A705705').readOnly=false;");
                               out.println("document.all('btnA705705').style.display='none';");
                            }
                        %>
                    </script>
                </td>
            </tr>
             <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource( "RYGL-2040", " 是否初任")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A705701" value="#{empApporDisMgrBB.empappointdissbo.firstApp}" dict="yes" dict_num="#{empApporDisMgrBB.firstAppField}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A705701')">
                </td>
            </tr>
             <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource( "RYGL-2039", " 任职方式")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A705732" value="#{empApporDisMgrBB.empappointdissbo.appMod}" dict="yes" dict_num="#{empApporDisMgrBB.appModeField}"  code=""
                            readonly="true"    alt="新职务|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A705732')">
                </td>
            </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="checkData()" action="#{empApporDisMgrBB.save}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>