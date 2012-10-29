<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
     function keySet(id) {
            window.showModalDialog("/xys/eva/SetDeptObjKeyLib.jsf?objId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
     }
     
     function selTemplate(){
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
                         if (str==""){
                             str+=chk[i].value;
                         }
                         else{
                             str+=","+chk[i].value;
                         }
                     }
                 }
             }
            if(str != null && str!=""){
           		document.all("form1:objIds").value=str;
           		var returnValue= window.showModalDialog("/xys/eva/Sel360Template.jsf", null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.4+"px;center:center;resizable:no;status:no;scroll:yes;");
           		if(returnValue!=null){
           			document.all("form1:templateId").value=returnValue;
               		return true;
           		}else{
           			return false;
           		}
            }else{
            	return false;
            }
         }else{
        	 return false;
         }
     }
     function selTemplate2(id){
           document.all("form1:objIds").value=id;
           var returnValue= window.showModalDialog("/xys/eva/Sel360Template.jsf", null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.4+"px;center:center;resizable:no;status:no;scroll:yes;");
           if(returnValue!=null){
              	document.all("form1:templateId").value=returnValue;
                return true;
           }else{
                return false;
           }
     }
</script>
<x:saveState value="#{xys_360SetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_360SetBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{xys_360SetBB.superId}"></h:inputHidden>
    <h:inputHidden id="templateId" value="#{xys_360SetBB.templateId}"></h:inputHidden>
    <h:inputHidden id="objIds" value="#{xys_360SetBB.objIds}"></h:inputHidden>
     <h:inputHidden id="planId" value="#{xys_360SetBB.planId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
		  <h:panelGrid align="center">
		  <h:panelGroup>
                  <h:outputText value="姓名或员工编号:"></h:outputText>
                  <h:inputText value="#{xys_360SetBB.queryValue}" styleClass="input"></h:inputText>
                  <h:commandButton value="查询" action="#{xys_360SetBB.doQuery}" styleClass="button01"></h:commandButton>
              </h:panelGroup>
		  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{xys_360SetBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{xys_360SetBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{xys_360SetBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{xys_360SetBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{xys_360SetBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{xys_360SetBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{xys_360SetBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{xys_360SetBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="选择模版" action="#{xys_360SetBB.selTemplate}" styleClass="button01" onclick="return selTemplate();" disabled="#{xys_360SetBB.disabled}"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_360SetBB.objList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
                 
        <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.objId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
        </h:column>         
        <h:column>
            <c:facet name="header"><h:outputText value="姓名"/></c:facet>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="模版名称"/></c:facet>
            <h:outputText value="#{list.templateName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
              <h:commandButton value="删除" action="#{xys_360SetBB.deleteObj}" onclick="return confirm('确实要删除指定被考核人员吗？');"
                               styleClass="button01" disabled="#{xys_360SetBB.disabled}">
                   <x:updateActionListener property="#{xys_360SetBB.objId}" value="#{list.objId}"/>
            </h:commandButton>
            <h:commandButton value="选择模版" action="#{xys_360SetBB.selTemplate}" styleClass="button01" 
            onclick="return selTemplate2('#{list.objId}');"  rendered="#{list.templateId=='NO-SET'}"></h:commandButton>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
