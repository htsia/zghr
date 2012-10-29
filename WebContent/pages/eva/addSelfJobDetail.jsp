<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<script type="text/javascript">
        function doChange(){
			var score = document.getElementsByTagName("input");
			var str="";
			for(var i=0;i<score.length;i++){
				if(score[i].type=="text"){
					if(score[i].value==""&&score[i].value!=0){
						if(i==0){
						score[i].value='';
						}else{
						score[i].value=0;
						}
						str+=score[i].value+":";
					}else{
						str+=score[i].value+":";
						}
			    }
			}
			var content = document.getElementsByTagName("textarea")[0].value;
			var another = document.getElementsByTagName("textarea")[1].value;
			if(content==null){
				content='';
			}
			if(another==null){
				another='';
				}
			var con = "";
			con +=content +":"+ another+":";
			str=con+str;
			var splitStr = str.split(":");
			if(splitStr[0]==""&&splitStr[1]==""&&splitStr[2]==""&&splitStr[3]==""){
				alert("请输入数据!");
				return false;
			}	
			document.all('form1:doChange').value=str;
		    return true;
        }
    </script>

<x:saveState value="#{eva_showSelfJobDetailBB}" />
<h:form id="form1">
	<h:inputHidden value="#{eva_showSelfJobDetailBB.initChange}"></h:inputHidden>

	<h:panelGrid columns="4" width="100%"
		columnClasses="td_form01,td_form02,td_form01,td_form02" align="center"
		styleClass="table03">
		<h:outputText value="履行责任"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
					out.print("<input value='' class='input' type='text'");
				%>
			</c:verbatim>
		</h:panelGroup>
		<h:outputText value="时间比重"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
					out.print("<input value='' class='input' type='text'");
				%>
			</c:verbatim>
		</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		<h:outputText value="工作任务"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
				out.print("<textarea name='data' cols='70'>");
				out.print("</textarea>");
				%>
			</c:verbatim>
		</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		<h:outputText value="考核要点"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
				out.print("<textarea name='data' cols='70'>");
				out.print("</textarea>");
				%>
			</c:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid align="right" styleClass="table03">
		<h:inputHidden id="doChange" value="#{eva_showSelfJobDetailBB.doChange}"></h:inputHidden>
				    <h:commandButton styleClass="button01" value="保存" onclick="return doChange();" action="#{eva_showSelfJobDetailBB.add}">
				    </h:commandButton>
	</h:panelGrid>
</h:form>