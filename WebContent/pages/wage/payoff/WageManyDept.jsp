<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    
    <script type="text/javascript">
        function forCopyPerson(){
            reval=window.showModalDialog("/wage/set/SetWageSet.jsf?UnitID="+document.all('form1:unitId').value+"&SetID="+document.all('form1:setId').value, null, "dialogWidth:300px; dialogHeight:150px;center:center;resizable:yes;status:yes;scroll:yes;");
            if (reval != null && reval!="") {
                form1.all("form1:personStr").value = reval;
                return true;
            } else {
                return false;
            }

        }
        function add(){
             window.showModalDialog("/wage/payoff/AddWageManyDept.jsf?SetId="+document.all("form1:setId").value, "", "dialogWidth:380px; dialogHeight:240px; status:0;resizable:yes");
             return true;
         }
         // �޸ĸ�����Ա��Ϣ
         function editInfo(id) {
             // # �ű����� ~������Ϣ
             var url = "/pages/wage/base/PersonInfoFrame.jsp?id=~" + id;
             //alert(url);
             window.open(url, null, "left=100,top=50,height=600,width=900,status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
             window.status = "";
             return false;
         }
    </script>

<x:saveState value="#{wage_manydeptBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{wage_manydeptBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="setId" value="#{wage_manydeptBB.setId}"></h:inputHidden>
    <h:inputHidden id="dateId" value="#{wage_manydeptBB.dateId}"></h:inputHidden>
    <h:inputHidden id="unitId" value="#{wage_manydeptBB.unitId}"></h:inputHidden>
    <h:inputHidden id="personStr" value=""/>

    <h:panelGrid width="98%" columns="3" styleClass="td_title" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="��η�����Ա����"></h:outputText>
          </h:panelGroup>
          <h:outputText value="����:#{wage_manydeptBB.perCount}"></h:outputText>
          <h:panelGrid align="right" columns="2">
              <h:commandButton styleClass="button01" action="#{wage_manydeptBB.saveCopyPerson}" value="���ƶ���" onclick="return forCopyPerson();"></h:commandButton>
              <h:commandButton styleClass="button01" value="����" action="#{wage_manydeptBB.queryPersonList}" onclick="return add();"></h:commandButton>
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <h:dataTable value="#{wage_manydeptBB.personList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
            <h:outputText value="#{list.personCode}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="Ա������"/></c:facet>
            <h:outputText value="#{list.name}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����1"/></c:facet>
            <h:outputText value="#{list.wagedept1}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����2"/></c:facet>
            <h:outputText value="#{list.wagedept2}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������������"/></c:facet>
            <h:outputText value="#{list.lastMonth}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton styleClass="button01" value="ȡ��" action="#{wage_manydeptBB.delete}">
                <x:updateActionListener property="#{wage_manydeptBB.itemID}" value="#{list.itemId}"/>
            </h:commandButton>
            <h:commandButton value="������Ϣά��" styleClass="button01" type="button" onclick="return editInfo('#{list.personId}');"></h:commandButton>
        </h:column>
    </h:dataTable>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
