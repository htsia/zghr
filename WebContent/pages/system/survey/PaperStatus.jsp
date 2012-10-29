<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doViewAtt( qid, code) {
        window.open('/system/survey/ShowAtt.jsf?QuestionID='+qid+'&Code='+code, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.1+",width="+screen.width*0.8+",toolbar=no,scrollbars=auto,menubar=no");
        return false;
    }
    function showInput(){
        window.showModalDialog("/system/survey/ShowInput.jsf?paperID="+document.all('form1:paperID').value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height+0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function showPaperAndAnswer(){
        window.showModalDialog("/system/survey/ShowPaperAndAnswer.jsf?paperID="+document.all('form1:paperID').value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height+0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }

    function doSurvey(){
    	window.open("/common/DoSurvey.jsf?paperID="+document.all('form1:paperID').value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height+0.7+"px;center:center;resizable:yes;status:no;scroll:yes;");
		return true;
    }
</script>

<x:saveState value="#{self_surveyprocessBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{self_surveyprocessBB.pageInit}" />
	<h:inputHidden id="paperID" value="#{self_surveyprocessBB.paperID}"></h:inputHidden>
	<c:verbatim>
		<table height=98% width=98% align="center">
			<tr>
				<td align="left" height=8px></c:verbatim> <h:selectBooleanCheckbox
						value="#{self_surveyprocessBB.percent}"></h:selectBooleanCheckbox>
					<f:verbatim>
						<%=LanguageSupport.getResource("XTGL-1377", "显示百分比")%>
						<%=LanguageSupport.getResource("XTGL-1146", "当前状态")%>:
			  	</f:verbatim> <h:outputText value="#{self_surveyprocessBB.status}"></h:outputText>
					<f:verbatim>
						<%=LanguageSupport
							.getResource("XTGL-1393", "结果公布状态")%>:
			  	</f:verbatim> <h:outputText value="#{self_surveyprocessBB.pubstatus}"></h:outputText>
					<f:verbatim>
						<%=LanguageSupport.getResource("XTGL-1378", "回收问卷")%>:
			  	</f:verbatim> <h:outputText value="#{self_surveyprocessBB.receivedPaper}"></h:outputText>
					<h:outputText value="  " /> <h:outputText value="浏览问卷"
						styleClass="button01" onclick="return showPaperAndAnswer();"
						rendered="#{self_surveyprocessBB.isRegName==true}"></h:outputText>
					<h:outputText value="录入问卷" styleClass="button01"
						onclick="return doSurvey();"
						rendered="#{(self_surveyprocessBB.method=='2')&&(self_surveyprocessBB.status=='调查进行中')}"></h:outputText>
					<c:verbatim>
				</td>
			</tr>

			<tr>
				<td align="right" height=8px></c:verbatim>
					<h:commandButton styleClass="button01" value="启动调查"
						action="#{self_surveyprocessBB.begin}" /> <h:commandButton
						styleClass="button01" value="停止调查"
						action="#{self_surveyprocessBB.stop}" /> <h:commandButton
						styleClass="button01" value="公布结果"
						rendered="#{self_surveyprocessBB.status=='调查结束'}"
						action="#{self_surveyprocessBB.beginPublish}" /> <h:commandButton
						styleClass="button01" value="停止公布"
						rendered="#{self_surveyprocessBB.status=='调查结束'}"
						action="#{self_surveyprocessBB.stopPublish}" /> <h:selectOneMenu
						value="#{self_surveyprocessBB.sortSelect}">
						<c:selectItem itemValue="-1" itemLabel="==排序选项=="></c:selectItem>
						<c:selectItem itemValue="A" itemLabel="A"></c:selectItem>
						<c:selectItem itemValue="B" itemLabel="B"></c:selectItem>
						<c:selectItem itemValue="C" itemLabel="C"></c:selectItem>
						<c:selectItem itemValue="D" itemLabel="D"></c:selectItem>
						<c:selectItem itemValue="E" itemLabel="E"></c:selectItem>
					</h:selectOneMenu> <h:commandButton styleClass="button01" value="刷新"
						action="#{self_surveyprocessBB.refresh}" /> <h:commandButton
						styleClass="button01" value="查看录入结果" type="button"
						onclick="return showInput();" /> <h:commandButton
						styleClass="button01" value="取消返回" onclick="window.close();" /> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<h:dataTable value="#{self_surveyprocessBB.surveyStatic}"
							var="slist" align="center" id="setList"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_left,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03">

							<h:column>
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1371", "题目")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.title}" style="width:300px" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showA}">
								<c:facet name="header">
								    <f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1379", "A选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultA}" />
								<h:commandButton type="button"
									onclick="doViewAtt('#{slist.questionID}','A')" value="查看内容"
									styleClass="button01" rendered="#{slist.isAttA}"></h:commandButton>
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showB}">
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1380", "B选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultB}" />
								<h:commandButton type="button"
									onclick="doViewAtt('#{slist.questionID}','B')" value="查看内容"
									styleClass="button01" rendered="#{slist.isAttB}"></h:commandButton>
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showC}">
								<c:facet name="header">
								    <f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1381", "C选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultC}" />
								<h:commandButton type="button"
									onclick="doViewAtt('#{slist.questionID}','C')" value="查看内容"
									styleClass="button01" rendered="#{slist.isAttC}"></h:commandButton>
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showD}">
								<c:facet name="header">
								    <f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1382", "D选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultD}" />
								<h:commandButton type="button"
									onclick="doViewAtt('#{slist.questionID}','D')" value="查看内容"
									styleClass="button01" rendered="#{slist.isAttD}"></h:commandButton>
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showE}">
								<c:facet name="header">
								<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1383", "E选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultE}" />
								<h:commandButton type="button"
									onclick="doViewAtt('#{slist.questionID}','E')" value="查看内容"
									styleClass="button01" rendered="#{slist.isAttE}"></h:commandButton>
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showF}">
								<c:facet name="header">
								    <f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1384", "F选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultF}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showG}">
								<c:facet name="header">
								<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1385", "G选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultG}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showH}">
								<c:facet name="header">
								<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1386", "H选项及计数")%>
									</f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultH}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showI}">
								<c:facet name="header">
								<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1387", "I选项及计数")%>
						       </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultI}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showJ}">
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1388", "J选项及计数")%>
						       </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultJ}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showK}">
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1389", "K选项及计数")%>
						            </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultK}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showL}">
								<c:facet name="header">
								<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1390", "L选项及计数")%>
						            </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultL}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showM}">
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1391", "M选项及计数")%>
						            </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultM}" />
							</h:column>

							<h:column rendered="#{self_surveyprocessBB.showN}">
								<c:facet name="header">
									<f:verbatim>
										<%=LanguageSupport.getResource(
										"XTGL-1392", "N选项及计数")%>
						            </f:verbatim>
								</c:facet>
								<h:outputText value="#{slist.staticResultN}" />
							</h:column>

						</h:dataTable>
						<c:verbatim>
					</div></td>
			</tr>

		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:setList");
</script>
