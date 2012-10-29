<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contTemplateBB}"/>

<script type="text/javascript" language="javascript">
    var popUpWin=0;
    function popUpWindow( left, top, width, height){
      if(popUpWin){
        if(!popUpWin.closed) popUpWin.close();
      }
      popUpWin = open('/pages/cont/TemplateItemView.jsf', 'popUpWin', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+', top='+top+',screenX='+left+',screenY='+top+'');
      return false;
    }
    function viewTemplate(id){
         window.open('/pages/cont/Download.jsp?attachmentId='+id, 'popUpWin', 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
    }
    function addTemplate(){
         window.showModalDialog("/cont/TemplateEdit.jsf", "", "dialogWidth:430px; dialogHeight:350px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
    function editTemplate(id){
         window.showModalDialog("/cont/TemplateEdit.jsf?ID="+id, "", "dialogWidth:430px; dialogHeight:350px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
</script>

<h:form id="form1">
    <h:panelGrid width="100%" styleClass="td_title" border="0" cellspacing="0" cellpadding="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="合同模板列表 " ></h:outputText>
        </h:panelGroup>
    </h:panelGrid>
    
    <h:inputHidden id="init_a" value="#{cont_contTemplateBB.init_a}"/>
<h:panelGrid  border="0"  align="center" columns="1" width="95%">
    <h:panelGrid  border="0"  cellspacing="4" align="right" columns="5" >
        <h:commandLink id="doQuery" action="#{cont_contTemplateBB.queryAll}"></h:commandLink>
        <h:commandButton styleClass="button01" value="模板类别管理" action="cont_TemplateClassList_jsf"/>
        <h:commandButton styleClass="button01" value="查看模板指标项" onclick="javascript:return popUpWindow(100,50,400,600);"/>
        <h:commandButton id="add_button" styleClass="button01" value=" 增加 " onclick="addTemplate();"/>
        <h:commandButton styleClass="button01" value="删除 " action="#{cont_contTemplateBB.deleteBatch}" onclick="return checkBatchDelete('selected_ids');" />
    </h:panelGrid>
</h:panelGrid>


<x:dataTable value="#{cont_contTemplateBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"   id="dateList"  align="center"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">
             <h:column>
                  <c:facet name="header">
                      <c:verbatim escape="false">
                      <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                      </c:verbatim>
                      </c:facet>
                  <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                  <h:outputText value="#{list.templateId}"/>
                  <h:outputText value=","/>
                  <h:outputText value="#{list.attachmentId}"/>
                  <c:verbatim>"></c:verbatim>
              </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="模板名称"/></c:facet>
                <h:outputText value="#{list.templateName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="模板类别名称"/></c:facet>
                <h:outputText value="#{list.contTemplateClassBO.templateClassName}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="版本"/></c:facet>
                <h:outputText value="#{list.templateEdition}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="模板类型"/></c:facet>
                <h:outputText value="#{list.templateType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="最后更新时间"/></c:facet>
                <h:outputText value="#{list.lastCreateDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton styleClass="button01" value="模板文件" onclick="viewTemplate('#{list.attachmentId}')" ></h:commandButton>
                <h:outputText value="  "/>
                <h:commandButton styleClass="button01" onclick="editTemplate('#{list.templateId}')" id="bnt1" value="修改"></h:commandButton>
            </h:column>
</x:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>