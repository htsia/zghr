<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
    function beginClean(){
        if (confirm('ȷ����ʼ�������ݿ���')){
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
            <td align="center" width="16%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="/system/cleandata.jsf">�������</a></td>
            <td align="center" width="16%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="/system/IDCardConvert.jsf">���֤ת��</a></td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <br>
    </c:verbatim>

    <h:panelGrid width="90%" align="center">
        <h:panelGroup>
            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1027","�ù��ܽ��������ݣ�����������ݡ�����ʼ��ť��ʼִ�� ")%> 
            </f:verbatim>
            <h:commandButton value="��ʼ" action="#{sys_CleanBB.ClearData}" styleClass="button01" onclick="return beginClean();"></h:commandButton>
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
