<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forCheck() {
        if(forsubmit(document.forms(0))){
             return true;
        }
        else{
            return false;
        }
    }
</script>

<x:saveState value="#{TrainClassAudit_editBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{TrainClassAudit_editBB.initAudit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ��ѵ���� -> ��ѵ������"/>
        </h:panelGroup>
    </h:panelGrid>
    <br>
  <c:verbatim>  
  <table><tr><td>
  </c:verbatim>
  <h:panelGrid align="center" width="98%" columns="1">
  		
         <h:panelGrid columns="4" width="100%" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="��ѵ������"/>
            <h:inputText id="name" readonly="true" value="#{TrainClassAudit_editBB.classbo.className}" />
			
			<h:outputText value="��ѵ������"/>
            <h:inputText id="classType" readonly="true" value="#{TrainClassAudit_editBB.classbo.classType}" />
            <h:outputText value="��ѵ��ϵ���" rendered="#{TrainClassAudit_editBB.classbo.classType=='��ϵ��ѵ'}"/>
            <h:inputText id="classLinkSystem" readonly="true" value="#{TrainClassAudit_editBB.classbo.classLinkSystem}" rendered="#{TrainClassAudit_editBB.classbo.classType=='��ϵ��ѵ'}"/>
            <h:outputText value="������"/>
            <h:inputText id="major" readonly="true" value="#{TrainClassAudit_editBB.classbo.classMajor}" />

            <h:outputText value="��ѵĿ��"/>
            <h:inputText id="adi" readonly="true" value="#{TrainClassAudit_editBB.classbo.classAid}" />

            <h:outputText value="��ѵ����"/>
            <h:inputText id="duxiang" readonly="true" value="#{TrainClassAudit_editBB.classbo.classScope}" />

            <h:outputText value="����"/>
            <h:inputText id="renshu" readonly="true" value="#{TrainClassAudit_editBB.classbo.classPCount}" />
			<h:outputText value="Ԥ��"/>
            <h:inputText id="yusuan" readonly="true" value="#{TrainClassAudit_editBB.classbo.classBudget}" />
            <h:outputText value="״̬"/>
            <h:inputText id="zt" readonly="true" value="#{TrainClassAudit_editBB.classbo.classStatusDes}" />
            <h:outputText value="��ʱ"/>
            <h:inputText id="keshi" readonly="true" value="#{TrainClassAudit_editBB.classbo.classHour}" />
		</h:panelGrid>
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
			<h:outputText value="�γ�˵��"/>
            <h:inputTextarea value="#{TrainClassAudit_editBB.classbo.classCourse}" readonly="true" rows="3" cols="55"/>
			<h:outputText value="����"/>
           	<h:inputTextarea value="#{TrainClassAudit_editBB.classbo.classDesc}" readonly="true" rows="3" cols="55"/>
		</h:panelGrid>
	</h:panelGrid>
<c:verbatim>  
  </td></tr><tr><td>��ѵ�μ��б�</td></tr><tr><td>
</c:verbatim>
		<x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList3"  align="center" border="0"  value="#{TrainClassAudit_editBB.scormList}"    var="list">
        
         <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�μ�����" /></c:facet>
            <h:outputText value="#{list.courseName}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�μ�����" /></c:facet>
            <h:outputText value="#{list.unitCount}"/>
        </h:column>
		
      </x:dataTable>
  <c:verbatim>  
  </td></tr><tr><td>��ѵ��ʦ�б�</td></tr><tr><td>
</c:verbatim>
		<x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{TrainClassAudit_editBB.teacherList}"    var="list">
        
         <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʦ����" /></c:facet>
            <h:outputText value="#{list.teacherName}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʦ�Ա�" /></c:facet>
            <h:outputText value="#{list.sex}"/>
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="ѧ��"/></c:facet>
            <h:outputText value="#{list.degree}" />
        </h:column>
		
		 <h:column>
            <c:facet name="header"><h:outputText value="��ʦ����"/></c:facet>
            <h:outputText value="#{list.teacherTypeDes}" />
        </h:column>
      </x:dataTable>
 <c:verbatim>  
  </td></tr><tr><td>��ѵ�̲��б�</td></tr><tr><td>
</c:verbatim>
		<x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList2"  align="center" border="0"  value="#{TrainClassAudit_editBB.bookList}"    var="list2">
        
         <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ�̲�����"/></c:facet>
            <h:outputText value="#{list2.bookName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list2.bookAuthor}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list2.bookPublisher}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�۸�"/></c:facet>
            <h:outputText value="#{list2.bookPrice}"/>
        </h:column>
	  </x:dataTable>
<c:verbatim>  
  </td></tr><table>
</c:verbatim>	
</h:form>