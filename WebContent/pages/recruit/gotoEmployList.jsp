<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function forViewPost(id) {
    windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
}
</script>
<x:saveState value="#{getToEmployBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{getToEmployBB.pageInit}"></h:inputHidden>
    <c:verbatim>
   <table height=98% width=100% align="center">
       	<tr height=8>
            <td class="td_title">��ǰ��ȱְλ</td>
        </tr>
       <tr><td align="right" height=8></td></tr>
	   <tr height="40%"><td>
	  <div style='width:100%;height:100%;overflow:auto' id="datatable">
	</c:verbatim>
    <x:dataTable value="#{getToEmployBB.recruitPostList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column rendered="#{getToEmployBB.showMode=='1'}">
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:commandLink value="#{list.postName}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
        </h:column>
        <h:column rendered="#{getToEmployBB.showMode=='2'}">
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postType}"/>
        </h:column>
        <h:column rendered="#{getToEmployBB.showMode=='2'}">
            <c:facet name="header"><h:outputText value="רҵ����"/></c:facet>
            <h:outputText value="#{list.majorType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����ʱ��"/></c:facet>
            <h:outputText value="#{list.publishDate}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="��λ������"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������Ƹ�ƻ�"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
       	<h:column>
           <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="Ͷ����" styleClass="button01" action="#{getToEmployBB.employ}">
            	<x:updateActionListener property="#{getToEmployBB.itemid}" value="#{list.itemId}"/>
            </h:commandButton>
          </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
		<tr height=8>
            <td class="td_title">�Ѿ�ӦƸְλ</td>
        </tr>
       <tr><td align="right" height=8></td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id="datatable1">
	</c:verbatim>
    <x:dataTable value="#{getToEmployBB.recuDetailList}" var="list" rowIndexVar="index" align="center" id="dateList1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column rendered="#{getToEmployBB.showMode=='1'}">
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:commandLink value="#{list.postName}" onclick="forViewPost('#{list.postID}')"></h:commandLink>
        </h:column>
        <h:column rendered="#{getToEmployBB.showMode=='2'}">
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postType}"/>
        </h:column>
        <h:column rendered="#{getToEmployBB.showMode=='2'}">
            <c:facet name="header"><h:outputText value="רҵ����"/></c:facet>
            <h:outputText value="#{list.majorType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ������"/></c:facet>
            <h:outputText value="#{list.publishPerson}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������Ƹ�ƻ�"/></c:facet>
            <h:outputText value="#{list.planId}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ӦƸʱ��"/></c:facet>
            <h:outputText value="#{list.applyDate}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText  style="width:80px" value="ӦƸ���"/></c:facet>
            <h:outputText value="#{list.statusDes}#{list.finalResultDes}"/>
           	<h:outputText value="   "/>
            <h:commandButton value="����"  onclick="return doTest('#{list.testID}')" styleClass="button01" rendered="#{list.status=='1'&&list.canTest==true}"/>
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
   setDataTableOver("form1:dateList1");
</script>
