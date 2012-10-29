<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type="+type,"aa","","900","600","no","10","100","yes");
        }
        function forAdQry(){
             doAdvanceQuery("C","ORG","111","Y","","C001.C001730 = '00900'","Y","<%=Constants.DEFAULT_QUERY_POST%>","Y","1");
         }
        function changeSuperOrg(){
            if (!checkMutilSelect(document.forms(0).chk)){
                alert("请先选择岗位！");
                return false;
            }
            var arg=getAllSelectValue(document.forms(0).chk,",")
            window.showModalDialog("/post/info/PostChangeSuper.jsf?PostIDs=" + arg, "", "dialogWidth:395px; dialogHeight:230px; center:yes; status:0;resizable:yes");
            return true;
        }
        function OpenRpt(){
            if (!checkMutilSelect(document.forms(0).chk)){
                alert("请先选择岗位！");
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
    </script>

<h:form id="form1">
    <h:inputHidden value="#{post_PostListBB.postList}"/>  
<f:verbatim>
    <input type="hidden" name="sessionFlag" value="2">

    <table id=t1 width="100%" border="0" cellspacing="0" cellpadding="0" height=98%>
        <tr>
            <td class="td_page" height=8px>
</f:verbatim>
                 <f:verbatim>
                   <%=LanguageSupport.getResource("JGGL-1078"," 岗位名称")%> :
                </f:verbatim>    
                <h:inputText id="postName" styleClass = "input" value="#{post_PostListBB.postName}"
                                  size="10"/>
                 <f:verbatim>
                   <%=LanguageSupport.getResource("JGGL-1004"," 主管机构")%> :
                </f:verbatim>    
                <h:inputText  id="orgName" readonly="true" styleClass = "input" value="#{post_PostListBB.superName}" />
                <h:inputHidden  id="superId" value="#{post_PostListBB.superId}" ></h:inputHidden>
                <h:inputHidden  id="changeId" value="#{post_PostListBB.changeId}" ></h:inputHidden>
                <h:commandButton  onclick="fPopUpOrgDlg2('form1:superId','form1:orgName',1)" styleClass="button_select" type="button"/>

                <h:commandButton value=" 查询 " styleClass="button01"
                                 action="#{post_PostListBB.queryPost}"/>
                <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" />

                <h:commandButton value="变更所属机构" onclick="return changeSuperOrg();" styleClass="button01" action="#{post_PostListBB.queryPost}"></h:commandButton>
<f:verbatim>
            </td>
            </tr>
            <tr>
            <td class="td_page"  height=8px>
</f:verbatim>
                <h:selectOneMenu id="ReportID" style="width:190px">
                    <c:selectItems value="#{post_PostListBB.regTableList}"/>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" type="button" value="显示登记表" onclick="OpenRpt();"></h:commandButton>
<f:verbatim>
            </td>
        </tr>
        <tr>
            <td colspan=2 >
                <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                        <jsp:param name="hasOperSign" value="true"/>
                        <jsp:param name="operSignType" value="checkbox"/>
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

