<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<h:form>
<c:verbatim>
      <table width="96%" align="center">
          <tr>
              <td align="center" width="16%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;������ƴ</td>
              <td>&nbsp;</td>
          </tr>
      </table>
      <table width="96%" class="">
          <tr><td>
</c:verbatim>
           <h:inputText value="#{sys_toolsBB.text}"></h:inputText>
           <h:commandButton styleClass="button01" value="ȫƴ" action="#{sys_toolsBB.genAll}"></h:commandButton>
           <h:commandButton styleClass="button01" value="����ĸ" action="#{sys_toolsBB.genShort}"></h:commandButton>
           <h:inputText readonly="true" value="#{sys_toolsBB.code}"></h:inputText>
<c:verbatim>
          </td></tr>
      </table>
</c:verbatim>
</h:form>      