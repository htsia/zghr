<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<script type="text/javascript" language="javascript">
    var API=parent.document.all('APIObject');
    function firstStudy(){
        document.all('form1:firstStudy').click();
    }
    function refreshStatus(){
        document.all('form1:refreshStatus').click();
    }
    function showCource(id){
        window.showModalDialog("/eLearn/ShowCourse.jsf?courseID="+document.all('form1:courseID').value, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function showStudyInfo(id){
        window.showModalDialog("/eLearn/studyUnitList.jsf?studyID="+document.all('form1:studyID').value, null, "dialogWidth:700px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function refreshStatus(){
        document.all('form1:refreshStatus').click();
    }
    with (window) onload = onresize = function(){
        var mainHeight = document.body.clientHeight - 70;
        document.getElementById("course").style.height = "" + mainHeight + "px";
    }
</script>

<x:saveState value="#{eLearn_studyBB}" />
<h:form id="form1">
    <h:inputHidden  id="startStudy" value="#{eLearn_studyBB.startStudy}"></h:inputHidden>
    <h:inputHidden  id="studyID" value="#{eLearn_studyBB.studyID}"></h:inputHidden>
    <c:verbatim>
    <table width=98%  align="center">
        <tr><td height=65 valign="top">
            <table width=98% align="center">
                <tr>
                <td align="right">
   </c:verbatim>
                <h:commandButton value="�γ�Ŀ¼" styleClass="button01" onclick="return showCource();" type="button"></h:commandButton>
                <h:commandButton value="ѧϰ���" styleClass="button01" onclick="return showStudyInfo();" type="button"></h:commandButton>
                <h:commandButton value="��һ��" styleClass="button01" action="#{eLearn_studyBB.prev}"></h:commandButton>
                <h:commandButton value="��һ��" styleClass="button01" action="#{eLearn_studyBB.next}"></h:commandButton>
                <h:commandButton id="firstStudy" style="display:none" value="��ʼѧϰ"  styleClass="button01" action="#{eLearn_studyBB.firstStudy}"></h:commandButton>
                <h:commandButton id="refreshStatus" style="display:none" value="ˢ��״̬"  onclick="return true;" styleClass="button01" action="#{eLearn_studyBB.refreshStatus}"></h:commandButton>
                <h:commandButton value="����" styleClass="button01" type="button" onclick="if (confirm('ȷ��Ҫ������?')){ parent.window.close(); }"></h:commandButton>
   <c:verbatim>
                </td>
                </tr>

                <tr>
                <td  align="left">
   </c:verbatim>
                    <h:inputHidden id="courseID" value="#{eLearn_studyBB.unitbo.courseID}"></h:inputHidden>
                    <h:inputHidden id="url" value="#{eLearn_studyBB.unitbo.uri}"></h:inputHidden>
                    <h:outputText value="��ǰ��Ԫ��#{eLearn_studyBB.unitbo.unitName}"></h:outputText>
                    <h:outputText value="   "></h:outputText>
                    <h:outputText value="��ǰ״̬��#{eLearn_studyBB.transbo.lessonStatusCHN}"></h:outputText>
                    <h:outputText value="   "></h:outputText>
                    <h:outputText value="�ۼ�ѧϰ����ʱ�䣺#{eLearn_studyBB.transbo.sessionTime}"></h:outputText>
            <c:verbatim>
                  </td></tr>
             </table>
         </td></tr>

            <tr>
            <td align="center">
                 <iframe id="course" width="98%" frameborder="0" scrolling="auto"></iframe>
                 <script type="text/javascript" language="javascript">
                     document.all('course').src=document.all('form1:url').value;
                 </script>
            </td>
            </tr>
     </table>
    </c:verbatim>
</h:form>

