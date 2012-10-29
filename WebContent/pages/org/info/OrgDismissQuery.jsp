<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forCancel() {
            var orgIds = "";
            if (checkMutilSelect(document.forms(0).chk)) {
                var obj = document.forms(0).chk;
                var size = obj.length;
                if (size == null) {
                    if (obj.checked) {
                        orgIds +=obj.value;
                    }
                } else {
                    for (var i = 0; i < size; i++) {
                        if (obj[i].checked) {
                            orgIds +=obj[i].value+",";
                        }
                    }
                    if(orgIds !=""){
                       orgIds = orgIds.substr(0,orgIds.length-1);
                    }
                }

                windowOpen("/org/info/OrgDismiss.jsf?ids="+orgIds,"aa","","700","200","no","200","200");
            }
        }

           function forAdQry(){
             doAdvanceQuery("B","ORG","111","Y","","B001.B001730='00900'","Y","<%=Constants.DEFAULT_QUERY_ORG%>","Y","1");
         }
    </script>

<h:form id="form1">
    <h:inputHidden value="#{OrgListBB.orgList}"/>  
<f:verbatim>

    <input type="hidden" name="sessionFlag" value="2">
    <table id=t1 width="100%" height=98% border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="td_page" height=8>
</f:verbatim>
                <f:verbatim> 
                      <%=LanguageSupport.getResource("JGGL-1002","机构名称：")%> 
                </f:verbatim>
                <h:inputText id="orgName" value="#{OrgListBB.orgName}"
                                  size="10" styleClass="input"/>
                   <f:verbatim> 
                      <%=LanguageSupport.getResource("JGGL-1004","主管机构：")%> 
                </f:verbatim>               
                <h:inputText id="superId" value="#{OrgListBB.superId}"
                                  size="10" styleClass="input" code="" dict="yes" dict_num="OU"  readonly="true"/>
                <h:commandButton  onclick="javascript:PopUpOrgDlg('form1:superId',1)" styleClass="button_select" type="button"/>
                  <f:verbatim> 
                      <%=LanguageSupport.getResource("JGGL-1003","机构类别：")%> 
                </f:verbatim>   
               <h:inputText id="orgType" styleClass="input" code="" dict="yes" dict_num="0891" value="#{OrgListBB.orgType}"
                            readonly="true"   size="10"/>
                <h:commandButton  onclick="javascript:PopUpCodeDlgOneControl('form1:orgType')" styleClass="button_select" type="button"/>
                <h:commandButton value=" 查询 " id="queryOrg" onclick="javascript:return forsubmit(document.forms(0));" styleClass="button01" action="#{OrgListBB.queryOrg}"/>
                 <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" />
<f:verbatim>
            </td>
            <td class="td_page" height=8><input name="" type="button" class="button01" onclick="forCancel()" 
                     value="<%=LanguageSupport.getResource("JGGL-1044","机构撤销")%>"></td>
        </tr>
         <tr><td colspan=2 height=8></td></tr>
         <tr><td colspan=2>
      <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="true"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="true"/>
        <jsp:param name="isForward" value="true"/>
        <jsp:param name="isRow" value="false"/>
        <jsp:param name="isPage" value="true"/>
    </jsp:include>
         </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
