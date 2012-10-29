<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
         function showDeptCommit(id){
        	 window.open("/employee/title/titleApplyItemList.jsf?applayId="+id, "", "height="+screen.height*0.8+", width="+screen.width+", top=50,left=0, toolbar=yes, menubar=no, location=no, resizable=yes,status=no");
             return true;  
         }
         function modify(id){
        	 window.showModalDialog("/employee/title/titleApplyEdit.jsf?applayId="+id, "", "dialogWidth:350px; dialogHeight:250px; status:0;resizable:yes");
             return true;  
         }
         function setContent(id){
        	 window.showModalDialog("/employee/title/applyContentMgr.jsf?applyId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
             return true;  
         }
         function add(){
        	 window.showModalDialog("/employee/title/titleApplyEdit.jsf?superId=new", "", "dialogWidth:350px; dialogHeight:250px; status:0;resizable:yes");
             return true;  
         }
         
         function showResult(id){
        	 window.showModalDialog("/employee/title/applyItemResult.jsf?applayId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
             return true;  
         }
         function deptSet3(id){
        	 window.showModalDialog("/employee/title/AuditGroupMgr.jsf?applayId="+id, "", "dialogWidth:750px; dialogHeight:400px; status:0;resizable:yes");
             return true;  
         }
         function setScoreSet(id){
        	 window.showModalDialog("/employee/title/AuditMasterList.jsf?applyId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
             return true;  
         }
         function showVoting(id){
        	 window.showModalDialog("/employee/title/applyItemVoteResult.jsf?applayId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.7+"px; status:0;resizable:yes");
             return true;  
         }
         function showProcessBar() {
     	    x = document.body.clientWidth / 2 - 150;
     	    y = document.body.clientHeight / 2;
     	    document.all('processbar').style.top = y;
     	    document.all('processbar').style.left = x;
     	    document.all('processbar').style.display = "";
     	 }
    </script>

<x:saveState value="#{emptitleapplyBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{emptitleapplyBB.pageInit}"></h:inputHidden>
	<c:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 职称评审 ->申报管理 </td>
        </tr>
    </table>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            	</c:verbatim>
			          <h:panelGrid align="right" columns="2">
			             <h:panelGroup>
			                <h:outputText value="记录数:#{emptitleapplyBB.mypage.totalRecord}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="页数:#{emptitleapplyBB.mypage.totalPage}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="每页有#{emptitleapplyBB.mypage.pageSize}"></h:outputText>
				            <h:outputText value="  "></h:outputText>
				            <h:outputText value="当前为第#{emptitleapplyBB.mypage.currentPage}页"></h:outputText>
			           		<h:commandButton value="首页" action="#{emptitleapplyBB.first}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="上页" action="#{emptitleapplyBB.pre}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="下页" action="#{emptitleapplyBB.next}" styleClass="button01"></h:commandButton>
				            <h:commandButton value="尾页" action="#{emptitleapplyBB.last}" styleClass="button01"></h:commandButton>
				            <h:outputText value="  "></h:outputText>
	            			<h:commandButton value="增加" onclick="return add();" styleClass="button01"></h:commandButton>
			            </h:panelGroup>
			          
			          </h:panelGrid>
            	<c:verbatim>
            	</td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{emptitleapplyBB.titleApplyList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="序号"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="年度"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.year}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="开始时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.beginDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="结束时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.endDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="申报人数"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.applyCount}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="状态"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    
                    <h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:panelGrid columns="6">
						<h:commandButton value="编辑" styleClass="button01" onclick="modify('#{list.applyId}')" rendered="#{list.status=='0'}"></h:commandButton>
						<h:commandButton value="结束" onclick="return confirm('确定要结束吗?');" action="#{emptitleapplyBB.end}" styleClass="button01" rendered="#{list.status=='0'}">
                  	        <x:updateActionListener property="#{emptitleapplyBB.applayId}" value="#{list.applyId}"/>
            			</h:commandButton>
            			<h:commandButton value="评审内容设置" styleClass="button01" onclick="setContent('#{list.applyId}')"></h:commandButton>
					    <h:commandButton value="发公告" styleClass="button01" rendered="#{list.isSendBull=='0'}" action="#{emptitleapplyBB.savebull}">
					    	<x:updateActionListener property="#{emptitleapplyBB.applayId}" value="#{list.applyId}"/>
					    </h:commandButton>
						<h:commandButton value="修改公告" styleClass="button01" onclick="return doEditBulletin('#{list.bulletin}')" rendered="#{list.isSendBull=='1'}"></h:commandButton>
						<h:commandButton value="申报人员信息" styleClass="button01" onclick="showDeptCommit('#{list.applyId}')"></h:commandButton>
						<h:commandButton value="格式化申报材料" styleClass="button01" action="#{emptitleapplyBB.refreashMatirao}" onclick="showProcessBar();">
					    	<x:updateActionListener property="#{emptitleapplyBB.applayId}" value="#{list.applyId}"/>
					    </h:commandButton>
						</h:panelGrid>
						<h:panelGrid columns="5">
						<h:commandButton value="评审团管理" styleClass="button01" onclick="deptSet3('#{list.applyId}')"></h:commandButton>
						<h:commandButton value="评审打分设置" styleClass="button01" onclick="setScoreSet('#{list.applyId}')"></h:commandButton>
						<h:commandButton value="全部计算" styleClass="button01" action="#{emptitleapplyBB.caculateAllPerson}" onclick="showProcessBar();">
					    	<x:updateActionListener property="#{emptitleapplyBB.applayId}" value="#{list.applyId}"/>
					    </h:commandButton>
						<h:commandButton value="打分结果" styleClass="button01" onclick="showResult('#{list.applyId}')"></h:commandButton>
						<h:commandButton value="投票结果" styleClass="button01" onclick="showVoting('#{list.applyId}')"></h:commandButton>
            			</h:panelGrid>
					</h:column>
				</x:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	</table>
	<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
