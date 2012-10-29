<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
function doOK() {
    var str="idnames|";
    chk=document.forms(0).selectItem;
    if (checkMutilSelect(chk)){
        var size = chk.length;
        if (size == null) {
            if (chk.checked) {
                str+=chk.value;
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (chk[i].checked) {
                    if (i==0){
                        str+=chk[i].value;
                    }
                    else{
                        str+=","+chk[i].value;
                    }
                }
            }
        }
        window.returnValue=str;
        window.close();
    }
    else{
        alert("��ѡ��Ҫ����Ŀγ�!");
    }
}
</script>

<x:saveState value="#{seltraincourcebb}"/>
<h:form id="form1">
      <h:inputHidden value="#{seltraincourcebb.pageInit}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="ȷ��" styleClass="button01" onclick="doOK();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{seltraincourcebb.manCourceList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
				<h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{briefList.itemID}:#{briefList.title}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="��Чʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.startDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="ʧЧʱ��" />
                    </f:facet>
                    <h:outputText value="#{briefList.endDate}" ></h:outputText>
                </h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


