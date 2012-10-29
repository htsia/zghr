<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="../include/taglib.jsp" %>
<html>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <head>
      <title></title>
      
      <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/check.js"></script>
      <script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAll.js"></script>
      <script type="text/javascript">
      function doCheck(){
          if (document.all('form1:title').value==""){
              alert("请录入岗位名称!");
              return false;
          }
          if (document.all('form1:superName').value==""){
              alert("请录入主管机构!");
              return false;
          }
          if (document.all('form1:postClass').value==""){
              alert("请录入岗位分类!");
              return false;
          }
          if (document.all('form1:updateDate').value==""){
              alert("请录入更新日期!");
              return false;
          }
          if (document.all('form1:workOut').value==""){
              alert("请录入岗位编制!");
              return false;
          }
          return forsubmit(document.forms(0));
      }
      function findPopUpOrgDlg(obj, useRightFlag, rootOrgId) {
    	    var ctrlobj = document.all(obj);
    	    showx = event.screenX - event.offsetX - 150;
    	    showy = event.screenY - event.offsetY + 18;
    	    if (useRightFlag == null)
    	        useRightFlag = 0;
    	    if (rootOrgId == null)
    	        rootOrgId = "";
    	    var arg = "dict_num=" + ctrlobj.dict_num;
    	    arg += "&curCode=" + ctrlobj.code;
    	    arg += "&value=" + ctrlobj.value;
    	    arg += "&rightFlag=" + useRightFlag;
    	    arg += "&rootId=" + rootOrgId;

    	    retval = window.showModalDialog("/pages/org/SelOrgItem.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    	    if (retval != null) {
    	        rs = retval.split(",");
    	        document.all('form1:superName').value = rs[1];
    	        document.all('form1:B001002').value = rs[0];
    	    }
    	}
      </script>
  </head>

  <body>
  <x:saveState value="#{orgTemplateBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{orgtemppostlistBB.initPost}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
                 <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-0100","机构管理 ")+"->"%> 
                 <%=LanguageSupport.getResource("JGGL-1076","模版管理")%> 
              </f:verbatim>
          </h:panelGroup>
      </h:panelGrid>

      <h:panelGrid columns="1"  width="98%" align="left">
           <h:panelGrid columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-1077","岗位名称")%> 
              </f:verbatim>
               <h:inputText  id="title" value="#{orgtemppostlistBB.postvo.name}"></h:inputText>
               <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-1004","主管机构")%> 
              </f:verbatim>
			   <h:panelGroup>
			   		<h:inputHidden id="B001002" value="#{orgtemppostlistBB.postvo.orgId}"></h:inputHidden>
			   		<h:inputText id="superName" readonly="true" value="#{orgtemppostlistBB.superName}"></h:inputText>
           			<h:commandButton type="button" styleClass="button_select" onclick="findPopUpOrgDlg('form1:B001002',2,'')"/>
			   </h:panelGroup>
			  <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-1079","岗位分类")%> 
              </f:verbatim>
               <h:panelGroup>
               <h:inputText styleClass="input" id="postClass" code="" dict="yes" dict_num="0110"  readonly="true"
                         value="#{orgtemppostlistBB.postvo.postClass}"
                         alt="岗位分类|0|s|50||"/>
                         <h:commandButton styleClass="button_select" type="button" onclick="PopUpCodeDlgOneControl('form1:postClass')"></h:commandButton>
                </h:panelGroup>
                
              <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-1080","更新日期")%> 
              </f:verbatim>
               <h:panelGroup>
	               <h:inputText styleClass="input" id="updateDate" value="#{orgtemppostlistBB.postvo.updateDate}"
	                         alt="更新日期|0|d|50||"/>
	                <h:commandButton styleClass="button_select" type="button" onclick="PopUpCalendarDialog('form1:updateDate')"></h:commandButton>
                </h:panelGroup>
                
              <f:verbatim>
                 <%=LanguageSupport.getResource("JGGL-1081","岗位编制")%> 
              </f:verbatim>
               <h:inputText  id="workOut" value="#{orgtemppostlistBB.postvo.workOut}"></h:inputText>
           </h:panelGrid>

           <h:panelGrid align="right">
              <h:commandButton value="保存" id="save"  action="#{orgtemppostlistBB.savePost}" styleClass="button01" onclick="return doCheck();"/>
           </h:panelGrid>
      </h:panelGrid>

  </h:form>
  <script type="text/javascript">
  	interpret(document.forms(0));
</script>
  </body>
</html>