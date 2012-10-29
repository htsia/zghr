<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>
	<link href="/css/editor.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="/js/commonFuns.js"></script>
	<script language="javascript" src="/js/editor.js"></script>
	<script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
<script type="text/javascript">
    function deleteAtt(){
        PutTextareaValue(document.all('BulletinEditForm:textarea'),fGetContent());
        return confirm('ȷ��ɾ����');
    }

    function AddAttech() {
        if (document.all('BulletinEditForm:title').value==null){
            alert("���������");
            return false;
        }
        if (document.all('BulletinEditForm:excelFile').value==null){
            alert("��ѡ���ļ�");
            return false;
        }
        PutTextareaValue(document.all('BulletinEditForm:textarea'),fGetContent());
        return true;
     }

    function forCheck() {
        // ���ű���
        if (document.all('BulletinEditForm:text1').value==null || document.all('BulletinEditForm:text1').value=="") {
            alert("��¼�����ű���!");
            return false;
        }
        if (document.all('BulletinEditForm:textarea').value==null || document.all('BulletinEditForm:textarea').value=="") {
            alert("��¼����������!");
            return false;
        }
        // ��Чʱ��
        if (document.all('BulletinEditForm:text3').value==null || document.all('BulletinEditForm:text3').value=="") {
            alert("��¼����Чʱ��!");
            return false;
        }
        if (document.all('BulletinEditForm:text4').value==null || document.all('BulletinEditForm:text4').value=="") {
            alert("��¼��ʧЧʱ��!");
            return false;
        }
        /*
        if (!document.all('BulletinEditForm:readerType')[1].checked && !document.all('BulletinEditForm:readerType')[2].checked){
            alert("��ѡ�����Ŷ���!");
            return false;
        }
        */
        return true;
    }
    function forSave() {
        PutTextareaValue(document.all('BulletinEditForm:textarea'),fGetContent());
        if (forCheck()) {
            return forsubmit(document.forms(0));
        }
        return false;
    }
