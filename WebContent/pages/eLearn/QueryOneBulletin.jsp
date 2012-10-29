<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ include file="/pages/include/taglib.jsp" %>

<x:saveState value="#{eLearn_learnInfoBB}"/>
<h:form>
    <c:verbatim><br></c:verbatim>
    <h:inputHidden value="#{eLearn_learnInfoBB.initQueryOneBulletin}"/>
    <c:verbatim>
        <table width=100%>
            <tr><td align="right">
    </c:verbatim>
               <h:commandButton value="关闭窗口" type="button" onclick="window.close();"  styleClass="button01" />
    <c:verbatim>
            </td></tr>
        </table>
    </c:verbatim>

    <h:panelGrid width="98%" columns="1" border="1" align="center"
        styleClass="table03" rowClasses="td_form01,td_form02,td_form02"
        cellpadding="4" >
        <h:panelGrid columns="1" align="center">
            <h:outputText value="#{eLearn_learnInfoBB.bulltinbo.blltnTopic}" style="font-size:18px;font-weight:bold;align:center" />

            <h:outputText value="发布时间：#{eLearn_learnInfoBB.bulltinbo.startDate}" />

            <f:verbatim>
                <HR color=#cccccc size="1" width="99%" align="center">
            </f:verbatim>
        </h:panelGrid>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>正文:<br></strong>"  />
            <h:outputText escape="false" value="#{eLearn_learnInfoBB.bulltinbo.blltnContent}" />
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>附件:<br></strong>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{eLearn_learnInfoBB.bulltinbo.attFile1}'>#{eLearn_learnInfoBB.bulltinbo.attTitle1}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{eLearn_learnInfoBB.bulltinbo.attFile2}'>#{eLearn_learnInfoBB.bulltinbo.attTitle2}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{eLearn_learnInfoBB.bulltinbo.attFile3}'>#{eLearn_learnInfoBB.bulltinbo.attTitle3}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{eLearn_learnInfoBB.bulltinbo.attFile4}'>#{eLearn_learnInfoBB.bulltinbo.attTitle4}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{eLearn_learnInfoBB.bulltinbo.attFile5}'>#{eLearn_learnInfoBB.bulltinbo.attTitle5}</a><br>"  />
        </h:panelGroup>
   </h:panelGrid>

<c:verbatim>
    <table width=100%>
        <tr><td align="right">
</c:verbatim>
           <h:commandButton value="关闭窗口" type="button" onclick="window.close();"  styleClass="button01" />
<c:verbatim>
        </td></tr>
    </table>
</c:verbatim>
</h:form>