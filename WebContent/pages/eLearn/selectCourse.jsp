<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<script type="text/javascript" language="javascript">
    function doOK1(){
    	 
    	  var chk=document.all('form1:courseids').value;
    	  var chk2=document.all('form1:courseNames').value;
    	  
    	  if(chk==""&&chk2==""){
    		  window.returnValue=null;
    	  }
    	  if(chk2==""&&chk!=""){
    		  window.returnValue=chk2+"|"+"";
    	  }
    	  if(chk!=""&&chk2!=""){
    		  window.returnValue=chk+"|"+chk2;
    	  }
    	 window.close();  
    }
    function doCancel(){
        window.returnValue=null;
        window.close();
    }

</script>
<x:saveState value="#{eLearn_courcebb}"/>
<h:form id="form1">
    <h:inputHidden  value="#{eLearn_courcebb.initSelect}"></h:inputHidden>
    <h:inputHidden  id="courseids" value="#{eLearn_courcebb.selectCourseIds}"></h:inputHidden>
    <h:inputHidden  id="courseNames" value="#{eLearn_courcebb.selectCourseNames}"></h:inputHidden>
    <f:verbatim>
    <table height=96% width=100%>
         <tr><td height=8>
         </td></tr>

        <tr><td height=8 align="right">
    </f:verbatim>
              <h:inputHidden id="courseID" value="#{eLearn_courcebb.courseID}"></h:inputHidden>
              <h:inputHidden id="courseName" ></h:inputHidden>
              <h:commandButton value="增加" styleClass="button01" onclick="PopUpeLearnCourseDlg(document.all('form1:courseID'),document.all('form1:courseName'));" action="#{eLearn_courcebb.addCourse}"></h:commandButton>
              <h:commandButton value="确定" type="button" styleClass="button01" onclick="doOK1();"></h:commandButton>
              <h:commandButton value="取消" type="button" styleClass="button01" onclick="doCancel();"></h:commandButton>
    <f:verbatim>
        </td></tr>

      <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </f:verbatim>
    <x:dataTable value="#{eLearn_courcebb.courseList}" var="list" align="center"  id="dateList"  rowIndexVar="index"
                 headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="95%" >

        <h:column>
             <c:facet name="header"><h:outputText value="序号"/>
             </c:facet>
             <h:outputText value="#{index+1}"/>
             <c:verbatim escape="false"><input type="checkbox" style="display:none" name="selected_ids" value="</c:verbatim>
             <h:outputText value="#{list.courseID}"/>
             <h:outputText value=","/>
             <h:outputText value="#{list.courseName}"/>
             <c:verbatim>"></c:verbatim>
         </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="课程名称"/></c:facet>
            <h:outputText value="#{list.courseName}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="删除" styleClass="button01" action="#{eLearn_courcebb.deleteCourse}">
              <x:updateActionListener property="#{eLearn_courcebb.courseID}" value="#{list.courseID}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
    <f:verbatim>
           </div>
     </td></tr>
    </table>
</f:verbatim>
</h:form>