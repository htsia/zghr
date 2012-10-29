<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{self_selfnewsbb}"/>
<h:form>
    <h:inputHidden value="#{self_selfnewsbb.initQueryOneNews}"/>
    <c:verbatim><br></c:verbatim>

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
        <h:panelGrid columns="1" align="center" >
            <h:outputText value="#{self_selfnewsbb.topic}"  style="font-size:18px;font-weight:bold;align:center"  />
            <h:outputText value="发布时间：#{self_selfnewsbb.startDate}" />
            <f:verbatim>
                <HR color=#cccccc size="1" width="99%" align="center">
            </f:verbatim>
        </h:panelGrid>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>&nbsp;&nbsp;正文:<br></strong>"  />
            <h:outputText escape="false" value="#{self_selfnewsbb.content}" />
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>&nbsp;&nbsp;附件:<br></strong>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfnewsbb.attFile1}'>#{self_selfnewsbb.attTitle1}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfnewsbb.attFile2}'>#{self_selfnewsbb.attTitle2}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfnewsbb.attFile3}'>#{self_selfnewsbb.attTitle3}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfnewsbb.attFile4}'>#{self_selfnewsbb.attTitle4}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfnewsbb.attFile5}'>#{self_selfnewsbb.attTitle5}</a><br>"  />
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
<script type="text/javascript">
    document.onselectstart=function(){return   false;};
    document.oncontextmenu=function(){return   false;};
    document.onselect=function(){document.selection.empty();};
    document.oncopy=function(){document.selection.empty();};
    document.onmouseup=function(){document.selection.empty();};
    document.onbeforecopy=function(){document.selection.empty();};
    document.onkeydown=function(){if(event.ctrlKey) return false;};
</script>
