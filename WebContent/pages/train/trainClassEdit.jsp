<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

     
      <script type="text/javascript">
    	function chkData(){
         return forsubmit(document.forms(0));
        }
       	function forBack(form){
             window.close();
       }
       	function forAddPerson() {
            var reval = window.showModalDialog("/train/TrainOutTeacherQuery.jsf", null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
    		if (reval != null && reval!="") {
            	var vars=reval.split("|");
            	document.all("form1:personStr").value = vars[1];
            	return true;
            } else {
                return false;
            }
       }
       	function forAddPerson2() {
            var reval = window.showModalDialog("/train/TrainInnerteacherQuery.jsf", null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
    		if (reval != null && reval!="") {
            	var vars=reval.split("|");
            	document.all("form1:personStr").value = vars[1];
            	return true;
            } else {
                return false;
            }
       }
       
       	function forAndBook() {
            var reval = window.showModalDialog("/train/TrainBookListQuery.jsf", null, "dialogWidth:1000px; dialogHeight:600px;center:center;resizable:yes;status:yes;scroll:yes;");
    		if (reval != null && reval!="") {
            	var vars=reval.split("|");
            	document.all("form1:bookStr").value = vars[1];
            	return true;
            } else {
                return false;
            }
       }
       function deleteBo(){
    	   confirm('确定要删除吗?');
       }
      </script>
  
  <x:saveState value="#{TrainClass_EditBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{TrainClass_EditBB.initEdit}"></h:inputHidden>
      <h:inputHidden id="personStr" value=""/>
       <h:inputHidden id="bookStr" value=""/>
      <h:panelGrid columns="2" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="培训班管理-> 增加培训班"/>
          </h:panelGroup>
          <h:panelGrid align="right">
              	<h:commandButton value="保存" id="save" onclick="return chkData();"
              	action="#{TrainClass_EditBB.save}" styleClass="button01"/>
           </h:panelGrid>
      </h:panelGrid>
<c:verbatim>
	<table align="center" width="98%"><tr><td width="100%" colspan="2">
</c:verbatim>
      <h:panelGrid columns="1"  width="100%" align="left">
      	
           <h:panelGrid width="100%" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             	<h:outputText value="培训班名称"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.className}" ></h:inputText>
               	<h:outputText value="培训类别"></h:outputText>
                <h:selectOneMenu value="#{TrainClass_EditBB.classbo.classType}" onchange="submit();" valueChangeListener="#{TrainClass_EditBB.changeType}">
                    <c:selectItem itemLabel="临时性" itemValue="0"></c:selectItem>
                    <c:selectItem itemLabel="体系培训" itemValue="1"></c:selectItem>
                </h:selectOneMenu>
               	<h:outputText value="负责人"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classMajor}" ></h:inputText>
               	<h:outputText value="培训目的"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classAid}" ></h:inputText>
               	<h:outputText value="培训对象"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classScope}" ></h:inputText>
               	<h:outputText value="人数"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classPCount}" ></h:inputText>
               	 <h:outputText value="预算"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classBudget}" ></h:inputText>
               	<h:outputText value="应用范围"></h:outputText>
               	<h:selectOneMenu value="#{TrainClass_EditBB.classbo.org_scope}">
                      <c:selectItems value="#{TrainClass_EditBB.orgList}"></c:selectItems>
               	</h:selectOneMenu>
               	<h:outputText value="课时"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classHour}" ></h:inputText>
               	<h:outputText value="在线学习课程" rendered="#{TrainClass_EditBB.classType=='0'}"></h:outputText>
                <h:panelGroup rendered="#{TrainClass_EditBB.classType=='0'}">
                    <h:inputText id="courseDes" value="#{TrainClass_EditBB.classbo.courseDes}" rendered="#{TrainClass_EditBB.classType=='0'}"/>
                    <h:inputHidden id="linkCourse" value="#{TrainClass_EditBB.classbo.linkCourse}" rendered="#{TrainClass_EditBB.classType=='0'}"/>
                    <h:commandButton styleClass="button_select" type="button" onclick="PopUpeLearnCourseTwoControl(document.all('form1:linkCourse'),document.all('form1:courseDes'));" rendered="#{TrainClass_EditBB.classType=='0'}"></h:commandButton>
                </h:panelGroup>
                <h:outputText value="培训体系类别" rendered="#{TrainClass_EditBB.classType=='1'}"></h:outputText>
                <h:panelGroup rendered="#{TrainClass_EditBB.classType=='1'}">
                    <h:inputText styleClass="input" id="syscode" code="" dict="yes" dict_num="2033"
                     readonly="true" value="#{TrainClass_EditBB.classbo.classLinkSystem}"
                     alt="性别|1|s|50||" rendered="#{TrainClass_EditBB.classType=='1'}"/>
                    <h:commandButton styleClass="button_select" type="button" onclick="PopUpCodeDlgOneControl('form1:syscode')" rendered="#{TrainClass_EditBB.classType=='1'}"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid width="100%" columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               	<h:outputText value="详情描述"></h:outputText>
               	<h:inputTextarea value="#{TrainClass_EditBB.classbo.classDesc}" rows="3" cols="60"></h:inputTextarea>
          </h:panelGrid> 
            <h:panelGrid width="100%" columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               	<h:outputText value="课程说明"></h:outputText>
				<h:inputTextarea value="#{TrainClass_EditBB.classbo.classCourse}" rows="3" cols="60"></h:inputTextarea>
			</h:panelGrid>
			
		</h:panelGrid>
