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

        	        
        /*�ϲ���ֵͬ���� 
        @tbl :Ҫ�ϲ��ı����� 
        @cellIndex:Ҫ�ϲ����� 
        */ 
        function   MergeCellsVertical(tbl,cellIndex) { 
              //�����������������У�ֱ�ӷ��� 
              if (tbl.rows.length < 2) return;   
              var i,j;   
              var last = tbl.rows(0).cells(cellIndex).innerHTML;   
              var lastIndex = 0;       
              for(i = 1; i < tbl.rows.length; i++) { 
                  //�����µ�ֵ 
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
              //���һ��Ҫ�ر���   
              if(lastIndex != tbl.rows.length - 1)   
             {         
                  for(j = lastIndex + 1; j < tbl.rows.length; j++)   
                  {             
                      tbl.rows(j).cells(cellIndex).removeNode();   
                  }   
                  tbl.rows(lastIndex).cells(cellIndex).rowSpan = tbl.rows.length - lastIndex + 1;   
              }   
        }   


        //ҳ��onload��ʱ������������ 
        function loadFinish(){ 
           var tbl=document.all("form1:dateList");
           for(var i=tbl.rows[0].cells.length;i>0;i--){ 
              var td=tbl.rows[0].cells[i-1].innerText.Trim(); 
              //�ϲ��������Ϊ"����"��"ҽ������"���� 
              if(td=='��������'||td=='���ڲ���'){ 
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
       		<td class="td_title" height="8"><img src="/images/tips.gif"> ����>>������ѵ�������</td>
       </tr>
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
             
            <h:panelGroup>
                <h:outputText value="��¼��:#{train_selfPersonDemandListbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{train_selfPersonDemandListbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{train_selfPersonDemandListbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{train_selfPersonDemandListbb.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{train_selfPersonDemandListbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_selfPersonDemandListbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_selfPersonDemandListbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{train_selfPersonDemandListbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return addPersonDemand();" styleClass="button01" rendered="#{train_selfPersonDemandListbb.showAdd=='1'}"></h:commandButton>
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
</body> 