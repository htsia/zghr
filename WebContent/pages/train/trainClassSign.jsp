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
            <td class="td_title"><img src="/images/tips.gif"> 培训管理-> 培训班报名</td>
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
                <h:outputText value="记录数:#{TrainSignClasslistBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{TrainSignClasslistBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{TrainSignClasslistBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{TrainSignClasslistBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{TrainSignClasslistBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{TrainSignClasslistBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{TrainSignClasslistBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{TrainSignClasslistBB.last}" styleClass="button01"></h:commandButton>
	            
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
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="培训班名称"/></c:facet>
            <h:outputText value="#{list.className}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="负责人"/></c:facet>
            <h:outputText value="#{list.classMajor}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="培训目的"/></c:facet>
            <h:outputText value="#{list.classAid}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="培训对象"/></c:facet>
            <h:outputText value="#{list.classScope}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="应用范围"/></c:facet>
            <h:outputText value="#{list.org_scope}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="人数"/></c:facet>
            <h:outputText value="#{list.classPCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="报名人数"/></c:facet>
            <h:outputText value="#{list.studentCount}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="课时"/></c:facet>
            <h:outputText value="#{list.classHour}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.classStatusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="报名开始时间"/></c:facet>
            <h:outputText value="#{list.signBeginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="报名结束时间"/></c:facet>
            <h:outputText value="#{list.signEndTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="培训开始时间"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="培训结束时间"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>
       <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="报名" onclick="return signed('#{list.classID}')" styleClass="button01" rendered="#{list.classStatus=='2' && list.classType=='0'}"></h:commandButton>
            <h:commandButton value="查看" onclick="return query('#{list.classID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="查看学员" onclick="return queryStudent('#{list.classID}')" styleClass="button01"></h:commandButton>
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
