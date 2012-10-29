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
         <td class="td_title" height=8><img src="/images/tips.gif" alt=""> 保险基数审批
         </td>
          <td class="td_title" align="right" height=8>
        </f:verbatim>
              <h:outputText value="当前状态:#{ins_computelistBB.bsb.statusDes}" />
<f:verbatim>
          </td>
     </tr>

      <tr>
          <td colspan=2 height=8>
</f:verbatim>
              <h:outputText value="  开始时间" />
              <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{ins_computelistBB.bsb.startDate}" readonly="true"/>

              <h:outputText value="   结束时间" />
              <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{ins_computelistBB.bsb.endDate}" readonly="true"/>

              <h:outputText value="   计算数据来源" />
              <h:selectOneMenu id="source" value="#{ins_computelistBB.bsb.field}" readonly="true">
                     <c:selectItems value="#{ins_computelistBB.caclFieldList}"></c:selectItems>
              </h:selectOneMenu>

              <h:outputText value="计算精度"/>
              <h:selectOneMenu id="precise"  value="#{ins_computelistBB.bsb.precise}" readonly="true">
                  <c:selectItem itemValue="" itemLabel="--请选择--"></c:selectItem>
                  <c:selectItem itemValue="0" itemLabel="元"></c:selectItem>
                  <c:selectItem itemValue="1" itemLabel="角"></c:selectItem>
                  <c:selectItem itemValue="2" itemLabel="分"></c:selectItem>
              </h:selectOneMenu>

              <h:commandButton value="导出" id="export" type="button" onclick="ExportShowTable();" styleClass="button01"/>
              <h:commandButton value="审批通过" rendered="#{ins_computelistBB.bsb.status=='2'}" styleClass="button01" action="#{ins_computelistBB.ApplyOK}" />
              <h:commandButton value="重新计算" rendered="#{ins_computelistBB.bsb.status=='2'}" styleClass="button01" action="#{ins_computelistBB.ApplyReturn}" />
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
