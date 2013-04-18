<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
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
            var pass= forsubmit(document.forms(0));
            if(pass){
            	x = document.body.clientWidth / 2 - 150;
        		y = document.body.clientHeight / 2;
        		document.all('processbar').style.top = y;
        		document.all('processbar').style.left = x;
        		document.all('processbar').style.display = "";
        		return true;
            }else{
            	return false;
            }
        }
        return false;
    }
</script>

<x:saveState value="#{OrgAddBB}"/>
<h:form id="form1">
<h:inputHidden value="#{OrgAddBB.pageInit}"></h:inputHidden>
<h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" columns="1" >
    <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <f:verbatim>
          <%=LanguageSupport.getResource("JGGL-0100","机构管理")%> -> <%=LanguageSupport.getResource("JGGL-0102","新增机构")%>
        </f:verbatim>
    </h:panelGroup>
</h:panelGrid>

<f:verbatim>
 <br>
 <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr>
        <td height="20" class="f05">
        <%=LanguageSupport.getResource("JGGL-1000","机构基本信息")%>
        </td>
        <td width="80%" id="orgCode" align="right" class="f04">
         <%=LanguageSupport.getResource("JGGL-1001","机构代码")%>
                      
</f:verbatim>
            <h:inputText styleClass="input" id="B001010" value="#{OrgAddBB.orgvo.orgCode}" alt="机构代码|1|s|9||"/>
<f:verbatim>
        </td>
    </tr>
</table>


<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr >
        <td width="140" class="td_form01 td_form_required">
             *<%=LanguageSupport.getResource("JGGL-1002","机构名称")%>
        </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText  styleClass="input" id="B001005" value="#{OrgAddBB.orgvo.orgName}" alt="机构名称|0|s|25||"/>
<f:verbatim>
        </td>
        <td width="140" class="td_form01 td_form_required">
                     *<%=LanguageSupport.getResource("JGGL-1003","机构类别")%>
        </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001075" code="" dict="yes" dict_num="0891"
                         readonly="true" value="#{OrgAddBB.orgvo.orgType}" alt="机构类别|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B001075')"></td>
    </tr>

    <tr >
        <td class="td_form01 td_form_required">
         *<%=LanguageSupport.getResource("JGGL-1004"," 主管机构")%>
        </td>
        <td class=td_form02 colspan="3">
</f:verbatim>
            <h:inputText styleClass="input" id="B001002" code="" dict="yes" dict_num="OU" value="#{OrgAddBB.orgvo.superId}"
                         readonly="true" alt="主管机构|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:B001002',2,'')">
        </td>
    </tr>

</table>
</f:verbatim>
<f:verbatim>

<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
    <tr><td height="40" colspan="4" class="f05" valign="bottom">
         <%=LanguageSupport.getResource("JGGL-1005","机构设立信息")%>
       </td></tr>
</table>

<table width=95% align=center border=0 cellpadding=0 cellspacing=0 class=table03>
    <tr >
        <td width="140" class="td_form01 td_form_required">
           *<%=LanguageSupport.getResource("JGGL-1006","机构设立时间")%>
                     </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" readonly="true" id="B004005" value="#{OrgAddBB.orgsetvo.setupTime}"
                         alt="机构设立时间|0|s|7||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:B004005')"></td>
        <td width="140" class="td_form01 td_form_required">
        *<%=LanguageSupport.getResource("JGGL-1007"," 机构设立类别")%>
        </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B004201" code="" dict="yes" dict_num="0896" readonly="true"
                         value="#{OrgAddBB.orgsetvo.setupType}" alt="机构设立类别|0|s|50||"/>
<f:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B004201')">
        </td>
    </tr>
    <tr >
        <td class="td_form01 ">
         <%=LanguageSupport.getResource("JGGL-1008","批准设立文号")%>   
         </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B004010" value="#{OrgAddBB.orgsetvo.setupNo}" alt="批准设立文号|1|s|20||"/>
<f:verbatim>
        </td>
        <td class="td_form01 ">
         <%=LanguageSupport.getResource("JGGL-1009","批准设立单位")%>
            
        </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B004025" value="#{OrgAddBB.orgsetvo.setupUnit}"
                         alt="批准设立单位|1|s|25||"/></td>
<f:verbatim>
    </tr>

    <tr >
        <td class=td_form01> 
          <%=LanguageSupport.getResource("JGGL-1010","备注")%>   
         </td>
        <td class=td_form02 colspan="3">
</f:verbatim>
            <h:inputTextarea rows="3" id="B004210" cols="80" value="#{OrgAddBB.orgsetvo.memo}"/>
<f:verbatim>
        </td>
    </tr>
</table>

<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td  align=right>
</f:verbatim>
            <h:commandButton value="增加" onclick="javascript:return forSave()" styleClass="button01"
                             action="#{OrgAddBB.createOrg}"/>
            <h:commandButton value="取消" styleClass="button01" action="#{OrgAddBB.cancelOrg}"></h:commandButton>
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
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
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