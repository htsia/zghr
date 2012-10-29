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
              alert("������˳��");
              return false;
          }
          if (document.all('form1:name').value==null || document.all('form1:name').value==""){
              alert("����������");
              return false;
          }
          if (document.all('form1:questiontype').value==null || document.all('form1:questiontype').value==""){
              alert("��ѡ����Ŀ����");
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
            <h:commandButton styleClass="button01" value="����" action="#{sys_questionBB.Save}"
                            onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1157", "˳��")%>
	        </f:verbatim>
            <h:inputText id="seq" value="#{sys_questionBB.questionbo.showSeq}" style="width:60px"/>

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1111", "����")%>
	        </f:verbatim>
            <h:inputTextarea id="name" value="#{sys_questionBB.questionbo.title}" cols="60" rows="6"/>

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1395", "��Ŀ����")%>
	        </f:verbatim>
            <h:panelGroup>
                <h:selectOneMenu id="questiontype" value="#{sys_questionBB.questionbo.type}" onchange="changeType();">
                    <c:selectItem itemLabel="ע��ͼƬ" itemValue="-2"></c:selectItem>
                    <c:selectItem itemLabel="ע������" itemValue="-1"></c:selectItem>
                    <c:selectItem itemLabel="��ѡ��" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="��ѡ��" itemValue="1"></c:selectItem>
                    <c:selectItem itemLabel="���Ը�������" itemValue="2"></c:selectItem>
                    <c:selectItem itemLabel="�ʴ���" itemValue="3"></c:selectItem>
                    <c:selectItem itemLabel="�����" itemValue="4"></c:selectItem>
                    <c:selectItem itemLabel="��Ƭѡ��" itemValue="5"></c:selectItem>
                </h:selectOneMenu>
            </h:panelGroup>

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1396", "��������")%>
	        </f:verbatim>
            <h:inputText id="lowvalue" value="#{sys_questionBB.questionbo.lowChars}" />

             <f:verbatim>
			    <%=LanguageSupport.getResource( "XTGL-1397", "����ͼƬ")%>
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
