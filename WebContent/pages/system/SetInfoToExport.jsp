<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <c:verbatim><base target="_self"></c:verbatim>
    <script language="javascript">
       function DoSelectAll(isSelect){
            var size = document.all('form1:inputField').length;
            for (var i = 0; i < size; i++) {
                document.all('form1:inputField')[i].checked=isSelect;
            }
        }
    </script>
<x:saveState value="#{sys_infoSetListBB}"/>
<h:form id="form1">
    <h:panelGrid columns="1" width="95%" styleClass="table03" align="center" columnClasses="td_top,td_top">
         <f:verbatim>
           <strong>
               <%=LanguageSupport.getResource("XTGL-1170","选择导出项")%>： 
           </strong>
         </f:verbatim>
        <h:selectManyCheckbox value="#{sys_infoSetListBB.exportField}" layout="pageDirection" id="inputField">
            <c:selectItems value="#{sys_infoSetListBB.exportSetList}"/>
        </h:selectManyCheckbox>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="4" cellspacing="3" align="right">
        <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
        <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
        <h:commandButton styleClass="button01" value="确认"  action="#{sys_infoSetListBB.createInfoFile}"
                         onclick="if(!checkMutilSelect(form1.all('form1:inputField'))){alert('请选择输入项');return false;}else{return true;}"/>
        <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
    </h:panelGrid>
</h:form>
