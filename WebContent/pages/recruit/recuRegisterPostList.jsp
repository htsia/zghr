<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script>
   function reportsend(personId){
    window.showModalDialog("/recruit/recuReportInfoSend.jsf?detailIds="+personId, "", 'height=350px, width=600px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
    return true;
   }
   function doOK(){
	    var str="";
	    chk=document.forms(0).selectItem;
	    if (checkMutilSelect(chk)){
	        var size = chk.length;
	        if (size == null) {
	            if (chk.checked) {
	                str+=chk.value;
	            }
	        } else {
	            for (var i = 0; i < size; i++) {
	                if (chk[i].checked) {
	                    if (i==0){
	                        str+=chk[i].value;
	                    }
	                    else{
	                        str+=","+chk[i].value;
	                    }
	                }
	            }
	        }
	        window.showModalDialog("/recruit/recuReportInfoSend.jsf?detailIds="+str, "", 'height=500px, width=600px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	       	return true;
	    }else{
	        alert("请选择要加入的人员!");
	        return false;
	    }
	}
</script>
 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{recu_registerManageBB}"></x:saveState>

<h:form id="form1">
    <h:inputHidden value="#{recu_registerManageBB.initPost}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{recu_registerManageBB.superId}"></h:inputHidden>
   <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="right" columns="2">
          <h:panelGroup>
          	<h:selectBooleanCheckbox value="#{recu_registerManageBB.selectAll}" onclick="submit();" valueChangeListener="#{recu_registerManageBB.queryAll}" />
			<h:outputText value="未处理人员"/>
			<h:outputText value=" "/>
          	<h:commandButton styleClass="button01" value="批量通知" onclick="return doOK();" />
          	<h:outputText value=" "></h:outputText>
            <h:selectOneMenu id="tem" style="width:200px"  onchange="submit();"  valueChangeListener="#{recu_registerManageBB.getInitInterViewPassPerson}" >
					<c:selectItems value="#{recu_registerManageBB.recuOutterList}" />
				</h:selectOneMenu>   
            </h:panelGroup>
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
    </c:verbatim>  
    <x:dataTable value="#{recu_registerManageBB.outterInterViewPassPersonList}" var="list" align="center" id="dateList1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index">
      		<h:column>
						<f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.detailId}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
			</h:column>       
        
        <h:column>
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="应聘者"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
         <h:column rendered="#{recu_registerManageBB.postMode=='0'}">
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column rendered="#{recu_registerManageBB.postMode=='1'}">
            <c:facet name="header"><h:outputText value="岗位类型"/></c:facet>
            <h:outputText value="#{list.postType}"/>
        </h:column>
        <h:column rendered="#{recu_registerManageBB.postMode=='1'}">
            <c:facet name="header"><h:outputText value="专业"/></c:facet>
            <h:outputText value="#{list.majorType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="状态"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
			<c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="通知报到"  styleClass="button01" onclick="return reportsend('#{list.	detailId}');" rendered="#{list.status=='5'}"/>   
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
