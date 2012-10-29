<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addPersonDemand(){
            
             window.showModalDialog("/train/SelfPersonDemandEdit.jsf?personId="+document.all("form1:personId").value, "", "dialogWidth:750px; dialogHeight:660px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/SelfPersonDemandEdit.jsf?demandId="+id, "", "dialogWidth:750px; dialogHeight:660px; status:0;resizable:yes");
            return true;
        }
        function doShowDeatail(id){
            window.showModalDialog("/train/TrainDetailDemand.jsf?demandID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        String.prototype.Trim = function(){ 
        	   return this.replace(/(^\s*)|(\s*$)/g, ""); 
        	} 

        	String.prototype.LTrim = function(){ 
        	   return this.replace(/(^\s*)/g, ""); 
        	} 

        	String.prototype.RTrim = function(){ 
        	   return this.replace(/(\s*$)/g, ""); 
        	} 

        	        
        /*合并相同值的行 
        @tbl :要合并的表格对象 
        @cellIndex:要合并的列 
        */ 
        function   MergeCellsVertical(tbl,cellIndex) { 
              //如果表格行数少于两行，直接返回 
              if (tbl.rows.length < 2) return;   
              var i,j;   
              var last = tbl.rows(0).cells(cellIndex).innerHTML;   
              var lastIndex = 0;       
              for(i = 1; i < tbl.rows.length; i++) { 
                  //发现新的值 
                  if(tbl.rows(i).cells(cellIndex).innerHTML != last)   
                    {         
                      if(i > lastIndex + 1)   
                      {   
                          for(j = lastIndex+1; j < i; j++)   
                          {   
                              tbl.rows(j).cells(cellIndex).removeNode();   
                          }   
                          tbl.rows(lastIndex).cells(cellIndex).rowSpan = i-lastIndex;   
                      }   
                      last = tbl.rows(i).cells(cellIndex).innerHTML;   
                      lastIndex = i;   
                  }   
              }   
              //最后一行要特别处理   
              if(lastIndex != tbl.rows.length - 1)   
             {         
                  for(j = lastIndex + 1; j < tbl.rows.length; j++)   
                  {             
                      tbl.rows(j).cells(cellIndex).removeNode();   
                  }   
                  tbl.rows(lastIndex).cells(cellIndex).rowSpan = tbl.rows.length - lastIndex + 1;   
              }   
        }   


        //页面onload的时候调用这个函数 
        function loadFinish(){ 
           var tbl=document.all("form1:dateList");
           for(var i=tbl.rows[0].cells.length;i>0;i--){ 
              var td=tbl.rows[0].cells[i-1].innerText.Trim(); 
              //合并表格列名为"日期"和"医生姓名"两列 
              if(td=='提需求者'||td=='所在部门'){ 
                MergeCellsVertical(tbl,i-1); 
              } 
           } 
        } 
                
        
    </script>
 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim> 

<x:saveState value="#{train_selfPersonDemandListbb}"></x:saveState>
<c:verbatim></c:verbatim>
<body onload="loadFinish()">
<h:form id="form1">
    
    <h:inputHidden value="#{train_selfPersonDemandListbb.pageInit}"></h:inputHidden>
     <h:inputHidden id="personId" value="#{train_selfPersonDemandListbb.personId}"></h:inputHidden>
        <c:verbatim>
       <table height=98% width=98% align="center">
       <tr>
       		<td class="td_title" height="8"><img src="/images/tips.gif"> 自助>>个人培训需求管理</td>
       </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
             
            <h:panelGroup>
                <h:outputText value="记录数:#{train_selfPersonDemandListbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{train_selfPersonDemandListbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{train_selfPersonDemandListbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{train_selfPersonDemandListbb.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{train_selfPersonDemandListbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{train_selfPersonDemandListbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{train_selfPersonDemandListbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{train_selfPersonDemandListbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addPersonDemand();" styleClass="button01" rendered="#{train_selfPersonDemandListbb.showAdd=='1'}"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <h:dataTable value="#{train_selfPersonDemandListbb.selfPersonDemandList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
     
        <h:column>
            <c:facet name="header"><h:outputText value="提需求者"/></c:facet>
            
            <h:outputText value="#{list.personID}"/>
        </h:column>
   
        <h:column>
            <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
            <h:outputText value="#{list.deptID}"/>
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
            <h:commandButton value="查看" onclick="return doShowDeatail('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked=='1'}"></h:commandButton>
            <h:commandButton value="编辑" onclick="return modify('#{list.demandID}')" styleClass="button01" rendered="#{list.demandLocked=='0'}"></h:commandButton>
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
</body> 