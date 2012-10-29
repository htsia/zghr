<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<h:form>
    <f:verbatim>
    <table width="220" border="0" cellspacing="0" cellpadding="0">
          <tr><td style="padding-top:20px;">
          </f:verbatim>
    <x:dataTable id="paperList" width="100%" headerClass="td_top"
					columnClasses="td_bottom_center" align="center"  border="0"  value="#{self_surveyBB.paperList}"    var="paperList">
       <h:column>
           <h:graphicImage  value="/images/common/hot.gif" rendered="#{paperList.paperID!=null && paperList.paperID!=''}"/>
           <h:commandLink  onclick="doSurvey('#{paperList.paperID}');return false;" rendered="#{paperList.publish!='1'}">
               <h:outputText value="#{paperList.name}"  />
           </h:commandLink>
           <h:outputText value="(#{paperList.createDate})"  rendered="#{paperList.publish!='1' && paperList.createDate!=''}" />
           <br>
       </h:column>
   </x:dataTable>

        <f:verbatim>

          </td></tr>
        </table>
        </f:verbatim>
</h:form>


