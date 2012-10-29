<%@ page import="com.hr319wg.scorm.questLibService" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.scorm.paperLibService" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.*" %>
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
    <tr><td align="right"><input type="button" class="button01" onclick="window.close();" value="关闭"></td></tr>

    <tr><td>
   <%
       String paperID=request.getParameter("PaperID");
       paperLibService plib = (paperLibService) SysContext.getBean("eLearn_paperservice");
       questLibService qlib = (questLibService) SysContext.getBean("eLearn_libservice");
       eLearnPaperBO bo = plib.findePaperBO(paperID);
       String str = "<br><center><font face='隶书' size='14pt'>"+bo.getName()+"考试</font></center>";
       out.println(str);
    %>
     </td></tr>
     <tr><td>
     <table width=100%>
        <%
            int allCount=0;
            List sessionList = plib.getChildPaperItemSet(bo.getPaperID());
            for (int i = 0; i < sessionList.size(); i++) {
                PaperItemSetBO setbo = (PaperItemSetBO) sessionList.get(i);
                List questionList = plib.getChildItem(setbo.getSetID());
                str = setbo.getSetName() + "&nbsp;&nbsp;共" + String.valueOf(questionList.size()) + "题";
                out.println("<tr><td>");
                out.println("<table width='100%' class='table02'>");
                out.println("<tr><td align='center' bgcolor=\"#2074C5\">");
                out.println(str);
                out.println("</td><tr>");
                out.println("<tr><td>");

                for (int j = 0; j < questionList.size(); j++) {
                    allCount++;
                    PaperItemBO item = (PaperItemBO) questionList.get(j);
                    QuestionBO qb = qlib.findeQuestionBO(item.getLinkID());
                    out.println("<tr><td>");
                    if (QuestionBO.QUESTION_TYPE_SINGLE.equals(qb.getQuestionType())) {
                        str = "<strong>" + String.valueOf(allCount) + "、" + qb.getTitle() + "(" + item.getScore() + ")</strong><br>";
                        out.println(str);

                        List answerList = qlib.getAllAnswerList(qb.getQuestionID());
                        for (int k = 0; k < answerList.size(); k++) {
                            AnswerListBO answer = (AnswerListBO) answerList.get(k);
                            str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + answer.getAnswerID() + "' type='radio'  value='" + answer.getAnswerCode() + "' name='" + qb.getQuestionID() + "'>" + answer.getAnswerCode() + "、" + answer.getAnswerName() + "<br>";
                            out.println(str);
                        }
                    }
                    else if (QuestionBO.QUESTION_TYPE_MUTL.equals(qb.getQuestionType())) {
                        str="<strong>" + String.valueOf(allCount) + "、" +qb.getTitle() + "</strong><br>";
                        out.println(str);

                        List answerList = qlib.getAllAnswerList(qb.getQuestionID());
                        for (int k = 0; k < answerList.size(); k++) {
                            AnswerListBO answer = (AnswerListBO) answerList.get(k);
                            str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + answer.getAnswerID() + "' type='checkbox'  value='" + answer.getAnswerCode() + "'>" + answer.getAnswerCode() + "、" + answer.getAnswerName() + "<br>";
                            out.println(str);
                        }
                    }
                    else if (QuestionBO.QUESTION_TYPE_REPLAY.equals(qb.getQuestionType())) {
                        if (qb.getLowChars()!=null && !"".equals(qb.getLowChars())){
                            out.println("<br><strong>" + String.valueOf(allCount) + "、"+ qb.getTitle() +"( 最少"+qb.getLowChars()+"字)</strong><br>");
                        }
                        else{
                            out.println("<br><strong>" + qb.getTitle() +"</strong><br>");
                        }
                        out.println("&nbsp;&nbsp;&nbsp;&nbsp;<textarea name='"+qb.getQuestionID()+"text' rows=6 cols=80></textarea>");
                    }
                    else if (QuestionBO.QUESTION_TYPE_JUDGE.equals(qb.getQuestionType())) {
                        str="<strong>" + String.valueOf(allCount) + "、"+ qb.getTitle() + "</strong><br>";
                        out.println(str);
                        str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   name='" + qb.getQuestionID() + "'>对 &nbsp;&nbsp";
                        out.println(str);
                        str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   name='" + qb.getQuestionID() + "'>错<br>";
                        out.println(str);
                    }
                    out.println("</td><tr>");
                }
                out.println("</table>");
                out.println("</td><tr>");
            }
        %>
    </table>
   </td></tr>
</table>
</body>
</html>
