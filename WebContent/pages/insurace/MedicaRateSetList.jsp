<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doAdd(){
        if (document.all('form1:unitId').value==""){
            alert("��ѡ��λ!");
            return false;
        }
        else{
            window.showModalDialog("/insurace/addMedical.jsf?unitID="+document.all('form1:unitId').value, null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
        }
        return true;
    }
    function doModify(itemID){
       window.showModalDialog("/insurace/addMedical.jsf?itemID="+itemID, null, "dialogWidth:450px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
    }
</script>

<x:saveState value="#{ins_medicalPayOffBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{ins_medicalPayOffBB.pageInit}"/>
    <h:inputHidden  id="unitId" value="#{ins_medicalPayOffBB.unitId}"/>
    <c:verbatim>
    <table width=99% align="center">
      <tr>
        <td align="left" height=30 align="left">
</c:verbatim>
            <h:outputText id="name"  value="��λ����:#{ins_medicalPayOffBB.unitname}" />
<c:verbatim>
        </td>

        <td align="right"  height=30 align="right">
</c:verbatim>
          <h:commandButton styleClass="button01" value="����"    onclick="return doAdd();"/>
           <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;"/>
<c:verbatim>
        </td>
      </tr>

      <tr>
          <td colspan=2>
</c:verbatim>
              <h:dataTable value="#{ins_medicalPayOffBB.rateList}" var="list" align="center" id="dateList"
                           headerClass="td_top" columnClasses="td_middle_center,td_middle"
                           styleClass="table03" width="95%" >

                  <h:column>
                      <c:facet name="header"><h:outputText value="����"/></c:facet>
                          <h:commandButton styleClass="button01" value="ɾ��" action="#{ins_medicalPayOffBB.deleteMedical}">
                                <x:updateActionListener property="#{ins_medicalPayOffBB.itemID}" value="#{list.itemID}"/>
                          </h:commandButton>
                      <h:commandButton styleClass="button01" value="�޸�" onclick="doModify('#{list.itemID}')" action="'"></h:commandButton>
                  </h:column>

                  <h:column>
                      <c:facet name="header"><h:outputText value="�������"/></c:facet>
                      <h:outputText value="#{list.agelow}"/>
                  </h:column>
                  
                  <h:column>
                      <c:facet name="header"><h:outputText value="�������"/></c:facet>
                      <h:outputText value="#{list.agehigh}"/>
                  </h:column>

                  <h:column>
                      <c:facet name="header"><h:outputText value="��λ�ɷѽ�������˺�(%)"/></c:facet>
                      <h:outputText value="#{list.unitRate}"/>
                  </h:column>

                  <h:column>
                      <c:facet name="header"><h:outputText value="���˽ɷ�(%)"/></c:facet>
                      <h:outputText value="#{list.personRate}"/>
                  </h:column>

                  <h:column>
                      <c:facet name="header"><h:outputText value="�ϼ�(%)"/></c:facet>
                      <h:outputText value="#{list.sumRate}"/>
                  </h:column>

              </h:dataTable>
<c:verbatim>
          </td>
      </tr>
  </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
