<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function Study(id){
        window.showModalDialog("/eLearn/LMSMain.jsf?studyID="+id, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }

     function showStudyInfo(id){
         window.showModalDialog("/eLearn/studyUnitList.jsf?studyID="+id, null, "dialogWidth:700px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
         return false;
     }
     function showCource(id){
         window.showModalDialog("/eLearn/ShowCourse.jsf?courseID="+id, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
         return true;
     }

</script>

<x:saveState value="#{trainSystemBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{trainSystemBB.showPostCourse}"></h:inputHidden>
 <f:verbatim>
    <table height=96% width=100% cellspacing="0" cellpadding="0">

    <tr><td >
        <br>学习体系列表:<br>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{trainSystemBB.postCourseList}" var="list" align="center"  id="dateList"   rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >

            <h:column>
                <c:facet name="header"><h:outputText value="序号"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="课程体系"/></c:facet>
                <h:outputText value="#{list.itemTypeDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="课程名称"/></c:facet>
                <h:outputText value="#{list.linkCourseDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="状态"/></c:facet>
                <h:outputText value="已学习" rendered="#{list.importCourse}"/>
                <h:outputText value="未学习" rendered="#{!list.importCourse}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="导入学习列表" styleClass="button01" rendered="#{!list.importCourse}" action="#{trainSystemBB.importCourse}">
                    <x:updateActionListener property="#{trainSystemBB.itemID}" value="#{list.itemId}"/>
                </h:commandButton>
            </h:column>
        </x:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
 </f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>