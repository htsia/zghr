<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doQueryManyPerson(){
            var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
            if (reval != null && reval !="") {
                document.all('form1:ManyPerson').value = reval;
                return true;
            } else {
                return false;
            }
        }
        function ViewApply(){
            window.showModalDialog("/employee/info/TypeChangingPerson.jsf", null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return false;
        }
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id, "aa", "", "800", "700", "no");
        }
        function forChange() {
            var perIds = "";
            if (checkMutilSelect(document.forms(0).chk)) {
                var obj = document.forms(0).chk;
                var size = obj.length;
                if (size == null) {
                    if (obj.checked) {
                        perIds += obj.value + ",";
                    }
                } else {
                    for (var i = 0; i < size; i++) {
                        if (obj[i].checked) {
                            perIds += obj[i].value + ",";
                        }
                    }

                }               
                if (perIds != "") {
                    perIds = perIds.substr(0, perIds.length - 1);
                }
                windowOpen("", "plist", "", "700", "300", "no", "200", "200");
                document.forms(1).perids.value = perIds;
                document.forms(1).target = "plist";
                document.forms(1).method = "post";
                var act="/employee/info/PersonChangeType.jsf?OperId="+document.all('form1:operId').value+"&newtype="+document.all('form1:newtype').value;
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
    </script>

    <x:saveState value="#{emp_typeChangeBB}"></x:saveState>
    <h:form id="form1">
        <h:inputHidden value="#{emp_typeChangeBB.init}"/>
        <h:inputHidden id="type" value="#{emp_typeChangeBB.type}"/>
        <h:inputHidden id="newtype" value="#{emp_typeChangeBB.newtype}"/>
        <h:inputHidden id="operId" value="#{emp_typeChangeBB.operId}"/>
        <h:inputHidden id="superId" value="#{emp_typeChangeBB.superId}"/>
        <c:verbatim>
        <input type="hidden" name="sessionFlag" value="2">
        <table id=t1 width="98%" height=95% border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" height=2>
		        	<%=LanguageSupport.getResource("RYGL-2193"," 姓名或编号")%>
</c:verbatim>
                    <h:inputText id="name" value="#{emp_typeChangeBB.name}"
                                    size="10" styleClass="input" onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value=" 查询 " id="queryPerson"  styleClass="button01"
                                     action="#{emp_typeChangeBB.queryPerson}"/>
                    <h:inputHidden id="ManyPerson" value="#{emp_typeChangeBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{emp_typeChangeBB.queryMultPerson}"/>
<c:verbatim>
                </td>
                <td class="td_page" height=2>
</c:verbatim>
                    <h:commandButton value="查看审批情况" rendered="#{emp_typeChangeBB.auditMode}" onclick="javascript:ViewApply();" type="button"   styleClass="button01"/>
                    <h:commandButton value="业务处理" onclick="javascript:forChange();" type="button"   styleClass="button01"/>
<c:verbatim>
                </td>
            </tr>

            <tr><td colspan=2>
                <jsp:include page="../../common/activepage/ActiveList.jsp">
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
</c:verbatim>
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
