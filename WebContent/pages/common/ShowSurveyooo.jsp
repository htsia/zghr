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
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.self.pojo.bo.SurveyDetailBO" %>
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
    String paperID=null;
    String personID=null;
    Hashtable answertable=null;
    SurveyUCC rc=null;
    try {
        rc = (SurveyUCC) SysContext.getBean("self_surveyUCC");
        paperID = (String)request.getSession().getAttribute("paperID");
        personID=(String)request.getSession().getAttribute("personID");
        spb = rc.getPaperBOByID(paperID);
        list = rc.getFullPaper(paperID);
        resultbo=rc.getResult(paperID,personID);
        answertable=rc.getDetailByPerson(personID);
    }
    catch (Exception e) {
        out.println("error:" + e.getMessage());
    }
%>

<table height=96% width=98%>
<tr><td height=8>
    <table width="96%" align="center" >
        <tr><td height=10></td></tr>
        <tr>
            <td valign="top" align="center" style="font-size:18px;font-weight:bold;">
                 <%if (spb!=null) out.print(spb.getName());%>
            </td>
            <td valign="bottom" align="right" style="font-size:12px;">
                 <%=CommonFuns.getSysDate("yyyy-MM-dd")%>
            </td>
        </tr>
        <tr><td height=10></td></tr>
        <tr>
            <td align="left" style="font-size:12px;font-weight:bold;" colspan=2>
                 <%if (spb != null) out.print(CommonFuns.filterNull(spb.getDescription()));%>
            </td>
        </tr>

        <tr>
            <td align="right" colspan=2>
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
                            String content=asBO.getAnswerName();
                            content += "<input name='"+asBO.getAnswerID()+"' type='text' readonly dict='yes' dict_num='' code='PO'>";
                            content += "<input type='button' class='button_select' onclick='fPopUpPostDlg(\""+asBO.getAnswerID()+"\",null,\""+user.getOrgId()+"\")'>";
                            outText=outText.replaceAll("\\$"+asBO.getCode()+"\\$",content);
                        }
                    }
                    out.println(outText);
                }
                else if (SurveyQuestionBO.QUESTION_TYPE_NO.equals(vo.getType())){     // 无题目
                    out.println("<br><strong>" + vo.getTitle() + "</strong><br>");
                }
                else if (SurveyQuestionBO.QUESTION_TYPE_REPLAY.equals(vo.getType())){
                	
                	if (vo.getLowChars()!=null && !"".equals(vo.getLowChars())){
                        out.println("<br><strong>" + vo.getTitle() +"(问答题 最少"+vo.getLowChars()+"字)</strong><br>");
                    }
                    else{
                        out.println("<br><strong>" + vo.getTitle() +"</strong><br>");
                    }
                	List list1=rc.getReplayList(vo.getQuestionID());
                	SurveyDetailBO bo1=(SurveyDetailBO)list1.get(0);
                	if(bo1!=null&&personID!=null){
                		 out.println("&nbsp;&nbsp;&nbsp;&nbsp;<textarea name='"+vo.getQuestionID()+"text' rows=6 cols=120>"+bo1.getTextResult()+"</textarea>");
                	}else{
                	   out.println("&nbsp;&nbsp;&nbsp;&nbsp;<textarea name='"+vo.getQuestionID()+"text' rows=6 cols=120></textarea>");
           			 }
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
                            SurveyDetailBO detail=(SurveyDetailBO)answertable.get(asBO.getAnswerID());
                            if (SurveyQuestionBO.QUESTION_TYPE_SINGLE.equals(vo.getType())){
                            	if(detail!=null){
                            		if(detail.getSelectResult().equals("1")){
                            			outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' checked='true'"+" type='radio'  value='"+asBO.getCode()+"' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                            		}else{
                            			outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' type='radio'  value='"+asBO.getCode()+"' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                            		}
                            	}else{
                            		outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' type='radio'  value='"+asBO.getCode()+"' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";	
                            	}
                            	
                            }else if (SurveyQuestionBO.QUESTION_TYPE_MUTL.equals(vo.getType())){
                            	if(detail!=null){
                            		if(detail.getSelectResult().equals("1")){
                            			outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type='checkbox' checked='true' value='"+asBO.getCode()+"' name='"+asBO.getAnswerID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";	
                            		}else{
                            			outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type='checkbox' value='"+asBO.getCode()+"' name='"+asBO.getAnswerID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                            		}
                            	}else{
                                	outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT type='checkbox' value='"+asBO.getCode()+"' name='"+asBO.getAnswerID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                            	}
                            }
                            else if (SurveyQuestionBO.QUESTION_TYPE_ATT.equals(vo.getType())){
                                if  (SurveyAnswerBO.TYPE_SELECT.equals(asBO.getType())){
                                    if (detail.getSelectResult().trim().equals("1")){
                                    	outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' checked='true'"+" type='radio'  value='"+asBO.getCode()+"' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                    }else{
                                    	outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' type='radio'  value='"+asBO.getCode()+"' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName() + "<br>";
                                    }
                                	
                                }
                                else{
                                	if (detail.getSelectResult().trim().equals("1")){
                                    	outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' checked='true'"+" type='radio'  value='"+asBO.getCode()+"' att='1' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName()+"<INPUT id='"+asBO.getAnswerID()+"' type='input'  name='"+vo.getQuestionID()+"text'><br>";
                                	}else{
                                		outText="&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='"+asBO.getAnswerID()+"' type='radio'  value='"+asBO.getCode()+"' att='1' name='"+vo.getQuestionID()+"'>"+asBO.getCode() + "、" + asBO.getAnswerName()+"<INPUT id='"+asBO.getAnswerID()+"' type='input'  name='"+vo.getQuestionID()+"text'><br>";
                                	}
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

