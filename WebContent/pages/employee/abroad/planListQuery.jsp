<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function sel(code){
    	window.returnValue = code;
        window.close();
    }
    </script>

<x:saveState value="#{aboradPlanqueryBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{aboradPlanqueryBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{aboradPlanqueryBB.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
              	<f:verbatim>
				     <%=LanguageSupport.getResource("JGGL-1092", "��ǰ����")%>:
                </f:verbatim>
              <h:outputText value="#{aboradPlanqueryBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <f:verbatim>
				     <%=LanguageSupport.getResource("JGGL-1092", "��¼��")%>:
                </f:verbatim>
                <h:outputText value="#{aboradPlanqueryBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	             <f:verbatim>
				     <%=LanguageSupport.getResource("JGGL-1092", "ҳ��")%>:
                </f:verbatim>
	            <h:outputText value="#{aboradPlanqueryBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	             <f:verbatim>
				     <%=LanguageSupport.getResource("JGGL-1092", "ÿҳ��")%>:
                </f:verbatim>
	            <h:outputText value="#{aboradPlanqueryBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	             <f:verbatim>
				     <%=LanguageSupport.getResource("JGGL-1092", "��ǰΪ��")%>:
                </f:verbatim>
	            <h:outputText value="#{aboradPlanqueryBB.mypage.currentPage}"> </h:outputText>
	              <f:verbatim>
				     <%=LanguageSupport.getResource("JGGL-1092", "ҳ")%>
                </f:verbatim>
	            
           		<h:commandButton value="��ҳ" action="#{aboradPlanqueryBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{aboradPlanqueryBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{aboradPlanqueryBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{aboradPlanqueryBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{aboradPlanqueryBB.planList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header">
                <f:verbatim>
				     <%=LanguageSupport.getResource("YXGL-1026", "����")%>
                </f:verbatim>
               </c:facet>
               <c:verbatim><a class="cursor:hand" onclick="sel('</c:verbatim><h:outputText value="#{list.planId}"/><c:verbatim>')">ѡ��</a></c:verbatim>
         </h:column>
        <h:column>
            <c:facet name="header">
                <f:verbatim>
				     <%=LanguageSupport.getResource("YXGL-1029", "����")%>
                </f:verbatim>
           </c:facet>
            <h:outputText value="#{list.deptId}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
              <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2013", "�ƻ�����")%>
                </f:verbatim>
             </c:facet>
            <h:outputText value="#{list.planTypeDes}"/>
        </h:column>
         <h:column>
            <c:facet name="header">
             <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2010", "�ƻ�ʱ��")%>
             </f:verbatim>
           </c:facet>
            <h:outputText value="#{list.planDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
             <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2012", "���ù���")%>
             </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.country}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
             <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2009", "��ʼ����")%>
             </f:verbatim>
           </c:facet>
            <h:outputText value="#{list.beginDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
             <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2008", "��������")%>
             </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.endDate}"/>
        </h:column>
         <h:column>
            <c:facet name="header">
             <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2018", "�ͻ�")%>
             </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.costomer}"/>
        </h:column>
         <h:column>
            <c:facet name="header">
              <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2006", "Ԥ��")%>
             </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.budget}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
             <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2017", "�ƶ���")%>
             </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.maker}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
               <f:verbatim>
				     <%=LanguageSupport.getResource("RYGL-2016", "�ƶ�ʱ��")%>
             </f:verbatim>
            </c:facet>
            <h:outputText value="#{list.makDate}"/>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
