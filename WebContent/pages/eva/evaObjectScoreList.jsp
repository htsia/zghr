<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.eva.pojo.vo.EvaObjectMasterScoreVO"%>
<%@page import="com.hr319wg.eva.pojo.bo.EvaMasterBO"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

 <c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
 <script type="text/javascript">
 function beginInput(masterid,objId,tempid){
     window.showModalDialog("/eva/selfTemplateSetScore.jsf?templateID="+tempid+"&masterID="+masterid+"&objectID="+objId,"", "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:yes;scroll:yes;");
     document.all('form1:refresh').click();
     return true;
 }
 </script>
<x:saveState value="#{evaobjectScoreListBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaobjectScoreListBB.pageInit}"></h:inputHidden>
    <h:commandButton id="refresh" value="ˢ��" style="display:none;"  action="#{evaobjectScoreListBB.doQuery}"></h:commandButton>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <%
       		String planId=(String)session.getAttribute("planId");
       %>
       <tr>
       			<td align="center" width="16%" class=tab><a href="EvaMasterResult2.jsf?planId=<%=planId%>">��ֻ������</a></td>
                <td align="center" width="16%" class=activeTab><a href="evaObjectScoreList.jsf?planId=<%=planId%>">�����ϸ���</a></td>
      </tr>
       <tr><td height=8 colspan="2"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	<h:panelGrid align="right" >
    	  <h:outputText value="#{evaobjectScoreListBB.gradeDes}"></h:outputText>
    	  </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:outputText value="������Ա�����"></h:outputText>
                <h:inputText id="condiValue" styleClass="input" value="#{evaobjectScoreListBB.condiValue}" size="20"></h:inputText>
                <h:commandButton id="btnSearch" value="�� ѯ"  styleClass="button01" action="#{evaobjectScoreListBB.doQuery}"/>
                 <h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{evaobjectScoreListBB.pagevo.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{evaobjectScoreListBB.pagevo.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{evaobjectScoreListBB.pagevo.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{evaobjectScoreListBB.pagevo.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{evaobjectScoreListBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaobjectScoreListBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{evaobjectScoreListBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{evaobjectScoreListBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td colspan="2">
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>	
	<%
	        List objectList=(ArrayList)session.getAttribute("objectList");
			String allowMark=(String)session.getAttribute("allowMark");
			String notShowHr=(String)session.getAttribute("notShowHr");
			out.println("<table class='table03' align='center' id='dateList1' width='100%'>");
			out.println("<tr>");
			out.println("<td class='locked_top td_fixtop'>���</td>");
			out.println("<td class='locked_top td_fixtop'>����</td>");
			out.println("<td class='locked_top td_fixtop'>����</td>");
			out.println("<td class='locked_top td_fixtop'>��������</td>");
			out.println("<td class='locked_top td_fixtop'>����÷�</td>");
			out.println("<td class='locked_top td_fixtop'>����ȼ�</td>");
			out.println("<td class='locked_top td_fixtop' colspan='5'>");
			out.println("<table width='100%' height='100%'>");
	        out.println("<td align='center' width='20%'>����</td>");
			out.println("<td align='center' width='20%'>��������</td>");
			if(notShowHr!=null&&notShowHr.equals("0")){
				out.println("<td align='center' width='20%'>��ֽ��</td>");
				out.println("<td align='center' width='20%'>����ȼ�</td>");
			}
			if(allowMark!=null&&allowMark.equals("1")){
				out.println("<td align='center' width='20%'>����</td>");
			}
			out.println("</table>");
			out.println("</td>");
			out.println("</tr>");
			if(objectList!=null&&objectList.size()>0){
				for(int i=0;i<objectList.size();i++){
					out.println("<tr>");
					EvaObjectMasterScoreVO vo=(EvaObjectMasterScoreVO)objectList.get(i);
					List list=vo.getMasterList();
					if(list!=null&&list.size()>0){
						out.println("<td class='td_middle_center'>"+(i+1)+"</td>");
						out.println("<td class='td_middle_center'>"+vo.getOrgName()+"</td>");
						out.println("<td class='td_middle_center'>"+vo.getDeptName()+"</td>");
						out.println("<td class='td_middle_center'>"+vo.getObjectName()+"</td>");
						out.println("<td class='td_middle_center'>"+vo.getScore()+"</td>");
						out.println("<td class='td_middle_center'>"+vo.getGradeName()+"</td>");
						out.println("<td class='td_middle_center' colspan='5'>");
						out.println("<table width='100%' height='100%'>");
						for(int j=0;j<list.size();j++){
							EvaMasterBO bo=(EvaMasterBO)list.get(j);
							out.println("<tr>");
							out.println("<td class='td_middle_center' width='20%'>"+bo.getPersonName()+"</td>");
							out.println("<td class='td_middle_center' width='20%'>"+bo.getMasterType()+"</td>");
							if(notShowHr!=null&&notShowHr.equals("0")){
								out.println("<td class='td_middle_center' width='20%'>"+bo.getScore()+"</td>");
								out.println("<td class='td_middle_center' width='20%'>"+bo.getGradeId()+"</td>");
							}
							if(allowMark!=null&&allowMark.equals("1")){
							out.println("<td class='td_middle_center' width='20%'><a href='#' onclick='return beginInput(\""+bo.getMasterID()+"\",\""+bo.getObjectID()+"\",\""+vo.getTemplateId()+"\")'>���</a></td>");
							}
							out.println("</tr>");
						}
						out.println("</table>");
						out.println("</td>");
					}
					out.println("</tr>");
				}
				
				out.println("</table>");
			}
	%>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
 setDataTableOver("dateList1");
</script>
