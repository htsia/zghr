<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.api.UserAPI"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ include file="../include/taglib.jsp" %>

<%
    String vis = "hidden";
    String hideSave = "Y";
    User user = (User) session.getAttribute(Constants.USER_INFO);
    UserAPI api = (UserAPI) SysContext.getBean("user_pmsAPI");
    String publicFlag=request.getParameter("publicFlag");
    if (publicFlag!=null){
        session.setAttribute("publicFlag",publicFlag);
    }
    else{
        publicFlag=(String)session.getAttribute("publicFlag");
    }

    if("PRIVATE".equals(publicFlag) || (api.checkIsHQUser(user) && user.isSysOper() && "PUBLIC".equals(request.getParameter("publicFlag")))){
        vis = "visible";
        hideSave="";
    }
    String operFlag=request.getParameter("operFlag");
    if  (operFlag==null){
        operFlag="1";
    }

    session.setAttribute("CONTRAL_SAVE",hideSave);
%>
<c:verbatim>
<base id="dbase" target="_parent">
</c:verbatim>
<script type="text/javascript">
    function forNew(){
        parent.location="/qry/QueryOrgSetting.jsf?operFlag=<%=operFlag%>&resetFlag=Y&classId=<%=CommonFuns.filterNull(request.getParameter("classId"))%>&qsType=<%=CommonFuns.filterNull(request.getParameter("qsType"))%>&setType=<%=CommonFuns.filterNull(request.getParameter("setType"))%>&unitType=<%=CommonFuns.filterNull(request.getParameter("unitType"))%>"
    }
    function forEdit(qryId){
        parent.location="/qry/QueryOrgSetting.jsf?operFlag=<%=operFlag%>&resetFlag=Y&classId=<%=CommonFuns.filterNull(request.getParameter("classId"))%>&qsType=<%=CommonFuns.filterNull(request.getParameter("qsType"))%>&setType=<%=CommonFuns.filterNull(request.getParameter("setType"))%>&qryId=" + qryId;
    }
    function forQuery(){
        pos= event.srcElement.parentElement.parentElement.rowIndex;
        rowcount = event.srcElement.parentElement.parentElement.parentElement.parentElement.rows.length;
        if(rowcount ==2){
            document.all("qryId").value = document.all("qryIds").value;
            return true;
        }else{
            document.all("qryId").value = document.all("qryIds")[pos-1].value;
            return true;
        }
    }
    function del(){
        rt = confirm('是否要删除');
        if(rt)
            document.all("dbase").target="_self";
        return rt;
    }
    function fordel(qryID){
        if(confirm('确定要删除吗')){
        	document.getElementById("qryID").value=qryID;
            document.all("dbase").target="_self";
	        return true;
        }
        return false;
    }
</script>


<x:saveState value="#{qry_queryBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{qry_queryBB.pageInit}"/>
<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr><td height=10></td></tr>
    <input type="hidden" id="qryID" name="ids"/>
    <tr><td align="right">
        <span>
</c:verbatim>
            <h:commandButton type="button" value="新建" styleClass="button01" onclick="forNew()" rendered="#{qry_queryBB.hasSRight}"/>
<c:verbatim>
        </span>
    </td></tr>
    </table>
	<br>
    
</c:verbatim>
    <h:dataTable var="list" id="dateList" value="#{qry_queryBB.queryBo}" headerClass="td_top" rowClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center" styleClass="table03" width="95%" border="1" align="center">
        <h:column>
            <c:facet name="header"><h:outputText value="名称"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建人"/></c:facet>
            <h:outputText value="#{list.createUser}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton id="doQuery" action="#{qry_staticSettingBB.doQuery}" onclick="return forQuery()" styleClass="button01" value="统计"/>
            <h:outputText value="  "/>
            <h:commandButton rendered="#{qry_queryBB.hasSRight}" onclick="return forEdit('#{list.qryId}');" styleClass="button01" type="button" value="修改" />
            <h:commandButton rendered="#{qry_queryBB.hasSRight}" action="#{qry_querySettingBB.deleteQuery}" onclick="return fordel('#{list.qryId}');" styleClass="button01" value="删除"/>
        </h:column>
    </h:dataTable>
<c:verbatim>
    <input type="hidden" name="qsType" value="<%=CommonFuns.filterNull(request.getParameter("qsType"))%>">
    <input type="hidden" name="setType" value="<%=CommonFuns.filterNull(request.getParameter("setType"))%>">
    <input type="hidden" name="classId" value="<%=CommonFuns.filterNull(request.getParameter("classId"))%>">
    <input type="hidden" name="flag" value="staticlist">
    <input type="hidden" name="qryId" value="">
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
