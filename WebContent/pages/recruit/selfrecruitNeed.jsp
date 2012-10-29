<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
         function addSelfRecuNeed(){
            
             window.showModalDialog("/recruit/selfrecruitNeedEdit.jsf?personId="+document.all("form1:personID").value, "", "dialogWidth:350px; dialogHeight:260px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/recruit/selfrecruitNeedEdit.jsf?itemId="+id, "", "dialogWidth:350px; dialogHeight:260px; status:0;resizable:yes");
            return true;
        }
       
      
        
    </script>
<x:saveState value="#{selfrecu_need_collectBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{selfrecu_need_collectBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="personID" value="#{selfrecu_need_collectBB.personId}"></h:inputHidden>
        <c:verbatim>
       <table height=98% width=98% align="center">
       <tr>
       		<td class="td_title" height="8"><img src="/images/tips.gif"> 自助>>自助招聘需求</td>
       </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">      
            <h:panelGroup>
                <h:outputText value="记录数:#{selfrecu_need_collectBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{selfrecu_need_collectBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{selfrecu_need_collectBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{selfrecu_need_collectBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{selfrecu_need_collectBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{selfrecu_need_collectBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{selfrecu_need_collectBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{selfrecu_need_collectBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          <h:commandButton value="增加" onclick="return addSelfRecuNeed();" styleClass="button01" ></h:commandButton>
          </h:panelGrid>
         
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable align="center">
	</c:verbatim> 
    <x:dataTable value="#{selfrecu_need_collectBB.selfRecuNeedList}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" 
					styleClass="table03" width="90%" border="0">
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="公布时间" />
						</c:facet>
						<h:outputText value="#{list.publishDate}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="岗位名称" />
						</c:facet>
						<h:outputText value="#{list.postId}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="填报人" />
						</c:facet>
						<h:outputText value="#{list.publishPersonName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="需求人数" />
						</c:facet>
						<h:outputText value="#{list.needCount}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="是否纳入计划" />
						</c:facet>
						<h:outputText value="#{list.isImportPlan}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑"
							onclick="return modify('#{list.itemId}')"
							styleClass="button01" rendered="#{list.isImportPlan=='否'}"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{selfrecu_need_collectBB.delete}"
							styleClass="button01" rendered="#{list.isImportPlan=='否'}">
							<x:updateActionListener
								property="#{selfrecu_need_collectBB.itemId}"
								value="#{list.itemId}" />
						</h:commandButton>
						<h:commandButton value="查看流程" onclick="return showWorkFlowLogByLinkID('#{list.importPlan}')" styleClass="button01" rendered="#{list.canSeach=='1'}"></h:commandButton>
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
</body> 