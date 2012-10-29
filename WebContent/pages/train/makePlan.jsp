<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addPlan(){
             if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
                 alert("请选择机构!");
                 return false;
             }
             window.showModalDialog("/train/addTrainPlan.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:600px; dialogHeight:550px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/addTrainPlan.jsf?planID="+id, "", "dialogWidth:600px; dialogHeight:550px; status:0;resizable:yes");
            return true;
        }
        function trainClassManager(id){
            window.showModalDialog("/train/trainClassManager.jsf?planID="+id, "", "dialogWidth:"+screen.width*0.75+"px; dialogHeight:550px; status:0;resizable:yes");
            return true;
        }
        function viewAtt(id){
        	 window.open('/pages/train/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
        }
    </script>

<x:saveState value="#{TrainPlan_makeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{TrainPlan_makeBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{TrainPlan_makeBB.superId}"></h:inputHidden>
    
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 培训管理-> 培训计划制定</td>
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
                <h:outputText value="记录数:#{TrainPlan_makeBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{TrainPlan_makeBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{TrainPlan_makeBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{TrainPlan_makeBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{TrainPlan_makeBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{TrainPlan_makeBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{TrainPlan_makeBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{TrainPlan_makeBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addPlan();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
   	<c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{TrainPlan_makeBB.planList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%">
        <h:column>
             <c:facet name="header"><h:outputText value="序号"/></c:facet>
             <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="计划名称"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划审批意见"/></c:facet>
            <h:outputText value="#{list.auditContent}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划年度"/></c:facet>
            <h:outputText value="#{list.year}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划季度"/></c:facet>
            <h:outputText value="#{list.dateType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划月份"/></c:facet>
            <h:outputText value="#{list.month}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="预算总额"/></c:facet>
            <h:outputText value="#{list.planBudget}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="计划人数"/></c:facet>
            <h:outputText value="#{list.createaOper}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="编制日期"/></c:facet>
            <h:outputText value="#{list.createDate}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="附件"/></c:facet>
            <h:outputText value="无" rendered="#{list.isHaveAtt=='0'}"/>
            <h:commandLink value="附件"  rendered="#{list.isHaveAtt=='1'}" onclick="viewAtt('#{list.planAtt}')">
   			</h:commandLink>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="培训班管理" onclick="return trainClassManager('#{list.planID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="修改" onclick="return modify('#{list.planID}')" styleClass="button01" rendered="#{list.status=='0' or list.status=='5'}"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{TrainPlan_makeBB.delete}" styleClass="button01" rendered="#{list.status=='0' or list.status=='5'}">
                  <x:updateActionListener property="#{TrainPlan_makeBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
            <h:commandButton value="报批" styleClass="button01" action="#{TrainPlan_makeBB.baopi}" rendered="#{list.status=='0'}">
            	<x:updateActionListener property="#{TrainPlan_makeBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
            <h:commandButton value="执行"  styleClass="button01" action="#{TrainPlan_makeBB.zhixing}" rendered="#{list.status=='2'}">
            	 <x:updateActionListener property="#{TrainPlan_makeBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
            <h:commandButton value="结束"  styleClass="button01" action="#{TrainPlan_makeBB.jiesu}" rendered="#{list.status=='3'}">
            	<x:updateActionListener property="#{TrainPlan_makeBB.planID}" value="#{list.planID}"/>
            </h:commandButton>
            <h:commandButton value="查看流程" onclick="return showWorkFlowLogByLinkID('#{list.planID}')" styleClass="button01" rendered="#{TrainPlan_makeBB.isWorkFlow=='1'}"></h:commandButton>
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
