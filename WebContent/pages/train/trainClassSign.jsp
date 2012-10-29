<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function query(id){
            window.showModalDialog("/train/TrainClassAuditQuery.jsf?classID="+id, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
        function signed(id){
            window.open("/train/trainClassSignList.jsf?classID="+id, "", "dialogWidth:800px; dialogHeight:800px; status:0;resizable:yes");
            return true;
        }
        function queryStudent(id){
            window.open("/train/trainClassSignList1.jsf?classID="+id, "", "dialogWidth:800px; dialogHeight:800px; status:0;resizable:yes");
            return true;
        }
        
     </script>

<x:saveState value="#{TrainSignClasslistBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{TrainSignClasslistBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{TrainSignClasslistBB.superId}"></h:inputHidden>
    
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> ��ѵ����-> ��ѵ�౨��</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{TrainSignClasslistBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{TrainSignClasslistBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{TrainSignClasslistBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{TrainSignClasslistBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{TrainSignClasslistBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{TrainSignClasslistBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{TrainSignClasslistBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{TrainSignClasslistBB.last}" styleClass="button01"></h:commandButton>
	            
	        </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{TrainSignClasslistBB.classList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ������"/></c:facet>
            <h:outputText value="#{list.className}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.classMajor}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵĿ��"/></c:facet>
            <h:outputText value="#{list.classAid}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ����"/></c:facet>
            <h:outputText value="#{list.classScope}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="Ӧ�÷�Χ"/></c:facet>
            <h:outputText value="#{list.org_scope}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.classPCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.studentCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʱ"/></c:facet>
            <h:outputText value="#{list.classHour}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.classStatusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������ʼʱ��"/></c:facet>
            <h:outputText value="#{list.signBeginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������ʱ��"/></c:facet>
            <h:outputText value="#{list.signEndTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ��ʼʱ��"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ����ʱ��"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="����" onclick="return signed('#{list.classID}')" styleClass="button01" rendered="#{list.classStatus=='2' && list.classType=='0'}"></h:commandButton>
            <h:commandButton value="�鿴" onclick="return query('#{list.classID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="�鿴ѧԱ" onclick="return queryStudent('#{list.classID}')" styleClass="button01"></h:commandButton>
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
