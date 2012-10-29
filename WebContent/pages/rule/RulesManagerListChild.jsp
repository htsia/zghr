<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddRule(){
        var superID=document.all('form1:superID').value;
        if (superID==null || superID==""){
            alert("����ѡ�����");
            return false;
        }
        window.showModalDialog("/rule/RuleFileEdit.jsf?superID="+superID, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }

    function doModifyRule(ruleid){
        window.showModalDialog("/rule/RuleFileEdit.jsf?fileID="+ruleid, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }

</script>

<x:saveState value="#{rule_browbb}"/>
<h:form id="form1">
    <h:inputHidden value="#{rule_browbb.managerInit}"></h:inputHidden>
    <h:inputHidden id="superID" value="#{rule_browbb.superID}"></h:inputHidden>
    <c:verbatim>
    <table width="98%" height=98% align="center">
    <tr><td height=8>
</c:verbatim>
         <h:panelGrid width="100%" columns="2" align="center">
              <h:outputText value="��ǰ���:#{rule_browbb.superName}"></h:outputText>
              <h:panelGrid columns="1" align="right">
                  <h:commandButton value="����" styleClass="button01" onclick="return doAddRule();"></h:commandButton>
              </h:panelGrid>
          </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
          <x:dataTable value="#{rule_browbb.manrulelist}"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="�ļ����" />
                    </f:facet>
                    <h:outputText value="#{briefList.docno}" ></h:outputText>
                </h:column>

				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����ʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.publicDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��Чʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.actDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="ʧЧʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.invalidDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="�ؼ���" />
                    </f:facet>
                    <h:outputText value="#{briefList.keyWords}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
   					<h:commandButton action="#{rule_editbb.DeleteFile}" value="ɾ��" styleClass="button01" rendered="#{briefList.havePower}" onclick="return confirm('ȷ��Ҫɾ����?')" >
                       <x:updateActionListener property="#{rule_editbb.fileID}" value="#{briefList.fileID}"/>
                    </h:commandButton>
                    <h:commandButton value="�޸�"  rendered="#{briefList.havePower}" styleClass="button01" onclick="return doModifyRule('#{briefList.fileID}');" />
                    <h:commandButton value="�鿴"  rendered="#{!briefList.havePower}" type="button" styleClass="button01" onclick="return doShowRule('#{briefList.fileID}');" />
                </h:column>
			</x:dataTable>
<c:verbatim>
     </div>
     </td></tr>
	</table>
</c:verbatim>
    </h:form>


