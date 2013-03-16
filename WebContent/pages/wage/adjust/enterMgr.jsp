<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
%>
<script type="text/javascript">
    function setWageItem(){
        window.showModalDialog("/wage/adjust/OrgEnterEdit.jsf?OrgID=<%=user.getOrgId()%>", null, "dialogWidth:480px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    function showWF(){
        var ID=getFirstSelectValue(form1.chk);
        if (ID!=null && ID!=""){
           showWorkFlowLogByLinkID(ID);
        }
        else{
            alert("请选择人员!");
        }
        return false;
     }
    function enterWageSet(){
        if (!checkMutilSelect(form1.chk)) {
            alert("请选择人员!");
            return false;
        }
        var ids="";
        var obj = document.forms(0).chk ;
        for (i = 0; i < obj.length; i++) {
            if (obj[i].checked) {
                ids += obj[i].value + ",";
            }
        }
        document.getElementById('form1:ids').value=ids;
//         ?PersonID="+ids
        var ret=window.showModalDialog("/wage/adjust/selectWageSet.jsf", null, "dialogWidth:300px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
        if (ret==null || ret==""){
            return false;
        }
        else{
            document.all('form1:setId').value=ret;
            return true;
        }
    }
    function doViewPerson(){
        var ID=getFirstSelectValue(form1.chk);
        if (ID!=null && ID!=""){
            var arg = "id=" + ID;
            window.open("/pages/wage/base/PersonInfoFrame.jsf?" + arg, null, "left=50,top=50,height=600,width=1200,status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
        }
        else{
            alert("请选择人员!");
        }
        return false;
    }
    function doDelete(){
        if (!checkMutilSelect(form1.chk)) {
            alert("请选择人员!");
            return false;
        }
        if(confirm('确定删除吗?')){
	        document.all("form1:ids").value=getAllSelectValue(form1.chk,",");
        	return true;
        }
        return false;
    }
</script>

  <x:saveState value="#{wage_enterPersonSetBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{wage_enterPersonSetBB.listEnterPerson}"/>

  <f:verbatim>
  <table width="98%" height="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title" height=8>
   </f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{wage_enterPersonSetBB.unitName}入职定级"/>
<f:verbatim>
        </td>
        
        <td class="td_title" align="right"  height=8>
</f:verbatim>
            <h:outputText value="处理日期："/>
            <h:inputText id="inputDate" readonly="true" size="15" value="#{wage_enterPersonSetBB.inputDate}" styleClass="input Wdate" onclick="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',el:'form1:inputDate'})"  onkeypress ="enterKeyDown('form1:queryPerson')"/>
            <h:commandButton id="queryPerson" value="查询" styleClass="button01" action="#{wage_enterPersonSetBB.queryEnter}"/>
            <h:outputText value="  "/>
            <h:commandButton value="修改薪资信息" styleClass="button01" type="button" onclick="doViewPerson();"/>
            <h:inputHidden id="ids" value="#{wage_enterPersonSetBB.ids}"/>
            <h:commandButton value="加入帐套" styleClass="button01" onclick="return enterWageSet();" action="#{wage_enterPersonSetBB.saveEnter}"/>
            <h:inputHidden id="setId" value="#{wage_enterPersonSetBB.setId}"/>
<f:verbatim>
        </td>
    </tr>
     <tr><td colspan="2" height=8></td></tr>
     <tr><td colspan="2">
         <jsp:include page="/pages/common/activepage/ActiveList.jsp">
             <jsp:param name="hasOperSign" value="true"/>
             <jsp:param name="operSignType" value="checkbox"/>
             <jsp:param name="hasEdit" value="true"/>
             <jsp:param name="isEditList" value="false"/>
             <jsp:param name="isCheckRight" value="false"/>
         </jsp:include>
     </td>
     </tr>
  </table>
</f:verbatim>       
</h:form>
