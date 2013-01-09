<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id, "aa", "", "800", "700", "no");
        }
        function forSel() {
               if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
                  document.forms(0).all('form1:queryPerson').click();
           }
        }

        function doWork() {
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
                var act="/insurace/PersonDelete.jsf?perIds="+perIds;
                //alert(act);
                document.forms(1).action = act;
                document.forms(1).submit();
                document.forms(1).target = "_self";
            } else {
                alert("请先选择人员");
                return false;
            }
        }

         function forAdQry(){
             doAdvanceQuery("A","ORG","111","Y","","A001.A001730='00900'","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
         }
         function forExport() {
             window.open('/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT%>');
             return null;
         }
         function forEdit(form, id, right) {
             var arg = "id=" + id;
             window.open("/pages/insurace/base/PersonInfoFrame.jsp?" + arg, null, "left="+screen.width*0.05+",top="+screen.height*0.01+",height="+screen.height*0.9+",width="+screen.width*0.9+",status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
             window.status = "";
         }
    </script>
</head>

<body>
    <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.personList}"/>
        <h:inputHidden id="superId" value="#{emp_personListBB.superId}"/>
     <f:verbatim>
        <input type="hidden" name="sessionFlag" value="2">
        <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td colspan="2" class="td_page" height=8>
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="选择人员类别"
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
                    </f:verbatim>
                                 <h:outputText value="姓名/员工编号/简拼"></h:outputText>
                                 <h:inputText id="name" value="#{emp_personListBB.name}"
                                                 size="10" styleClass="input" onkeypress ="enterKeyDown('form1:queryPerson')" />
                                 <h:commandButton value=" 查询 " id="queryPerson"  styleClass="button01"
                                                  action="#{emp_personListBB.queryPerson}"/>
                                 <h:outputText value="  "/>
                                 <h:commandButton value="自定义查询" onclick="javascript:return forAdQry();" styleClass="button01" />
                                <h:selectOneMenu id="displaySet" value="#{emp_personListBB.defaultQry}" onchange="disPlayProcessBar();submit();" valueChangeListener="#{emp_personListBB.changeQuery}">
                                    <c:selectItems value="#{emp_personListBB.insdisplaySetList}"></c:selectItems>
                                </h:selectOneMenu>
                                <h:outputText value=" "/>
                    			<h:commandButton styleClass="button01" value="导出Excel" type="button" onclick="return forExport();"/>
                    <f:verbatim>
                </td>
                <td class="td_page" height=8>
       </f:verbatim>
                    <h:commandButton value="业务处理" onclick="javascript:doWork();" type="button"   styleClass="button01"/>
       <f:verbatim>
                </td>
            </tr>

            <tr><td colspan=2>
                <jsp:include page="../common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
			            <jsp:param name="operSignType" value="checkbox"/>
			            <jsp:param name="hasEdit" value="true"/>
			            <jsp:param name="isForward" value="true"/>
			            <jsp:param name="rowFuncName" value="forEdit"/>
			            <jsp:param name="isEditList" value="false"/>
			            <jsp:param name="isCheckRight" value="false"/>
                </jsp:include>
            </td></tr>
        </table>
       </f:verbatim>
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>
    <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
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
<script type="text/javascript">
    interpret(document.forms(0));
</script>
