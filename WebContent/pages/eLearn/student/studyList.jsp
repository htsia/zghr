<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function showMap(){
        window.showModalDialog("/train/postTrainCourse.jsf", null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function Study(type,id,action,title,fileName){
        if (type=='2'){ // ��ͳ�μ�
            doShowCource(action,title,fileName);
        }
        else{
            window.showModalDialog("/eLearn/LMSMain.jsf?studyID="+id, null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height+"px;center:center;resizable:yes;status:no;scroll:yes;");
        }
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

<x:saveState value="#{eLearn_studyBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{eLearn_studyBB.initStudy}"></h:inputHidden>
 <f:verbatim>
    <table height=96% width=100% cellspacing="0" cellpadding="0">
    <tr>
    <td class=td_title height=8>
 </f:verbatim>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ����ѧϰ"/>
  <f:verbatim>
    </td>
     <td align="right" class=td_title>
  </f:verbatim>
         <h:commandButton value="ѧϰ��ͼ" styleClass="button01" onclick="showMap();"></h:commandButton>
   <f:verbatim>
     </td>
    </tr>

    <tr><td colspan="2">
        <br>ѧϰ�γ��б�:<br>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{eLearn_studyBB.studyList}" var="list" align="center"  id="dateList"   rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >

            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�γ�����"/></c:facet>
                <h:outputText value="#{list.courseName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�μ�����"/></c:facet>
                <h:outputText value="#{list.courseTypeDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ʼѧϰʱ��"/></c:facet>
                <h:outputText value="#{list.firstTime}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="�ܵ�Ԫ��"/></c:facet>
                <h:outputText value="#{list.unitCount}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��ѧ��Ԫ��"/></c:facet>
                <h:outputText value="#{list.learnCount}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton type="button" styleClass="button01" value="ѧϰ" onclick="return Study('#{list.courseType}','#{list.studyID}','#{list.wareitembo.action}','#{list.wareitembo.title}','#{list.wareitembo.fileName}')">
                </h:commandButton>
                <h:commandButton value="�γ�Ŀ¼" rendered="#{list.courseType!='2'}" styleClass="button01" type="button" onclick="showCource('#{list.courseID}')"></h:commandButton>
                <h:commandButton value="ѧϰ���" rendered="#{list.courseType!='2'}" styleClass="button01" type="button" onclick="showStudyInfo('#{list.courseType}')"></h:commandButton>
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