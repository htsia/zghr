<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
</script>
    <x:saveState value="#{empApporDisMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{empApporDisMgrBB.initEdit2}"/>
        <h:inputHidden value="#{empApporDisMgrBB.pids}"/>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td class=td_form01>  <%=LanguageSupport.getResource( "RYGL-2049", " 人员姓名")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim> 
			   <h:inputTextarea value="#{empApporDisMgrBB.personNames}" rows="3" cols="30" readonly="true"></h:inputTextarea>
<c:verbatim>
               </td>
            </tr>

            <tr nowrap>
                <td class=td_form01> <%=LanguageSupport.getResource( "RYGL-2050", " 任职文号")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
               <h:inputText value="#{empApporDisMgrBB.appPageNum}"></h:inputText>  
<c:verbatim>
                </td>
            </tr>
             <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource( "RYGL-2051", "解聘或免职文号")%></td>
                <td class=td_form02 colspan="3">
</c:verbatim>
			 <h:inputText value="#{empApporDisMgrBB.deAppPageNum}"></h:inputText>  
<c:verbatim>
                </td>
            </tr>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存"  action="#{empApporDisMgrBB.shengxiao}" /></td>
<c:verbatim>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>