<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String backFlag = CommonFuns.filterNull(request.getParameter("backFlag"));
%>

    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id+"&backFlag=<%=backFlag%>&type="+type, "aa", "", "1000", "600", "no","10","1","yes");
        }
        function forSel() {
            if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                   document.forms(0).all('form1:queryPerson').click();
            }
        }
        function forSelPerson() {
            if (checkMutilSelect(document.forms(0).chk)) {
                showx = event.screenX - event.offsetX - 150;
                showy = event.screenY - event.offsetY + 18;
                windowOpen("","plist","","1000","600","no","10","0","yes");
               //window.open("", "plist", "dialogWidth:800px; dialogHeight:700px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
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
                 document.forms(1).method = "post";
                document.forms(1).action = "/employee/info/PersonManyEditInfo.jsf?backFlag=<%=backFlag%>";
                document.forms(1).submit();
                document.forms(1).target = "_self";
            } else {
                alert("请选择人员");
                return false;
            }
        }
         function forAdQry(){
             document.all("form1:name").value = "";
             doAdvanceQuery("A","ORG","111","Y","","A001.A001730='<%=Constants.NO%>'","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
         }
    </script>
    <x:saveState value="#{emp_backpersonListBB}"></x:saveState>
    <h:form id="form1">
        <h:inputHidden value="#{emp_backpersonListBB.personList}"/>
        <h:inputHidden id="superId" value="#{emp_backpersonListBB.superId}"/>
         <c:verbatim>
         <input type="hidden" name="sessionFlag" value="2">
         <input type="hidden" name="backFlag" value="<%=backFlag%>">
         <table id=t1 width="98%" height=95% border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="td_page" colspan="2" height=8>　
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="<%=LanguageSupport.getResource("XTGL-1012","选择人员类别")%>  "
                           onclick="forSel()">
         </c:verbatim>
                    <h:inputHidden id="personType" value="#{emp_backpersonListBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{emp_backpersonListBB.personTypeValue}"/>
                    <h:outputText value="#{emp_backpersonListBB.personTypeDesc}"></h:outputText>
<c:verbatim>
                </td>
            </tr>
             <tr><td class="td_page" height=8>
</c:verbatim>        
                    <f:verbatim>
                      <%= LanguageSupport.getResource("RYGL-1016", "姓名")%>
                    </f:verbatim>
                    <h:inputText id="name" value="#{emp_backpersonListBB.name}"
                                    size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
                    <h:commandButton value=" 查询 " id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                                     action="#{emp_backpersonListBB.queryPerson}"/>
<c:verbatim>
                </td>
                <td class="td_page" height=8>
</c:verbatim>
                    <h:commandButton value="维护多人" onclick="javascript:forSelPerson();" type="button"
                                     styleClass="button01"/>
<c:verbatim>
                </td>
            </tr>
            <tr><td colspan=2 height=8></td></tr>
            <tr><td colspan=2>
                <jsp:include page="../../common/activepage/ActiveList.jsp">
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
