<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

      <c:verbatim><base target="_self"></c:verbatim>
      <script type="text/javascript">
    	function chkData(){
         
             return forsubmit(document.forms(0));
         }
       	function forBack(form){
             window.close();
       }
      </script>
  
  <x:saveState value="#{TrainClass_EditBB}" />
  <h:form id="form1">
      <h:inputHidden id="initEdit" value="#{TrainClass_EditBB.initEdit}"></h:inputHidden>
      <h:panelGrid columns="1" styleClass="td_title" width="98%" align="center">
          <h:panelGroup>
              <h:graphicImage value="/images/tips.gif" />
              <h:outputText value="��ѵ�����-> ������ѵ��"/>
          </h:panelGroup>
      </h:panelGrid>

 <c:verbatim>
	<table><tr><td width="100%" colspan="2">
</c:verbatim>
      <h:panelGrid columns="1"  width="98%" align="left">
      	
           <h:panelGrid width="100%" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">
             	<h:outputText value="��ѵ������"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.className}" ></h:inputText>
               	<h:outputText value="������"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classMajor}" ></h:inputText>
               	<h:outputText value="��ѵĿ��"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classAid}" ></h:inputText>
               	<h:outputText value="��ѵ����"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classScope}" ></h:inputText>
          </h:panelGrid>
          <h:panelGrid width="100%" columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               	<h:outputText value="��������"></h:outputText>
               	<h:inputTextarea value="#{TrainClass_EditBB.classbo.classDesc}" rows="3" cols="60"></h:inputTextarea>
          </h:panelGrid> 
           <h:panelGrid width="100%" columns="4" columnClasses="td_form01,td_form02,td_form01,td_form02" align="center" styleClass="table03">	
               	<h:outputText value="����"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classPCount}" ></h:inputText>
               	<h:outputText value="Ԥ��"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classBudget}" ></h:inputText>
               	<h:outputText value="Ӧ�÷�Χ"></h:outputText>
               	<h:selectOneMenu value="#{TrainClass_EditBB.classbo.org_scope}">
                      <c:selectItems value="#{TrainClass_EditBB.orgList}"></c:selectItems>
               	</h:selectOneMenu>
               	<h:outputText value="��ʱ"></h:outputText>
               	<h:inputText value="#{TrainClass_EditBB.classbo.classHour}" ></h:inputText>
             </h:panelGrid> 
            <h:panelGrid width="100%" columns="2" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
               	<h:outputText value="�γ�˵��"></h:outputText>
				<h:inputTextarea value="#{TrainClass_EditBB.classbo.classCourse}" rows="3" cols="60"></h:inputTextarea>
			
			 <h:outputText value="��������ѧϰ�γ�"></h:outputText>
                <h:panelGroup>
                    <h:inputText id="courseDes" value="#{TrainClass_EditBB.classbo.courseDes}" />
                    <h:inputHidden id="linkCourse" value="#{TrainClass_EditBB.classbo.linkCourse}" />
                    <h:commandButton styleClass="button_select" type="button" onclick="PopUpeLearnCourseTwoControl(document.all('form1:linkCourse'),document.all('form1:courseDes'));"></h:commandButton>
                </h:panelGroup>
			</h:panelGrid>
			
		</h:panelGrid>
<c:verbatim>
	</td></tr><tr><td align="left">��ʦ�б�</td><td align="right">
</c:verbatim>
	<h:commandButton action="#{TrainClass_EditBB.addinnerTeacher}" value="�����ڲ���ʦ" styleClass="button01" onclick="return forAddPerson2();"></h:commandButton>
	<h:outputText value="  "></h:outputText>
	<h:commandButton action="#{TrainClass_EditBB.addOutTeacher}" value="�����ⲿ��ʦ" onclick="return forAddPerson();" styleClass="button01"></h:commandButton>
<c:verbatim>	
	</td></tr><tr><td colspan="2">
</c:verbatim>
	 <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{TrainClass_EditBB.teacherList}"    var="list">
        
         <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʦ����" /></c:facet>
            <h:outputText value="#{list.teacherName}" />
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʦ�Ա�" /></c:facet>
            <h:outputText value="#{list.sex}"/>
        </h:column>
		<h:column>
            <c:facet name="header"><h:outputText value="ѧ��"/></c:facet>
            <h:outputText value="#{list.degree}" />
        </h:column>
		
		 <h:column>
            <c:facet name="header"><h:outputText value="��ʦ����"/></c:facet>
            <h:outputText value="#{list.teacherTypeDes}" />
        </h:column>
       
		<h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
           	<h:commandButton value="ɾ��" onclick="deleteBo();" action="#{TrainClass_EditBB.delete}" styleClass="button01" rendered="#{list.itemId!='new'}">
                  <x:updateActionListener property="#{TrainClass_EditBB.itemId}" value="#{list.itemId}"/>
            </h:commandButton>
            <h:commandButton value="ɾ��" onclick="deleteBo();" action="#{TrainClass_EditBB.delete2}" styleClass="button01" rendered="#{list.itemId=='new'}">
                  <x:updateActionListener property="#{TrainClass_EditBB.teacherId}" value="#{list.teacherId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
<c:verbatim>
	</td></tr><tr><td align="left">�̲��б�</td><td align="right">
</c:verbatim>
<h:commandButton action="#{TrainClass_EditBB.addBook}" value="���ӽ̲�" styleClass="button01" onclick="return forAndBook();"></h:commandButton>
<c:verbatim>	
	</td></tr><tr><td colspan="2">
</c:verbatim>
<x:dataTable  headerClass="td_top" styleClass="table03"  width="100%" rowIndexVar="index"
        columnClasses="td_middle_left,td_middle_left" id="linkList2"  align="center" border="0"  value="#{TrainClass_EditBB.bookList}"    var="list2">
        
         <h:column>
               <c:facet name="header"><h:outputText value="���"/></c:facet>
               <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ�̲�����"/></c:facet>
            <h:outputText value="#{list2.bookName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list2.bookAuthor}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list2.bookPublisher}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�۸�"/></c:facet>
            <h:outputText value="#{list2.bookPrice}"/>
        </h:column>
	   <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
           	<h:commandButton value="ɾ��" onclick="deleteBo();" action="#{TrainClass_EditBB.delete3}" styleClass="button01" rendered="#{list2.itemId!='new'}">
                  <x:updateActionListener property="#{TrainClass_EditBB.itemBookId}" value="#{list2.itemId}"/>
            </h:commandButton>
            <h:commandButton value="ɾ��" onclick="deleteBo();" action="#{TrainClass_EditBB.delete4}" styleClass="button01" rendered="#{list2.itemId=='new'}">
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
