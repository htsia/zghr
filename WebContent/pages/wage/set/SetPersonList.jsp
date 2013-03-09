<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.wage.service.WageSetService"%>
<%@ page import="com.hr319wg.wage.pojo.bo.WageSetBO"%>
<%@ page import="com.hr319wg.common.exception.SysException"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.wage.web.WageSetPersonBackingBean"%>

<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    WageSetService setSrc=null;
    String flowFlag= Constants.YES;
    try {
        setSrc = (WageSetService) SysContext.getBean("wage_SetService");
        String setId=((WageSetPersonBackingBean)request.getAttribute("wage_setPersonBB")).getSetId();
        WageSetBO set=setSrc.findSetBySetId(setId);
        flowFlag =set.getFlowFlag();
    } catch (SysException e) {
        e.printStackTrace(); 
    }
%>

<script type="text/javascript">
    var flowFlag='<%=flowFlag%>';
    function forCopyPerson(){
        reval=window.showModalDialog("/wage/set/SetWageSet.jsf?UnitID="+document.all('form1:unitId').value+"&SetID="+document.all('form1:setId').value, null, "dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:yes;scroll:yes;");
        if (reval != null && reval!="") {
            form1.all("form1:personStr").value = reval;
            return true;
        } else {
            return false;
        }
    }

    function doQueryManyPerson(){
        var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval !="") {
            document.all('form1:ManyPerson').value = reval;
            return true;
        } else {
            return false;
        }
    }

    function forQueryPerson() {
        var setName = form1.all("form1:setName").value;
        var unitId = form1.all("form1:unitId").value;
        var setId= form1.all("form1:setId").value;
        var arg = "setID="+setId+"&setName=" + setName + "&unitId=" + unitId;
        reval = window.showModalDialog("/wage/set/SetPersonQuery.jsf?flowFlag="+flowFlag+"&act=initSetPers&" + arg, null, "dialogWidth:1000px; dialogHeight:650px;center:center;resizable:yes;status:yes;scroll:no;");
        if (reval != null) {
            form1.all("form1:personStr").value = reval;
            return true;
        } else {
            return false;
        }
    }
    function confirmDel() {
        if (checkMutilSelect(form1.chk)) {
            if (confirm('确定要移出吗？')){
                return true;
            }else{
                return false;
            }
        }else{
            alert('请选择人员');
            return false;
        }
    }
    function forExport() {
        window.open('/pages/common/ExportToExcel.jsp?sessionKey=setPersonTableVO');
    }
    function queryPersonChange(){
       window.showModalDialog("/wage/payoff/showPersonChange.jsf?setId=" + form1.all("form1:setId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
    }
</script>

<x:saveState value="#{wage_setPersonBB}"/>
<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setPersonBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_setPersonBB.setId}"/>
    <h:inputHidden id="setName" value="#{wage_setPersonBB.setName}"/>
    <h:inputHidden id="unitId" value="#{wage_setPersonBB.unitId}"/>
    <h:inputHidden id="personStr" value="#{wage_setPersonBB.personStr}"/>
    <h:inputHidden id="ManyPerson" value="#{wage_setPersonBB.manyPerson}"/>
    <c:verbatim>
    <table height=98% width=100%>
    <tr>
        <td height=1 align="left">
    </c:verbatim>
           <h:outputText escape="false" value="<strong>账套名称：</strong>#{wage_setPersonBB.setName}"/>
<c:verbatim>
        </td>
   </tr>
    <tr>
        <td height=1 align="right">
</c:verbatim>
            <h:outputText escape="false" value="<strong>姓名或员工编号：</strong>"></h:outputText>
            <h:inputText id="name" value="#{wage_setPersonBB.name}"  size="10" styleClass="input" />
            <h:commandButton value="查询" id="queryPerson"  styleClass="button01"   action="#{wage_setPersonBB.queryPerson}"/>
            <h:commandButton value="多人查询" action="#{wage_setPersonBB.queryMultiPerson}" onclick="doQueryManyPerson();" styleClass="button01"/>
            <h:commandButton styleClass="button01" value="自定义查询"
                             action="#{wage_setPersonBB.queryAdvance}"
                             onclick="return doAdvanceQuery('A','ORG','011','Y','TABLEOBJECT','','N','140','Y')"/>
           <h:commandButton value="人事关系已转出" styleClass="button01" action="#{wage_setPersonBB.queryTransPerson}" rendered="#{wage_setPersonBB.queryTrans}"></h:commandButton>
            <h:commandButton onclick="queryPersonChange();" value="查询人员变化" type="button" styleClass="button01"/>
            <h:commandButton styleClass="button01" value="复制人员" rendered="#{wage_setPersonBB.copyPerson}"
                             action="#{wage_setPersonBB.saveCopyPerson}" onclick="return forCopyPerson()"/>
            <h:commandButton styleClass="button01" value="增加" rendered="#{wage_setPersonBB.operRight}"
                             action="#{wage_setPersonBB.save}" onclick="return forQueryPerson()"/>
            <h:commandButton styleClass="button01" value="移出" rendered="#{wage_setPersonBB.operRight}"
                             action="#{wage_setPersonBB.delete}"
                             onclick="return confirmDel();"/>
            <h:commandButton styleClass="button01" value="返回" action="#{wage_setBB.list}">
                <x:updateActionListener property="#{wage_setBB.wageset.unitId}" value="#{wage_setPersonBB.unitId}"/>
            </h:commandButton>
            <h:commandButton value="导出" type="button" onclick="forExport();" styleClass="button01"/>
<c:verbatim>
        </td>
    </tr>
    <tr><td colspan=2>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="false"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="false"/>
            <jsp:param name="target" value="setPersonTableVO"/>
            <jsp:param name="maskWarn" value="true"/>
        </jsp:include>
    </td></tr>
    </table>
</c:verbatim>
</h:form>
