<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
	function doQuery(id){
            window.showModalDialog("/recruit/recruitNoticeRead.jsf?noticeid="+id, "", "dialogWidth:500px; dialogHeight:380px; status:0;resizable:yes");
            return true;
        }

</script>
<x:saveState value="#{getRecuitNoticeBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{getRecuitNoticeBB.pageInit}"></h:inputHidden>
    <c:verbatim>
    
    <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif">外部招聘->通知通告</td>
        </tr>
       <tr><td align="right" height=8></td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{getRecuitNoticeBB.noticeList}" var="list" rowIndexVar="index" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="发送者"/></c:facet>
            <h:outputText value="#{list.senderName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="发送时间"/></c:facet>
            <h:outputText value="#{list.sendTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="是否已读"/></c:facet>
            <h:outputText value="#{list.viewed}"/>
        </h:column>
        <h:column>
           <c:facet name="header"><h:outputText  style="width:80px" value="操作"/></c:facet>
           	<h:commandButton value="查看"  onclick="return doQuery('#{list.noticeId}')" styleClass="button01"/>
           	<h:graphicImage alt="新通知" value="/images/common/new.gif" rendered="#{list.viewed=='否'}"/>
           </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

