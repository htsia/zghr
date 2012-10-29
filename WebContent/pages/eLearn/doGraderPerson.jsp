<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.TestPersonResultBO" %>
<%@ page import="com.hr319wg.eLearn.pojo.vo.TestPersonResultVO" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.QuestionBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doGradePerson(id){
    }
</script>

<x:saveState value="#{eLearn_testBB}"/>
<h:form id="form1">
      <c:verbatim><br></c:verbatim>
      <h:inputHidden value="#{eLearn_testBB.initGradePerson}"></h:inputHidden>
      <h:inputHidden  value="#{eLearn_testBB.itemID}"></h:inputHidden>
       <c:verbatim>
      <table>
       <%
           List list = (ArrayList) session.getAttribute("TestResult");
           if (list != null) {
               for (int i = 0; i < list.size(); i++) {
                   String des;
                   String value = "";
                   TestPersonResultVO tb = (TestPersonResultVO) list.get(i);
                   out.println("<tr>");
                   out.println("<td>");
                   if (QuestionBO.QUESTION_TYPE_REPLAY.equals(tb.getQuestionType())) {
                       value = CommonFuns.filterNull(tb.getScore());
                       des = "<br><strong>" + String.valueOf(i + 1) + "、</strong>题型[" + tb.getTypeDes() + "] <br>&nbsp;&nbsp;&nbsp;&nbsp;结果[" + tb.getResult() + "]<br>&nbsp;&nbsp;&nbsp;&nbsp; 参考答案[" + tb.getReferKey() + "] <br>&nbsp;&nbsp;&nbsp;&nbsp;总分[" + tb.getAllscore() + "]";
                   } else {
                       if (tb.getScore() != null && !"".equals(tb.getScore())) {
                           value = tb.getScore();
                       } else if (tb.getResult() != null && tb.getResult().equals(tb.getReferKey())) {
                           value = tb.getAllscore();
                       }
                       if(QuestionBO.QUESTION_TYPE_JUDGE.equals(tb.getQuestionType())){
                    	   if(null!=tb.getResult()&&"1".equals(tb.getResult())){
                    		   tb.setResult("对");
                    	   }else{
                    		   tb.setResult("错");
                    	   }
                       }
                       des = "<br><strong>" + String.valueOf(i + 1) + "、</strong>题型[" + tb.getTypeDes() + "] 结果[" + tb.getResult() + "] 参考答案[" + tb.getReferKey() + "] <br>&nbsp;&nbsp;&nbsp;&nbsp;总分[" + tb.getAllscore() + "]"; 
                   }
                   des += "<br>&nbsp;&nbsp;&nbsp;&nbsp;得分<input type='input' name='" + tb.getResultID() + "' value='" + value + "'>";
                   out.println(des);
                   out.println("</td>");
                   out.println("</tr>");
               }
           }
       %>

      <tr><td align="right">
      </c:verbatim>
         <h:commandButton value="提交" action="#{eLearn_testBB.saveGrade}" styleClass="button01" ></h:commandButton>
      <c:verbatim>
      </td></tr>
      </table>
      </c:verbatim>
</h:form>


