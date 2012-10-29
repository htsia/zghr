<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
      function doCheck(){
          if (document.all('form1:seq').value==null || document.all('form1:seq').value==""){
              alert("请输入顺序");
              return false;
          }
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
          if (document.all('form1:questiontype').value=='3'){
              document.all('form1:lowvalue').style.display='block';
          }
          else{
              document.all('form1:lowvalue').style.display='none';
          }

          if (document.all('form1:questiontype').value=='-2' || document.all('form1:questiontype').value=='5'){
              document.all('form1:imgageFile').style.display='block';
          }
          else{
              document.all('form1:imgageFile').style.display='none';
          }
      }
    </script>

<x:saveState value="#{sys_questionBB}"/>
<h:form id="form1" enctype="multipart/form-data">
    <h:inputHidden id="pageInit" value="#{sys_questionBB.pageInit}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{sys_questionBB.Save}"
                            onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1157", "顺序")%>
	        </f:verbatim>
            <h:inputText id="seq" value="#{sys_questionBB.questionbo.showSeq}" style="width:60px"/>

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1111", "内容")%>
	        </f:verbatim>
            <h:inputTextarea id="name" value="#{sys_questionBB.questionbo.title}" cols="60" rows="6"/>

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1395", "题目类型")%>
	        </f:verbatim>
            <h:panelGroup>
                <h:selectOneMenu id="questiontype" value="#{sys_questionBB.questionbo.type}" onchange="changeType();">
                    <c:selectItem itemLabel="注释图片" itemValue="-2"></c:selectItem>
                    <c:selectItem itemLabel="注释文字" itemValue="-1"></c:selectItem>
                    <c:selectItem itemLabel="单选题" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="多选题" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="可以附加内容" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="问答题" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="填空题" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="照片选择" itemValue="5"></c:selectItem>
                </h:selectOneMenu>
            </h:panelGroup>

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1396", "最少字数")%>
	        </f:verbatim>
            <h:inputText id="lowvalue" value="#{sys_questionBB.questionbo.lowChars}" />

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1397", "关联图片")%>
	        </f:verbatim>
            <h:panelGrid columns="1" id="imgageFile">
                <h:graphicImage value="/file/survey/#{sys_questionBB.questionbo.fileName}"  />
                <x:inputFileUpload styleClass="input" id="blobFile" value="#{sys_questionBB.blobFile}"  storage="file" size="25" />
           </h:panelGrid>

        </h:panelGrid>

    </h:panelGrid>
</h:form>
      <script type="text/javascript">
          changeType();
      </script>
