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
        <br>ѧϰ��ϵ�б�:<br>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{trainSystemBB.postCourseList}" var="list" align="center"  id="dateList"   rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >

            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�γ���ϵ"/></c:facet>
                <h:outputText value="#{list.itemTypeDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�γ�����"/></c:facet>
                <h:outputText value="#{list.linkCourseDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="״̬"/></c:facet>
                <h:outputText value="��ѧϰ" rendered="#{list.importCourse}"/>
                <h:outputText value="δѧϰ" rendered="#{!list.importCourse}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="����ѧϰ�б�" styleClass="button01" rendered="#{!list.importCourse}" action="#{trainSystemBB.importCourse}">
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