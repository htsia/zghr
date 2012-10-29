<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


    <script type="text/javascript">
      function doCheck(){
          if (document.all('form1:name').value==null || document.all('form1:name').value==""){
              alert("请输入名称");
              return false;
          }
          if (document.all('form1:questiontype').value==null || document.all('form1:questiontype').value==""){
              alert("请选择题目类型");
              return false;
          }
          return true;
      }
      function changeType(){
          document.all('form1:cap').style.display='none';
          document.all('form1:lowvalue').style.display='none';
          document.all('form1:referKeyTitle').style.display='none';
          document.all('form1:referKey').style.display='none';
          document.all('form1:judgeTitle').style.display='none';
          document.all('judge').style.display='none';

          if (document.all('form1:questiontype').value=='3'){
              document.all('form1:cap').style.display='block';
              document.all('form1:lowvalue').style.display='block';
              document.all('form1:referKeyTitle').style.display='block';
              document.all('form1:referKey').style.display='block';
          }
          if (document.all('form1:questiontype').value=='5'){
              document.all('form1:judgeTitle').style.display='block';
              document.all('judge').style.display='block';
          }
      }
    </script>

<x:saveState value="#{eLearn_questionLibBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{eLearn_questionLibBB.pageInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{eLearn_questionLibBB.SaveQuestion}"
                            onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="内容"/>
            <h:inputTextarea id="name" value="#{eLearn_questionLibBB.questionbo.title}" cols="60" rows="6"/>

            <h:outputText value="应用范围"></h:outputText>
            <h:selectOneMenu value="#{eLearn_questionLibBB.questionbo.orgscope}">
                     <c:selectItems value="#{eLearn_questionLibBB.orgList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="题目类型" style="width:60px"/>
            <h:panelGroup>
                <h:selectOneMenu id="questiontype" value="#{eLearn_questionLibBB.questionbo.questionType}" onchange="changeType();">
                    <c:selectItem itemLabel="注释文字" itemValue="-1"></c:selectItem>
                    <c:selectItem itemLabel="单选题" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="多选题" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="可以附加内容" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="问答题" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="填空题" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="判断题" itemValue="5"></c:selectItem>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:outputText id="judgeTitle" value="是否正确"/>
            <h:panelGroup>
            <c:verbatim><div id="judge"></c:verbatim>
            <h:selectOneRadio  value="#{eLearn_questionLibBB.questionbo.isRight}">
                <c:selectItem itemLabel="对" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="错" itemValue="0"></c:selectItem>
            </h:selectOneRadio>
            <c:verbatim></div></c:verbatim>
            </h:panelGroup>

            <h:outputText id="cap" value="最少字数"/>
            <h:inputText id="lowvalue" value="#{eLearn_questionLibBB.questionbo.lowChars}" />

            <h:outputText id="referKeyTitle" value="参考答案"/>
            <h:inputTextarea  id="referKey" value="#{eLearn_questionLibBB.questionbo.referKey}" cols="60" rows="6"/>

        </h:panelGrid>
    </h:panelGrid>
</h:form>
      <script type="text/javascript">
          changeType();
      </script>
