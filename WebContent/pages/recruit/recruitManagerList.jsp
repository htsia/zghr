<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
	<c:verbatim><script language="javascript" src="/js/list.js"></script></c:verbatim>
    <script type="text/javascript">
         function addTeacher(){
             window.showModalDialog("/recruit/recruitManagerEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/recruit/recruitManagerEdit.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
        function recruitPost(id){
            window.showModalDialog("/recruit/inner/publish.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
        function recruitPost2(id){
            window.showModalDialog("/recruit/outterPublish.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }  
        function recruitPost3(id){
            window.showModalDialog("/recruit/inner/publishQuery.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
        function recruitPost4(id){
            window.showModalDialog("/recruit/outterPublishQuery.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
        function queryCheckPerson(id){
        	window.showModalDialog("/recruit/QueryCheckInPerson.jsf?planID="+id, "", "dialogWidth:800px; dialogHeight:600px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{recruit_ManagerListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{recruit_ManagerListBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{recruit_ManagerListBB.superId}"></h:inputHidden>
    
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 招聘管理-> 招聘管理信息维护</td>
        </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="1">
             <h:panelGroup>
                <h:outputText value="记录数:#{recruit_ManagerListBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recruit_ManagerListBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recruit_ManagerListBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recruit_ManagerListBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{recruit_ManagerListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recruit_ManagerListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recruit_ManagerListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recruit_ManagerListBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addTeacher();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{recruit_ManagerListBB.planList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="locked_top" columnClasses="td_middle_center_lock,td_middle_center_lock,td_middle_center_lock,td_middle,td_middle,td_middle,td_middle,td_middle,td_middle_left"
                 styleClass="table03" width="1400" >
        
        <x:column width="40">
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </x:column>
        <x:column width="200">
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="修改" onclick="return modify('#{list.planID}')" styleClass="button01" rendered="#{list.planStatus=='0'  || list.planStatus=='5'}"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{recruit_ManagerListBB.delete}" styleClass="button01" rendered="#{list.planStatus=='0' || list.planStatus=='5'}">
                  <x:updateActionListener property="#{recruit_ManagerListBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
            <h:commandButton value="报批" styleClass="button01" action="#{recruit_ManagerListBB.baopi}" rendered="#{list.planStatus=='0' && list.isHavePost=='1'}">
            	<x:updateActionListener property="#{recruit_ManagerListBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
            <h:commandButton value="查看" onclick="return recruitPost3('#{list.planID}')" styleClass="button01" rendered="#{list.planStatus=='1' && list.planMethod=='0'}"></h:commandButton>
            <h:commandButton value="查看" onclick="return recruitPost4('#{list.planID}')" styleClass="button01" rendered="#{list.planStatus=='1' && list.planMethod=='1'}"></h:commandButton>
            <h:commandButton value="招聘职位" onclick="return recruitPost('#{list.planID}')" styleClass="button01" rendered="#{list.planStatus=='0' && list.planMethod=='0'}"></h:commandButton>
            <h:commandButton value="招聘职位" onclick="return recruitPost2('#{list.planID}')" styleClass="button01" rendered="#{list.planStatus=='0' && list.planMethod=='1'}"></h:commandButton>
            <h:commandButton value="查看录取人员" onclick="return queryCheckPerson('#{list.planID}')" styleClass="button01" rendered="#{list.planMethod=='1'}"></h:commandButton>
            <h:commandButton value="结束"  styleClass="button01" action="#{recruit_ManagerListBB.jiesu}" rendered="#{list.planStatus=='3'}">
            	<x:updateActionListener property="#{recruit_ManagerListBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
             <h:commandButton value="查看流程" onclick="return showWorkFlowLogByLinkID('#{list.planID}')" styleClass="button01" rendered="#{recruit_ManagerListBB.isWorkFlow=='1'}"></h:commandButton>
        </x:column>
        <x:column width="200">
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </x:column>
        <x:column width="100">
            <c:facet name="header"><h:outputText value="周期类型"/></c:facet>
            <h:outputText value="#{list.planType}"/>
        </x:column>
        <x:column width="100">
            <c:facet name="header" ><h:outputText value="计划方式"/></c:facet>
            <h:outputText value="#{list.plaMethodDesc}"/>
        </x:column>
        <x:column width="100">
            <c:facet name="header" ><h:outputText value="计划类型"/></c:facet>
            <h:outputText value="#{list.postModeDes}"/>
        </x:column>
        <x:column width="40">
            <c:facet name="header"><h:outputText value="预算"/></c:facet>
            <h:outputText value="#{list.budget}"/>
        </x:column>
        <x:column width="110">
            <c:facet name="header"><h:outputText value="开始日期"/></c:facet>
            <h:outputText value="#{list.startDate}"/>
        </x:column>
        <x:column width="110">
            <c:facet name="header"><h:outputText value="结束日期"/></c:facet>
            <h:outputText value="#{list.endDate}"/>
        </x:column>
         <x:column width="160">
            <c:facet name="header"><h:outputText value="招聘职位个数"/></c:facet>
            <h:outputText value="#{list.postCount}"/>
        </x:column>
         <x:column width="150">
            <c:facet name="header"><h:outputText value="总需求人数"/></c:facet>
            <h:outputText value="#{list.needCount}"/>
        </x:column>
        <x:column width="40">
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.planStatusDes}"/>
        </x:column>
        <x:column width="100">
            <c:facet name="header"><h:outputText value="审批意见"/></c:facet>
            <h:outputText value="#{list.approveReason}"/>
        </x:column>
        <x:column width="80">
            <c:facet name="header"><h:outputText value="创建人"/></c:facet>
            <h:outputText value="#{list.createID}"/>
        </x:column>
         <x:column width="110">
            <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </x:column>
        <x:column width="110">
            <c:facet name="header"><h:outputText value="是否需要考试"/></c:facet>
            <h:outputText value="#{list.testDesc}"/>
        </x:column>
        <x:column width="110">
            <c:facet name="header"><h:outputText value="最多应聘岗位"/></c:facet>
            <h:outputText value="#{list.maxRecuPost}"/>
        </x:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
   tableFixCol=3;// 锁定两列
   listControl=document.all("form1:dateList");
   window.setInterval('setFixCol()', 700);
</script>
