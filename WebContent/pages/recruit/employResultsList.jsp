<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{getEmployResultBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{getEmployResultBB.pageInit}"></h:inputHidden>
    <c:verbatim>
    
    <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif">�ⲿ��Ƹ->ӦƸ���</td>
        </tr>
       <tr><td align="right" height=8></td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{getEmployResultBB.recuDetailList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����ʱ��"/></c:facet>
            <h:outputText value="#{list.publishDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ������"/></c:facet>
            <h:outputText value="#{list.publishPerson}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ӦƸʱ��"/></c:facet>
            <h:outputText value="#{list.applyDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText  style="width:80px" value="ӦƸ���"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
           	<h:outputText value="   "/>
            <h:commandButton value="����"  onclick="return doTest('#{list.testID}')" styleClass="button01" rendered="#{list.status=='2'}"/>
            <h:outputText value="(�鿴ע�������ʼ�)" rendered="#{list.status=='1'||list.status=='6'}"/>
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

