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
<x:saveState value="#{cle_DateListBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{cle_DateListBB.pageInit}"/>

    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
            <tr>
                <td class=td_title>
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" 班级管理 ->  学年管理"/>
      <f:verbatim>
                </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8 align="right">
</f:verbatim>
             <h:inputText id="year" value="#{cle_DateListBB.year}"></h:inputText>
             <h:commandButton value="开始新学年"  styleClass="button01"  onclick="return checkYear();" action="#{cle_DateListBB.addYear}"/>
<f:verbatim>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{cle_DateListBB.dateList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >

            <h:column>
                <c:facet name="header"><h:outputText value="年度"/></c:facet>
                <h:outputText value="#{list.year}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="创建人"/></c:facet>
                <h:outputText value="#{list.creatorName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="创建日期"/></c:facet>
                <h:outputText value="#{list.createDate}"/>
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