</script>
<x:saveState value="#{sys_NewsEditBackingBean}" />
<h:form id="BulletinEditForm" enctype="multipart/form-data">
	<h:inputHidden value="#{sys_NewsEditBackingBean.initPage}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>
				<%=LanguageSupport.getResource("XTGL-0900",
									"ϵͳ���� ")%>->
                  </f:verbatim>
			<h:outputText value="#{sys_NewsListBackingBean.pageTitle} -> ����" />
			<f:verbatim>
				<%=LanguageSupport.getResource("XTGL-1295",
									"����")%>
			</f:verbatim>
		</h:panelGroup>
	</h:panelGrid>

	<f:verbatim>
		<br>
	</f:verbatim>
	<c:verbatim>
		<table border="0" align="center" cellspacing="2" cellpadding="10"
			columnClasses="td_form01,td_form02" styleClass="table03">
			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1094", "���ű���")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputText id="text1"
						styleClass="input" value="#{sys_NewsEditBackingBean.vo.topic}"
						size="80" maxlength="50" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1333", "������Դ")%></td>
				<td class="td_form02"></c:verbatim> <h:inputText styleClass="input"
						value="#{sys_NewsEditBackingBean.vo.newsSource}" size="80"
						maxlength="50" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1334", "����ͼƬ")%></td>
				<td class="td_form02"></c:verbatim> <h:graphicImage
						value="/file/news/#{sys_NewsEditBackingBean.vo.newsFile}"
						width="160" height="260"
						rendered="#{sys_NewsEditBackingBean.vo.newsFile!=null && sys_NewsEditBackingBean.vo.newsFile!=''}" />
					<c:verbatim>
						<br>
					</c:verbatim> <x:inputFileUpload id="blobFile" styleClass="input"
						value="#{sys_NewsEditBackingBean.blobFile}" storage="file"
						size="25" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1335", "��������")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputTextarea id="textarea" rows="15"
						cols="80" style="display:none;"
						value="#{sys_NewsEditBackingBean.vo.content}" /> <c:verbatim>
						<script language="javascript">
                        gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                        gContentId = "BulletinEditForm:textarea";//Ҫ�������ݵ�content ID
                        OutputEditorLoading();
                    </script>
						<iframe id="HtmlEditor" class="editor_frame" frameborder="0"
							marginheight="0" marginwidth="0"
							style="width: 100%; height: 300px; overflow: visible;"></iframe>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1090", "��Чʱ��")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputText id="text3"
						styleClass="input" value="#{sys_NewsEditBackingBean.vo.startDate}"
						size="17" readonly="true">
					</h:inputText> <h:commandButton value="" styleClass="button_date" type="button"
						onclick="PopUpCalendarDialog('BulletinEditForm:text3')" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><img src="/images/common/new.gif"><%=LanguageSupport.getResource("XTGL-1092", "ʧЧʱ��")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputText id="textflag"
						styleClass="input"
						value="#{sys_NewsEditBackingBean.vo.newEndDate}" size="17"
						readonly="true">
					</h:inputText> <h:commandButton value="" styleClass="button_date" type="button"
						onclick="PopUpCalendarDialog('BulletinEditForm:textflag')" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1092", "ʧЧʱ��")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputText id="text4"
						styleClass="input" value="#{sys_NewsEditBackingBean.vo.endDate}"
						size="17" readonly="true">
					</h:inputText> <h:commandButton value="" styleClass="button_date" type="button"
						onclick="PopUpCalendarDialog('BulletinEditForm:text4')" /> <c:verbatim>
				</td>
			</tr>


			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1298", "�鿴����")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:selectManyCheckbox
						value="#{sys_NewsEditBackingBean.inputList}"
						layout="pageDirection">
						<c:selectItems value="#{sys_NewsEditBackingBean.levelList}"></c:selectItems>
					</h:selectManyCheckbox> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1299", "�Ƿ񹫿�")%></td>
				<td class="td_form02" colspan=3></c:verbatim>
                    <h:selectOneRadio
						value="#{sys_NewsEditBackingBean.vo.publicFlag}">
						<f:selectItem itemValue="1" itemLabel="���Թ���" />
						<f:selectItem itemValue="0" value="true" itemLabel="��¼��鿴" />
					</h:selectOneRadio> <c:verbatim>
				</td>
			</tr>

        <tr>
            <td class="td_form01">�Ƿ���ʾ�ڿ����Ŀ</td>
            <td class="td_form02" colspan=3></c:verbatim>
                <h:selectOneRadio
                    value="#{sys_NewsEditBackingBean.vo.express}">
                    <f:selectItem itemValue="1" itemLabel="��" />
                    <f:selectItem itemValue="0" itemLabel="��" />
                </h:selectOneRadio> <c:verbatim>
            </td>
        </tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1097", "���ŷ�Χ")%></td>
				<td class="td_form02"></c:verbatim> <h:inputText id="text5"
						styleClass="input"
						value="#{sys_NewsEditBackingBean.vo.scopeOrgNames}" size="80"
						readonly="true">
					</h:inputText> <h:inputHidden id="text5code"
						value="#{sys_NewsEditBackingBean.vo.scopeOrgIds}" /> <h:commandButton
						type="button" styleClass="button_select"
						onclick="PopUpMutilOrgTwoControl('BulletinEditForm:text5code','BulletinEditForm:text5','1','')" />
					<c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1301", "�����б�")%></td>
				<td class="td_form02" colspan=3 align="right"><br> <%=LanguageSupport.getResource("XTGL-1105", "����")%>
					</c:verbatim> <h:inputText id="title" value="#{sys_NewsEditBackingBean.title}" />
					<x:inputFileUpload styleClass="input" id="excelFile"
						value="#{sys_NewsEditBackingBean.excelFile}" storage="file"
						size="25" /> <h:commandButton styleClass="button01" value="�ϴ�"
						onclick="return AddAttech();"
						action="#{sys_NewsEditBackingBean.uploadFile}" /> <c:verbatim>
						<br>
						<br>
					</c:verbatim> <h:panelGroup>
						<h:dataTable value="#{sys_NewsEditBackingBean.attList}" var="list"
							align="center" headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="98%">
							<h:column>
								<c:facet name="header">
								   <f:verbatim>
								       <%=LanguageSupport.getResource("XTGL-1099", "���")%>
								   </f:verbatim>
									
								</c:facet>
								<h:outputText value="#{list.index}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								   <f:verbatim>
								       <%=LanguageSupport.getResource("XTGL-1015", "����")%>
								   </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.attTitle}" />
							</h:column>

							<h:column>
							   <c:facet name="header">
								    <f:verbatim>
								       <%=LanguageSupport.getResource("YXGL-1026", "����")%>
								   </f:verbatim>
								</c:facet>
						     <h:commandButton value="ɾ��" styleClass="button01"
									action="#{sys_NewsEditBackingBean.deleteAtt}"
									onclick="return deleteAtt();">
									<x:updateActionListener
										property="#{sys_NewsEditBackingBean.index}"
										value="#{list.index}" />
						     </h:commandButton>
						     
							</h:column>
						</h:dataTable>
					</h:panelGroup> <c:verbatim>
				</td>
			</tr>
		</table>
		<br>
	</c:verbatim>

	<h:panelGrid border="0" columns="2" cellpadding="8" align="right">
		<h:commandButton value="����" onclick="return forSave();"
			action="#{sys_NewsEditBackingBean.saveNews}" styleClass="button01" />
		<h:commandButton value="����" action="sys_newslist"
			styleClass="button01" />
	</h:panelGrid>
</h:form>


