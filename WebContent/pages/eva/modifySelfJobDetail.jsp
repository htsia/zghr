<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	String num = request.getParameter("num");
	String[] array = (String[]) request.getSession().getAttribute(
			"array" + num);
%>
<script type="text/javascript">
        function doChange(){
			var score = document.getElementsByTagName("input");
			var str="";
			for(var i=0;i<score.length;i++){
				if(score[i].type=="text"){
					if(score[i].value==null||score[i].value==""){
						score[i].value='';
					}
					if(score[i].value!=0){
					str += score[i].value + ":";
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
			con += content +":"+ another+":";
			str=con+str;
			str = str.replace(/%/g,"");//��ҳ���ϵ�%�滻Ϊ�գ���֤ҳ���в�����ֶ��%����Ϊ�����ݿ����������ʱ��̨���Զ����%
			var splitStr = str.split(":");
			if(splitStr[0]==""||splitStr[1]==""||splitStr[2]==""||splitStr[3]==""){
				alert("�뱣֤���ݵ�����!");
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
		<h:outputText value="��������"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
					out.print("<input value='" + array[1] + "' class='input' type='text'");
				%>
			</c:verbatim>
		</h:panelGroup>
		<h:outputText value="ʱ�����"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
					out.print("<input value='" + array[3] + "' class='input' type='text'");
				%>
			</c:verbatim>
		</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		<h:outputText value="��������"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
				out.print("<textarea name='data' cols='70'>");
				out.print(array[2]);
				out.print("</textarea>");
				%>
			</c:verbatim>
		</h:panelGroup>
		</h:panelGrid>
		
		<h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
		<h:outputText value="����Ҫ��"></h:outputText>
		<h:panelGroup>
			<c:verbatim>
				<%
				out.print("<textarea name='data' cols='70'>");
				out.print(array[4]);
				out.print("</textarea>");
				%>
			</c:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<h:panelGrid align="right" styleClass="table03">
		<h:inputHidden id="doChange" value="#{eva_showSelfJobDetailBB.doChange}"></h:inputHidden>
				    <h:commandButton styleClass="button01" value="����" onclick="return doChange();" action="#{eva_showSelfJobDetailBB.change}">
				    </h:commandButton>
	</h:panelGrid>
</h:form>