<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>
<script type="text/javascript">
    function doRun(){
        if (confirm('确定将15位身份证号转换为18位？')){
            disPlayProcessBar();
            return forsubmit(document.forms(0));
        }
        return false;
    }
</script>

<h:form id="form1">
    <c:verbatim>
    <table width="96%" align="center">
        <tr>
            <td align="center" width="16%" class=tab><a href="/system/cleandata.jsf">清除垃圾</a></td>
            <td align="center" width="16%" class=activeTab><a href="/system/IDCardConvert.jsf">身份证转换</a></td>
            <td>&nbsp;</td>
        </tr>
    </table>
    <br>
    </c:verbatim>

    <h:panelGrid width="90%" align="center">
        <h:panelGroup>
            <h:outputText value="选择机构"></h:outputText>
            <h:inputText id="orgId" value="#{sys_CleanBB.orgId}" readonly = "true"
                              size="30" styleClass="input" code="" dict="yes" dict_num="OU" />
            <h:commandButton onclick="PopUpOrgDlg('form1:orgId',2,'')" styleClass="button_select"  type="button"/>

            <h:commandButton value="开始" action="#{sys_CleanBB.id15To18}" styleClass="button01" onclick="return doRun();"></h:commandButton>
        </h:panelGroup>

        <h:outputText escape="false" value="<strong>转换测试:</strong>"></h:outputText>

        <h:panelGroup>
             <h:inputText value="#{sys_CleanBB.oldID}"></h:inputText>
             <h:commandButton value="=>" styleClass="button01" action="#{sys_CleanBB.testid15To18}"></h:commandButton>
             <h:inputText value="#{sys_CleanBB.newID}" readonly="true"></h:inputText>
        </h:panelGroup>

        <h:outputText escape="false" value="<strong>校验:</strong>"></h:outputText>
        <h:panelGroup>
             <h:inputText value="#{sys_CleanBB.checkID}"></h:inputText>
             <h:commandButton value="=>" styleClass="button01" action="#{sys_CleanBB.doCheck}"></h:commandButton>
             <h:outputText value="#{sys_CleanBB.checkDes}"></h:outputText>
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
