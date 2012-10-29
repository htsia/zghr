<%@ page import="com.hr319wg.scorm.questLibService" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.QuestionBO" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.AnswerListBO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<html>
<head>
  <link href="/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<table width=98% align="center">
    <tr><td height=8></td></tr>
    <tr><td align="right"><input type="button" class="button01" onclick="window.close();" value="�ر�"></td></tr>
    <tr><td>
   <%
       questLibService qlib = (questLibService) SysContext.getBean("eLearn_libservice");
       QuestionBO qb = qlib.findeQuestionBO(request.getParameter("QestionID"));
       String str = "";
       String answerStr="�ο��𰸣�";
       if (QuestionBO.QUESTION_TYPE_SINGLE.equals(qb.getQuestionType())) {
           str="<strong>" + qb.getTitle() + "</strong><br>";
           out.println(str);
           List answerList = qlib.getAllAnswerList(qb.getQuestionID());
           for (int k = 0; k < answerList.size(); k++) {
               AnswerListBO answer = (AnswerListBO) answerList.get(k);
               str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + answer.getAnswerID() + "' type='radio'  value='" + answer.getAnswerCode() + "' name='" + qb.getQuestionID() + "'>" + answer.getAnswerCode() + "��" + answer.getAnswerName() + "<br>";
               out.println(str);
               if ("1".equals(answer.getIsRight())){
                   answerStr+=" "+answer.getAnswerCode();
               }
           }
       }
       else if (QuestionBO.QUESTION_TYPE_MUTL.equals(qb.getQuestionType())) {
           str="<strong>" + qb.getTitle() + "</strong><br>";
           out.println(str);

           List answerList = qlib.getAllAnswerList(qb.getQuestionID());
           for (int k = 0; k < answerList.size(); k++) {
               AnswerListBO answer = (AnswerListBO) answerList.get(k);
               str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + answer.getAnswerID() + "' type='checkbox'  value='" + answer.getAnswerCode() + "'>" + answer.getAnswerCode() + "��" + answer.getAnswerName() + "<br>";
               out.println(str);
               if ("1".equals(answer.getIsRight())){
                   answerStr+=" "+answer.getAnswerCode();
               }
           }
       }
       else if (QuestionBO.QUESTION_TYPE_REPLAY.equals(qb.getQuestionType())) {
           if (qb.getLowChars()!=null && !"".equals(qb.getLowChars())){
               out.println("<br><strong>" + qb.getTitle() +"( ����"+qb.getLowChars()+"��)</strong><br>");
           }
           else{
               out.println("<br><strong>" + qb.getTitle() +"</strong><br>");
           }
           out.println("&nbsp;&nbsp;&nbsp;&nbsp;<textarea name='"+qb.getQuestionID()+"text' rows=6 cols=80></textarea>");
           answerStr+=qb.getReferKey();
       }
       else if (QuestionBO.QUESTION_TYPE_JUDGE.equals(qb.getQuestionType())) {
           str="<strong>" + qb.getTitle() + "</strong><br>";
           if ("1".equals(qb.getIsRight())){
        	   out.println(str);
               str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   name='" + qb.getQuestionID() + "' checked='true'>�� &nbsp;&nbsp";
               out.println(str);
               str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   name='" + qb.getQuestionID() + "'>��<br>";
               out.println(str);
              answerStr+="��";
           }
           else{
        	   out.println(str);
               str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   name='" + qb.getQuestionID() + "'>�� &nbsp;&nbsp";
               out.println(str);
               str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   name='" + qb.getQuestionID() + "' checked='true'>��<br>";
               out.println(str);
              answerStr+="��";
           }
       }
       out.println("<font color=red>"+answerStr+"</font>");
   %>
   </td></tr>
</table>
</body>
</html>
