<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
        function doCheck(){
           if (checkMutilSelect(document.form1.selected_ids)){
               var str="";
               if (document.form1.selected_ids.length == null) {
                   str=document.form1.selected_ids.value;
               } else {
                   for (var i = 0; i < document.form1.selected_ids.length; i++) {
                       if (document.form1.selected_ids[i].checked) {
                           if (str=="") {
                               str=document.form1.selected_ids[i].value;
                               break;
                           }
                       }
                   }
               }
               document.all('form1:ids').value=str;
           }
           else{
               alert("��ѡ�񿪽�������Ա!");
               return false;
           }
        }
    </script>

<x:saveState value="#{emp_letterBB}" />
<h:form id="form1">
	<h:inputHidden id="initWorkLetter"
		value="#{emp_letterBB.initopenBasicWorkLetter}" />
	<h:inputHidden id="ids" value="#{emp_letterBB.ids}"></h:inputHidden>
	<c:verbatim>
		<table width="98%" height=98% cellspacing=0 cellpadding=0 border=0
			align="center">
			<tr>
				<td height=8 width="50%" class="td_title"></c:verbatim> <h:graphicImage
						value="/images/tips.gif" /> 
			   <c:verbatim>
			    <%=LanguageSupport.getResource("RYGL-2173", "�¿����˵�ת������")%>
				</td>
				<td height=8 width="50%" align="right" class="td_title"></c:verbatim> <h:commandButton
						styleClass="button01" value="ȷ��" onclick="return doCheck();"
						action="#{emp_letterBB.openBasicWorkLetter}"></h:commandButton> <h:commandButton
						type="button" styleClass="button01" onclick="window.close();"
						value="�˳�"></h:commandButton> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td colspan=2 height=8></c:verbatim> <h:panelGroup>
				        <f:verbatim>
				              <%=LanguageSupport.getResource("RYGL-2161", "�����ű��")%>:
				        </f:verbatim>
						<h:inputText readonly="true" value="#{emp_letterBB.outLetterNo}" />
						 <f:verbatim>
				              <%=LanguageSupport.getResource("RYGL-2174", "ֻ�����ܲ��������������Ѿ������˽����ͬ����������ɽ�����")%>
				        </f:verbatim>
					</h:panelGroup> <c:verbatim>
				</td>
			</tr>

			<tr>
				<td colspan=2>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</c:verbatim>
						<h:dataTable value="#{emp_letterBB.personList}" var="list"
							align="center" headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
							styleClass="table03">

							<h:column>
								<c:facet name="header">
									<c:verbatim escape="false">
										<input type="checkbox" name="chkAll"
											onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)" />
									</c:verbatim>
								</c:facet>
								<c:verbatim escape="false">
									<input type="checkbox" name="selected_ids"
										value="</c:verbatim>
                                     <h:outputText value="#{list.chgId}"/>
                                    <c:verbatim>">
								</c:verbatim>
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2163", "��������")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.applyDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				             			 <%=LanguageSupport.getResource("XTGL-1042", "Ա�����")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.personCode}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
				             			 <%=LanguageSupport.getResource("MSG-0010", "����")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.name}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2146", "ԭ��λ")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromOrgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2175", "������λ")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toOrgName}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								   <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2175", "ԭ��λ���")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromOpinion}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								    <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2172", "ԭ��λ����ԭ��")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromReason}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2171", "ԭ��λ����ʱ��")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.fromDate}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2170", "ԭ��λ��ͬ���")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.cont_old_end}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2169", "���뵥λ���")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toOpinion}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2168", "���뵥λ����ԭ��")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toReason}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								       <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2167", "���뵥λ����ʱ��")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.toDate}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								     <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2166", "�µ�λ��ͬ���")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.cont_new_begin}" />
							</h:column>

							<h:column>
								<c:facet name="header">
								      <f:verbatim>
				             			 <%=LanguageSupport.getResource("RYGL-2151", "����״̬")%>
				      				  </f:verbatim>
								</c:facet>
								<h:outputText value="#{list.applyStatusDes}" />
							</h:column>
						</h:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
