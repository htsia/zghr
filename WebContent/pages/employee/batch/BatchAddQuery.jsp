<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
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
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id, "aa", "", "900", "600", "no","yes");
        }
        function forSel() {
            if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                   document.forms(0).all('form1:queryPerson').click();
            }
        }

        function forSelPerson() {
            if (checkMutilSelect(document.forms(0).chk)) {
                showx = event.screenX - event.offsetX - 150;
                showy = event.screenY - event.offsetY + 18;
                windowOpen("","plist","","800","600","50","100","no","yes");
                var obj = document.forms(0).chk ;
                var ids = "";
                if (obj.length == null) {
                    ids = obj.value + ",";
                } else {
                    for (i = 0; i < obj.length; i++) {
                        if (obj[i].checked) {
                            ids += obj[i].value + ",";
                        }
                    }
                }
                ids = ids.substr(0, ids.length - 1);
                document.forms(1).perids.value = ids;
                document.forms(1).target = "plist";
                document.forms(1).action = "/employee/batch/BatchAddFrame.jsf";
                document.forms(1).submit();
                document.forms(1).target = "_self";
            } else {
                alert("请选择人员");
                return false;
            }
        }
          function forAdQry(){
             doAdvanceQuery("A","ORG","111","Y","","(A001.A001730='00900')","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
         }
    </script>

    <x:saveState value="#{emp_personListBB}"></x:saveState>  
    <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.personList}"/>
        <h:inputHidden id="superId" value="#{emp_personListBB.superId}"/>       
 <f:verbatim>
        <input type="hidden" name="sessionFlag" value="2">

        <table id=t1 width="100%" height=96% border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td colspan="2" class="td_page" height=8>
                           
                    <input name="simple1" type="button" id=15 next=20 class="button01" value='<%=LanguageSupport.getResource( "RYGL-0316", "选择人员类别")%>' 
                           onclick="forSel()">
 </f:verbatim>
                    <h:inputHidden id="personType" value="#{emp_personListBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{emp_personListBB.personTypeValue}"/>
                    <h:outputText value="#{emp_personListBB.personTypeDesc}"></h:outputText>
 <f:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_page" height=8>
                  <%=LanguageSupport.getResource("MSG-0010"," 姓名 ")%> :
 </f:verbatim>
                    <h:inputText id="name" value="#{emp_personListBB.name}" onkeypress ="enterKeyDown('form1:queryPerson')"
                                    size="10"/>
                    <h:commandButton value=" 查询 " id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                                     action="#{emp_personListBB.queryPerson}"/>
                    <h:inputHidden id="ManyPerson" value="#{emp_personListBB.nameStrs}"></h:inputHidden>
                    <h:commandButton value="多人查询" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                     action="#{emp_personListBB.queryMultPerson}"/>
                    <h:commandButton value="自定义查询" onclick="javascript:return forAdQry();" styleClass="button01" />
 <f:verbatim>
                </td>
                <td class="td_page">
</f:verbatim>
                    <h:commandButton value="批量增加" onclick="javascript:forSelPerson();" type="button"
                                     styleClass="button01"/>
<f:verbatim>
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
                    <jsp:param name="rowFuncName" value="forView"/>
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
