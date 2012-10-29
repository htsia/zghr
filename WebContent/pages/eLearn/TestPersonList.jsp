<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
    </script>

<x:saveState value="#{eLearn_testBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{eLearn_testBB.initSetPerson}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8 ></td></tr>
       <tr><td height=8 align="right">
    </c:verbatim>

                <h:outputText value="记录数:#{eLearn_testBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{eLearn_testBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{eLearn_testBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{eLearn_testBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{eLearn_testBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{eLearn_testBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{eLearn_testBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{eLearn_testBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>

                <h:inputHidden id="recID" value="#{eLearn_testBB.personID}"></h:inputHidden>
                <h:inputHidden id="recName" />

                <h:commandButton value="增加" onclick="fPopUpMutiPerDlg('form1:recName', 'form1:recID');" styleClass="button01" action="#{eLearn_testBB.addPerson}"></h:commandButton>

    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
        <x:dataTable value="#{eLearn_testBB.personList}" var="list" align="center" id="dateList"  rowIndexVar="index"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="90%" >

            <h:column>
                <f:facet name="header">
                    <h:outputText value=""  />
                </f:facet>
                <h:outputText value="#{index+1}"   />
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="删除"  styleClass="button01"  action="#{eLearn_testBB.deletePerson}">
                       <x:updateActionListener property="#{eLearn_testBB.itemID}" value="#{list.itemID}"/>
                </h:commandButton>
            </h:column>
        </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>