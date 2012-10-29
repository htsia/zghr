<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

    <script type="text/javascript">
	    function doSetScore(id,arr) {
	        window.showModalDialog("/eva/ShowJobContent.jsf?seq="+id+"&array="+arr, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
			return true;
	         }
	    function doChangeScore(i,itemId) {
	        window.showModalDialog("/eva/modifySelfJobDetail.jsf?num="+i+"&itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:no;");
	        document.all('form1:refresh').click();
			return true;
	         }
	    function doAddScore() {
            var itemId =document.all("form1:itemId").value ;
           window.showModalDialog("/eva/addSelfJobDetail.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:no;");
			return true;
             }
        function saveScore(){
			var score = document.getElementsByTagName("input");
			var str="";
			for(var i=0;i<score.length;i++){
				if(score[i].type=="text"){
					if(score[i].value==null||score[i].value==""){
						score[i].value = 0;
					}
					str += score[i].id+":"+score[i].value + ",";
			    }
			}
			document.all('form1:saveStr').value=str;
		    return true;
        }
        function getHistory() {
            var itemId =document.all("form1:itemId").value ;
           	window.showModalDialog("/eva/jobEstimateLog.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
			return true;
        }
    </script>
    
<x:saveState value="#{eva_showSelfJobDetailBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_showSelfJobDetailBB.pageLeadInit}"/>
    <h:inputHidden id="itemId" value="#{eva_showSelfJobDetailBB.itemID}"/>
	<h:commandButton id="refresh" value="ˢ��" style="display:none;"  action="#{eva_showSelfJobDetailBB.queryPlanList}"></h:commandButton>
	<c:verbatim>
		<table width="100%">
			<tr>
				<td>
				</c:verbatim>
					<h:panelGrid align="left" columns="2">
    					<h:outputText value="��ǰ״̬��"></h:outputText>
    					<h:outputText value="#{eva_showSelfJobDetailBB.statusDes}"/>
    				</h:panelGrid>
				<c:verbatim>
				</td>
				<td align="right">
				</c:verbatim>
					<h:commandButton value="����" styleClass="button01" onclick="return doAddScore();" rendered="#{eva_showSelfJobDetailBB.jobBo.status=='1' or eva_showSelfJobDetailBB.jobBo.status=='4' or eva_showSelfJobDetailBB.jobBo.status=='0'}"></h:commandButton>
				   	<h:outputText value=" "></h:outputText>
				   	<h:commandButton value="ְ��������׼" styleClass="button01" action="#{eva_showSelfJobDetailBB.audit}" rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:outputText>
        			<h:commandButton value="ְ����������׼" styleClass="button01" action="#{eva_showSelfJobDetailBB.audit2}" rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='1'}"></h:outputText>
        			<h:commandButton value="ͬ���޸�" styleClass="button01" action="#{eva_showSelfJobDetailBB.modify}" rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:outputText>
        			<h:commandButton value="��ͬ���޸�" styleClass="button01" action="#{eva_showSelfJobDetailBB.modifyNO}" rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='3'}"></h:outputText>
        			<h:commandButton value="ͬ���޸Ĺ�������" styleClass="button01" action="#{eva_showSelfJobDetailBB.modifyContentOK}" rendered="#{eva_showSelfJobDetailBB.status=='5'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='2'}"></h:outputText>
        			<h:commandButton value="��ͬ���޸Ĺ�������" styleClass="button01" action="#{eva_showSelfJobDetailBB.modifyContentNo}" rendered="#{eva_showSelfJobDetailBB.status=='5'}"></h:commandButton>
        			<h:outputText value=" " rendered="#{eva_showSelfJobDetailBB.status=='2'}"></h:outputText>
        			<h:commandButton value="����" styleClass="button01" onclick="return getHistory();"></h:commandButton>
        			<h:outputText value=" "></h:outputText>
        			<h:commandButton styleClass="button01" value="���" onclick="return saveScore();" action="#{eva_showSelfJobDetailBB.saveScore}" rendered="#{eva_showSelfJobDetailBB.status=='7'}"></h:commandButton>
				    <h:inputHidden id="saveStr" value="#{eva_showSelfJobDetailBB.saveStr}"></h:inputHidden>
				    <c:verbatim>
				</td>
			</tr>
		</table>
		<table class="table03" align="center" id="dateList" >
			<tr>
				<td class='locked_top' valign='middle' align='center'>��������</td>
				<td class='locked_top' valign='middle' align='center'>��������</td>
				<td class='locked_top' valign='middle' align='center'>ʱ�����</td>
				<td class='locked_top' valign='middle' align='center'>����Ҫ��</td>
				<td class='locked_top' valign='middle' align='center'>�����������</td>
				<td class='locked_top' valign='middle' align='center'>���˴��</td>
				<td class='locked_top' valign='middle' align='center'>����</td>
			</tr>
			<%
				
				for(int i=1;i<=10;i++){
					if(request.getAttribute("tasklist"+i)!=null){
					String[] array = (String[])request.getAttribute("tasklist"+i);//��request��ȡ���������ǿ��ת��
					String arr = array[0];
					String itemId = (String)session.getAttribute("itemId");
					request.getSession().removeAttribute("array"+i);
					request.getSession().setAttribute("array"+i,array);
					out.print("<tr>");
					for(int j = 1;j < array.length;j++){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						if(array[j]!=null){
							out.print(array[j]);
						}else{
							out.print(CommonFuns.filterNull(array[j]));
						}
						out.print("</td>");
						}
					if(request.getAttribute("content"+i)!=null){
					List content = (List)request.getAttribute("content"+i);
					EvaJobContentBO jcb;
					//��ʾ�����������˴��
					out.print("<td valign='middle' class='td_middle_left' align='center'>");
					out.print("<table>");
					for(int k=0;k<content.size();k++){
						jcb = (EvaJobContentBO)content.get(k);
					out.print("<tr>");
					out.print("<td>");
					if(jcb.getContent()==null){
						jcb.setContent(CommonFuns.filterNull(jcb.getContent()));
					}
					out.print(jcb.getContent());
					out.print("</td>");
					out.print("<td>");
					if(jcb.getSelfScore()==null||"".equals(jcb.getSelfScore())){
						jcb.setSelfScore("0");
					}
					out.print(jcb.getSelfScore()+"��");
					out.print("</td>");
					out.print("<td>");
					if(jcb.getResult()==null){
						jcb.setResult(CommonFuns.filterNull(jcb.getResult()));
					}
					out.print(jcb.getResult());
					out.print("</td>");
					out.print("</tr>");
					}
					out.print("</table>");
					out.print("</td>");
					//��ʾ���幤�����ݼ��쵼���˴��
					out.print("<td valign='middle' class='td_middle_left' align='center'>");
					out.print("<table>");
					for(int k=0;k<content.size();k++){
						jcb = (EvaJobContentBO)content.get(k);
					out.print("<tr>");
					out.print("<td>");
					if(jcb.getLeadScore()==null||"".equals(jcb.getLeadScore())){
						jcb.setLeadScore("0");
					}
					if("7".equals((String)session.getAttribute("status"))){
						out.print("<input id = '"+jcb.getTaskID()+"' class='input' type='text' value='"+jcb.getLeadScore()+"'/>");
					}else{
						out.print("<input id = '"+jcb.getTaskID()+"' class='input' type='text' value='"+jcb.getLeadScore()+"' readonly='true'/>");
					}
					out.print("</td>");
					out.print("</tr>");
					}
					out.print("</table>");
					out.print("</td>");
					}else{
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("</td>");
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("</td>");
					}
					if("0".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("1".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\">");
						out.print("</td>");
					}
					
					if("2".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					
					if("3".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("4".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\">");
						out.print("</td>");
					}
					if("5".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("6".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doSetScore('"+itemId+"','"+arr+"');\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("7".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					if("8".equals((String)session.getAttribute("status"))){
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("<input type=\"button\" class=\"button01\" value=\"�޸�����\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\" disabled=\"true\">");
						out.print("<input type=\"button\" class=\"button01\" value=\"ɾ��\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\" disabled=\"true\">");
						out.print("</td>");
					}
					out.print("</tr>");
					}
				}
			%>
		</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("dateList");
</script>