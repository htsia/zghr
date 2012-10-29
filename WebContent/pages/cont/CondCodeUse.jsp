<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<html>
  <head><title></title></head>
  <body>
  <x:saveState value="#{cont_codeinfoBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{cont_codeinfoBB.initStat}"></h:inputHidden>
      <table class="table02" width="98%" align="center">
          <tr>
              <td colspan="2"><h:outputText escape="false" value="<strong>单位：</strong>"></h:outputText></td>
              <td><h:outputText value="#{cont_codeinfoBB.contCodeInfo.name}"></h:outputText></td>
          </tr>

          <tr>
              <td rowspan=5 class="td_top" valign="center" width="20" align="center">区<br>段<br>一</td>
              <td class="td_top">低值</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeInfo.low1}"/></td>
          </tr>
          <tr>
              <td class="td_top">高值</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeInfo.high1}"/></td>
          </tr>
          <tr>
              <td class="td_top">容量</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.count1}"/></td>
          </tr>
          <tr>
              <td class="td_top">已使用</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.signCount1}"/></td>
          </tr>
          <tr>
              <td class="td_top">未用</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.unUsed1}"/></td>
          </tr>

          <tr>
              <td rowspan=5 class="td_top" valign="center" width="20" align="center">区<br>段<br>二</td>
              <td class="td_top">低值</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeInfo.low2}"/></td>
          </tr>
          <tr>
              <td class="td_top">高值</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeInfo.high2}"/></td>
          </tr>
          <tr>
              <td class="td_top">容量</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.count2}"/></td>
          </tr>
          <tr>
              <td class="td_top">已使用</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.signCount2}"/></td>
          </tr>
          <tr>
              <td class="td_top">未用</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.unUsed2}"/></td>
          </tr>

          <tr>
              <td rowspan=5 class="td_top" valign="center" width="20" align="center">区<br>段<br>三</td>
              <td class="td_top">低值</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeInfo.low3}"/></td>
          </tr>
          <tr>
              <td class="td_top">高值</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeInfo.high3}"/></td>
          </tr>
          <tr>
              <td class="td_top">容量</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.count3}"/></td>
          </tr>
          <tr>
              <td class="td_top">已使用</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.signCount3}"/></td>
          </tr>
          <tr>
              <td class="td_top">未用</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.unUsed3}"/></td>
          </tr>

          <tr>
              <td rowspan=5 class="td_top" valign="center" width="20" align="center">合<br>计<br></td>
              <td class="td_top">容量</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.allCount}"/></td>
          </tr>
          <tr>
              <td class="td_top">已使用</td>
              <td><h:outputText value="#{cont_codeinfoBB.contCodeStat.allSignCount}"/></td>
          </tr>
          <tr>
              <td class="td_top">未用</td>
              <td class="td_middle"><h:outputText value="#{cont_codeinfoBB.contCodeStat.allunUsed}"/></td>
          </tr>

      </table>
  </h:form>
  </body>
</html>