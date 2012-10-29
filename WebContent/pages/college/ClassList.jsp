<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
       function checkYear(){
           if (document.all('form1:year').value =="" || document.all('form1:year').value.length!=4){
               alert("请输入四位年数据!");
               return false;
           }
           return true;
       }
</script>
<x:saveState value="#{cle_ClassListBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{cle_ClassListBB.pageInit}"/>

    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
            <tr>
                <td class=td_title>
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 班级管理 ->  班级信息"/>
      <f:verbatim>
                </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8 align="right">
</f:verbatim>
             <h:selectOneMenu value="#{cle_ClassListBB.year}">
                 <c:selectItems value="#{cle_ClassListBB.yearList}"></c:selectItems>
             </h:selectOneMenu>

             <h:commandButton styleClass="button01" value="查询" action="#{cle_ClassListBB.queryClass}"></h:commandButton>
             <h:commandButton styleClass="button01" value="毕业" action="#{cle_ClassListBB.graduate}"></h:commandButton>
<f:verbatim>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{cle_ClassListBB.classList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >

            <h:column>
                 <c:facet name="header">
                     <c:verbatim escape="false">
                     <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                     </c:verbatim>
                 </c:facet>
                 <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                 <h:outputText value="#{list.classId}"/>
                 <c:verbatim>"></c:verbatim>
             </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="年度"/></c:facet>
                <h:outputText value="#{list.year}"></h:outputText>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="班级名称"/></c:facet>
                <h:outputText value="#{list.className}"></h:outputText>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="当前状态"/></c:facet>
                <h:outputText value="#{list.statusDes}"></h:outputText>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="学生人数"/></c:facet>
                <h:outputText value="#{list.studentCount}"></h:outputText>
            </h:column>

        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>