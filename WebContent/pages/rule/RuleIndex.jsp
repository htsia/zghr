<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
      function checkInput(){
          var flag=0;
          if (document.all('form1:beginTime').value!=''){
              flag=1;
          }
          if (document.all('form1:endTime').value!=''){
              flag=1;
          }
          if (document.all('form1:title').value!=''){
              flag=1;
          }
          if (document.all('form1:key').value!=''){
              flag=1;
          }
          if (document.all('form1:content').value!=''){
              flag=1;
          }
          if (flag==0){
              alert("û��ѡ���κ�����������")
              return false;
          }
          return true;
      }
</script>

<x:saveState value="#{rule_browbb}"/>
<h:form id="form1">
    <c:verbatim>
    <table width=99% height=98% align="center">
        <tr><td height=4>
        </td></tr>

        <tr><td height=8>
            <table width=90% align=center>
            <tr>
                <td>
    </c:verbatim>
                    <h:outputText escape="false" value="<strong>����ʱ��:</strong>&nbsp;��&nbsp;"></h:outputText>
                    <h:inputText styleClass="input" id="beginTime" size="12" alt="��ʼʱ��|0|d" value="#{rule_browbb.beginTime}" readonly="true"/>
                    <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:beginTime')"></f:verbatim>
                    <h:outputText escape="false" value="&nbsp;��&nbsp;"></h:outputText>
                    <h:inputText styleClass="input" id="endTime" alt="����ʱ��|0|d" size="12" value="#{rule_browbb.endTime}" readonly="true"/>
                    <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:endTime')"></f:verbatim>
    <c:verbatim>
                </td>
            </tr>
            <tr><td>
    </c:verbatim>
                    <h:outputText escape="false" value="<strong>��&nbsp;&nbsp;��:</strong>"></h:outputText>
                    <h:inputText id="title" value="#{rule_browbb.title}"></h:inputText>
                    <h:outputText value="   "></h:outputText>
                    <h:outputText escape="false" value="<strong>�ؼ���:</strong>"></h:outputText>
                    <h:inputText id="key" value="#{rule_browbb.key}"></h:inputText>
    <c:verbatim>
            </td></tr>

            <tr><td  >
    </c:verbatim>
                    <h:outputText escape="false" value="<strong>��&nbsp;&nbsp;��:</strong>"></h:outputText>
                    <h:inputText id="content" value="#{rule_browbb.content}"></h:inputText>
<c:verbatim>
                </td>
          </tr>
          <tr>
                <td align="right" height=8>
</c:verbatim>
                     <h:commandButton value="����" styleClass="button01" action="#{rule_browbb.QueryRule}"  onclick="return checkInput();"></h:commandButton>
<c:verbatim>
                </td>
            </tr>
            </table>
        </td></tr>

        <tr>
            <td align="left" height=25>
</c:verbatim>
                <h:outputText value="��¼��:#{rule_browbb.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ҳ��:#{rule_browbb.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ÿҳ��#{rule_browbb.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��ǰΪ��#{rule_browbb.pagevo.currentPage}ҳ"></h:outputText>
                <h:commandButton value="��ҳ" action="#{rule_browbb.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{rule_browbb.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{rule_browbb.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="βҳ" action="#{rule_browbb.last}" styleClass="button01"></h:commandButton>
<c:verbatim>
            </td>
        </tr>
        <tr><td>
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
          <x:dataTable value="#{rule_browbb.rulelist}" id="dateList"
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

					<h:commandButton value="�鿴��ϸ��Ϣ" styleClass="button01" type="button" onclick="return doShowRule('#{briefList.fileID}');">
					</h:commandButton>
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


