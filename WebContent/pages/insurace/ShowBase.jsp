<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    
</script>

  <x:saveState value="#{ins_computelistBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{ins_computelistBB.beginRateSet}"></h:inputHidden>
      <h:inputHidden id="setId" value="#{ins_computelistBB.setId}"></h:inputHidden>
      <f:verbatim>
      <table width="100%" height=96% width=98 align="center" cellspacing=0 cellspaning=0>
      <tr>
         <td class="td_title" height=8><img src="/images/tips.gif" alt=""> ���ջ�������
         </td>
          <td class="td_title" align="right" height=8>
        </f:verbatim>
              <h:outputText value="��ǰ״̬:#{ins_computelistBB.bsb.statusDes}" />
<f:verbatim>
          </td>
     </tr>

      <tr>
          <td colspan=2 height=8>
</f:verbatim>
              <h:outputText value="  ��ʼʱ��" />
              <h:inputText styleClass="input" id="beginTime" size="12" alt="��ʼʱ��|0|d" value="#{ins_computelistBB.bsb.startDate}" readonly="true"/>

              <h:outputText value="   ����ʱ��" />
              <h:inputText styleClass="input" id="endTime" alt="����ʱ��|0|d" size="12" value="#{ins_computelistBB.bsb.endDate}" readonly="true"/>

              <h:outputText value="   ����������Դ" />
              <h:selectOneMenu id="source" value="#{ins_computelistBB.bsb.field}" readonly="true">
                     <c:selectItems value="#{ins_computelistBB.caclFieldList}"></c:selectItems>
              </h:selectOneMenu>

              <h:outputText value="���㾫��"/>
              <h:selectOneMenu id="precise"  value="#{ins_computelistBB.bsb.precise}" readonly="true">
                  <c:selectItem itemValue="" itemLabel="--��ѡ��--"></c:selectItem>
                  <c:selectItem itemValue="0" itemLabel="Ԫ"></c:selectItem>
                  <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                  <c:selectItem itemValue="2" itemLabel="��"></c:selectItem>
              </h:selectOneMenu>

              <h:commandButton value="����" id="export" type="button" onclick="ExportShowTable();" styleClass="button01"/>
              <h:commandButton value="����ͨ��" rendered="#{ins_computelistBB.bsb.status=='2'}" styleClass="button01" action="#{ins_computelistBB.ApplyOK}" />
              <h:commandButton value="���¼���" rendered="#{ins_computelistBB.bsb.status=='2'}" styleClass="button01" action="#{ins_computelistBB.ApplyReturn}" />
<f:verbatim>
          </td>
      </tr>

     <tr> <td colspan=2>
          <jsp:include page="/pages/common/activepage/ShowTable.jsp">
              <jsp:param name="para" value="true"/>
          </jsp:include>
     </td></tr>
      </table>
</f:verbatim>
      <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>

  </h:form>
