<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>


<x:saveState id="eLearn_upFileBB" value="#{eLearn_upFileBB}" />
<h:form enctype="multipart/form-data" >
    <h:panelGrid columns="1"  width="100%" cellpadding="4" align="center" border="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="学习资料上传" />
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
        <h:inputText value="#{eLearn_upFileBB.describeweb}" />
     <c:verbatim>
       </td></tr>

       <tr><td class="td_form1">
    </c:verbatim>
      <h:outputText value="操作"></h:outputText>
    <c:verbatim>
      </td><td>
    </c:verbatim>
       <x:inputFileUpload id="myFileId" value="#{eLearn_upFileBB.files}" storage="file" styleClass="input" required="true" size="20"/>
    <c:verbatim>
       </td></tr>
        </table>
    </c:verbatim>


   <h:panelGrid columns="1"   cellspacing="8" width="10%" align="right">
       <h:panelGroup>
         <h:commandButton value="保 存" action="#{eLearn_upFileBB.createprocessMyFile}"  styleClass="button01"/>
   	     <h:commandButton value="取 消" type="button" onclick="window.close();return false;" styleClass="button01"/>
       </h:panelGroup>
   </h:panelGrid>
</h:form>
