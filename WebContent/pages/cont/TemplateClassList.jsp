<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript" language="javascript">
    function addTemplate(){
         window.showModalDialog("/cont/TemplateClassEdit.jsf", "", "dialogWidth:350px; dialogHeight:230px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
    function editTemplate(id){
         window.showModalDialog("/cont/TemplateClassEdit.jsf?ID="+id, "", "dialogWidth:350px; dialogHeight:230px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
</script>


<x:saveState value="#{cont_contTemplateClassBB}"/>

<h:form id="form1">
    <h:panelGrid width="100%" border="0" cellspacing="6"  styleClass="td_title" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="合同模板类别列表 " ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>

<h:inputHidden id="init_a" value="#{cont_contTemplateClassBB.init_a}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="800">
     <h:panelGrid  border="0"  cellspacing="4" align="right" columns="4" >
         <h:commandLink id="doQuery" action="#{cont_contTemplateClassBB.queryAll}"></h:commandLink>
         <h:commandButton id="add_button" styleClass="button01" value="增加" onclick="addTemplate();"/>
         <h:commandButton styleClass="button01" value="删除" action="#{cont_contTemplateClassBB.deleteBatch}" onclick="return checkBatchDelete('selected_ids');" />
         <h:commandButton styleClass="button01" value="返回模板管理" action="cont_TemplateList_jsf"/>
     </h:panelGrid>
</h:panelGrid>

<x:dataTable value="#{cont_contTemplateClassBB.bos}" var="list"  rowIndexVar="index" align="center"
                     headerClass="td_top"  id="dateList"
                     rowClasses="td_middle" styleClass="table03" width="80%" border="1">
             <h:column>
                  <c:facet name="header">
                      <c:verbatim escape="false">
                      <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                      </c:verbatim>
                      </c:facet>
                  <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                  <h:outputText value="#{list.templateClassId}"/>
                  <c:verbatim>"></c:verbatim>
              </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="模板类别名称"/></c:facet>
                <h:outputText value="#{list.templateClassName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="创建机构"/></c:facet>
                <h:outputText value="#{list.createOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="修改" styleClass="button01" onclick="editTemplate('#{list.templateClassId}');"></h:commandButton>
            </h:column>
</x:dataTable>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>