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

<%
    User user = (User) (session.getAttribute(Constants.USER_INFO));
    SurveyPaperBO spb = null;
    SurveyResultBO resultbo=null;
    List list = new ArrayList();
    String paperID="";
    try {
        SurveyUCC rc = (SurveyUCC) SysContext.getBean("self_surveyUCC");
        paperID = request.getParameter("paperID");
        spb = rc.getPaperBOByID(paperID);
        list = rc.getFullPaper(paperID);
    }
    catch (Exception e) {
        out.println("error:" + e.getMessage());
    }
    String view=CommonFuns.filterNull(request.getParameter("View"));
%>

<table height=96% width=98%>
<tr><td height=8>
    <table width="96%" align="center" border="0">
        <tr><td height=10 colspan="2"></td></tr>
        <tr>
            <td valign="top" align="center" style="font-size:18px;font-weight:bold;">
                 <%if (spb!=null) out.print(spb.getName());%>
            </td>
            <td valign="bottom" align="right" style="font-size:12px;">
                 <%=CommonFuns.getSysDate("yyyy-MM-dd")%>
            </td>
        </tr>
        <tr><td height=10 colspan="2"></td></tr>
        <tr>
            <td align="left" style="font-size:12px;font-weight:bold;" colspan=2>
                 <%if (spb != null) out.print(CommonFuns.filterNull(spb.getDescription()));%>
            </td>
        </tr>

        <tr>
            <td align="right" colspan=2>
                <input value="导出到Word" id="form1:word" class="button01" onclick="return showSurveyInword('<%=request.getParameter("paperID")%>');" type="button">
            </td>
        </tr>
    </table>
 </td></tr>

<tr><td>
    <div style='width:100%;height:100%;overflow:auto' id=datatable>
        <table width="96%" align="center" class="table02">
        <%
          if (list != null) {
                session.setAttribute("haveAnswered","0");
                for (int i = 0; i < list.size(); i++) { // 问题循环
                    out.println("<tr><td >");
                    SurveyQuestionVO vo = (SurveyQuestionVO) list.get(i);
                    if (SurveyQuestionBO.QUESTION_TYPE_BLANK.equals(vo.getType())){     // 填空题目
                        String outText=vo.getTitle();
                        List answer = vo.getAnswer();
                        if (answer != null) {
                            for (int j = 0; j < answer.size(); j++) {
                                SurveyAnswerBO asBO = (SurveyAnswerBO) answer.get(j);
                                String content="";
                                if ("true".equals(session.getAttribute("inWord"))){
                                   content="<U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</U>"; 
                                }
                                else{
                                    content = "<input type='text' name='"+asBO.getAnswerID()+"'>";
                                }
                                outText=outText.replaceAll("#"+asBO.getCode()+"#",content);
                            }
                        }
                        out.println("<strong>"+outText+"</strong>");
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
                        if (!"true".equals(view)){
                            out.println("<tr><td align='left'><input type='checkbox' name='"+vo.getQuestionID()+"'><strong>投票</strong><br></td></tr>");
                        }
                        out.println("</table><br>");
                    }
                    else if (SurveyQuestionBO.QUESTION_TYPE_REPLAY.equals(vo.getType())){
                        if (vo.getLowChars()!=null && !"".equals(vo.getLowChars())){
                            out.println("<br><strong>" + vo.getTitle() +"(问答题 最少"+vo.getLowChars()+"字)</strong><br>");
                        }
                        else{
                            out.println("<br><strong>" + vo.getTitle() +"</strong><br>");
                        }
                        out.println("&nbsp;&nbsp;&nbsp;&nbsp;<br><br><br><br><br><br>");
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
                                    outText="&nbsp;&nbsp;&nbsp;&nbsp;<font size=5>□</font>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                }else if (SurveyQuestionBO.QUESTION_TYPE_MUTL.equals(vo.getType())){
                                    outText="&nbsp;&nbsp;&nbsp;&nbsp;<font size=5>□</font>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                }
                                else if (SurveyQuestionBO.QUESTION_TYPE_ATT.equals(vo.getType())){
                                    if  (SurveyAnswerBO.TYPE_SELECT.equals(asBO.getType())){
                                        outText="&nbsp;&nbsp;&nbsp;&nbsp;<font size=5>□</font>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                    }
                                    else{
                                        outText="&nbsp;&nbsp;&nbsp;&nbsp;<font size=5>□</font>"+asBO.getCode() + "、" + asBO.getAnswerName()+"<U>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</U><br>";
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
</table>

