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
                 alert("请输入培训教材名称！");
                 return false;
             }else if(document.all("form1:author").value==""){
                 alert("请输入作者名称！");
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
			<h:outputText value=" 培训管理 -> 培训教材管理" />
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" width="98%" align="left" >
		<h:panelGrid columns="2" columnClasses="td_form01,td_form02"
			align="center" styleClass="table03">
			<h:outputText value="培训教材名称"></h:outputText>
			<h:inputText id="bookName" value="#{train_bookeditbb.bookbo.bookName}"></h:inputText>

			<h:outputText value="作者"></h:outputText>
			<h:inputText id="author" value="#{train_bookeditbb.bookbo.bookAuthor}"></h:inputText>

			<h:outputText value="出版社"></h:outputText>
			<h:inputText value="#{train_bookeditbb.bookbo.bookPublisher}"></h:inputText>

			<h:outputText value="价格"></h:outputText>
			<h:inputText value="#{train_bookeditbb.bookbo.bookPrice}"></h:inputText>

			<h:outputText value="介绍"></h:outputText>
			<h:inputText value="#{train_bookeditbb.bookbo.bookMemo}"></h:inputText>

			<h:outputText value="应用范围"></h:outputText>
			<h:selectOneMenu value="#{train_bookeditbb.bookbo.bookOrg}">
				<c:selectItems value="#{train_bookeditbb.orgList}"></c:selectItems>
			</h:selectOneMenu>
		</h:panelGrid>

		<h:panelGrid align="right">
			<h:commandButton value="保存" id="save" onclick="return forsave();"
				action="#{train_bookeditbb.save}" styleClass="button01" />
		</h:panelGrid>
	</h:panelGrid>

</h:form>
