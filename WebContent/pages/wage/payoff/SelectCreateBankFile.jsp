<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function doViewGroupPayoff(){
    window.showModalDialog("/wage/payoff/GroupPayoffView.jsf?dateID="+document.all('form1:dateId').value, "", "dialogWidth:580px; dialogHeight:380px;center:center;status:yes; directories:yes;scrollbars:no;Resizable=no; "  );
    return false;
}
function doCalc(){
    return disPlayProcessBar();
}


</script>

<x:saveState value="#{wage_selectbankBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_selectbankBB.initBankFile}"></h:inputHidden>
<c:verbatim>
    <br>
    <table width=98% align="center">
       <tr><td>
</c:verbatim>
           <h:selectOneMenu id="groupLevel" value="#{wage_selectbankBB.groupLevel}">
               <c:selectItem itemValue="DEPT_NAME" itemLabel="��ϸ���"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME" itemLabel="����1"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME2" itemLabel="����2"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME3" itemLabel="����3"></c:selectItem>
               <c:selectItem itemValue="HIGH_NAME4" itemLabel="����4"></c:selectItem>
           </h:selectOneMenu>
           <h:commandButton value="ˢ��" styleClass="button01" action="#{wage_selectbankBB.queryDept}">

           </h:commandButton>
           <h:selectManyCheckbox  value="#{wage_selectbankBB.selectDepts}" layout="pageDirection" id="inputField">
               <c:selectItems value="#{wage_selectbankBB.deptList}"/>
           </h:selectManyCheckbox>
<c:verbatim>
       </td>

       <td align="right" valign="top">
</c:verbatim>

            <c:verbatim><br><br></c:verbatim>
            <h:commandButton  styleClass="button01" type="button" value="ȫ��ѡ��" onclick="DoSelectAll(true);" />
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton  styleClass="button01" type="button" value="ȫ��ȡ��" onclick="DoSelectAll(false);" />
            <c:verbatim><br><br></c:verbatim>
            <h:commandButton value="����" onclick="return doCalc();" styleClass="button01" action="#{wage_selectbankBB.genReport}"></h:commandButton>
            <c:verbatim><br><br>
            </c:verbatim>
                   <h:panelGrid columns="2" styleClass="table03" columnClasses="td_form01,td_form02" rendered="#{wage_selectbankBB.showResult}">
                       <h:outputText value="�����ˣ�"></h:outputText>
                       <h:outputText value="#{wage_selectbankBB.disk.operateName}"></h:outputText>

                       <h:outputText value="����ʱ�䣺"></h:outputText>
                       <h:outputText value="#{wage_selectbankBB.disk.operateDate}"></h:outputText>

                       <h:outputText value="������ʷ"></h:outputText>
                       <h:commandButton  value="�鿴"  type="button" styleClass="button01" onclick="doViewGroupPayoff();"></h:commandButton>

                        <h:outputText value="�������"></h:outputText>
                        <h:outputText value="#{wage_selectbankBB.disk.sumInfo}"></h:outputText>

                       <h:outputText value="����"></h:outputText>
                       <h:outputText escape="false" value="<a target='_blank' href='#{wage_selectbankBB.bankFileUrl}'>����򿪱����ļ�</a>"  />
                  </h:panelGrid>
           <c:verbatim>
       </td>
       </tr>
    </table>
    </c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>


