<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<h:form id="form1">
    <h:inputHidden value="#{sys_parameterBB.pageInit}"/>
    <%
        Map hash = (Map) request.getAttribute("PARA_MAP");
    %>

    <c:verbatim>
    <table width="98%" height=98% border="0" align="center" cellspacing="0" cellpadding="0">
        <tr>
		    <td class="td_title" height=8><img src="/images/tips.gif">
		     <%=LanguageSupport.getResource("COMM-1047", " 参数设置")%>
		    </td>
        </tr>

        <tr><td align="right" height=40 valign="middle">
   </c:verbatim>
            <h:commandButton action="#{sys_parameterBB.saveParameter}" value="保存" onclick="javascript:return confirm('是否要保存')" styleClass="button01"/>
   <c:verbatim>
        </td></tr>

    <tr><td>
     <div style='width:100%;height:100%;overflow:auto' id=datatable>
        <table border="1" width="95%" align="center" class="table03">
            <tr>
                <td class="td_top"><%=LanguageSupport.getResource("XTGL-1099", "序号")%></td>
                <td class="td_top"><%=LanguageSupport.getResource("XTGL-1247", "常量名")%></td>
                <td class="td_top" width="75%"><%=LanguageSupport.getResource("XTGL-1248", "值")%></td>
            </tr>
</c:verbatim>
            <%
                int pos = 0;
                Field[] fields = Constants.class.getFields();
                for (int i = 0; i < fields.length; i++) {
                    if (9 == fields[i].getModifiers()) {
                        String key = fields[i].getName();
            %>
    <c:verbatim>
            <tr>
                <td class="td_middle"><%=++pos%></td>
                <td class="td_middle"><%=fields[i].getName()%></td>
                <td class="td_middle"><input type="text" name="<%=key%>" value="<%=CommonFuns.filterQuotation(CommonFuns.filterNull((String) hash.get(key)))%>" class="input"
                                             style="width:100%;"></td>
            </tr>
</c:verbatim>
            <%
                    }
                }
            %>
<c:verbatim>
        </table>
     </div>
    </td></tr>   
   </table>
   </c:verbatim>
</h:form>
