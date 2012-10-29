<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<c:verbatim>
<script type="text/javascript" language="javascript">
    with (window) onload = onresize = function(){
        var mainHeight = document.body.clientHeight - 20;
        if (document.getElementById("studyContent")!=null){
            document.getElementById("studyContent").style.height = "" + mainHeight + "px";
        }
    }
</script>
</c:verbatim>
<%
   String study=request.getParameter("studyID");
%>
<x:saveState value="#{eLearn_studyBB}" />
<h:form id="form1">
    <c:verbatim>
    <table width=98%  align="center" >
         <tr><td height=0 align="right">
               <jsp:plugin   type="applet"   code="com.hr319wg.scorm.NewHRAdapterApplet" name="APIObject"
                archive="scormclient.jar,scormdata.jar,hr-busilogic.jar"        width="2"   height="2"   codebase="/pages/eLearn/">
              </jsp:plugin>
         </td></tr>

         <tr><td valign="top">
               <iframe  width='100%'  name='studyContent'  scrolling='no' frameborder='0' src='/eLearn/LMSFrame.jsf?studyID=<%=study%>'/>
         </td></tr>
     </table>
    </c:verbatim>

</h:form>

