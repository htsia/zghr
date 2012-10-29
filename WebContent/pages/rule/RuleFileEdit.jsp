<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<c:verbatim>
    <base target="_self">
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
            if (document.all('form1:title').value==null){
                alert("请输入标题");
                return false;
            }
            if (document.all('form1:excelFile').value==null){
                alert("请选择文件");
                return false;
            }
            return true;
         }
    </script>

<x:saveState value="#{rule_editbb}"/>
<h:form id="form1" enctype="multipart/form-data">
       <h:inputHidden id="pageInit" value="#{rule_editbb.fileInit}"/>
       <c:verbatim>
               <table width="98%">
                  <tr><td align="right">
       </c:verbatim>
                   <h:panelGroup>
                       <h:commandButton styleClass="button01" value="保存" action="#{rule_editbb.SaveFile}"
                                        onclick="return doCheck();"/>
                       <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
                     </h:panelGroup>
       <c:verbatim>
                  </td>
                  </tr>
               </table>
       </c:verbatim>

       <c:verbatim>
        <br>
        <table  width="98%"  align="center" Class="table03">
            <tr>
                <td class="td_form01">类别</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputHidden value="#{rule_editbb.rulefile.typeID}" />
                    <h:inputText readonly="true" id="typeName" value="#{rule_editbb.rulefile.typeName}" />
<c:verbatim>
                </td>

                <td class="td_form01">适用范围</td>
                <td class="td_form02" >
</c:verbatim>
                    <h:panelGroup>
                        <h:selectOneMenu id="orgID" value="#{rule_editbb.rulefile.publicOrg}">
                            <c:selectItems value="#{rule_editbb.orgList}"></c:selectItems>
                        </h:selectOneMenu>
                    </h:panelGroup>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">名称</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText id="name" value="#{rule_editbb.rulefile.title}" />
<c:verbatim>
            </td>
            </tr>

            <tr>
            <td class="td_form01">颁布者</td>
            <td class="td_form02">
</c:verbatim>
              <h:inputText id="authorizer" value="#{rule_editbb.rulefile.authorizer}" />
<c:verbatim>
            </td>

            <td class="td_form01">颁布时间</td>
            <td class="td_form02">
 </c:verbatim>
                <h:inputText readonly="true" id="publicDate" value="#{rule_editbb.rulefile.publicDate}" />
                <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:publicDate')"/>
<c:verbatim>
            </td>
            </tr>

            <tr>
            <td class="td_form01">开始执行时间</td>
            <td class="td_form02">
 </c:verbatim>
               <h:inputText readonly="true" id="actDate" value="#{rule_editbb.rulefile.actDate}" />
               <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:actDate')"/>
<c:verbatim>
             </td>
            <td class="td_form01">文件编号</td>
            <td class="td_form02">
</c:verbatim>
             <h:inputText id="docno" value="#{rule_editbb.rulefile.docno}" />
<c:verbatim>
            </td>
             </tr>

            <tr>
            <td class="td_form01">关键字</td>
            <td class="td_form02" colspan="3">
</c:verbatim>
            <h:inputText id="keyWords" value="#{rule_editbb.rulefile.keyWords}" />
<c:verbatim>
            </td>
            </tr>

            <tr>
            <td class="td_form01">内容</td>
            <td class="td_form02" colspan="3">
</c:verbatim>
            <h:inputTextarea style="display:none;" id="textarea" rows="18" cols="80" value="#{rule_editbb.rulefile.content}" />
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
                <td class="td_form02" colspan=3 align="right">
                    <br>
</c:verbatim>
                    <h:outputText value="标题"></h:outputText>
                    <h:inputText id="title" value="#{rule_editbb.title}"/>
                    <x:inputFileUpload id="excelFile" styleClass="input" value="#{rule_editbb.excelFile}"  storage="file" size="25" />
                    <h:commandButton   styleClass="button02" value="上传" onclick="return AddAttech();" action="#{rule_editbb.uploadFile}"/>
                    <c:verbatim><br><br></c:verbatim>
                    <h:panelGroup>
                    <h:dataTable value="#{rule_editbb.attList}" var="list" align="center"
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
                                                     action="#{rule_editbb.deleteAtt}" onclick="return confirm('确认删除？')">
                                        <x:updateActionListener property="#{rule_editbb.index}" value="#{list.index}"/>
                                    </h:commandButton>
                            </h:column>
                        </h:dataTable>
                    </h:panelGroup>
<c:verbatim>
                </td>
            </tr>            
        </table>
        <br>
</c:verbatim>
</h:form>
