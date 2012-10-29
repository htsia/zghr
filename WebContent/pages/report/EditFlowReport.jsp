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
                alert("请选择Excel文件!");
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
            <c:facet name="header"><h:outputText value="表号"/></c:facet>
            <h:outputText value="#{list.rptcode}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="描述"/></c:facet>
            <h:outputText value="#{list.rptDesc}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="生成时间"/></c:facet>
            <h:outputText value="#{list.crDate}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="显示" styleClass="button01" type="button" onclick="OpenRpt('#{list.title}');"></h:commandButton>
            <h:commandButton value="上传" styleClass="button01" onclick="return doCheck();" action="#{RptFlowEditBB.uploadFile}">
                <x:updateActionListener property="#{RptFlowEditBB.titleID}" value="#{list.title}"></x:updateActionListener>
            </h:commandButton>
        </h:column>

    </h:dataTable>
    <c:verbatim>
        </table>
    </c:verbatim>

</h:form>
