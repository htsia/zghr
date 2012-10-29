<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript" >
    //XMLHttpRequest状态改变时要执行的函数
    function handleStateChange() {
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
                //解析从xml文件得到的结果,动态画树
                parseResults();
            }
        }
    }

    //解析从xml文件得到的结果
    function parseResults() {
        var results = xmlHttp.responseXML;
        var orgs = null;
        var trees = results.getElementsByTagName("message");
        for (var i = 0; i < trees.length; i++) {
            orgs = trees[i];
            info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
        }
    }
    //创建XMLHttpRequest对象
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }
    
    function forCheck() {
        //debugger;
        var queryString = createQueryString("B001",document.forms(0));
        createXMLHttpRequest();
        xmlHttp.open("POST", "/pages/ajax/Check.jsp", false);
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
        xmlHttp.send(queryString);

        if (info != null && info != "" && info != "no") {
            alert(info);
            return false;
        }
        return true;
    }

    function forSave() {
        if (forCheck()) {
            return forsubmit(document.forms(0));
        }
        return false;
    }
</script>

<x:saveState value="#{OrgAddBB}"/>
<h:form id="form1">
<h:inputHidden value="#{OrgAddBB.pageInit}"></h:inputHidden>
<h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" columns="1" >
    <h:panelGroup>
        <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-0100","机构管理 ")+"->"%> 
                 <%=LanguageSupport.getResource("JGGL-0102","新增机构")%> 
         </f:verbatim>
    </h:panelGroup>
</h:panelGrid>

<f:verbatim>
<br>
<table width=350 align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr >
        <td width="140" id="orgCode"  class="td_form01">
         <%=LanguageSupport.getResource("JGGL-1072","机构代码")%> 
       </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText  id="B001010" value="#{OrgAddBB.orgvo.orgCode}" alt="机构代码|1|s|9||"/>
    <f:verbatim>
        </td>
    </tr>

    <tr>
        <td width="140" class="td_form01 td_form_required">
              <%=LanguageSupport.getResource("JGGL-1073","机构名称")%> 
             </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText  id="B001005" value="#{OrgAddBB.orgvo.orgName}" alt="机构名称|0|s|25||"/>
<f:verbatim>
        </td>
    </tr>

    <tr>
    <td width="140" class="td_form01 td_form_required"> <%=LanguageSupport.getResource("JGGL-1003","机构类别")%> </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="B001075" code="" dict="yes" dict_num="0891"
                     readonly="true" value="#{OrgAddBB.orgvo.orgType}" alt="机构类别|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B001075')"></td>
    </tr>
    
    <tr >
        <td class="td_form01 td_form_required"> <%=LanguageSupport.getResource("JGGL-1098","上级机构")%></td>
        <td class=td_form02 >
</f:verbatim>
            <h:inputText  id="B001002" code="" dict="yes" dict_num="OU" value="#{OrgAddBB.orgvo.superId}"
                         readonly="true" alt="上级机构|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:B001002',2,'')">
        </td>
    </tr>

</table>
</f:verbatim>

<f:verbatim>
<br>    
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td  align=right>
</f:verbatim>
            <h:commandButton value="  增加  " onclick="javascript:return forSave()" styleClass="button01"
                             action="#{OrgAddBB.createOrgXX}"/>
            <h:commandButton value="  取消  " styleClass="button01" action="#{OrgAddBB.cancelOrg}"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>
<script type="text/javascript">
<%
     InfoItemBO orgcode=SysCacheTool.findInfoItem("","B001010");
     if ("1".equals(orgcode.getItemNotNull())){
         out.println("document.all('orgCode').className='td_form_required';");
         out.println("document.all('form1:B001010').alt='机构代码|0|s|"+orgcode.getItemDataLength()+"||';");
     }
     else{
        out.println("document.all('form1:B001010').alt='机构代码|1|s|"+orgcode.getItemDataLength()+"||';");
     }
%>
</script>