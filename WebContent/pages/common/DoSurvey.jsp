<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.ucc.impl.SurveyUCC" %>
<%@ page import="com.hr319wg.self.pojo.bo.SurveyPaperBO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.self.pojo.vo.SurveyQuestionVO" %>
<%@ page import="com.hr319wg.self.pojo.bo.SurveyAnswerBO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.self.pojo.bo.SurveyQuestionBO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.self.pojo.bo.SurveyResultBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%
    response.setHeader("Pragma","No-cache"); 
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ include file="/pages/include/taglib.jsp" %>

<script type="text/javascript">
    function doSingleCheck(questionID){   // 检查单选是否选择
        var selected=false;
        if (document.all(questionID).length==null || document.all(questionID).length==undefined){  // 只有一个选项
            if (document.all(questionID).checked) {
                selected=true;
            }
        }
        else{
            for(var i=0;i<document.all(questionID).length;i++){
               if (document.all(questionID)[i].checked){
                   if (document.all(questionID)[i].att==null || document.all(questionID)[i].att==undefined) {
                       selected=true;
                       break;
                   }
                   else{  // 选择附加内容则必须填写
                       if (document.all(questionID+"text").value!=""){
                           selected=true;
                           break;
                       }
                   }
               }
            }
        }
        return selected;
    }
    function doMultCheck(AnswerList){
        var li=AnswerList.split(",");
        var selected=false;
        for(var i=0;i<li.length;i++){
            if (li[i]!=""){
                if (document.all(li[i]).checked) {
                    selected=true;
                    break;
                }
            }
        }
        return selected;
    }
    function doReplayCheck(textid,length){
        //debugger;
        if (length>0 && document.all(textid).value.length<length){
           document.all(textid).focus();
           return false;
        }
        return true;
    }
    </script>

<%
    User user = (User) (session.getAttribute(Constants.USER_INFO));
    SurveyPaperBO spb = null;
    SurveyResultBO resultbo=null;
    List list = new ArrayList();
    String paperID="";
    try {
        SurveyUCC rc = (SurveyUCC) SysContext.getBean("self_surveyUCC");
        paperID = request.getParameter("paperID");
        resultbo=rc.getResult(paperID,user.getUserId());
        spb = rc.getPaperBOByID(paperID);
        list = rc.getFullPaper(paperID);
    }
    catch (Exception e) {
        out.println("error:" + e.getMessage());
    }
%>

<h:form id="form1">
<h:inputHidden value="#{self_surveyprocessBB.paperID}"/>
<c:verbatim>
<table height=100% width=98%>
<tr><td height=8>
    <table width="96%" align="center">
        <tr><td height=10></td></tr>
        <tr>
            <td valign="top" align="center" style="font-size:18px;font-weight:bold;">
                 <%if (spb!=null) out.print(spb.getName());%>
            </td>            
        </tr>
        <tr>
			<td valign="bottom" align="right" style="font-size:12px;">
                 <%=CommonFuns.getSysDate("yyyy-MM-dd")%>
            </td></tr>
        <tr>
            <td align="left" style="font-size:12px;font-weight:bold;padding-left:20px;">
                 <%if (spb != null) out.print(CommonFuns.filterNull(spb.getDescription()));%>
            </td>
        </tr>
    </table>
 </td></tr>

