<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<base target="_self">
<script language="javascript">
    function OpenRpt(){
        if (document.all("form1:ReportID").value=="-1"){
            alert("请先选择表格样式！");
            return false;
        }

        if (checkMutilSelect(form1.chk)) {
            count = form1.chk.length;
            var perID = "";
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        perID = form1.chk[i].value;   // 取第一个
                        break;
                    }
            } else
                perID = form1.chk.value;
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+perID+"&ORGUID=&Parameter=&Title=";
            window.open(url);
        } else {
            alert("请选择人员");
        }
       return false;
   }
    
    function checkSubmit(form1) {
        flag = true;
        //审批意见
        var approveStatus = form1.all("form1:approveStatus").value;
        //截至生效日期
        var uptoValidDate = form1.all("form1:uptoValidDate").value;
        if (approveStatus == "201003") {
            if (uptoValidDate == "" || uptoValidDate == null) {
                alert("当审查意见为审查通过时，截至生效办理时间不能为空！");
                flag = false;
                return flag;
             }
        }else if(approveStatus == "201004"){
            if (uptoValidDate != "" && uptoValidDate != null) {
                alert("当审查意见为审查未过时，截至生效办理时间不能填写！");
                flag = false;
                return flag;
            }
        }
        //审批日期
        var approveDate = form1.all("form1:approveDate").value;

        if (uptoValidDate.trim() != "" && approveDate.trim() != "") {
            var sT = uptoValidDate.split("-");
            var stemp = new Date(sT[0], sT[1],  sT[2],"01");
            var wT = approveDate.split("-");
            var wtemp = new Date(wT[0], wT[1], wT[2],"01");
            if ((stemp.getTime() - wtemp.getTime()) <= 0) {
                alert("截至生效办理时间必须大于审查日期!");
                flag = false;
                return flag;
            }
        }
        var approveRemark = form1.all("form1:approveRemark").value;
        if (approveRemark != "" && approveRemark != null) {
            if (approveRemark.length>50) {
                alert("备注最多只能输入50个汉字！");
                flag = false;
                return flag;
            }
        }

       return flag;
}
function confirmSave(form1){
        if (confirm('确定要提交审查结果吗？')) {
            pageCodeExchange(form1);
            return true;
        } else {
            return false;
        }
}

</script>
<x:saveState value="#{cont_contApproveBB}"/>

<h:form id="form1">
<h:inputHidden id="str" value="#{cont_contApproveBB.initAudit}"/>
<h:inputHidden id="str" value="#{cont_contApproveBB.selectContIds}"/>

<h:panelGrid width="100%" border="0" cellspacing="6" cellpadding="0" styleClass="td_title">
   <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="审查合同 " ></h:outputText>
   </h:panelGroup> 
</h:panelGrid>


<h:panelGrid  border="0"  align="center" columns="1" width="98%">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="待审查人员合同信息" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>


<x:dataTable value="#{cont_contApproveBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top"  align="center"
                     rowClasses="td_middle" styleClass="table03" width="98%" border="1">

            <h:column>
                <c:facet name="header"><h:outputText value="选择"/></c:facet>
                <c:verbatim escape="false"><input type="checkbox" name="chk" value="</c:verbatim>
                <h:outputText value="#{list.contPersonBO.personId}"/>
              <c:verbatim>"></c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="上报机构"/></c:facet>
                <h:outputText value="#{list.createOrgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="经办人"/></c:facet>
                <h:outputText value="#{list.operatorName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="期限类别"/></c:facet>
                <h:outputText value="#{list.contTermClass}"/>
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
                <c:facet name="header"><h:outputText value="合同约定开始时间"/></c:facet>
                <h:outputText value="#{list.contStartDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="合同约定结束时间"/></c:facet>
                <h:outputText value="#{list.contEndDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="合同解除时间"/></c:facet>
                <h:outputText value="#{list.contEndSignDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="用工类别"/></c:facet>
                <h:outputText value="#{list.contPersonBO.jobType}"/>
            </h:column>
    
            <h:column>
                <c:facet name="header"><h:outputText value="生效过期"/></c:facet>
                <h:outputText value="#{list.validOverdue}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="原因说明"/></c:facet>
                <h:outputText value="#{list.endReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="审查状态"/></c:facet>
                <h:outputText value="#{list.approveStatus}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <c:verbatim escape="false"><A  href="/pages/cont/Download.jsp?attachmentId=</c:verbatim><h:outputText value="#{list.attachmentId}"/><c:verbatim escape="false">" taget="_blank" ></c:verbatim>
                <h:outputText value="合同查看" />
                <c:verbatim escape="false"></A></c:verbatim>
            </h:column>
