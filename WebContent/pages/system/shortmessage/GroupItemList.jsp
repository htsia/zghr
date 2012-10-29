<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function personSort(){
            window.showModalDialog("/system/PersonSort.jsf?bookID="+document.all("form1:bookID").value, null, "dialogWidth:330px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doDelete(){
           if (confirm("确定要删除吗?")){
                if (checkMutilSelect(form1.chk)) {
                    count = form1.chk.length;
                    var str = "";
                    if (count != null) {
                        var num = 0;
                        for (i = 0; i < count; i++)
                            if (form1.chk[i].checked) {
                                str += form1.chk[i].value + ",";
                                num++;
                            }
                        if (num > <%=Constants.ACTIVE_PAGE_SIZE%>) {
                            alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                            return false;
                        }
                    } else
                        str = form1.chk.value;
                    //alert(str);
                    document.all("form1:deletePerson").value=str;
                    return true;
                } else {
                    alert("请选择人员!");
                    return false;
                }
          }
          else{
              return false;
          }
        }
    </script>

<x:saveState value="#{sys_smGroupitemBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_smGroupitemBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="groupID" value="#{sys_smGroupitemBB.groupID}"></h:inputHidden>
    <h:inputHidden value="#{sys_smGroupitemBB.groupName}"></h:inputHidden>
    <h:inputHidden id="deletePerson" value=""/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1361", "管理群数据 ")%>->
			</f:verbatim>
            
            <h:outputText value="#{sys_smGroupitemBB.groupName}"/>
        </h:panelGroup>

        <h:panelGrid align="right" columns="1" cellspacing="2" width="30%">
            <h:commandButton styleClass="button01" type="button" value="返回" onclick="window.close();" />
        </h:panelGrid>
    </h:panelGrid>

    <h:panelGrid columns="2" width="95%">
        <h:panelGroup>
             <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1362", "输入人员姓名或编号 ")%>:
			</f:verbatim>
            <h:inputText value="#{sys_smGroupitemBB.name}"></h:inputText>
            <h:commandButton styleClass="button01" value="查询" action="#{sys_smGroupitemBB.queryAdd}"></h:commandButton>
        </h:panelGroup>

        <h:panelGrid align="right">
            <h:panelGroup>
                <h:inputHidden id="recID" value="#{sys_smGroupitemBB.personID}"></h:inputHidden>
                <h:inputHidden id="recName" value="#{sys_smGroupitemBB.personName}"/>
                <h:commandButton  styleClass="button01" value="新增" action="#{sys_smGroupitemBB.addPerson}" onclick="return fPopUpPerDlg('form1:recName', 'form1:recID', '','0');"></h:commandButton>
                <h:commandButton  styleClass="button01" value="删除" action="#{sys_smGroupitemBB.deletePerson}" onclick="doDelete();"> </h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>
    <c:verbatim><br>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
    </jsp:include>
    </c:verbatim>
</h:form>
