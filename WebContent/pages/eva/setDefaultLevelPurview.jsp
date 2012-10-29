<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function addlevelPurview(){
      	window.showModalDialog("/eva/addDefaultLevelPruview.jsf?method=add&planid="+document.all('form1:planID').value, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
      	return true;
    }
    function modifylevelPurview(id){
    	window.showModalDialog("/eva/addDefaultLevelPruview.jsf?method=modify&levelId="+id, null, "dialogWidth:500px; dialogHeight:350px;center:center;resizable:yes;status:no;scroll:yes;");
      	return true;
    }
</script>
<x:saveState value="#{eva_objectBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{eva_objectBB.initDefaultLevelPurview}"></h:inputHidden>
    <h:inputHidden id="planID" value="#{eva_objectBB.planId}"></h:inputHidden>
   <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td height=8>
        </td></tr>

        <tr><td height=8 align="left">
    </c:verbatim>
            <h:outputText value="计划:#{eva_objectBB.planName}"></h:outputText>
    <c:verbatim>
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
           <h:commandButton value="增加" styleClass="button01" onclick="return addlevelPurview();"></h:commandButton>
           <h:commandButton value="关闭" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id="datatable">
    </c:verbatim>
        <h:dataTable value="#{eva_objectBB.defaultPurviewList}" var="list" width="100%" id="dateList"
                        styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                    
				<h:column>
                      <f:facet name="header">
                          <h:outputText value="考核层次类型"/>
                      </f:facet>
                     <h:outputText escape="false" value="#{list.masterType}"/>
                </h:column>
		       <h:column>
                <f:facet name="header">
                    <h:outputText value="权重(%)"/>
                </f:facet>
                <h:outputText escape="false" value="#{list.purview}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="操作"/>
                </f:facet>
                <h:commandButton value="修改" onclick="return modifylevelPurview('#{list.levelId}')" styleClass="button01"></h:commandButton>
                <h:commandButton value="删除" styleClass="button01" action="#{eva_objectBB.deleteDefaultLevalPurview}">
                     <x:updateActionListener property="#{eva_objectBB.levelId}" value="#{list.levelId}"/>
                </h:commandButton>
            </h:column>

            </h:dataTable>
    <c:verbatim>
        </div>
        </td></tr>
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