</x:dataTable>


<h:panelGrid  border="0"  cellpadding="0"  cellspacing="0"  align="center" columns="1" width="600">
    <h:panelGrid  border="0"  cellspacing="0" align="left" columns="1" >
        <h:outputText value="录入信息" styleClass="td05"/>
    </h:panelGrid>
</h:panelGrid>

<h:panelGrid width="600" border="0" cellpadding="0" cellspacing="0" styleClass="table03" align="center" columns="2" columnClasses="td_form01,td_form02">
        <h:outputText styleClass="td_form_required" value="相关表格"/>
        <h:panelGroup>
            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{cont_contApproveBB.contReportList}"/>
            </h:selectOneMenu>
            <h:commandButton value="显示" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
        </h:panelGroup>

        <h:outputText styleClass="td_form_required" value="审查意见"/>
         <h:selectOneMenu value="#{cont_contApproveBB.vo.approveStatus}" id="approveStatus">
                    <c:selectItem itemValue="201003" itemLabel="审查通过" />
                    <c:selectItem itemValue="201004" itemLabel="审查未过" />
        </h:selectOneMenu>

        <h:outputText value="截至生效办理时间" />
        <h:panelGroup>
             <h:inputText id="uptoValidDate" styleClass="input" size="10" value="#{cont_contApproveBB.vo.uptoValidDate}" readonly="true" />
             <c:verbatim><input type="button" class="button_date" onclick="PopUpCalendarDialog('form1:uptoValidDate')"> </c:verbatim>
        </h:panelGroup>

         <h:outputText value="备注" />
         <h:panelGroup>
             <h:inputTextarea id="approveRemark" rows="4" cols="40"  value="#{cont_contApproveBB.vo.approveRemark}"/>
         </h:panelGroup>

         <h:outputText value="通知" />
          <h:panelGroup>
              <h:panelGroup>
                <h:selectBooleanCheckbox value="#{cont_contApproveBB.send}"></h:selectBooleanCheckbox>
                <h:outputText value="自动发送"></h:outputText>
              </h:panelGroup>
              <c:verbatim><br></c:verbatim>
              <h:inputTextarea rows="4" cols="40" value="#{cont_contApproveBB.message}"></h:inputTextarea>
          </h:panelGroup>

         <h:outputText styleClass="td_form_required" value="审查人"></h:outputText>
         <h:inputText styleClass="input" value="#{cont_contApproveBB.vo.approvePersonId}" id="approvePersonId"  code="" dict="yes" dict_num="PE" readonly="true" alt="审查人|0"/>

         <h:outputText styleClass="td_form_required" value="审查日期"></h:outputText>
         <h:panelGroup>
              <h:outputText value="#{cont_contApproveBB.vo.approveDate}" />
              <h:inputHidden id="approveDate" value="#{cont_contApproveBB.vo.approveDate}"/>
         </h:panelGroup>

</h:panelGrid>
     <h:panelGrid  border="0" cellspacing="2" cellpadding="5" align="center" columns="2">
                <h:commandButton styleClass="button01" value="提交审查结果" action="#{cont_contApproveBB.save}"  onclick="if( checkSubmit(document.forms(0)) && checkAll(document.forms(0)) ){return confirmSave(document.forms(0));}else{return false;}"/>
                <h:commandButton styleClass="button01" type="button" value="返回" onclick="window.close();"/>
     </h:panelGrid>

</h:form>

<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
