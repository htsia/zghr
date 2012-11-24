<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
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

    function doRemove(){
        if (!checkMutilSelect(form1.chk)) {
            alert("请选择人员!");
            return false;
        }
        if(confirm('确定移出帐套吗?')){
	        document.all("form1:ids").value=getAllSelectValue(form1.chk,",");
        	return true;
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
    function doViewPerson(){
        var ID=getFirstSelectValue(form1.chk);
        if (ID!=null && ID!=""){
           forModifyPersonDetail(ID.split("-")[1]);
        }
        else{
            alert("请选择人员!");
        }
        return false;
    }
</script>

  <x:saveState value="#{wage_exitPersonSetBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{wage_exitPersonSetBB.listExitPerson}"/>

  <f:verbatim>
  <table width="98%" height="98%" border="0" cellpadding="0" cellspacing="0" align="center">
    <tr>
        <td class="td_title" height=8>
   </f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="#{wage_exitPersonSetBB.unitName}人员增减变化情况"/>
<f:verbatim>
        </td>
        
        <td class="td_title" align="right"  height=8>
</f:verbatim>
            <h:outputText value="处理日期:"/>
            <h:inputText  id="inputDate" readonly="true" size="15" value="#{wage_exitPersonSetBB.inputDate}" styleClass="input Wdate" onclick="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',el:'form1:inputDate'})" onkeypress ="enterKeyDown('form1:queryPerson')"/>
            <h:commandButton id="queryPerson" value="查询" styleClass="button01" action="#{wage_exitPersonSetBB.queryExit}"/>
            <h:outputText value="  "/>
            <h:commandButton value="查看人员信息" styleClass="button01" type="button" onclick="doViewPerson();"/>
            <h:outputText value="  "/>
            <h:inputHidden id="ids" value="#{wage_exitPersonSetBB.ids}"/>
            <h:commandButton value="移出账套" styleClass="button01" action="#{wage_exitPersonSetBB.removeFromSet}" onclick="return doRemove();"/>
            <h:commandButton value="删除" styleClass="button01" action="#{wage_exitPersonSetBB.delete}" onclick="return doDelete();"/>
            <h:outputText value="  "/>
            <h:commandButton value="导出" styleClass="button01" type="button" onclick="doExport();"/>
<f:verbatim>
        </td>
    </tr>
     <tr><td colspan="2" height=8></td></tr>
     <tr><td colspan="2">
         <jsp:include page="/pages/common/activepage/ActiveList.jsp">
             <jsp:param name="hasOperSign" value="true"/>
             <jsp:param name="operSignType" value="checkbox"/>
             <jsp:param name="hasEdit" value="false"/>
             <jsp:param name="isEditList" value="false"/>
             <jsp:param name="isCheckRight" value="false"/>
         </jsp:include>
     </td>
     </tr>
  </table>
</f:verbatim>       
</h:form>
