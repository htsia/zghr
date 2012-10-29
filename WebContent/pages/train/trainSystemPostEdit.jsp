<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

     
      <script type="text/javascript">
    	function chkDate(){
        	if(document.all("form1:syscode").value==""){
            	alert("请选择培训体系类型");
            	return false;
        	}else if(document.all("form1:type").value==""){
        		alert("请选择课程类型 ");
            	return false;
            }else if(document.all("form1:linkCourse").value==""){
        		alert("请选择课程");
            	return false;
        	}else{
        		document.all("form1:syscode").code=document.all("form1:typeId").value;
        		alert(document.all("form1:syscode").code);
         		return forsubmit(document.forms(0));
        	}
        }
        function changeCourse(){
            var codevalue=document.all("form1:syscode").code;
            document.all("form1:typeId").value=codevalue;
            document.form1.submit();
        }
       	function forBack(form){
             window.close();
        }
        function selectCource(){
        	 var reval = window.showModalDialog("/train/selPrivateCourse.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:yes;scroll:yes;");
             if (reval != null && reval!="") {
                 var vars=reval.split("|");
                 var ids="";
                 var names="";
                 var idnames= vars[1].split(",");
                 for(var i=0;i<idnames.length;i++){
                     if(idnames[i]!=null&&idnames[i]!=""){
                         var idname=idnames[i].split(":");
                         if(ids!=""){
                         	ids+=","+idname[0];
                         }else{
                            ids+=idname[0];
                         }
                         if(names!=""){
                         	names+=","+idname[1];
                         }else{
                        	names+=idname[1];
                         }
                     }
                 }
                 document.all("form1:linkCourse").value=ids;
                 document.all("form1:courseDes").value=names;
                 return true;
             } else {
                 return false;
             }
        }
      </script>
  
  <x:saveState value="#{trainSystemPostBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{trainSystemPostBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="postId" value="#{trainSystemPostBB.postId}"></h:inputHidden>
      <h:inputHidden id="personStr" value=""/>
      <h:inputHidden id="bookStr" value=""/>
      <h:inputHidden id="typeId" value=""/>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="培训体系管理-> 培训体系设置"/>
          </h:panelGroup>
      </h:panelGrid>

	<h:panelGrid columns="1"  width="98%" align="left">
      	
           <h:panelGrid width="100%" columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               	<h:outputText value="培训类型"></h:outputText>
               	<h:panelGroup>
               	<h:inputText styleClass="input" id="syscode" code="" dict="yes" dict_num="2033"
                     readonly="true" value="#{trainSystemPostBB.systembo.itemType}"
                     alt="性别|1|s|50||"/>
                 <f:verbatim>
        			<input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:syscode')">
                </f:verbatim>
                </h:panelGroup>
                <h:outputText value="课件类型"></h:outputText>
                <h:selectOneMenu id="type" value="#{trainSystemPostBB.systembo.courseType}" onchange="changeCourse()" valueChangeListener="#{trainSystemPostBB.changType}">
                	<c:selectItem itemLabel="选择" itemValue=""/>
                	<c:selectItem itemLabel="scorm课件" itemValue="1"/>
                	<c:selectItem itemLabel="传统课件" itemValue="2"/>
                </h:selectOneMenu>
			 	<h:outputText value="关联在线学习课程"></h:outputText>
                <h:panelGroup>
                    <h:inputTextarea id="courseDes" cols="60" rows="5" readonly="true" value="#{trainSystemPostBB.systembo.linkCourseDes}"></h:inputTextarea>
                    <h:inputHidden id="linkCourse" value="#{trainSystemPostBB.systembo.linkCourse}"/>
                    <h:commandButton styleClass="button_select" type="button" onclick="PopUpeLearnCourseTwoControl(document.all('form1:linkCourse'),document.all('form1:courseDes'));" rendered="#{trainSystemPostBB.systembo.courseType=='1'}"></h:commandButton>
                    <h:commandButton styleClass="button_select" type="button" onclick="selectCource()" rendered="#{trainSystemPostBB.systembo.courseType=='2'}"></h:commandButton>
                </h:panelGroup>
                <h:outputText value="学时"></h:outputText>
                <h:inputText value="#{trainSystemPostBB.systembo.period}"></h:inputText>
                <h:outputText value="学分"></h:outputText>
                <h:inputText value="#{trainSystemPostBB.systembo.score}"></h:inputText>
			</h:panelGrid>
			<h:panelGrid align="right">
              <h:commandButton value="保存" id="save" styleClass="button01" onclick="return chkDate();" action="#{trainSystemPostBB.saveSystembo}" />
           </h:panelGrid>
      </h:panelGrid>
</h:form>

  <script type="text/javascript">
    interpret(document.forms(0));
</script>
