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
        PutTextareaValue(document.all('form1:textarea'),fGetContent());
        return confirm('确认删除？');
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
        PutTextareaValue(document.all('form1:textarea'),fGetContent());
        return true;
     }
    function forCheck() {
        // 生效时间
        if (document.all('form1:text3').value==null || document.all('form1:text3').value=="") {
            alert("请录入生效时间!");
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

<x:saveState value="#{sys_BulletinEditBackingBean}" />
<h:form id="form1" enctype="multipart/form-data">
	<h:inputHidden value="#{sys_BulletinEditBackingBean.initPage}" />
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>
				<%=LanguageSupport.getResource("XTGL-0900",
									"系统管理 ")%>  -> 
                </f:verbatim>
			<h:outputText value="#{sys_BulletinListBackingBean.pageTitle}" />
			<f:verbatim>
				<%=LanguageSupport.getResource("XTGL-1295",
									"发布 ")%>  -> 
                </f:verbatim>
		</h:panelGroup>
	</h:panelGrid>

	<f:verbatim>
		<br>`	
        </f:verbatim>
	<c:verbatim>
		<table border="0" align="center" cellspacing="2" width=96%
			class="table03" cellpadding="10">
			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1089", "公告标题 ")%>
				</td>
				<td class="td_form02" colspan=3></c:verbatim> <h:inputText id="text1"
						styleClass="input" value="#{sys_BulletinEditBackingBean.vo.topic}"
						size="80" maxlength="50" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1296", "公告内容 ")%>
				</td>
				<td class="td_form02" colspan=3></c:verbatim> <h:inputTextarea id="textarea"
						style="display:none;"
						value="#{sys_BulletinEditBackingBean.vo.content}" /> <c:verbatim>
						<script language="javascript">
                    gFrame = 1;//1-在框架中使用编辑器
                    gContentId = "form1:textarea";//要载入内容的content ID
                    OutputEditorLoading();
                </script>
						<iframe id="HtmlEditor" class="editor_frame" frameborder="0"
							marginheight="0" marginwidth="0"
							style="width: 100%; height: 300px; overflow: visible;"></iframe>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1297", "生效时间 ")%>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputText id="text3"
						styleClass="input"
						value="#{sys_BulletinEditBackingBean.vo.startDate}" size="17"
						readonly="true" /> <h:commandButton value="" styleClass="button_date"
						type="button" onclick="PopUpCalendarDialog('form1:text3')" /> <c:verbatim>
				</td>
				<td class="td_form01"></c:verbatim> <h:graphicImage
						value="/images/common/new.gif"></h:graphicImage> <f:verbatim>
						<%=LanguageSupport.getResource("XTGL-1091",
							"标示失效时间 ")%>
					</f:verbatim> <c:verbatim>
				</td>
				<td class="td_form02"></c:verbatim> <h:inputText id="newicon"
						styleClass="input"
						value="#{sys_BulletinEditBackingBean.vo.newEndDate}" size="17"
						readonly="true" /> <h:commandButton value=""
						styleClass="button_date" type="button"
						onclick="PopUpCalendarDialog('form1:newicon')" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1092", "失效时间 ")%>
				</td>
				<td class="td_form02" colspan="3"></c:verbatim> <h:inputText id="text4"
						styleClass="input"
						value="#{sys_BulletinEditBackingBean.vo.endDate}" size="17"
						readonly="true" /> <h:commandButton value="" styleClass="button_date"
						type="button" onclick="PopUpCalendarDialog('form1:text4')" /> <c:verbatim>
				</td>
			</tr>
			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1298", "查看级别 ")%></td>
				<td class="td_form02" colspan="3"></c:verbatim> <h:selectManyCheckbox
						value="#{sys_BulletinEditBackingBean.inputList}"
						layout="pageDirection">
						<c:selectItems value="#{sys_BulletinEditBackingBean.levelList}"></c:selectItems>
					</h:selectManyCheckbox> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-XTGL-1299",
							"是否公开 ")%></td>
				<td class="td_form02" colspan=3></c:verbatim> <h:selectOneRadio
						value="#{sys_BulletinEditBackingBean.vo.publicFlag}">
						<f:selectItem itemValue="1" itemLabel="可以公开" />
						<f:selectItem itemValue="0" value="true" itemLabel="登录后查看" />
					</h:selectOneRadio> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1300", "公告对象 ")%></td>
				<td class="td_form02" colspan=3></c:verbatim> <h:selectOneRadio
						value="#{sys_BulletinEditBackingBean.vo.readerType}">
						<f:selectItem itemValue="01" itemLabel="业务系统和自助系统" />
						<f:selectItem itemValue="02" value="true" itemLabel="业务系统" />
					</h:selectOneRadio> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1093", "公告范围 ")%></td>
				<td class="td_form02" colspan=3></c:verbatim> <h:inputText id="text5"
						styleClass="input"
						value="#{sys_BulletinEditBackingBean.vo.scopeOrgNames}" size="80"
						readonly="true" /> <h:inputHidden id="text5code"
						value="#{sys_BulletinEditBackingBean.vo.scopeOrgIds}" /> <h:commandButton
						type="button" styleClass="button_select"
						onclick="PopUpMutilOnlyOrgTwoControl('form1:text5code','form1:text5','1','')" />
					<c:verbatim>
				</td>
			</tr>

			<tr>
				<td class="td_form01"><%=LanguageSupport.getResource("XTGL-1301", "附件列表 ")%></td>
				<td class="td_form02" colspan=3 align="right"><br> <%=LanguageSupport.getResource("XTGL-1105", "标题 ")%>
					</c:verbatim> <h:inputText id="title"
						value="#{sys_BulletinEditBackingBean.title}" /> <x:inputFileUpload
						styleClass="input" id="excelFile"
						value="#{sys_BulletinEditBackingBean.excelFile}" storage="file"
						size="25" /> <h:commandButton value="上传"
						onclick="return AddAttech();" styleClass="button01"
						action="#{sys_BulletinEditBackingBean.uploadFile}" /> <c:verbatim>
						<br>
						<br>
					</c:verbatim> <h:panelGroup>
						<h:dataTable value="#{sys_BulletinEditBackingBean.attList}"
							var="list" align="center" id="dateList" headerClass="td_top"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03" width="98%">
							<h:column>
								<c:facet name="header">
								     <%=LanguageSupport.getResource("XTGL-1099", "序号")%>
								</c:facet>
								<h:outputText value="#{list.index}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								     <%=LanguageSupport.getResource("XTGL-1015", "描述")%>
								</c:facet>
								<h:outputText value="#{list.attTitle}" />
							</h:column>

							<h:column>
								<c:facet name="header">
									 <%=LanguageSupport.getResource("XTGL-1026", "操作")%>
								</c:facet>
								<h:commandButton value="删除" styleClass="button01"
									action="#{sys_BulletinEditBackingBean.deleteAtt}"
									onclick="return deleteAtt();">
									<x:updateActionListener
										property="#{sys_BulletinEditBackingBean.index}"
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
		<h:panelGroup>
			<h:commandButton value="发布"
				action="#{sys_BulletinEditBackingBean.saveBulletin}"
				styleClass="button01" onclick="return forSave();" />
			<h:commandButton value="返回" type="button" onclick="window.close()"
				styleClass="button01" />
		</h:panelGroup>
	</h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


