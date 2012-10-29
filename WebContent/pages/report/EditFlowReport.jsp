<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function OpenRpt(titleID){
            var url="/pages/report/FlowReportShow.jsp?Title="+titleID;
            window.open(url);
            return false;
        }
        function doCheck(){
            if (document.all('form1:excelFile').value==''){
                alert("��ѡ��Excel�ļ�!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{RptFlowEditBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden value="#{RptFlowEditBB.pageInit}"/>
    <c:verbatim>
        <table width=98% align="center">
          <tr><td align="right">
    </c:verbatim>
              <x:inputFileUpload
						styleClass="input" id="excelFile"
						value="#{RptFlowEditBB.excelFile}" storage="file"
						size="25" />
    <c:verbatim>
          </td></tr>
    </c:verbatim>

    <h:dataTable value="#{RptFlowEditBB.reportList}" var="list" align="center"  id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="380" >
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{list.rptcode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.rptDesc}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.crDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="��ʾ" styleClass="button01" type="button" onclick="OpenRpt('#{list.title}');"></h:commandButton>
            <h:commandButton value="�ϴ�" styleClass="button01" onclick="return doCheck();" action="#{RptFlowEditBB.uploadFile}">
                <x:updateActionListener property="#{RptFlowEditBB.titleID}" value="#{list.title}"></x:updateActionListener>
            </h:commandButton>
        </h:column>

    </h:dataTable>
    <c:verbatim>
        </table>
    </c:verbatim>

</h:form>