<tr><td>
    <div style='width:100%;height:98%;overflow:auto;padding-left:20px;' id=datatable>
        <table width="96%" align="center" class="table02">
        <%
            if (resultbo!=null){
                out.println("<tr><td>");
                if ("1".equals(spb.getIsHide())){
                    out.println("你已经在"+resultbo.getAnswerDate()+"接受过调查了!");
                }
                else{
                    out.println("你已经在"+resultbo.getAnswerDate()+"接受过调查了!<br><A target='_blank' href='/common/ShowSurvey.jsf?View=true&paperID="+paperID+"'>查看问卷</A>&nbsp;&nbsp;<A target='_blank' href='/system/survey/PaperResult.jsf?paperID="+paperID+"' >查看当前调查结果</A>");
                }
                out.println("</td></tr>");
                session.setAttribute("haveAnswered","1");
            }
            else if (list != null) {
                session.setAttribute("haveAnswered","0");
                for (int i = 0; i < list.size(); i++) { // 问题循环
                    out.println("<tr><td style='padding-left:20px;'>");
                    SurveyQuestionVO vo = (SurveyQuestionVO) list.get(i);
                    if (SurveyQuestionBO.QUESTION_TYPE_BLANK.equals(vo.getType())){     // 填空题目
                        String outText=vo.getTitle();
                        List answer = vo.getAnswer();
                        if (answer != null) {
                            for (int j = 0; j < answer.size(); j++) {
                                SurveyAnswerBO asBO = (SurveyAnswerBO) answer.get(j);
                                String content="";
                                if (SurveyAnswerBO.TYPE_POST.equals(asBO.getType())){
                                    content += "<input name='"+asBO.getAnswerID()+"' type='text' readonly dict='yes' dict_num='' code='PO'>";
                                    content += "<input type='button' class='button_select' onclick='fPopUpPostDlg(\""+asBO.getAnswerID()+"\",null,\""+user.getOrgId()+"\")'>";
                                }
                                else{
                                    content = "<input type='text' name='"+asBO.getAnswerID()+"'>";
                                }
                                outText=outText.replaceAll("#"+asBO.getCode()+"#",content);
                            }
                        }
                        out.println(outText);
                    }
                    else if (SurveyQuestionBO.QUESTION_TYPE_NO.equals(vo.getType())){     // 无题目
                        out.println("<br><strong>" + vo.getTitle() + "</strong><br>");
                    }
                    else if (SurveyQuestionBO.QUESTION_TYPE_IMG.equals(vo.getType())){     // 图片
                        out.println("<br><table>");
                        out.println("<tr><td><img src='/file/survey/"+vo.getFileName()+"'></td></tr>");
                        out.println("<tr><td align='center'><br><strong>" + vo.getTitle() + "</strong><br></td></tr>");
                        out.println("</table><br>");
                    }
                    else if (SurveyQuestionBO.QUESTION_TYPE_PHOTO.equals(vo.getType())){     // 选照片
                        out.println("<br><table>");
                        out.println("<tr><td><img src='/file/survey/"+vo.getFileName()+"'></td></tr>");
                        out.println("<tr><td align='center'><strong>" + vo.getTitle() + "</strong><br></td></tr>");
                        out.println("<tr><td align='left'><input type='checkbox' name='"+vo.getQuestionID()+"'><strong>投票</strong><br></td></tr>");
                        out.println("</table><br>");
                    }
                    else if (SurveyQuestionBO.QUESTION_TYPE_REPLAY.equals(vo.getType())){
                        if (vo.getLowChars()!=null && !"".equals(vo.getLowChars())){
                            out.println("<br><strong>" + vo.getTitle() +"(问答题 最少"+vo.getLowChars()+"字)</strong><br>");
                        }
                        else{
                            out.println("<br><strong>" + vo.getTitle() +"</strong><br>");
                        }
                        out.println("&nbsp;&nbsp;&nbsp;&nbsp;<textarea name='"+vo.getQuestionID()+"text' rows=6 cols=120></textarea>");
                    }
                    else {
                        String typeDes="";
                        if (SurveyQuestionBO.QUESTION_TYPE_SINGLE.equals(vo.getType())){
                           typeDes="(单项选择)";
                        }
                        else if (SurveyQuestionBO.QUESTION_TYPE_MUTL.equals(vo.getType())){
                           typeDes="(多项选择)";
                        }
                        else if (SurveyQuestionBO.QUESTION_TYPE_ATT.equals(vo.getType())){
                           typeDes="(可以附加说明)";
                        }
                        out.println("<br><strong>" + vo.getTitle() +typeDes+ "</strong><br>");
                        String outText="";
                        List answer = vo.getAnswer();
                        if (answer != null) {
                            for (int j = 0; j < answer.size(); j++) {
                                SurveyAnswerBO asBO = (SurveyAnswerBO) answer.get(j);
                                if (SurveyQuestionBO.QUESTION_TYPE_SINGLE.equals(vo.getType())){
                                    outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' type='radio'  value='"+asBO.getCode()+"' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                }else if (SurveyQuestionBO.QUESTION_TYPE_MUTL.equals(vo.getType())){
                                    outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type='checkbox' value='"+asBO.getCode()+"' name='"+asBO.getAnswerID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                }
                                else if (SurveyQuestionBO.QUESTION_TYPE_ATT.equals(vo.getType())){
                                    if  (SurveyAnswerBO.TYPE_SELECT.equals(asBO.getType())){
                                        outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' type='radio'  value='"+asBO.getCode()+"' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                    }
                                    else{
                                        outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' type='radio'  value='"+asBO.getCode()+"' att='1' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName()+"<INPUT id='"+asBO.getAnswerID()+"' type='input'  name='"+vo.getQuestionID()+"text'><br>";
                                    }
                                }
                                out.println(outText);
                            }
                        }
                    }
                    out.println("</td></tr>");
                }
            }
        %>
    </table>
    </div>
</td></tr>
<tr><td height=10>
	<table width="96%" align="center">        
        <tr>
            <td align="center" height="20">
</c:verbatim>
                <h:commandButton value="提交意见" id="ok" styleClass="button01" onclick="return docheck();" action="#{self_surveyprocessBB.submitAnswer}"></h:commandButton>
<c:verbatim>
            </td>
        </tr>
    </table>
</td></tr>
</table>
</c:verbatim>
</h:form>
<script type="text/javascript">
    function docheck(){
        var vote=0;
<%
        if (list != null){
        for (int i = 0; i < list.size(); i++) { // 问题循环
            SurveyQuestionVO vo = (SurveyQuestionVO) list.get(i);
            if (SurveyQuestionBO.QUESTION_TYPE_REPLAY.equals(vo.getType())){
                    if (vo.getLowChars()==null && "".equals(vo.getLowChars())){
                       out.println("                      if (!doReplayCheck('"+vo.getQuestionID()+"text',0)) { alert('请回答所有问题!');return false;}");
                    }
                    else{
                       out.println("                      if (!doReplayCheck('"+vo.getQuestionID()+"text',"+vo.getLowChars()+")) { alert('填写内容未达到字数限制!');return false;}");
                    }
                }
                else if (SurveyQuestionBO.QUESTION_TYPE_SINGLE.equals(vo.getType())||
                    SurveyQuestionBO.QUESTION_TYPE_ATT.equals(vo.getType())){
                    out.println("                      if (!doSingleCheck('"+vo.getQuestionID()+"')) { alert('请回答所有问题且选择附加内容时必须填写附加内容!');return false;}");
                }
                else if (SurveyQuestionBO.QUESTION_TYPE_PHOTO.equals(vo.getType())){     // 选照片
                    out.println(" if (document.all('"+vo.getQuestionID()+"').checked) vote++;");
                }
                else if (SurveyQuestionBO.QUESTION_TYPE_MUTL.equals(vo.getType())){
                    List answer = vo.getAnswer();
                    String anws="";
                    if (answer != null) {
                        for (int j = 0; j < answer.size(); j++) {
                          anws+=","+((SurveyAnswerBO)(answer.get(j))).getAnswerID();
                        }
                        out.println("                      if (!doMultCheck('"+anws+"')) { alert('请回答所有问题且选择附加内容时必须填写附加内容!');return false;}");
                    }
                }
                else if (SurveyQuestionBO.QUESTION_TYPE_BLANK.equals(vo.getType())){
                 List answer = vo.getAnswer();
                 if (answer != null) {
                    for (int j = 0; j < answer.size(); j++) {
                         out.println("                  if (document.all('"+((SurveyAnswerBO)(answer.get(j))).getAnswerID()+"').value=='') { alert('请录入"+((SurveyAnswerBO)(answer.get(j))).getAnswerName()+"');return false;}");
                    }
                }
               }
            }
        }
        if (spb.getVoteCount()!=null && !"".equals(spb.getVoteCount())){
           out.println(" if (vote>"+spb.getVoteCount()+") {alert('最多选择"+spb.getVoteCount()+"张照片');return false;}");
        }
%>

        return forsubmit(document.forms(0));
    }
</script>



