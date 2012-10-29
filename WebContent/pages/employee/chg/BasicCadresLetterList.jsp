<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function ModifyNo(id){
        var ret=window.showModalDialog("/employee/chg/BasicModifyLetterNo.jsf?letterType=worker&ID="+id, null, "dialogWidth:300px; dialogHeight:200px;center:center;resizable:no;status:no;");
        return false;
    }

    function doOpenCadLetter() {
         var ret=window.showModalDialog("/employee/chg/BasicOpenCardLetter.jsf?Init=true", null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:"+screen.height*0.85+"px;center:center;resizable:no;status:no;");
         return true;
    }

    //id �����ű��
    function OpenRpt(id){
        if (document.all("form1:ReportID").value=="-1"){
            alert("����ѡ������ʽ��");
            return false;
        }
        var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+id+"&Title=WL_"+id;
        window.open(url);
        return false;
    }
    function OpenRptOrFlow(id){
        if (document.all("form1:ReportID").value=="-1"){
            alert("����ѡ������ʽ��");
            return false;
        }
        <%User user = (User) session.getAttribute(Constants.USER_INFO);
			out.print("    var orguid='" + user.getOrgId() + "';");%>

        var url="/pages/report/RollORFlowReportShow.jsp?RptCode="
				+ document.all("form1:ReportID").value + "&ID=" + id
				+ "&Title=CD_" + orguid + id;
		window.open(url);
		return false;
	}

	function OpenRptByControl() {
		if (document.all("form1:ReportID").value == "-1") {
			alert("����ѡ������ʽ��");
			return false;
		}
		var url = "/pages/report/ClientReportShow.jsp?RptCode="
				+ document.all("form1:ReportID").value + "&ID=&ORGUID="
				+ document.all("form1:unitId").value + "&Parameter="
				+ document.all("form1:setId").value + "&Title="
				+ document.all("form1:setId").value + "_"
				+ document.all("form1:dateId").value + "_"
				+ document.all("form1:ReportID").value;
		window.open(url);
		return false;
	}
</script>
<x:saveState value="#{emp_letterBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emp_letterBB.initBasicCadWrok}"></h:inputHidden>
	<c:verbatim>
		<table width="98%" height=98% align="center">
			<tr>
				<td height=8>
					<table>
						<tr>
							<td></c:verbatim> <h:selectOneMenu id="ReportID" style="width:190px">
									<c:selectItems value="#{emp_letterBB.baseCadresReport}" />
								</h:selectOneMenu> <c:verbatim>
							</td>
							<td></c:verbatim> <f:verbatim>
									<%=LanguageSupport.getResource("COMM-1043", "��¼��")%>��
		     	</f:verbatim> <h:outputText value="#{emp_letterBB.pagevo.totalRecord}"></h:outputText>
								<h:outputText value="  "></h:outputText> <f:verbatim>
									<%=LanguageSupport.getResource("COMM-1044", "ҳ��")%>��
		     	</f:verbatim> <h:outputText value="#{emp_letterBB.pagevo.totalPage}"></h:outputText>
								<h:outputText value="  "></h:outputText> <f:verbatim>
									<%=LanguageSupport.getResource("COMM-1045", "ÿҳ��")%>
								</f:verbatim> <h:outputText value="#{emp_letterBB.pagevo.pageSize}"></h:outputText>
								<h:outputText value="  "></h:outputText> <f:verbatim>
									<%=LanguageSupport.getResource("COMM-1046", "��ǰΪ��")%>
								</f:verbatim> <h:outputText value="#{emp_letterBB.pagevo.currentPage}"></h:outputText>
								<f:verbatim>
									<%=LanguageSupport.getResource("COMM-1047", "ҳ")%>
								</f:verbatim> <c:verbatim>
							</td>
							<td align="right"></c:verbatim> <h:commandButton value="��ҳ"
									action="#{emp_letterBB.first}" styleClass="button01"></h:commandButton>
								<h:commandButton value="��ҳ" action="#{emp_letterBB.pre}"
									styleClass="button01"></h:commandButton> <h:commandButton
									value="��ҳ" action="#{emp_letterBB.next}" styleClass="button01"></h:commandButton>
								<h:commandButton value="βҳ" action="#{emp_letterBB.last}"
									styleClass="button01"></h:commandButton> <h:outputText
									value="     "></h:outputText> <h:commandButton
									value="�¿��ɲ���ת������" styleClass="button01"
									onclick="doOpenCadLetter();"></h:commandButton> <h:commandButton
									value="�˳�" type="button" styleClass="button01"
									onclick="window.close();"></h:commandButton> <c:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto'
						id='datatable'>
						</c:verbatim>
						<h:dataTable value="#{emp_letterBB.letterList}" var="list"
							width="100%" styleClass="table03" headerClass="td_fixtop"
							columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
							<h:column>
								<c:facet name="header">
								 <f:verbatim>
			                      <%=LanguageSupport.getResource("YXGL-1026","����")%>  
			                    </f:verbatim>
								</c:facet>
								<h:commandButton value="�޸ı��" styleClass="button01"
									onclick="ModifyNo('#{list.chgId}');"></h:commandButton>
								<h:commandButton value="��ӡ" type="button" styleClass="button01"
									onclick="OpenRptOrFlow('#{list.chgId}');"></h:commandButton>
							</h:column>

							<h:column>
								<f:facet name="header">
								 <f:verbatim>
			                      <%=LanguageSupport.getResource("RYGL-2154","���")%>  
			                    </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.fromletterno}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								 <f:verbatim>
			                      <%=LanguageSupport.getResource("RYGL-2155","������λ")%>  
			                    </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.fromOrgName}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								 <f:verbatim>
			                      <%=LanguageSupport.getResource("RYGL-2156","���뵥λ")%>  
			                    </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.toOrgName}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								<f:verbatim>
			                      <%=LanguageSupport.getResource("RYGL-2122","��Ա���")%>  
			                    </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.personCode}" />
							</h:column>
							<h:column>
								<f:facet name="header">
								<f:verbatim>
			                      <%=LanguageSupport.getResource("RYGL-2157","��Ա���")%>  
			                    </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.degree}" />
							</h:column>

							<h:column>
								<f:facet name="header">
								<f:verbatim>
			                      <%=LanguageSupport.getResource("RYGL-2049","��Ա����")%>  
			                    </f:verbatim>
								</f:facet>
								<h:outputText escape="false" value="#{list.name}" />
							</h:column>
						</h:dataTable>
						<c:verbatim>
					</div></td>
			</tr>
		</table>
	</c:verbatim>
</h:form>