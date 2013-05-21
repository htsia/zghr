<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doCheck() {
            if (document.all("form1:A001054").value==""){
                alert("没有选择人员类别!");
                return false;
            }
            if (document.all("form1:A016030").value==""){
                alert("没有选择上岗部门!");
                return false;
            }

            return forsubmit(document.forms(0));
         }
        function selectRetirePerson(){
            fPopUpPerDlgFilter('form1:recName', 'form1:recID',"p.personType not in ('<%=Constants.IN_SERVICE_TYPE.replaceAll(",","','")%>')");
            createXMLHttpRequest();
            xmlHttp.onreadystatechange = handleStateChange;

            xmlHttp.open("GET", "/pages/ajax/Person.jsp?perID="+document.all("form1:recID").value, true);
            xmlHttp.send(null);
        }
        function selPost(){
            var deptId=document.all("form1:A016030").code;
            if(deptId==''){
            	alert("请选选择机构");
            	return;
            }
            PopUpPostDlgByDept(document.all("form1:A001715"),null,deptId);
        }
        var xmlHttp;
        var superId = "";

        //创建XMLHttpRequest对象
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest();
            }
        }
        //XMLHttpRequest状态改变时要执行的函数
        function handleStateChange() {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    //解析从xml文件得到的结果,动态画树
                    parseResults();
                }
            }
        }
        //解析从xml文件得到的结果 ，动态画树
        function parseResults() {
            var results = xmlHttp.responseXML;

            var trees = results.getElementsByTagName("person");
            if (trees.length>0){
                try{
                    var A001044=trees[0].getElementsByTagName("A001044")[0].firstChild.nodeValue;
                    document.all('form1:A001044').value=A001044;
                }
                catch(e){
                   document.all('form1:A001044').value="";
                }
                try{
                    var A001781=trees[0].getElementsByTagName("A001781")[0].firstChild.nodeValue;
                    document.all('form1:A001781').value=A001781;
                }
                catch(e){
                   document.all('form1:A001781').value="";
                }
                
            }
        }

    </script>

    <x:saveState value="#{emp_engageBB}"/>
    <h:form id="form1">
        <c:verbatim>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95% >
            <tr><td height=12></td></tr>

            <tr>
                <td width="120" class=td_form01> <%=LanguageSupport.getResource("XTGL-1182","人员")%>  </td>
                <td  class=td_form02>
</c:verbatim>
                    <h:inputHidden id="recID" value="#{emp_engageBB.pid}"></h:inputHidden>
                    <h:inputText readonly="true" id="recName" value="#{emp_engageBB.PName}" />
<c:verbatim>
                    <input class="button_person" type="button" onclick="selectRetirePerson()">
                </td>
           </tr>

    <tr>
         <td width="120" class="td_form01"><%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"A001044")%></td>
         <td  class=td_form02>
</c:verbatim>
        <h:inputText styleClass="input" id="A001044"  readonly="true"    />
<c:verbatim>
        </td>
    </tr>

    <tr>
         <td width="120" class="td_form01"><%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"A001781")%></td>
         <td  class=td_form02>
</c:verbatim>
        <h:inputText styleClass="input" id="A001781"  readonly="true"    />
<c:verbatim>
        </td>
    </tr>

    <tr>
    <td class="td_form01 td_form_required" width="120">入职时间</td>
    <td class=td_form02>
 </c:verbatim>
        <h:inputText styleClass="input" id="A016020"
                     readonly="true" value="#{emp_engageBB.changeDate}"
                     alt="入职时间|0|s|50||"/>
<c:verbatim>
        <input type="button" class="button_date"    onclick="PopUpCalendarDialog('form1:A016020')">
    </tr>

            <tr>
            <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("XTGL-1047","增员类别")%></td>
            <td class=td_form02>
 </c:verbatim>
                <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                             readonly="true" value="#{emp_engageBB.changeType}"
                             alt="增员类别|0|s|50||"/>
<c:verbatim>
                <input type="button" class="button_select"    onclick="PopUpCodeDlgOneControl('form1:A016010','<%=Constants.EMP_REENTER_ADD_TYPE%>')">
            </tr>

            <tr>
                 <td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2255","聘后人员类别")%>  </td>
                 <td  class=td_form02>
 </c:verbatim>
                     <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                                  value="#{emp_engageBB.afterType}" alt="变更后人员类别|0|s|50||"/>
 <c:verbatim>
                     <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054','<%=Constants.EMP_REENTER_PERSON_TYPE%>')">
                </td>
            </tr>

            <tr>
                 <td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2019","入职机构")%>  </td>
                 <td  class=td_form02>
</c:verbatim>
                     <h:inputText styleClass="input" id="A016030" value="#{emp_engageBB.chgs}" dict="yes" dict_num="OU"  code=""
                             readonly="true"    alt="调入部门|0|s|50||"/>
<c:verbatim>
                     <input type="button" class="button_org" onclick="PopUpOrgDlgShowGroup('form1:A016030',2,'')">
                </td>
            </tr>

    <tr>
         <td width="90" class="td_form01 td_form_required">入职岗位</td>
         <td  class=td_form02>
</c:verbatim>
        <h:inputText styleClass="input" id="A001715" value="#{emp_engageBB.post}" dict="yes" dict_num="PO"  code=""
                readonly="true"    alt="新岗位|1|s|50||"/>
<c:verbatim>
        <input type="button" class="button_post" onclick="selPost();">
        </td>
    </tr>



            <tr><td height=5 colspan=2></td></tr>
            
            <tr>
                <td colspan=2 align="right">
                   <font color=red><strong>注意：入职机构必须选择最底层的部门或班组&nbsp;&nbsp;</strong></font>
 </c:verbatim>
                   <h:selectBooleanCheckbox value="#{emp_engageBB.keepOldTime}"></h:selectBooleanCheckbox>
                   <h:outputText value="保留原入职时间"></h:outputText>
 <c:verbatim>
                </td>
            </tr>
    <tr>
        <td colspan=2 align="right">
 </c:verbatim>
            <h:commandButton id="save" styleClass="button01" value="保存" onclick="return doCheck();" action="#{emp_engageBB.addReEnter}" />
<c:verbatim>
        </td>
    </tr>

        </table>
 </c:verbatim>
    </h:form>
