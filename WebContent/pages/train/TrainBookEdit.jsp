<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
          function forsave(){
             if(document.all("form1:bookName").value==""){
                 alert("��������ѵ�̲����ƣ�");
                 return false;
             }else if(document.all("form1:author").value==""){
                 alert("�������������ƣ�");
				return false;
                 }
             return true;
            }
          function forBack(form){
             window.close();
          }
      </script>

<x:saveState value="#{train_bookeditbb}" />
<h:form id="form1">
	<h:inputHidden id="initEdit" value="#{train_bookeditbb.initEdit}"></h:inputHidden>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value=" ��ѵ���� -> ��ѵ�̲Ĺ���" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="98%" align="left" >
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="��ѵ�̲�����"></h:outputText>
			<h:inputText id="bookName" value="#{train_bookeditbb.bookbo.bookName}"></h:inputText>

			<h:outputText value="����"></h:outputText>
			<h:inputText id="author" value="#{train_bookeditbb.bookbo.bookAuthor}"></h:inputText>

			<h:outputText value="������"></h:outputText>
			<h:inputText value="#{train_bookeditbb.bookbo.bookPublisher}"></h:inputText>

			<h:outputText value="�۸�"></h:outputText>
			<h:inputText value="#{train_bookeditbb.bookbo.bookPrice}"></h:inputText>

			<h:outputText value="����"></h:outputText>
			<h:inputText value="#{train_bookeditbb.bookbo.bookMemo}"></h:inputText>

			<h:outputText value="Ӧ�÷�Χ"></h:outputText>
			<h:selectOneMenu value="#{train_bookeditbb.bookbo.bookOrg}">
				<c:selectItems value="#{train_bookeditbb.orgList}"></c:selectItems>
			</h:selectOneMenu>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="����" id="save" onclick="return forsave();"
				action="#{train_bookeditbb.save}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>

</h:form>
