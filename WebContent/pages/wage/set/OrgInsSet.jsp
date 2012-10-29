<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_setBB.initOrgIns}" />
    <h:inputHidden value="#{wage_setBB.copySet}" />
    <c:verbatim>
    <table class="table03" width=98% align="center">
      <tr>
          <td colspan=2 align="right">
</c:verbatim>
              <h:commandButton styleClass="button01" value="����" action="#{wage_setBB.saveOrgIns}"  />
              <h:commandButton styleClass="button01" type="button" value="ȡ������" onclick="window.close();"/>
<c:verbatim>
          </td>
      </tr>
        
      <tr>
        <td class="td_form01" align="right">
          ���ϱ��յ�λ�ɷ�
        </td>
        <td class="td_form02">
 </c:verbatim>
            <h:selectOneMenu value="#{wage_setBB.orgins.endowmentLast}">
               <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
               <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
            </h:selectOneMenu>

            <h:selectOneMenu value="#{wage_setBB.orgins.endowmentBase}">
               <c:selectItems value="#{wage_setBB.baseField}"></c:selectItems>
            </h:selectOneMenu>
            <h:outputText value="��#{wage_setBB.orgins.endowmentRate}%"/>
<c:verbatim>
        </td>
      </tr>

        <tr>
          <td class="td_form01" align="right">
            ҽ�Ʊ��յ�λ�ɷ�
          </td>
          <td class="td_form02">
 </c:verbatim>
              <h:selectOneMenu value="#{wage_setBB.orgins.medicareLast}">
                 <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
                 <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
              </h:selectOneMenu>

              <h:selectOneMenu value="#{wage_setBB.orgins.medicareBase}">
                 <c:selectItems value="#{wage_setBB.baseField}"></c:selectItems>
              </h:selectOneMenu>
              <h:outputText value="��#{wage_setBB.orgins.medicareRate}%"/>
<c:verbatim>
          </td>
        </tr>

        <tr>             <tr>
          <td class="td_form01" align="right">
            ʧҵ���յ�λ�ɷ�
          </td>
          <td class="td_form02">
 </c:verbatim>
              <h:selectOneMenu value="#{wage_setBB.orgins.unemployLast}">
                 <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
                 <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
              </h:selectOneMenu>

              <h:selectOneMenu value="#{wage_setBB.orgins.unemployBase}">
                 <c:selectItems value="#{wage_setBB.baseField}"></c:selectItems>
              </h:selectOneMenu>
              <h:outputText value="��#{wage_setBB.orgins.endowmentRate}%"/>
<c:verbatim>
          </td>
        </tr>

          <td class="td_form01" align="right">
            ���˱��յ�λ�ɷ�
          </td>
          <td class="td_form02">
 </c:verbatim>
              <h:selectOneMenu value="#{wage_setBB.orgins.compoLast}">
                 <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
                 <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
              </h:selectOneMenu>

              <h:selectOneMenu value="#{wage_setBB.orgins.compoBase}">
                 <c:selectItems value="#{wage_setBB.baseField}"></c:selectItems>
              </h:selectOneMenu>
              <h:outputText value="��#{wage_setBB.orgins.compoRate}%"/>
<c:verbatim>
          </td>
        </tr>

        <tr>
          <td class="td_form01" align="right">
            �������յ�λ�ɷ�
          </td>
          <td class="td_form02">
 </c:verbatim>
              <h:selectOneMenu value="#{wage_setBB.orgins.procreateLast}">
                 <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
                 <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
              </h:selectOneMenu>

              <h:selectOneMenu value="#{wage_setBB.orgins.procreateBase}">
                 <c:selectItems value="#{wage_setBB.baseField}"></c:selectItems>
              </h:selectOneMenu>
              <h:outputText value="��#{wage_setBB.orgins.procreateRate}%"/>
<c:verbatim>
          </td>
        </tr>

      <tr>
        <td class="td_form01" align="right">
          ���λ�ɷ�
        </td>
        <td class="td_form02">
 </c:verbatim>
            <h:selectOneMenu value="#{wage_setBB.orgins.annuityLast}">
               <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
               <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
            </h:selectOneMenu>

            <h:selectOneMenu value="#{wage_setBB.orgins.annuityBase}">
               <c:selectItems value="#{wage_setBB.baseField}"></c:selectItems>
            </h:selectOneMenu>
            <h:outputText value="��#{wage_setBB.orgins.annuityRate}%"/>
<c:verbatim>
        </td>
      </tr>

      <tr>
        <td class="td_form01" align="right">
          ס��������λ�ɷ�
        </td>
        <td class="td_form02">
 </c:verbatim>
            <h:selectOneMenu value="#{wage_setBB.orgins.houseLast}">
               <c:selectItem itemLabel="����" itemValue="0"></c:selectItem>
               <c:selectItem itemLabel="����" itemValue="1"></c:selectItem>
            </h:selectOneMenu>

            <h:selectOneMenu value="#{wage_setBB.orgins.houseBase}">
               <c:selectItems value="#{wage_setBB.baseField}"></c:selectItems>
            </h:selectOneMenu>
            <h:outputText value="��#{wage_setBB.orgins.houseRate}%"/>
<c:verbatim>
        </td>
      </tr>

    </table>
</c:verbatim>
</h:form>
