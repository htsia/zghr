<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
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
    function AddAttech() {
        if (document.all('form1:title').value==null){
            alert("���������");
            return false;
        }
        if (document.all('form1:excelFile').value==null){
            alert("��ѡ���ļ�");
            return false;
        }
        return true;
     }
    function forCheck() {
        // ��Чʱ��
        if (document.all('form1:text3').value==null || document.all('form1:text3').value=="") {
            alert("��¼����Чʱ��!");
            return false;
        }
        return true;
    }
    function forSave() {
        PutTextareaValue(document.all('form1:textarea'),fGetContent());
        if (forCheck()) {
            return forsubmit(document.forms(0));
        }
        return false;
    }
</script>

<x:saveState value="#{eLearn_bulletinBB}"/>
    <h:form id="form1" enctype="multipart/form-data">
 	  <h:inputHidden value="#{eLearn_bulletinBB.initEdit}" />
       <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" ������� -> ����"/>
            </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>
        <c:verbatim>
        <table border="0"  align="center" cellspacing="2"   width=96% class="table03" cellpadding="10"	>
			<tr>
                <td class="td_form01">�������</td>
                <td class="td_form02" colspan=3>
</c:verbatim>
                  <h:inputText id="text1" styleClass="input" value="#{eLearn_bulletinBB.bulletinbo.blltnTopic}" size="80" maxlength="50"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">��������</td>
                <td class="td_form02" colspan=3>
</c:verbatim>
                 <h:inputTextarea id="textarea" style="display:none;" value="#{eLearn_bulletinBB.bulletinbo.blltnTopic}" />
<c:verbatim>
                <script language="javascript">
                    gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                    gContentId = "form1:textarea";//Ҫ�������ݵ�content ID
                    OutputEditorLoading();
                </script>
                <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
                 </td>
            </tr>

            <tr>
                <td class="td_form01">��Чʱ��</td>
                <td class="td_form02">
</c:verbatim>
                 <h:inputText id="text3" styleClass="input" value="#{eLearn_bulletinBB.bulletinbo.startDate}" size="17" readonly="true"/>
				 <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:text3')"/>
<c:verbatim>
       </td>
                 <td class="td_form01">
 </c:verbatim>
                    <h:graphicImage value="/images/common/new.gif"></h:graphicImage>
                    <h:outputText value="��ʾʧЧʱ��" />
<c:verbatim>
                </td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText id="newicon" styleClass="input" value="#{eLearn_bulletinBB.bulletinbo.newEndDate}" size="17" readonly="true" />
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:newicon')"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">ʧЧʱ��</td>
                <td class="td_form02" colspan="3">
</c:verbatim>
                    <h:inputText id="text4" styleClass="input" value="#{eLearn_bulletinBB.bulletinbo.endDate}" size="17" readonly="true"/>
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:text4')"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">�����б�</td>
                <td class="td_form02" colspan=3 align="right">
                    <br>
</c:verbatim>
                    <h:outputText value="����"></h:outputText>
                    <h:inputText id="title" value="#{eLearn_bulletinBB.title}"/>
                    <x:inputFileUpload styleClass="input" id="excelFile" value="#{eLearn_bulletinBB.excelFile}"  storage="file" size="25" />
                    <h:commandButton    value="�ϴ�"  onclick="return AddAttech();" styleClass="button01" action="#{eLearn_bulletinBB.uploadFile}"/>
                    <c:verbatim><br><br></c:verbatim>
                    <h:panelGroup>
                    <h:dataTable value="#{eLearn_bulletinBB.attList}" var="list" align="center"  id="dateList"
                                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                                     styleClass="table03" width="98%" >
                            <h:column>
                                <c:facet name="header"><h:outputText value="���"/></c:facet>
                                <h:outputText value="#{list.index}"/>
                            </h:column>
                            <h:column>
                                <c:facet name="header"><h:outputText value="����"/></c:facet>
                                <h:outputText value="#{list.attTitle}"/>
                            </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="����"/></c:facet>
                                    <h:commandButton value="ɾ��" styleClass="button01"
                                                     action="#{eLearn_bulletinBB.deleteAtt}" onclick="return confirm('ȷ��ɾ����')">
                                        <x:updateActionListener property="#{eLearn_bulletinBB.index}" value="#{list.index}"/>
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

        <h:panelGrid border="0" columns="2" cellpadding="8" align="right">
			<h:panelGroup>
                <h:commandButton value="����" action="#{eLearn_bulletinBB.Save}" styleClass="button01" onclick="return forSave();"/>
                <h:commandButton value="����" action="sys_bulletinlist" styleClass="button01" />
            </h:panelGroup>
        </h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


