<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
    function beginClean(){
        if (confirm('确定开始清理数据库吗？')){
            disPlayProcessBar();
            return true;
        }
        return false;
    }
</script>
<h:form>
    <c:verbatim>
    <table width="96%" align="center">
        <tr>
            <td align="center" width="16%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/system/cleandata.jsf">清除垃圾</a></td>
            <td align="center" width="16%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="/system/IDCardConvert.jsf">身份证转换</a></td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <br>
    </c:verbatim>

    <h:panelGrid width="90%" align="center">
        <h:panelGroup>
            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1027","该功能将整理数据，清除垃圾数据。按开始按钮开始执行 ")%> 
            </f:verbatim>
            <h:commandButton value="开始" action="#{sys_CleanBB.ClearData}" styleClass="button01" onclick="return beginClean();"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
