<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function doMessageWork(){
        window.showModalDialog("/attence/attCardMessage.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:600px; dialogHeight:400px; status:0;resizable:yes");
        return true;
    }
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id, "aa", "", "800", "700", "no");
        }
        function forSel() {
               if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
                  document.forms(0).all('form1:queryPerson').click();
           }
        }

        function doWork() {
        	var flag = 0;
        	var perIds = "";
            if (checkMutilSelect(document.forms(0).chk)) {
                var obj = document.forms(0).chk;
                var size = obj.length;
                if (size == null) {
                    if (obj.checked) {
                        perIds = obj.value;
                    }
                }else {
                    for (var i = 0; i < size; i++) {
                        if (obj[i].checked) {
                            flag = flag + 1;
                            if (flag == 1)
                              perIds = obj[i].value ;
                            if (flag > 1)
                                break;
                        }
                    }

                }
                if (flag > 1) {
                    alert("只能进行单人发卡操作！");
                    return false;
                }
                windowOpen("", "plist", "", "300", "150", "no", "200", "200");
                document.forms(1).perids.value = perIds;
                document.forms(1).target = "plist";
                document.forms(1).method = "post";
                var act="/attence/attCardMgrEdit.jsf?perIds="+perIds;
                //alert(act);
                document.forms(1).action = act;
                document.forms(1).submit();
                document.forms(1).target = "_self";
                return true;
            } else {
                alert("请先选择人员");
                return false;
            }
        }

         function forAdQry(){
             doAdvanceQuery("A","ORG","111","Y","","A001.A001730='00900'","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
         }
    </script>
<x:saveState value="#{AttCardMgr_ChildBB}"/>
    <h:form id="form1">
        <h:inputHidden id="pageInit" value="#{AttCardMgr_ChildBB.pageInit}"/>
        <h:inputHidden id="personList" value="#{AttCardMgr_ChildBB.personList}"/>
        <h:inputHidden id="superId" value="#{AttCardMgr_ChildBB.superId}"/>
     <f:verbatim>
        <input type="hidden" name="sessionFlag" value="2">
        <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" height=8>
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="选择人员类别"
                           onclick="forSel()">
       </f:verbatim>
                    <h:inputHidden id="personType" value="#{AttCardMgr_ChildBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{AttCardMgr_ChildBB.personTypeValue}"/>
                    <h:outputText value="姓名或员工编号："></h:outputText>
                    <h:inputText id="name" value="#{AttCardMgr_ChildBB.name}"
                                    size="10" styleClass="input" onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value=" 查询 " id="queryPerson"  styleClass="button01"
                                     action="#{AttCardMgr_ChildBB.queryPerson}"/>
                    <h:commandButton value="高级查询" onclick="javascript:return forAdQry();" styleClass="button01" />
       <f:verbatim>
                </td>

                <td class="td_page" height=8>
       </f:verbatim>
                    <h:commandButton value="设置考勤卡" onclick="javascript:doWork();" type="button"   styleClass="button01"/>
                    <h:commandButton value="发卡日志" onclick="javascript:doMessageWork();" type="button"   styleClass="button01"/>
       <f:verbatim>
                </td>
            </tr>

            <tr><td colspan=2>
                <jsp:include page="../common/activepage/ActiveList.jsp">
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
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
