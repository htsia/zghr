<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addPersonDemand(){
            
             window.showModalDialog("/train/TrainPersonDemandEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:750px; dialogHeight:660px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/TrainPersonDemandEdit.jsf?demandId="+id, "", "dialogWidth:750px; dialogHeight:660px; status:0;resizable:yes");
            return true;
        }
        function doShowDeatail(id){
            window.showModalDialog("/train/TrainDetailDemand.jsf?demandID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        
    </script>
 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{train_personDemandListbb}"></x:saveState>

<h:form id="form1">
    <h:inputHidden value="#{train_personDemandListbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_personDemandListbb.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{train_personDemandListbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            
            <h:panelGroup>
                <h:outputText value="��¼��:#{train_personDemandListbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{train_personDemandListbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{train_personDemandListbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{train_personDemandListbb.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{train_personDemandListbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_personDemandListbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_personDemandListbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{train_personDemandListbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return addPersonDemand();" styleClass="button01" ></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <h:dataTable value="#{train_personDemandListbb.personDemandList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.personID}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
            <h:outputText value="#{list.deptID}"/>
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
            <h:commandButton value="�鿴" onclick="return doShowDeatail('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked=='1'}"></h:commandButton>
            <h:commandButton value="�༭" onclick="return modify('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked=='0'}"></h:commandButton>
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
