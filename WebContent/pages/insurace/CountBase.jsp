<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function showProcessBar() {
       x = document.body.clientWidth / 2 - 150;
       y = document.body.clientHeight / 2;
       document.all('processbar').style.top = y;
       document.all('processbar').style.left = x;
       document.all('processbar').style.display = "";
    }

    function checkDate(){
    var endDate = document.all("form1:endTime").value;
    var startDate = document.all("form1:beginTime").value;
    if(startDate==null||startDate==""||endDate==null||endDate==""){
        alert("�����뿪ʼʱ��ͽ���ʱ��");
        return false;
    }else if(startDate>endDate){
        alert("��ʼʱ�����ڽ���ʱ��");
        return false;
    }
    if (document.all("form1:source").value==""){
        alert("��ѡ�����������Դ");
        return false;
    }
     if (document.all("form1:precise").value==""){
         alert("��ѡ����㾫��");
         return false;
     }
    showProcessBar();
    return true;
 }
 function saveRate(){
    var setId=document.all('form1:setId').value;
    var ret=window.showModalDialog("/insurace/SaveRate.jsf?setId="+setId, null, "dialogWidth:400px; dialogHeight:280px;center:center;resizable:no;status:no;scroll:no;");
    if (ret=='ok'){
        window.close();
        return true;
    }
    return false;
 }
</script>

  <x:saveState value="#{ins_computelistBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{ins_computelistBB.beginRateSet}"></h:inputHidden>
      <h:inputHidden id="setId" value="#{ins_computelistBB.setId}"></h:inputHidden>
      <f:verbatim>
      <table width="98%" height=96%  align="center" cellspacing=0 cellpadding=0>
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
              <h:outputText value="��ʼʱ��" />
              <h:inputText styleClass="input" id="beginTime" size="12" alt="��ʼʱ��|0|d" value="#{ins_computelistBB.beginTime}" readonly="true"/>
              <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>

              <h:outputText value="����ʱ��" />
              <h:inputText styleClass="input" id="endTime" alt="����ʱ��|0|d" size="12" value="#{ins_computelistBB.endTime}" readonly="true"/>
              <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>

              <h:outputText value="����������Դ" />
              <h:selectOneMenu id="source" value="#{ins_computelistBB.caclField}" >
                     <c:selectItems value="#{ins_computelistBB.caclFieldList}"></c:selectItems>
              </h:selectOneMenu>

              <h:outputText value="���㾫��"/>
              <h:selectOneMenu id="precise"  value="#{ins_computelistBB.precise}">
                  <c:selectItem itemValue="" itemLabel="--��ѡ��--"></c:selectItem>
                  <c:selectItem itemValue="0" itemLabel="Ԫ"></c:selectItem>
                  <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                  <c:selectItem itemValue="2" itemLabel="��"></c:selectItem>
              </h:selectOneMenu>

              <h:commandButton value="��ʼ����" rendered="#{ins_computelistBB.bsb==null || ins_computelistBB.bsb.status=='1'}" id="calcbase" onclick="return checkDate();" styleClass="button01" action="#{ins_computelistBB.CalcRate}" />
              <h:commandButton value="����" id="export" type="button" onclick="ExportShowTable();" styleClass="button01"/>
              <h:commandButton value="����" rendered="#{ins_computelistBB.bsb.status=='1'}" styleClass="button01" action="#{ins_computelistBB.doApply}" />
              <h:commandButton value="������Ч" id="savebase" action="#{ins_computelistBB.changeStats}" rendered="#{ins_computelistBB.bsb.status=='3'}" onclick="return saveRate();" styleClass="button01"  />
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
