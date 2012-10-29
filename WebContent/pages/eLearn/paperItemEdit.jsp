<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    
    <script type="text/javascript">
      function doCheck(){
          if (document.all('form1:title').value==null || document.all('form1:title').value==""||document.all('form1:title').value=="-1"){
              alert("请选择题目！");
              return false;
          }
          return true;
      }
      function selectQuestion(){
          if(document.all("form1:type").value=="" ||document.all("form1:type").value==null){
              alert("请选择题目类型！");
              return false;
          }
          var reval = window.showModalDialog("/eLearn/questionSelLib.jsf?type="+document.all('form1:type').value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
          if (reval != null && reval!="") {
          	var vars=reval.split(",");
            document.all("form1:title").value = vars[0];
          	document.all("form1:linkID").value = vars[1];
            return true;
          } else {
              return false;
          }
      }
    </script>

<x:saveState value="#{eLearn_paperLibBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eLearn_paperLibBB.initEditItem}"/>
    <h:inputHidden id="type" value="#{eLearn_paperLibBB.type}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eLearn_paperLibBB.SavePaperItem}"
                            onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="关联题目"/>
            <h:panelGroup>
            	<h:inputText id="title" value="#{eLearn_paperLibBB.itembo.title}" readonly="true"/>
                <h:inputHidden id="linkID" value="#{eLearn_paperLibBB.itembo.linkID}" />
                <h:commandButton styleClass="button_select" type="button" onclick="selectQuestion()"></h:commandButton>
            </h:panelGroup>

            <h:outputText value="顺序"/>
            <h:inputText  value="#{eLearn_paperLibBB.itembo.showSeq}" />

            <h:outputText value="分数"/>
            <h:inputText id="score" value="#{eLearn_paperLibBB.itembo.score}" />
        </h:panelGrid>
    </h:panelGrid>
</h:form>

