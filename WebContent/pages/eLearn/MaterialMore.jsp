<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<x:saveState id="eLearn_upFileBB" value="#{eLearn_upFileBB}" />
<h:form id="form1" enctype="multipart/form-data" >
  <h:panelGrid columns="1"  width="98%" align="center">
    <h:panelGrid columns="1"  styleClass="td_title" width="100%" cellpadding="4" align="center" border="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="ѧϰ����"/>
        </h:panelGroup>
    </h:panelGrid>

    <h:dataTable value="#{eLearn_upFileBB.listweb}" var="filelist"  id="dateList"
                 headerClass="td_top" width="100%" columnClasses="td_middle_center" align="center" border="1" styleClass="table03" >
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ļ���" />
                        </f:facet>
                        <h:outputText value="#{filelist.filename}" escape="false"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�� ��" />
                        </f:facet>
                        <h:outputText value="#{filelist.describe}" escape="false"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="�ļ���С" />
                        </f:facet>
                        <h:outputText value="#{filelist.filesize}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="����ʱ��" />
                        </f:facet>
                        <h:outputText value="#{filelist.datetime}" />
                    </h:column>

                    <h:column>
                    <f:facet name="header">
                        <h:outputText value="�� ��" style="width:50px"/>
                    </f:facet>
                    <f:verbatim><a target="_blank" href="</f:verbatim><h:outputText value="#{filelist.relativepath}"/><f:verbatim>">����</a></f:verbatim>

                    </h:column>
    </h:dataTable>
	
    </h:panelGrid>

</h:form>

<script type="text/javascript">
    setDataTableOver("form1:dateList");
   function showUpFilePopDialog() {
        var sFeature="dialogWidth:400px;dialogHeight:250px;Status:0;resizable:true;help:0";
        var url="/eLearn/UpFilePop.jsf";
        var result=window.showModalDialog(url,window,sFeature);
	}
</script>