<c:verbatim>
	</td></tr><tr><td align="left">讲师列表</td><td align="right">
</c:verbatim>
	<h:commandButton action="#{TrainClass_EditBB.addinnerTeacher}" value="增加内部讲师" styleClass="button01" onclick="return forAddPerson2();"></h:commandButton>
	<h:outputText value="  "></h:outputText>
	<h:commandButton action="#{TrainClass_EditBB.addOutTeacher}" value="增加外部讲师" onclick="return forAddPerson();" styleClass="button01"></h:commandButton>
<c:verbatim>	
	</td></tr><tr><td colspan="2">
</c:verbatim>
	 <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{TrainClass_EditBB.teacherList}"    var="list">
        
         <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="讲师姓名" /></c:facet>
            <h:outputText value="#{list.teacherName}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="讲师性别" /></c:facet>
            <h:outputText value="#{list.sex}"/>
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="学历"/></c:facet>
            <h:outputText value="#{list.degree}" />
        </h:column>
		
		 <h:column>
            <c:facet name="header"><h:outputText value="讲师类型"/></c:facet>
            <h:outputText value="#{list.teacherTypeDes}" />
        </h:column>
       
		<h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
           	<h:commandButton value="删除" onclick="deleteBo();" action="#{TrainClass_EditBB.delete}" styleClass="button01" rendered="#{list.itemId!='new'}">
                  <x:updateActionListener property="#{TrainClass_EditBB.itemId}" value="#{list.itemId}"/>
            </h:commandButton>
            <h:commandButton value="删除" onclick="deleteBo();" action="#{TrainClass_EditBB.delete2}" styleClass="button01" rendered="#{list.itemId=='new'}">
                  <x:updateActionListener property="#{TrainClass_EditBB.teacherId}" value="#{list.teacherId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<c:verbatim>
	</td></tr><tr><td align="left">教材列表</td><td align="right">
</c:verbatim>
<h:commandButton action="#{TrainClass_EditBB.addBook}" value="增加教材" styleClass="button01" onclick="return forAndBook();"></h:commandButton>
<c:verbatim>	
	</td></tr><tr><td colspan="2">
</c:verbatim>
<x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList2"  align="center" border="0"  value="#{TrainClass_EditBB.bookList}"    var="list2">
        
         <h:column>
               <c:facet name="header"><h:outputText value="序号"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="培训教材名称"/></c:facet>
            <h:outputText value="#{list2.bookName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="作者"/></c:facet>
            <h:outputText value="#{list2.bookAuthor}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="出版社"/></c:facet>
            <h:outputText value="#{list2.bookPublisher}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="价格"/></c:facet>
            <h:outputText value="#{list2.bookPrice}"/>
        </h:column>
	   <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
           	<h:commandButton value="删除" onclick="deleteBo();" action="#{TrainClass_EditBB.delete3}" styleClass="button01" rendered="#{list2.itemId!='new'}">
                  <x:updateActionListener property="#{TrainClass_EditBB.itemBookId}" value="#{list2.itemId}"/>
            </h:commandButton>
            <h:commandButton value="删除" onclick="deleteBo();" action="#{TrainClass_EditBB.delete4}" styleClass="button01" rendered="#{list2.itemId=='new'}">
                  <x:updateActionListener property="#{TrainClass_EditBB.bookId}" value="#{list2.bookId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<c:verbatim>
	</td></tr></table>
</c:verbatim>
  </h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
