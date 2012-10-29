<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>

    <script type="text/javascript">
    	var str="";
        function doSetScore(id,arr) {
            window.showModalDialog("/eva/ShowJobContent.jsf?seq="+id+"&array="+arr, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.5+"px;center:center;resizable:yes;status:no;scroll:no;");
            document.all('form1:refresh').click();
			return true;
             }
        function doAddScore() {
            var itemId =document.all("form1:itemId").value ;
           window.showModalDialog("/eva/addSelfJobDetail.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:no;");
			return true;
             }
        function getHistory() {
            var itemId =document.all("form1:itemId").value ;
           	window.showModalDialog("/eva/jobEstimateLog.jsf?itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
			return true;
        }
        function doChangeScore(i,itemId) {
            window.showModalDialog("/eva/modifySelfJobDetail.jsf?num="+i+"&itemId="+itemId, null, "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.2+"px;center:center;resizable:yes;status:no;scroll:no;");
            document.all('form1:refresh').click();
			return true;
        }
        function deleteLine(array,itemId,num){
        	str = array+":"+itemId+":"+num;
        	document.all("form1:deletebutton").click();
            }
        function deleteData(){
        	document.all("form1:doDelete").value=str;
        	return true;
            }
    </script>
<x:saveState value="#{eva_showSelfJobDetailBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eva_showSelfJobDetailBB.pageInit}"/>
    <h:inputHidden id="itemId" value="#{eva_showSelfJobDetailBB.itemID}"/>
    <h:inputHidden id ="doDelete" value="#{eva_showSelfJobDetailBB.doDelete}"/>
    <h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{eva_showSelfJobDetailBB.queryPlanList}"></h:commandButton>
    <h:commandButton id="deletebutton" value="删除" style="display:none;" onclick="return deleteData();" action="#{eva_showSelfJobDetailBB.delete}"></h:commandButton>
	<h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 绩效管理 -> 自助岗位职责考核"/>
        </h:panelGroup>
        
    </h:panelGrid>
    
    <h:panelGrid columns="1" align="center" width="98%">
    	<h:panelGroup>
    	<h:panelGrid align="left" columns="2">
    		<h:outputText value="当前状态："></h:outputText>
    		<h:outputText value="#{eva_showSelfJobDetailBB.statusDes}"/>
    	</h:panelGrid>
    	<h:panelGrid align="right" columns="8">
        	<h:commandButton value="增加" styleClass="button01" onclick="return doAddScore();"></h:commandButton>
        	<h:outputText value=" "></h:outputText>
        	<h:commandButton value="过程" styleClass="button01" onclick="return getHistory();"></h:commandButton>
        	<h:outputText value=" "></h:outputText>
        </h:panelGrid>
        </h:panelGroup>
	<c:verbatim>
		<br>
		<table class="table02" align="center" id="dateList">
			<tr>
				<td class='locked_top' valign='middle' align='center'>履行责任</td>
				<td class='locked_top' valign='middle' align='center'>工作任务</td>
				<td class='locked_top' valign='middle' align='center'>时间比重</td>
				<td class='locked_top' valign='middle' align='center'>考核要点</td>
				<td class='locked_top' valign='middle' align='center'>具体工作</td>
				<td class='locked_top' valign='middle' align='center'>操作</td>
			</tr>
			<%
				for(int i=1;i<=10;i++){
					if(request.getAttribute("tasklist"+i)!=null){
					String[] array = (String[])request.getAttribute("tasklist"+i);//从request中取出数组进行强制转换
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
					//显示具体工作内容
					String arr = array[0];
					String itemId = (String)session.getAttribute("itemId");  
					if(request.getAttribute("content"+i)!=null){
					List content = (List)request.getAttribute("content"+i);
					out.print("<td valign='middle' class='td_middle_left' align='center'>");
					out.print("<table>");
					for(int k=0;k<content.size();k++){
						EvaJobContentBO jcb = (EvaJobContentBO)content.get(k);
					out.print("<tr>");
					out.print("<td>");
					if(jcb.getContent()==null){
						jcb.setContent(CommonFuns.filterNull(jcb.getContent()));
					}
					out.print(jcb.getContent());
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
					}else{
						out.print("<td valign='middle' class='td_middle_left' align='center'>");
						out.print("</td>");
					}
					out.print("<td valign='middle' class='td_middle_left' align='center'>");
					out.print("<input type=\"button\" class=\"button01\" value=\"修改内容\" onclick=\"doSetScore('"+itemId+"','"+arr+"');\">");
					out.print("<input type=\"button\" class=\"button01\" value=\"修改属性\" onclick=\"doChangeScore('"+i+"','"+itemId+"');\">");
					out.print("<input type=\"button\" class=\"button01\" value=\"删除\" onclick=\"deleteLine('"+array[1]+"','"+itemId+"','"+i+"');\">");
					out.print("</td>");
					out.print("</tr>");
					}
				}
			%>
		</table>
	</c:verbatim>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("dateList");
</script>