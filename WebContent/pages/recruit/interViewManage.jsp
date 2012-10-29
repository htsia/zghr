<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

    <script type="text/javascript">
      function beginTest(detailId){
      	  window.showModalDialog("/recruit/beginTest.jsf?detailId="+detailId, null, "dialogWidth:500px; dialogHeight:320px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
      }
      function showResult(personId,staus){
	   window.showModalDialog("/recruit/resumeDetail2.jsf?personId="+personId+"&status="+staus, "", "dialogHeight="+screen.height*0.7+"px; dialogWidth="+screen.width*0.7+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=yes;location=no; status=no");
       return true;
   }
    </script>
<x:saveState value="#{recu_interviewResultBB}"/>
<h:form id="form1">
    <h:inputHidden value = "#{recu_interviewResultBB.initManagePage}"></h:inputHidden>
   <c:verbatim>
       <table height="98%" width="98%" align="center">
       <tr><td height="8"> 
    </c:verbatim>
    
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
            	<h:selectBooleanCheckbox value="#{recu_interviewResultBB.selectAll}" onclick="submit();" valueChangeListener="#{recu_interviewResultBB.queryAll}" />
				<h:outputText value="显示全部"/>
				<h:outputText value=" "/>
                <h:outputText value="记录数:#{recu_interviewResultBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{recu_interviewResultBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{recu_interviewResultBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{recu_interviewResultBB.mypage.currentPage}页"></h:outputText>
	            <h:commandButton value="首页" action="#{recu_interviewResultBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{recu_interviewResultBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{recu_interviewResultBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{recu_interviewResultBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id='datatable'>
	</c:verbatim>
    <x:dataTable value="#{recu_interviewResultBB.interviewList}" width="100%" var="list" rowIndexVar="index" align="center" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" >
             
            <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="已通知面试的人"/></c:facet>
                <h:outputText value="#{list.personName}"/>
            </h:column>
        	<h:column rendered="#{recu_interviewResultBB.postMode=='0'}">
                <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
                <h:outputText value="#{list.postName}"/>
            </h:column>
            <h:column rendered="#{recu_interviewResultBB.postMode=='1'}">
                <c:facet name="header"><h:outputText value="岗位类型"/></c:facet>
                <h:outputText value="#{list.postType}"/>
            </h:column>
            <h:column rendered="#{recu_interviewResultBB.postMode=='1'}">
                <c:facet name="header"><h:outputText value="专业"/></c:facet>
                <h:outputText value="#{list.majorType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
        <h:column>
                 <c:facet name="header"><h:outputText value="操作"/></c:facet>
                 <h:commandButton value="开始考试" styleClass="button01" onclick="beginTest('#{list.detailId}')" rendered="#{list.ifSetTest=='0' && list.status=='1'&& recu_interviewResultBB.haveTest=='1'}"></h:commandButton>
                 <h:outputText value="  "></h:outputText>
                 <h:commandButton value="开始面试"  action="#{recu_interviewResultBB.begingInterview}" styleClass="button01" rendered="#{(list.isFinishTest=='1'||recu_interviewResultBB.haveTest=='0')&& list.status=='1'}">
                  <x:updateActionListener property="#{recu_interviewResultBB.detailId}" value="#{list.detailId}"/>
            	</h:commandButton>
                 <h:commandButton value="简历信息"  styleClass="button01" onclick="return showResult('#{list.personId}','#{list.status}');"/>
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