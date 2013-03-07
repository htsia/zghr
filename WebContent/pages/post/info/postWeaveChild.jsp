<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/doc/PostIndex.jsf?postid="+id+"&fk="+id,"aa","","900","600","yes","10","100","yes");
        }
        function forAdQry(){
             doAdvanceQuery("C","ORG","111","Y","","C001.C001730 = '00900'","Y","<%=Constants.DEFAULT_QUERY_POST%>","Y","1");
        }
        function OpenRpt(){
            if (!checkMutilSelect(document.forms(0).chk)){
                alert("请先选择人员！");
                return false;
            }

            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var obj = document.forms(0).chk ;
            var ids = "";
            if (obj.length == null) {
                ids = obj.value;
            } else {
                for (i = 0; i < obj.length; i++) {
                    if (obj[i].checked) {
                        ids = obj[i].value;
                        break;
                    }
                }
            }

            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&Parameter="+ids;
            window.open(url);
            return false;
        }
        function forWeave(){
        	var superID=document.getElementById("form1:superID").value;
        	if(superID==''){
        		alert("请查询岗位");
        		return false;
        	}
        	
        	x = document.body.clientWidth / 2 - 150;
            y = document.body.clientHeight / 2;
            document.all('processbar').style.top = y;
            document.all('processbar').style.left = x;
            document.all('processbar').style.display = "";
        	return true;
        }
    </script>

<h:form id="form1">
    <h:inputHidden value="#{post_PostWeaveBB.postList}"/>
    <h:inputHidden id="superID" value="#{post_PostWeaveBB.superId}"/>
<f:verbatim>
    <input type="hidden" name="sessionFlag" value="2">

    <table id=t1 width="100%" border="0" cellspacing="0" cellpadding="0" height=98%>
        <tr>
            <td class="td_page" height=8px>
</f:verbatim>
                <f:verbatim>
                     <strong><%=LanguageSupport.getResource("JGGL-1077","岗位名称")%></strong>
                </f:verbatim>
                <h:inputText id="postName" styleClass = "input" value="#{post_PostWeaveBB.postName}"
                                  size="10"/>
                <f:verbatim>
                 <strong><%=LanguageSupport.getResource("JGGL-1004"," 主管机构")%></strong>
                </f:verbatim>
                <h:inputText  id="orgName" readonly="true" styleClass = "input" value="#{post_PostWeaveBB.superName}" />
                <h:inputHidden  id="superId" value="#{post_PostWeaveBB.superId}" ></h:inputHidden>
                <h:commandButton  onclick="fPopUpOrgDlg2('form1:superId','form1:orgName',1)" styleClass="button_select" type="button"/>
                <h:commandButton value=" 查询 " styleClass="button01"
                                 action="#{post_PostWeaveBB.queryPost}"/>
                <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" />
                <h:commandButton value="核算"  styleClass="button01" onclick="return forWeave();" action="#{post_PostWeaveBB.calc}"/>
                <h:commandButton value="导出" styleClass="button01" type="button" onclick="doExport();"></h:commandButton>
<f:verbatim>
            </td>
            </tr>

        <tr>
            <td colspan=2 >
                <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                        <jsp:param name="hasOperSign" value="false"/>
                        <jsp:param name="hasEdit" value="true"/>
                        <jsp:param name="isEditList" value="false"/>
                        <jsp:param name="isCheckRight" value="true"/>
                        <jsp:param name="isForward" value="true"/>
                        <jsp:param name="isRow" value="true"/>
                        <jsp:param name="rowFuncName" value="forView"/>
                        <jsp:param name="isPage" value="true"/>
                    </jsp:include>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr></table>
</marquee>
