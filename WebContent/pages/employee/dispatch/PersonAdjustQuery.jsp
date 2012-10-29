<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
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

        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id, "aa", "", "800", "700", "no");
        }
        function forSel() {
           if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                  document.forms(0).all('form1:queryPerson').click();
           }
        }

        function forCancel() {
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
                windowOpen("", "plist", "", "700", "200", "no", "200", "200");
                document.forms(1).perids.value = perIds;
                document.forms(1).target = "plist";
                document.forms(1).method = "post";
                document.forms(1).action = "/employee/dispatch/PersonAdjust.jsf";
                document.forms(1).submit();
                document.forms(1).target = "_self";
            } else {
                alert("请选择要划转的人");
                return false;
            }
        }
         function forAdQry(){
             doAdvanceQuery("A","ORG","111","Y","","A001.A001730='00900'","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
         }
    </script>

    <x:saveState value="#{emp_personListBB}"></x:saveState>
    <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.personList}"/>
        <h:inputHidden id="superId" value="#{emp_personListBB.superId}"/>
<f:verbatim>
            <input type="hidden" name="sessionFlag" value="2">
           <table id=t1 width="100%" height="96%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" colspan="3" height="8">
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="<%=LanguageSupport.getResource("XTGL-1012", " 选择人员类别")%>"
                           onclick="forSel()">
</f:verbatim>
                    <h:outputText value="#{emp_personListBB.personTypeDesc}"></h:outputText>
                    <h:inputHidden id="personType" value="#{emp_personListBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{emp_personListBB.personTypeValue}"/>
<f:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_page" height="8">
</f:verbatim>
                        <h:selectOneMenu id="displaySet" value="#{emp_personListBB.defaultQry}" onchange="submit()" valueChangeListener="#{emp_personListBB.changeQuery}">
                            <c:selectItems value="#{emp_personListBB.displaySetList}"></c:selectItems>
                        </h:selectOneMenu>
<f:verbatim>
                </td>
                <td class="td_page" height="8">
                 <%=LanguageSupport.getResource("XTGL-1013", "姓名或员工编号")%>:
</f:verbatim>    
                    <h:inputText id="name" value="#{emp_personListBB.name}"
                                    size="10" styleClass="input" onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value=" 查询 " id="queryPerson"  styleClass="button01"
                                     action="#{emp_personListBB.queryPerson}"/>
                    <h:inputHidden id="ManyPerson" value="#{emp_personListBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{emp_personListBB.queryMultPerson}"/>

                    <h:commandButton value="自定义查询" onclick="javascript:return forAdQry();" styleClass="button01" />
<f:verbatim>
                </td>
                <td class="td_page" height="8">
</f:verbatim>
                    <h:commandButton value="业务处理" onclick="javascript:forCancel();" type="button"
                                     styleClass="button01"/>
<f:verbatim>
                </td>
            </tr>

            <tr>
                <td colspan="3">
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
                </td>
            </tr>
        </table>
</f:verbatim>          
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
