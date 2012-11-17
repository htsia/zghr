<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
   function modify(id){
	   window.showModalDialog("/employee/probation/wageItemEdit.jsf?itemId="+id, null, "dialogWidth:400px; dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
	   return true;
   }
</script>
<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{empprobastionWageMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{empprobastionWageMgrBB.pageInit}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "��¼��")%>:
              	</f:verbatim>
                <h:outputText value="#{empprobastionWageMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>:
              	</f:verbatim>
	            <h:outputText value="#{empprobastionWageMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>
								</f:verbatim>
	            <h:outputText value="#{empprobastionWageMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>
								</f:verbatim>
	            <h:outputText value="#{empprobastionWageMgrBB.mypage.currentPage}"></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "ҳ")%>
								</f:verbatim>
            
	            <h:commandButton value="��ҳ" action="#{empprobastionWageMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empprobastionWageMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empprobastionWageMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{empprobastionWageMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>
    <x:dataTable value="#{empprobastionWageMgrBB.wageItemList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" >
     
        <h:column>
            <c:facet name="header">
             <f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1099", "���")%>
								</f:verbatim>
            </c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header">
            <f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2041", "ָ����")%>
								</f:verbatim>
            </c:facet>
            <h:outputText value="#{list.fieldID}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
            <f:verbatim>
								    <%=LanguageSupport.getResource("RYGL-2042", "ָ������")%>
								</f:verbatim>
            </c:facet>
            <h:outputText value="#{list.fieldDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
            	<f:verbatim>
								    <%=LanguageSupport.getResource("JGGL-1100", "ԭֵ")%>
								</f:verbatim>
            </c:facet>
            <h:outputText value="#{list.oldValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
            <f:verbatim>
								    <%=LanguageSupport.getResource("JGGL-1101", "��ֵ")%>
								</f:verbatim>
            </c:facet>
            <h:outputText value="#{list.newValue}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
            <f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1051", "״̬")%>
								</f:verbatim>
            </c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header">
           <f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1090", "��Чʱ��")%>
								</f:verbatim>
            </c:facet>
            <h:outputText value="#{list.updateDate}"/>
        </h:column>
    </x:dataTable>

	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
