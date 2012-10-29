<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.cont.web.ContNewSignBackingBean"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{cont_contNewSignBB}"/>

<script type="text/javascript" language="javascript">
    function importContact(){
        window.showModalDialog("/cont/import/PerDataUpload.jsf", "dialogWidth:750px; dialogHeight:500px; center:center; status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    }
    function clearws() {
        document.getElementById("checkSubmitFlg").value="0";
    }
    function clearStatew() {
        setInterval("clearws()",2000);
    }
    function valid(ctrlobj){
        if(!checkBatchDo('selected_ids')){  return false; }
        showx = 300 ;
        showy = 200;
        retval = window.showModalDialog("/cont/SelectValidDateForNewSign.jsf", "", "dialogWidth:350px; dialogHeight:230px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
        if (retval != null) {
               var temp =  retval.indexOf(',');
               form1.all("form1:str").value = retval.substr(0,temp);
               form1.all("form1:printFlag").value = retval.substr(temp+1);
        } else {
               return false;
        }
     }
     function doApprove(){
        if (confirm(' 确定要做报审吗？')) {
            return true;
        } else {
            return false;
        }
     }
     function doCancelApprove(){
        if (confirm(' 确定要撤销报审吗？')) {
            return true;
        } else {
            return false;
        }
     }

    //打包下载
    function downloadBatch(form1){
        if(!checkBatchDo('selected_ids')){  return false; }
        var old_action = document.form1.action;
        window.open("","downloadBatch","left=400,top=300,height=100,width=200,toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes");
        document.form1.target = 'downloadBatch';
        var temp_action = "/pages/cont/DownloadBatch.jsp";
        document.form1.action = temp_action;
        form1.submit();
        document.form1.action = old_action;
        document.form1.target = '_self';
    }

    function checkModiCode(selected_ids){
        var form = document.forms[0];
        var field = form(selected_ids);
        var size = field.length;
        //debugger;
        var flag=0;
        if (size == null) {
            if (!field.checked) {
                alert("请选择要修改的项目!");
                return false;
            }
            else{
                if (document.all('form1:data_0:status').innerText=="审查通过"){
                    alert("已审批项目不能修改!");
                    return false;
                }
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (field[i].checked) {
                    if (document.all('form1:data_'+i+':status').innerText=="审查通过"){
                        flag=2;
                        break;
                    }
                    else{
                       flag=3;
                    }
                }
            }
            if (flag==0) {
                alert("请选择要修改的项目!");
                return false;
            }
            if (flag==2){
                alert("已审批项目不能修改!");
                return false;
            }
        }
        return true;
    }

    function checkDelete(selected_ids){
        var form = document.forms[0];
        var field = form(selected_ids);
        var size = field.length;
        //debugger;
        var flag=0;
        if (size == null) {
            if (!field.checked) {
                alert("请选择要删除的项目!");
                return false;
            }
            else{
                if (document.all('form1:data_0:status').innerText=="审查通过"){
                    alert("已审批项目不能删除!");
                    return false;
                }
            }
        } else {
            for (var i = 0; i < size; i++) {
                if (field[i].checked) {
                    if (document.all('form1:data_'+i+':status').innerText=="审查通过"){
                        flag=2;
                        break;
                    }
                    else{
                       flag=3;
                    }
                }
            }
            if (flag==0) {
                alert("请选择要删除的项目!");
                return false;
            }
            if (flag==2){
                alert("已审批项目不能删除!");
                return false;
            }
        }

        if (confirm('确定要删除吗？')) {
            return true;
        } else {
            return false;
        }
    }
</script>

<h:form id="form1">
<h:inputHidden id="init_a" value="#{cont_contNewSignBB.init_a}"/>
<h:inputHidden id="str" value="#{cont_contNewSignBB.validDate}"/>
<h:inputHidden id="printFlag" value="#{cont_contNewSignBB.printFlag}"/>

<h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
   <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 合同管理 ->  合同新签"/>
    </h:panelGroup>

    <h:panelGrid  border="0"  cellspacing="0" align="right" columns="4" >
        <h:outputText value="未签合同集团内调入人员：#{cont_contNewSignBB.adjustCount}" rendered="#{cont_contNewSignBB.empChangeMode=='1'}"></h:outputText>
        <h:commandButton styleClass="button01" value="未签合同调入员工列表" action="cont_adjustPersonList_jsf" rendered="#{cont_contNewSignBB.empChangeMode=='1'}"/>
        <h:outputText value="未签合同新员工共有：#{cont_contNewSignBB.newCount}"></h:outputText>
        <h:commandButton styleClass="button01" value="未签合同新员工列表" action="cont_PersonList_jsf"/>
    </h:panelGrid>

</h:panelGrid>

<h:panelGrid  border="0"  align="center" columns="1" width="95%">

     <h:panelGrid  border="0"  cellspacing="0" align="left" columns="10" >
         <h:panelGroup>
             <h:outputText value=" 姓名："/>
             <h:inputText styleClass="input" size="15" id="personNameQry" value="#{cont_contNewSignBB.personNameQry}"/>
             <h:outputText value="审查状态："/>
             <h:selectOneMenu value="#{cont_contNewSignBB.approveStatusQry}" id="approveStatusQry">
                        <c:selectItem itemValue="" itemLabel="请选择" />
                        <c:selectItem itemValue="201001" itemLabel="未报审" />
                        <c:selectItem itemValue="201002" itemLabel="待审查" />
                        <c:selectItem itemValue="201003" itemLabel="审查通过" />
                        <c:selectItem itemValue="201004" itemLabel="审查未过" />
            </h:selectOneMenu>
            <h:commandButton styleClass="button01" value=" 查询 " action="#{cont_contNewSignBB.queryAll}"/>
        </h:panelGroup>

        <%
            ContNewSignBackingBean bb = (ContNewSignBackingBean)request.getAttribute("cont_contNewSignBB");
            bb.checkRight();
        %>
        <h:commandButton styleClass="button01" value="新签合同" action="#{cont_contNewSignBB.forwardAdd}"  />
        <h:commandButton styleClass="button01" value="导入" onclick="importContact();" />
        <h:commandButton styleClass="button01" value="批量修改" action="#{cont_contNewSignBB.findByIds}" onclick="return checkBatchDo('selected_ids');"/>
        <h:commandButton styleClass="button01" value="合同编号维护" action="#{cont_contNewSignBB.editMainContCode}" onclick="return checkModiCode('selected_ids');"/>
        <h:commandButton styleClass="button01" value="报审" action="#{cont_contNewSignBB.toApprove}" onclick="if(checkBatchDo('selected_ids')) { return doApprove(); } else {return false;}"/>
        <h:commandButton styleClass="button01" value="撤销报审" action="#{cont_contNewSignBB.toCancelApprove}" onclick="if(checkBatchDo('selected_ids')) { return doCancelApprove(); } else {return false;}"/>
        <h:commandButton styleClass="button01" value="生效" action="#{cont_contNewSignBB.toValid}" onclick="javascript:return valid();"/>
        <h:commandButton styleClass="button01" value="删除" action="#{cont_contNewSignBB.deleteBatch}" onclick="return checkDelete('selected_ids');" />
        <c:verbatim escape="false"><input type="button" class="button01"   name="cont_button" value="合同下载" onclick="javascript:downloadBatch(document.forms(0));" /> </c:verbatim>
     </h:panelGrid>

    <h:panelGrid align="right" styleClass="locked_top">
        <h:panelGroup>
            <h:outputText value="记录数:#{cont_contNewSignBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="页数:#{cont_contNewSignBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="每页有#{cont_contNewSignBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="当前为第#{cont_contNewSignBB.pagevo.currentPage}页"></h:outputText>
            <h:commandButton value="首页" action="#{cont_contNewSignBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{cont_contNewSignBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{cont_contNewSignBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{cont_contNewSignBB.last}" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
    
</h:panelGrid>

<x:dataTable value="#{cont_contNewSignBB.bos}" var="list"  rowIndexVar="index" id="data"
                     headerClass="td_top"   align="center"
                     rowClasses="td_middle" styleClass="table03" width="95%" border="1">
             <h:column>
                  <c:facet name="header">
                      <c:verbatim escape="false">
                      <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                      </c:verbatim>
                      </c:facet>
                  <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                  <h:outputText value="#{list.contId}"/>
                  <h:outputText value=","/>
                  <h:outputText value="#{list.contPersonBO.personId}"/>
                  <h:outputText value=","/>
                  <h:outputText value="#{list.attachmentId}"/>
                  <c:verbatim>"></c:verbatim>
              </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同编号"/></c:facet>
                <h:outputText value="#{list.contCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.contPersonBO.personName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                <h:outputText value="#{list.contPersonBO.personSex}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="岗位类别"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同约定起始时间"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="合同约定终止时间"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="审查状态"/></c:facet>
                <h:outputText id="status" value="#{list.approveStatus}" title="审查单位：#{list.approveOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandLink id="bnt1" value="人员信息查看" onclick="forViewPersonDetail('#{list.contPersonBO.personId}')">
                </h:commandLink>
                <h:outputText value="  "/>
                <h:commandLink id="bnt2" value="合同信息" action="#{cont_contNewSignBB.findById}">
                    <c:param name="contId" value="#{list.contId}"/>
                </h:commandLink>
                <h:outputText value="  "/>
                <c:verbatim escape="false"><A  onclick="doShowCont('</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">')" taget="_blank" ></c:verbatim>
                <h:outputText value="合同查看" />
                <c:verbatim escape="false"></A></c:verbatim>
                <h:outputText value="  "/>
                <h:commandLink id="link2" value="审查信息" action="#{cont_contNewSignBB.findApproveInfoById}" >
                     <c:param name="contId" value="#{list.contId}"/>
                </h:commandLink>
            </h:column>
</x:dataTable>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:data");
</script>
