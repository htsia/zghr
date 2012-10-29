<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript" language="javascript">
   function selectNewPerson() {
        var field = form1.all('selected_ids');
        if (checkMutilSelect(field)) {
            revalue = "";
            count = field.length;
            if (count != null) {
                for (i = 0; i < count; i++)
                    if (field[i].checked) {
                        revalue += field[i].value + ",";
                    }
            } else {
                revalue = field.value;
            }
            window.returnValue = revalue;
            //alert(revalue);
            window.close();
            document.all('form1:refresh').click();
        } else {
            alert("请选择人员！");
            return false;
        }
    }
</script>

<h:form id="form1">
	<h:commandButton id="refresh" value="刷新" style="display:none;" action="#{cont_contSelectNewPersonBB.refreshload}"></h:commandButton>
    <h:inputHidden id="init_a" value="#{cont_contSelectNewPersonBB.init_a}"/>
<c:verbatim>
    <table height=98% width=98% align="center">
    <tr><td height=8>
</c:verbatim>
        <h:panelGrid width="100%" columns="2" styleClass="td_title"  border="0" cellspacing="0" cellpadding="0" >
            <h:panelGroup>
               <h:graphicImage value="/images/tips.gif" />
               <h:outputText value="选择新员工" ></h:outputText>
            </h:panelGroup>

            <h:panelGrid  border="0"  cellspacing="0" align="right" columns="2" >
                <c:verbatim escape="false"> <input type="button"  class="button01" value="确定" onclick="selectNewPerson()"> </c:verbatim>
                <h:commandButton  styleClass="button01" value="取消" onclick="javascript:window.close();"/>
             </h:panelGrid>

        </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td height=8>
</c:verbatim>
    <h:panelGrid align="right" styleClass="locked_top" columns="2" width="98%">
        <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
            <h:outputText value="姓名或员工编号："/>
            <h:inputText styleClass="input" size="20" id="personNameQry" value="#{cont_contSelectNewPersonBB.personNameQry}"/>
            <h:commandButton styleClass="button01" value=" 查询 " action="#{cont_contSelectNewPersonBB.doQuery}"/>
        </h:panelGrid>

        <h:panelGroup>
            <h:outputText value="记录数:#{cont_contSelectNewPersonBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="页数:#{cont_contSelectNewPersonBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="每页有#{cont_contSelectNewPersonBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="当前为第#{cont_contSelectNewPersonBB.pagevo.currentPage}页"></h:outputText>
            <h:commandButton value="首页" action="#{cont_contSelectNewPersonBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{cont_contSelectNewPersonBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{cont_contSelectNewPersonBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{cont_contSelectNewPersonBB.last}" styleClass="button01"></h:commandButton>
        </h:panelGroup>
    </h:panelGrid>
<c:verbatim>
    </td></tr>

    <tr><td>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
    <x:dataTable value="#{cont_contSelectNewPersonBB.bos}" var="list"  rowIndexVar="index"
                     headerClass="td_top" id="dateList"  align="center"
                     rowClasses="td_middle" styleClass="table03" width="98%" border="1">
             <h:column>
                  <c:facet name="header">
                      <c:verbatim escape="false">
                      <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                      </c:verbatim>
                      </c:facet>
                  <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                  <h:outputText value="#{list.personId}"/>
                  <c:verbatim>"></c:verbatim>
              </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="人员编号"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="姓名"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="性别"/></c:facet>
                <h:outputText value="#{list.sex}"/>
            </h:column>



					<h:column>
						<c:facet name="header">
							<h:outputText value="所在部门" />
						</c:facet>
						<h:outputText value="#{list.deptName}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="岗位名称" />
						</c:facet>
						<h:outputText value="#{list.cname}" />
					</h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="身份证号码"/></c:facet>
                <h:outputText value="#{list.idCard}"/>
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
