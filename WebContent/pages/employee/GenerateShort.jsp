<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
    function doCalc(){
        disPlayProcessBar();
        return forsubmit(document.forms(0));
    }
</script>
<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0300","人员管理 ")%> ->
              <%=LanguageSupport.getResource("RYGL-0325"," 生成姓名简拼、全拼")%>
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
     <f:verbatim>
    <br>
    <table class="table03" border="1" width="800" align="center">
        <tr>
            <td colspan="3" align="left">
            <strong>  <%=LanguageSupport.getResource("RYGL-2415","计算规则")%>：</strong><br><br>
            &nbsp;&nbsp;&nbsp;&nbsp; <%=LanguageSupport.getResource("RYGL-2416","根据姓名信息(A001001)产生简拼(A001002),全拼(A001789)")%>.<br>
            </td>
        </tr>
        <tr class="td_middle">
            <td><%=LanguageSupport.getResource("RYGL-2290","所属机构 ")%></td>
            <td>
      </f:verbatim>
                <h:inputText id="orgId" value="#{emp_DrawoutAgeBB.orgId}" readonly = "true"
                                  size="20" styleClass="input" code="" dict="yes" dict_num="OU" />
                <h:commandButton onclick="PopUpOrgDlg('form1:orgId',2,'')" styleClass="button_select"  type="button"/>
     <f:verbatim>
            </td>
            <td>
     </f:verbatim>
                <h:commandButton  styleClass="button01" value="开始计算" onclick = "return doCalc();" action ="#{emp_DrawoutAgeBB.generatePersonShort}"/>
     <f:verbatim>
            </td>
        </tr>
    </table>
     </f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
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