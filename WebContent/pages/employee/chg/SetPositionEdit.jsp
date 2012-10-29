<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function changeStatus(){
            if (form1.all("form1:status").value=="0"){
                form1.all("form1:idOK").value = "审批不通过";
            }
            else{
                form1.all("form1:idOK").value = "审批通过";
            }
        }
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }

            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var perID = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            perID = form1.chk[i].value;   // 取第一个
                            break;
                        }
                } else
                    perID = form1.chk.value;
                var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
                window.open(url);
            } else {
                alert("请选择人员");
            }
           return false;
       }
    </script>
</head>

<body>
<x:saveState value="#{emp_PersonChgListBB}"/>
<h:form id="form1">
    <h:inputHidden id="fromOrgEdit" value="#{emp_PersonChgListBB.setPosition}"/>
    <h:inputHidden id="chgId" value="#{emp_PersonChgListBB.personchangevo.chgId}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
          <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-2179", " 调配管理")%>->
                  <%=LanguageSupport.getResource("RYGL-2217", " 设定拟任部门和岗位")%>
          </f:verbatim>
       </h:panelGroup>
    </h:panelGrid>
    <br>
    <h:panelGrid columns="2"  align="center" width="60%" columnClasses="td_form01,td_form02" styleClass="table03">
        <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-1016", "姓名")%>
          </f:verbatim>
        <h:outputText value="#{emp_PersonChgListBB.personchangevo.name}"/>
        
          <f:verbatim>
                  <%=LanguageSupport.getResource("YGL-2218", "接收部门")%>
          </f:verbatim>
        <h:panelGroup>
            <h:inputText styleClass="input" id="dept" value="#{emp_PersonChgListBB.personchangevo.toDepId}" dict="yes" dict_num="OU"  code=""
                    readonly="true"    alt="调入部门|1|s|50||"/>
            <c:verbatim>
            <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:dept',2,'<% User user = (User) session.getAttribute(Constants.USER_INFO);out.print(user.getOrgId());%>')">
            </c:verbatim>
        </h:panelGroup>

         <f:verbatim>
                  <%=LanguageSupport.getResource("RYGL-2219", "拟任岗位")%>
          </f:verbatim>
        <h:panelGroup>
        <h:inputText styleClass="input" id="job" code="" dict="yes" dict_num="3006"
                     readonly="true" value="#{emp_PersonChgListBB.personchangevo.toPostId}"
                     alt="拟任岗位|1|s|50||"/>
            <c:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:job')">
            </c:verbatim>
         </h:panelGroup>

         <f:verbatim>
                  <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
          </f:verbatim>
        <h:panelGroup>
            <h:commandButton id="idOK" value="确定" onclick="return forsubmit(document.forms(0));" action="#{emp_PersonChgListBB.saveSetPosition}" styleClass="button01" >
            </h:commandButton>
            <h:commandButton id="idCancel" value="返回" onclick="window.close()" styleClass="button01" >
            </h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
</body>
</html>