<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addBook(){
             window.showModalDialog("/train/TrainSelfDepartDemandEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:700px; dialogHeight:600px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/TrainSelfDepartDemandEdit.jsf?orgID="+id, "", "dialogWidth:700px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
        function doShowDeatail(id){
            window.showModalDialog("/train/TrainDetailDemand.jsf?demandID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{train_selfdepartdemandlistbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{train_selfdepartdemandlistbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_selfdepartdemandlistbb.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{train_selfdepartdemandlistbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             
            <h:panelGroup>
                <h:outputText value="��¼��:#{train_selfdepartdemandlistbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{train_selfdepartdemandlistbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{train_selfdepartdemandlistbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{train_selfdepartdemandlistbb.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{train_selfdepartdemandlistbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_selfdepartdemandlistbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_selfdepartdemandlistbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{train_selfdepartdemandlistbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return addBook();" styleClass="button01" rendered="#{train_selfdepartdemandlistbb.showAdd=='1'}"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <h:dataTable value="#{train_selfdepartdemandlistbb.departDemandList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���ʱ��"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>

		<h:column>
            <c:facet name="header"><h:outputText value="��ѵ��ʽ"/></c:facet>
            <h:outputText value="#{list.demandStyleDes}"/>
        </h:column>
		
		<h:column>
            <c:facet name="header"><h:outputText value="��ѵʱ��"/></c:facet>
            <h:outputText value="#{list.demandTimeDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�༭" onclick="return modify('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked!='1'}" disabled="false"></h:commandButton>
        	<h:commandButton value="�鿴" onclick="doShowDeatail('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked!='0'}" disabled="false"></h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>