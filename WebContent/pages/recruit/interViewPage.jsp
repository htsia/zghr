<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<script type="text/javascript">
function doOK() {
    if (document.all('form1:paperID').value=="" || document.all('form1:paperID').value==null){
        alert("请选择试卷!");
        return false;
    }
	    var paperId = document.all('form1:paperID').value;
        document.all("form1:detailId").value = paperId;
        alert("操作成功!");
        window.close();
        return true;
    }
</script>
<x:saveState value="#{recu_interviewResultBB}" />
<h:form id="form1">
	<h:inputHidden value="#{recu_interviewResultBB.initEdit}"></h:inputHidden>
	<h:inputHidden id="superId" value="#{recu_interviewResultBB.superId}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id='datatable'>
				</c:verbatim> 
				
        <h:panelGrid columns="5" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
        <h:outputText value="设置面试试卷"></h:outputText>
            <h:panelGroup>
                <h:inputText id="paperName" readonly="true" value="#{eLearn_testBB.testbo.paperName}"></h:inputText>
                <h:inputHidden id="paperID" value="#{eLearn_testBB.testbo.paperID}"></h:inputHidden>
                <h:commandButton styleClass="button_select" onclick="PopUpPaperTwoControl(document.all('form1:paperID'),document.all('form1:paperName'))" type="button" ></h:commandButton>
				<h:commandButton styleClass="button01" value="保存" action="#{recu_interviewResultBB.changeStatus}" onclick="return doOK();" />
	            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
	            <h:inputHidden id="detailId" value="#{recu_interviewResultBB.paperID}"></h:inputHidden>
            </h:panelGroup>
            
	</h:panelGrid>
				 <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>