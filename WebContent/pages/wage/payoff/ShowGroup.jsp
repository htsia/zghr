<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    
    <script type="text/javascript">
        function forSel() {
            if (document.all('form1:oper').value=='1'){
               PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:classitem").value,'');
            }
            else{
                PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue'),document.all( 'form1:classvaluedes'), document.all("form1:classitem").value,'');
            }
            return false;
        }
        function  chechPara(){
            if (document.all('form1:classitem').value!=''){
                if (document.all('form1:classvalue').value==''){
                    alert("��ѡ�����ֵ��");
                    return false;
                }
            }
            return true;
        }
        
    </script>

  <x:saveState value="#{wage_groupBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{wage_groupBB.showGroup}"/>
      <h:inputHidden value="#{wage_groupBB.setId}"/>
      <h:inputHidden value="#{wage_groupBB.groupField}"/>

      <f:verbatim>
      <table  width="100%" height=98% border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" >
          <tr >
              <td class="td_title"  height=8>
               <table width="100%">
               <tr>
                  <td>
       </f:verbatim>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value=" ��н�ʲ��Ż���"/>
<f:verbatim>
                  </td>

                  <td  align="right">
</f:verbatim>
                      <h:selectBooleanCheckbox value="#{wage_groupBB.onlyHave}"></h:selectBooleanCheckbox>
                      <h:outputText value="������������Ա"></h:outputText>

                      <h:outputText value="н�ʲ��Ż��ܷ�ʽ"/>
                      <h:selectOneMenu value="#{wage_groupBB.groupLevel}" onchange="submit()" valueChangeListener="#{wage_groupBB.changeLevel}">
                          <c:selectItem itemValue="DEPT_NAME" itemLabel="��ϸ���"></c:selectItem>
                          <c:selectItem itemValue="HIGH_NAME" itemLabel="����1"></c:selectItem>
                          <c:selectItem itemValue="HIGH_NAME2" itemLabel="����2"></c:selectItem>
                          <c:selectItem itemValue="HIGH_NAME3" itemLabel="����3"></c:selectItem>
                          <c:selectItem itemValue="HIGH_NAME4" itemLabel="����4"></c:selectItem>
                      </h:selectOneMenu>
<f:verbatim>
                  </td>
              </tr>
              </table>
              </td>
          </tr>

          <tr>
              <td  height=8>
</f:verbatim>
                  <h:outputText value="�趨ͳ�Ʒ�Χ=>"></h:outputText>
                  <h:selectOneMenu style="width:110px;" id="classitem" value="#{wage_groupBB.personType}" onchange="document.all('form1:classvalue').value='';document.all('form1:classvaluedes').value='';">
                      <f:selectItems value="#{wage_groupBB.classItemList}"/>
                  </h:selectOneMenu >

                  <h:selectOneMenu id="oper" value="#{wage_groupBB.oper}">
                       <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                       <c:selectItem itemValue="2" itemLabel="����"></c:selectItem>
                  </h:selectOneMenu>

                  <h:inputText readonly="true"  style="width:210px" id="classvaluedes"/>
                  <h:inputHidden id="classvalue" value="#{wage_groupBB.personTypeValue}"/>
                  <h:commandButton id="select" type="button" styleClass="button01" value="ѡ��"  onclick="forSel()"/>
                  <h:commandButton id="count" value="ͳ��" styleClass="button01" onclick="return chechPara();" action="#{wage_groupBB.beginCalc}" ></h:commandButton>
                  <h:commandButton id="export" value="����" styleClass="button01" onclick="ExportShowTable();" type="button"></h:commandButton>
                  <h:commandButton value="�ر�" styleClass="button01" onclick="window.close()"></h:commandButton>
<f:verbatim>
              </td>
          </tr>

          <tr><td>
              <jsp:include page="/pages/common/activepage/ShowTable.jsp">
                  <jsp:param name="para" value="true"/>
              </jsp:include>
           </td></tr>
      </table>
</f:verbatim>      
  </h:form>
