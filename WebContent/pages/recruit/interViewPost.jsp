<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<script type="text/javascript">
     function doQuery(id){
          window.showModalDialog("/recruit/reservePersonList.jsf?detailId="+id, "", "dialogWidth:600px; dialogHeight:250px; status:0;resizable:yes");
          return true;
     }
     function showResult(personId,staus){
	   window.showModalDialog("/recruit/resumeDetail2.jsf?personId="+personId+"&status="+staus, "", "dialogHeight="+screen.height*0.7+"px; dialogWidth="+screen.width*0.7+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=yes;location=no; status=no");
       return true;
   }
     function showTable(planId){
 		url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+planId+"&ORGUID=&Parameter=&Title=";
 		window.open(url);
 	}
</script>

<x:saveState value="#{interviewPersonaduitBB}" />
<h:form id="form1">
	<h:inputHidden value="#{interviewPersonaduitBB.initPassEdit}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim>
				<h:panelGrid align="left">
					<h:panelGroup>
						<h:selectOneMenu id="ReportID" style="width:190px">
               				<c:selectItems value="#{interviewPersonaduitBB.regTableList}"/>
           	    		</h:selectOneMenu>
           	    		<h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{interviewPersonaduitBB.planId}');"/>                       
					</h:panelGroup>
				</h:panelGrid>
				<h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{interviewPersonaduitBB.selectAll}" onclick="submit();" valueChangeListener="#{interviewPersonaduitBB.queryAll}" />
						<h:outputText value="��ʾȫ��"/>
						<h:outputText value=" "/>
                <h:outputText value="��¼��:#{interviewPersonaduitBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{interviewPersonaduitBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{interviewPersonaduitBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{interviewPersonaduitBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{interviewPersonaduitBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{interviewPersonaduitBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{interviewPersonaduitBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{interviewPersonaduitBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> <x:dataTable value="#{interviewPersonaduitBB.personList}" width="100%"
					var="list" rowIndexVar="index" align="center" id="dateList"
					headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03">
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column rendered="#{interviewPersonaduitBB.postMode=='0'}">
						<c:facet name="header">
							<h:outputText value="��λ����" />
						</c:facet>
						<h:outputText value="#{list.postName}" />
					</h:column>
                    <h:column rendered="#{interviewPersonaduitBB.postMode=='1'}">
						<c:facet name="header">
							<h:outputText value="��λ����" />
						</c:facet>
						<h:outputText value="#{list.postType}" />
					</h:column>
                    <h:column rendered="#{interviewPersonaduitBB.postMode=='1'}">
						<c:facet name="header">
							<h:outputText value="רҵ" />
						</c:facet>
						<h:outputText value="#{list.majorType}" />
					</h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="���Ե÷�" />
						</c:facet>
						<h:outputText value="#{list.ivScore}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="״̬" />
						</c:facet>
						<h:outputText value="#{list.statusDes}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="����" styleClass="button01"
							onclick="return doQuery('#{list.detailId}');" rendered="#{list.status=='4'}"></h:commandButton>
                        <h:commandButton value="������Ϣ"  styleClass="button01" onclick="return showResult('#{list.personId}','#{list.status}');"/>
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>