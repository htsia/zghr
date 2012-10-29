<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>

    <script type="text/javascript">
        function doCheck(){
           PutTextareaValue(document.all('form1:textarea'),fGetContent());
           if(document.all('form1:name').value==""){
               alert("必须录入标题！");
               return false;
           }
           return true;
        }
        function AddAttech() {
            if (document.all('form1:title').value==null || document.all('form1:title').value==""){
                alert("请输入标题");
                return false;
            }
            if (document.all('form1:excelFile').value==null || document.all('form1:excelFile').value==""){
                alert("请选择文件");
                return false;
            }
            return true;
         }
    </script>

<x:saveState value="#{law_editbb}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="pageInit" value="#{law_editbb.fileInit}"/>
    <h:panelGrid columns="2" align="right" cellspacing="2">
        <h:commandButton styleClass="button01" value="保存" action="#{law_editbb.SaveFile}"
                         onclick="return doCheck();"/>
        <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
    </h:panelGrid>

    <c:verbatim>
        <br><br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td class="td_form01">类别</td>
                <td class="td_form02">
   </c:verbatim>
                    <h:inputHidden value="#{law_editbb.lawfile.typeID}" />
                    <h:inputText readonly="true" id="typeName" value="#{law_editbb.lawfile.typeName}" />
 <c:verbatim>
                </td>

                <td class="td_form01">
 </c:verbatim>
                <h:outputText value="颁布者"/>
 <c:verbatim>
                </td>
                <td class="td_form02">
 </c:verbatim>
                <h:inputText id="authorizer" value="#{law_editbb.lawfile.authorizer}" />
 <c:verbatim>
            </td>
            </tr>

            <tr>
            <td class="td_form01">
</c:verbatim>
            <h:outputText value="名称"/>
 <c:verbatim>
            </td>
            <td colspan="3" class="td_form02">
 </c:verbatim>
            <h:inputText id="name" value="#{law_editbb.lawfile.title}" />
 <c:verbatim>
             </td>
             </tr>

            <tr>
                <td class="td_form01">
 </c:verbatim>
                <h:outputText value="颁布时间"/>
 <c:verbatim>
                </td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText readonly="true" id="publicDate" value="#{law_editbb.lawfile.publicDate}" />
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:publicDate')"/>
 <c:verbatim>
                </td>

                <td class="td_form01"> 开始执行时间</td>
                <td class="td_form02">
 </c:verbatim>
                   <h:inputText readonly="true" id="actDate" value="#{law_editbb.lawfile.actDate}" />
                   <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:actDate')"/>
 <c:verbatim>
                 </td>
            </tr>

            <tr>
            <td class="td_form01">
 </c:verbatim>
            <h:outputText value="文件编号"/>
 <c:verbatim>
            </td>
            <td class="td_form02" colspan="3">
 </c:verbatim>
              <h:inputText id="docno" value="#{law_editbb.lawfile.docno}" />
 <c:verbatim>
            </td>
            </tr>

            <tr>
            <td class="td_form01">
 </c:verbatim>
            <h:outputText value="关键字"/>
 <c:verbatim>
            </td>
            <td class="td_form02" colspan="3">
 </c:verbatim>
            <h:inputText id="keyWords" value="#{law_editbb.lawfile.keyWords}" />
 <c:verbatim>
            </td>
            </tr>

            <tr>
            <td class="td_form01">
 </c:verbatim>
            <h:outputText value="内容"/>
 <c:verbatim>
            </td>
            <td class="td_form02" colspan="3">
 </c:verbatim>
              <h:inputTextarea style="display:none;" id="textarea" rows="18" cols="80" value="#{law_editbb.lawfile.content}" />
 <c:verbatim>
             <script language="javascript">
                 gFrame = 1;//1-在框架中使用编辑器
                 gContentId = "form1:textarea";//要载入内容的content ID
                 OutputEditorLoading();
             </script>
             <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
            </td>
            </tr>

            <tr>
                <td class="td_form01">附件列表</td>
                <td class="td_form02" colspan=3 align="left">
                    <br>
 </c:verbatim>
                    <h:outputText value="标题"></h:outputText>
                    <h:inputText id="title" value="#{law_editbb.title}"/>
                    <x:inputFileUpload id="excelFile" styleClass="input" value="#{law_editbb.excelFile}"  storage="file" size="25" />
                    <h:commandButton   styleClass="button02" value="上传" onclick="return AddAttech();" action="#{law_editbb.uploadFile}"/>
                    <c:verbatim><br></c:verbatim>
                    <c:verbatim><br></c:verbatim>
                    <h:panelGroup>
                    <h:dataTable value="#{law_editbb.attList}" var="list" align="center"   id="dateList"
                                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                                     styleClass="table03" width="98%" >
                            <h:column>
                                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                                <h:outputText value="#{list.index}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                                <h:outputText value="#{list.attTitle}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                                    <h:commandButton value="删除" styleClass="button01"
                                                     action="#{law_editbb.deleteAtt}" onclick="return confirm('确认删除？')">
                                        <x:updateActionListener property="#{law_editbb.index}" value="#{list.index}"/>
                                    </h:commandButton>
                            </h:column>
                        </h:dataTable>
                    </h:panelGroup>
<c:verbatim>
                </td>
            </tr>
        </table>
        <br><br>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
