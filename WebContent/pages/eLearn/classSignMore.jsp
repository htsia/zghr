<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<script language="javascript">
function doSignClass(id){
    window.showModalDialog("/eLearn/selfClassSign.jsf?ClassID="+id, null, "dialogWidth:500px; dialogHeight:550px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
</script>
<c:verbatim><base target="_self"></c:verbatim>
<x:saveState id="eLearn_upFileBB" value="#{eLearn_upFileBB}" />
<h:form id="form1" enctype="multipart/form-data" >
  <h:panelGrid columns="1"  width="98%" align="center">
    <h:panelGrid columns="1"  styleClass="td_title" width="100%" cellpadding="4" align="center" border="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="网上报名"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:dataTable value="#{eLearn_courcebb.classMoreList}" var="filelist"  id="dateList"
                 headerClass="td_top" width="100%" columnClasses="td_middle_center" align="center" border="1" styleClass="table03" >
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="名称" />
                        </f:facet>
                        <h:outputText value="#{filelist.className}" escape="false"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="目标" />
                        </f:facet>
                        <h:outputText value="#{filelist.classAid}" escape="false"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="说明" />
                        </f:facet>
                        <h:outputText value="#{filelist.classDesc}" />
                    </h:column>

                    <h:column>
                    <f:facet name="header">
                        <h:outputText value="操 作" style="width:50px"/>
                    </f:facet>
                        <h:commandButton value="报名" styleClass="button01" type="button" onclick="doSignClass('#{filelist.classID}')"></h:commandButton>
                    </h:column>
    </h:dataTable>
	
    </h:panelGrid>

</h:form>

<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>