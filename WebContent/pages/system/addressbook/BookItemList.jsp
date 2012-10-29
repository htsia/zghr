<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function personSort(){
            window.showModalDialog("/system/PersonSort.jsf?bookID="+document.all("form1:bookID").value, null, "dialogWidth:330px; dialogHeight:450px;center:center;resizable:no;status:no;scroll:yes;");
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

<x:saveState value="#{sys_AddressBookItemBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_AddressBookItemBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="bookID" value="#{sys_AddressBookItemBB.bookID}"></h:inputHidden>
    <h:inputHidden value="#{sys_AddressBookItemBB.bookName}"></h:inputHidden>
    <h:inputHidden id="deletePerson" value=""/>
    <c:verbatim>
    <table width=98% height=96%>
       <tr><td height=1 class=td_title>
</c:verbatim>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-0900"," 系统管理 ")%>->
                     <%=LanguageSupport.getResource("XTGL-1288","显示通讯录 ")%> ->
             </f:verbatim>
            <h:outputText value="#{sys_AddressBookItemBB.bookName}"/>
<c:verbatim>
      </td></tr>

      <tr><td height=1 align=right>
 </c:verbatim>
              <f:verbatim>
                     <%=LanguageSupport.getResource("XTGL-1289"," 输入人员姓名或编号")%> ：
             </f:verbatim>
            <h:inputText value="#{sys_AddressBookItemBB.name}"></h:inputText>
            <h:commandButton value="查询" styleClass="button01" action="#{sys_AddressBookItemBB.queryAdd}"></h:commandButton>
            <h:inputHidden id="recID" value="#{sys_AddressBookItemBB.personID}"></h:inputHidden>
            <h:inputHidden id="recName" value="#{sys_AddressBookItemBB.personName}"/>
            <h:commandButton  styleClass="button01" value="修改排序"  onclick="return personSort();"></h:commandButton>
            <h:commandButton  styleClass="button01" value="新增" action="#{sys_AddressBookItemBB.addPerson}" onclick="return fPopUpMutiPerDlg('form1:recName', 'form1:recID', '','0');"></h:commandButton>
            <h:commandButton  styleClass="button01" value="删除" action="#{sys_AddressBookItemBB.deletePerson}" onclick="doDelete();"> </h:commandButton>
            <h:commandButton styleClass="button01" type="button" value="返回" onclick="window.close();" />
<c:verbatim>
    </td></tr>

     <tr><td >
       <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
        </jsp:include>
     </td></tr>
    </table>
</c:verbatim>
</h:form>
