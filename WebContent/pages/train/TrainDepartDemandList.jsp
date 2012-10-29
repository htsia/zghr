<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addBook(){
             if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
                 alert("请选择机构!");
                 return false;
             }
             window.showModalDialog("/train/TrainDepartDemandEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:700px; dialogHeight:600px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/TrainDepartDemandEdit.jsf?orgID="+id, "", "dialogWidth:700px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
        function doShowDeatail(id){
            window.showModalDialog("/train/TrainDetailDemand.jsf?demandID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>

<x:saveState value="#{train_departdemandlistbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{train_departdemandlistbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_departdemandlistbb.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{train_departdemandlistbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            
            <h:panelGroup>
                <h:outputText value="记录数:#{train_departdemandlistbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{train_departdemandlistbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{train_departdemandlistbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{train_departdemandlistbb.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{train_departdemandlistbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{train_departdemandlistbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{train_departdemandlistbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{train_departdemandlistbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addBook();" styleClass="button01" ></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <h:dataTable value="#{train_departdemandlistbb.departDemandList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="提需求部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="提出时间"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>

		<h:column>
            <c:facet name="header"><h:outputText value="培训形式"/></c:facet>
            <h:outputText value="#{list.demandStyleDes}"/>
        </h:column>
		
		<h:column>
            <c:facet name="header"><h:outputText value="培训时间"/></c:facet>
            <h:outputText value="#{list.demandTimeDes}"/>
        </h:column>
		
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="编辑" onclick="return modify('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked!='1'}" disabled="false"></h:commandButton>
            <h:commandButton value="查看" onclick="doShowDeatail('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked!='0'}" disabled="false"></h:commandButton>
        </h:column>
    </h:dataTable>
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