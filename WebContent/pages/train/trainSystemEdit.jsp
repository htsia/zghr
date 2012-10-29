<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

     
      <script type="text/javascript">
    	function chkDate(){
        	if(document.all("form1:postId").value==""){
            	alert("��ѡ���λ");
            	return false;
        	}else if(document.all("form1:type").value==""){
        		alert("��ѡ��γ����� ");
            	return false;
            }else if(document.all("form1:linkCourse").value==""){
        		alert("��ѡ��γ�");
            	return false;
        	}else{
         		return forsubmit(document.forms(0));
        	}
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
  
  <x:saveState value="#{trainSystemBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{trainSystemBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{trainSystemBB.superID}"></h:inputHidden>
      <h:inputHidden id="personStr" value=""/>
       <h:inputHidden id="bookStr" value=""/>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="��ѵ��ϵ����-> ��ѵ��ϵ����"/>
          </h:panelGroup>
      </h:panelGrid>

	<h:panelGrid columns="1"  width="98%" align="left">
      	
           <h:panelGrid width="100%" columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
             	 
             	<h:outputText value="��λ����"></h:outputText>
             	<h:panelGroup>
                    <h:inputHidden id="postId" value="#{trainSystemBB.systembo.postId}"></h:inputHidden>
                    <h:inputText readonly="true" id="postName" styleClass="input" value="#{trainSystemBB.systembo.postName}"/>
                    <h:outputText value=" "></h:outputText>
                    <h:commandButton value="ѡ��" styleClass="button01"  type="button" onclick="fPopUpPostDlg('form1:postId','form1:postName');"></h:commandButton>
             	 </h:panelGroup>
               	<h:outputText value="��ѵ����"></h:outputText>
               	<h:inputText styleClass="input" id="syscode" code="" dict="yes" dict_num="2033"
                     readonly="true" value="#{trainSystemBB.itemTypeDes}"
                     alt="�Ա�|1|s|50||"/>
                <h:outputText value="�μ�����"></h:outputText>
                <h:selectOneMenu id="type" value="#{trainSystemBB.systembo.courseType}" onchange="submit();" valueChangeListener="#{trainSystemPostBB.changType}">
                	<c:selectItem itemLabel="ѡ��" itemValue=""/>
                	<c:selectItem itemLabel="scorm�μ�" itemValue="1"/>
                	<c:selectItem itemLabel="��ͳ�μ�" itemValue="2"/>
                </h:selectOneMenu>
			 	<h:outputText value="��������ѧϰ�γ�"></h:outputText>
               <h:panelGroup>
                    <h:inputTextarea id="courseDes" cols="60" rows="5" readonly="true" value="#{trainSystemBB.systembo.linkCourseDes}"></h:inputTextarea>
                    <h:inputHidden id="linkCourse" value="#{trainSystemBB.systembo.linkCourse}"/>
                    <h:commandButton styleClass="button_select" type="button" onclick="PopUpeLearnCourseTwoControl(document.all('form1:linkCourse'),document.all('form1:courseDes'));" rendered="#{trainSystemBB.systembo.courseType=='1'}"></h:commandButton>
                    <h:commandButton styleClass="button_select" type="button" onclick="selectCource()" rendered="#{trainSystemBB.systembo.courseType=='2'}"></h:commandButton>
                </h:panelGroup>
                <h:outputText value="ѧʱ"></h:outputText>
                <h:inputText value="#{trainSystemBB.systembo.period}"></h:inputText>
                <h:outputText value="ѧ��"></h:outputText>
                <h:inputText value="#{trainSystemBB.systembo.score}"></h:inputText>
			</h:panelGrid>
			<h:panelGrid align="right">
              <h:commandButton value="����" id="save" styleClass="button01" onclick="return chkDate();" action="#{trainSystemBB.saveSystembo}" />
           </h:panelGrid>
      </h:panelGrid>
</h:form>

  <script type="text/javascript">
    interpret(document.forms(0));
</script>
