<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="f"  uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h"  uri="http://java.sun.com/jsf/html"%>
<%@ include file="../include/taglib.jsp" %>
<script type="text/javascript">
function forSave() {
	forsubmit(document.forms(0)); 	
}
</script>

<x:saveState value="#{recuLetterBB}" />
<h:form id="form1" >
      <h:inputHidden id="initEdit" value="#{recuLetterBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="subid" value="#{recuLetterBB.subid}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value=" �������� ->רҵ�����ʸ�༭ "/>
          </h:panelGroup>
      </h:panelGrid>
      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           		
                <h:outputText value="רҵ�����ʸ�"></h:outputText>
                 <h:panelGroup>
                <h:inputText id="a010005" styleClass="input"  value="#{recuLetterBB.letterbo.a010005}" dict="yes" dict_num="0330"  code=""
                            readonly="true"    alt="�ʸ�|1|s|50||"/>
                <c:verbatim>
                <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a010005')">
                 </c:verbatim>
                 </h:panelGroup>
                 <h:outputText value="רҵ����"></h:outputText>
                 <h:panelGroup>
                <h:inputText id="a010706" styleClass="input"  value="#{recuLetterBB.letterbo.a010706}" dict="yes" dict_num="0370"  code=""
                            readonly="true"    alt="רҵ|1|s|50||"/>
                <c:verbatim>
                <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a010706')">
                 </c:verbatim>
                 </h:panelGroup>
                 <h:outputText value="רҵ��������"></h:outputText>
                 <h:panelGroup>
                <h:inputText id="a010006" styleClass="input"  value="#{recuLetterBB.letterbo.a010006}" dict="yes" dict_num="0170"  code=""
                            readonly="true"    alt="ְ�Ƽ���|1|s|50||"/>
                <c:verbatim>
                <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:a010006')">
                 </c:verbatim>
                 </h:panelGroup>
              	<h:outputText value="ȡ���ʸ�ʱ��"></h:outputText>
                <h:panelGroup>
                <h:inputText styleClass="input" id="beginDate" value="#{recuLetterBB.letterbo.a010015}"
                             readonly="true" alt="��ʼ����|0|d|50||"/>
                <c:verbatim>
                 <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginDate')">
                </c:verbatim>
            	</h:panelGroup>
           </h:panelGrid>
           <h:panelGrid align="right">
              <h:commandButton value="����" id="save" action="#{recuLetterBB.save}"   styleClass="button01"  onclick="javascript:return forSave()"/>
           </h:panelGrid>
      </h:panelGrid>
  </h:form>

