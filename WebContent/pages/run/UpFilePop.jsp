<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<c:verbatim><base target="_self"></c:verbatim>
<x:saveState id="upFilePopBackingBean" value="#{upFilePopBackingBean}" />
<h:form enctype="multipart/form-data" >
    <h:panelGrid columns="1"  styleClass="td_title" width="100%" cellpadding="4" align="center" border="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="软件上传" />
        </h:panelGroup>
    </h:panelGrid>

    <c:verbatim>
        <table width=98% align="center">
        <tr>
        <td class="td_form1">
    </c:verbatim>
        <h:outputText value="标题"></h:outputText>
    <c:verbatim>
        </td>
        <td>
    </c:verbatim>
        <h:inputText value="#{upFilePopBackingBean.describeweb}" />
     <c:verbatim>
       </td></tr>

       <tr><td class="td_form1">
    </c:verbatim>
      <h:outputText value="操作"></h:outputText>
    <c:verbatim>
      </td><td>
    </c:verbatim>
       <x:inputFileUpload id="myFileId" value="#{upFilePopBackingBean.files}" storage="file" styleClass="input" required="true" size="20"/>       
    <c:verbatim>
       </td></tr>
        </table>
    </c:verbatim>


   <h:panelGrid columns="1"   cellspacing="8" width="10%" align="right">
       <h:panelGroup>
         <h:commandButton value="保 存" action="#{upFilePopBackingBean.createprocessMyFile}"  styleClass="button01"/>
   	     <h:commandButton value="取 消" type="button" onclick="window.close();return false;" styleClass="button01"/>
       </h:panelGroup>
   </h:panelGrid>
</h:form>
