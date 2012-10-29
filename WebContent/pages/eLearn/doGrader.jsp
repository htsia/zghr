<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doGradePerson(id){
        window.showModalDialog("/eLearn/doGraderPerson.jsf?itemID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_testBB}"/>
<h:form id="form1">
      <c:verbatim><br></c:verbatim>
      <h:inputHidden value="#{eLearn_testBB.initSetPerson}"></h:inputHidden>
      <c:verbatim>
          <table height=97% width=98% align="center">
          <tr><td height=8 ></td></tr>
      
          <tr><td height=8>
      </c:verbatim>
              <h:outputText value="��¼��:#{eLearn_testBB.mypage.totalRecord}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="ҳ��:#{eLearn_testBB.mypage.totalPage}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="ÿҳ��#{eLearn_testBB.mypage.pageSize}"></h:outputText>
              <h:outputText value="  "></h:outputText>
              <h:outputText value="��ǰΪ��#{eLearn_testBB.mypage.currentPage}ҳ"></h:outputText>

              <h:commandButton value="��ҳ" action="#{eLearn_testBB.first}" styleClass="button01"></h:commandButton>
              <h:commandButton value="��ҳ" action="#{eLearn_testBB.pre}" styleClass="button01"></h:commandButton>
              <h:commandButton value="��ҳ" action="#{eLearn_testBB.next}" styleClass="button01"></h:commandButton>
              <h:commandButton value="βҳ" action="#{eLearn_testBB.last}" styleClass="button01"></h:commandButton>
              <h:outputText value="  "></h:outputText>
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
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>

                       <h:column>
                           <c:facet name="header"><h:outputText value="����"/></c:facet>
                           <h:outputText value="#{list.score}"/>
                       </h:column>

               <h:column>
                   <f:facet name="header">
                       <h:outputText value="�Ƿ���" style="width:100px" />
                   </f:facet>
                   <h:selectOneRadio value="#{list.isfinish}" disabled="true">
                       <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                       <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                   </h:selectOneRadio>
               </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="����"   styleClass="button01"  rendered="#{list.isfinish=='1'}" onclick="doGradePerson('#{list.itemID}');"/>
            </h:column>
        </x:dataTable>
<c:verbatim>  
              </div>
          </td></tr>
        </table>
</c:verbatim>
    <script type="text/javascript">
       setDataTableOver("form1:dateList");
    </script>
    </h:form>


