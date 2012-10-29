<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.self.ucc.IStarsUCC" %>
<%@ page import="com.hr319wg.sys.api.SysAPI" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="com.hr319wg.user.pojo.bo.SelfOperateBO" %>
<%@ page import="com.hr319wg.user.ucc.IUserQryUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.user.pojo.vo.UserQryVO" %>
<%@ page import="com.hr319wg.qry.ucc.IQueryUCC" %>
<%@ page import="com.hr319wg.qry.pojo.vo.QueryVO" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    User user = (User)session.getAttribute(Constants.USER_INFO);
%>
    <c:verbatim>
    <script type="text/javascript" language="JavaScript1.2" src="<%=request.getContextPath()%>/js/menu.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript">
        function showMoreWeather(city){
            window.showModalDialog("/pages/self/MoreWeather.jsp?city"+city, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowRecruit(){
            window.showModalDialog("/recruit/innerRecruit.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doShowPerson(){
            window.showModalDialog("/self/PersonInfoList.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenShortMessage(){
            window.showModalDialog("/system/ShortMessageList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOpenAdvice(){
            window.showModalDialog("/system/SenderAdvicesList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function gotoHR(){
           parent.document.all('form1:gotoSys').click();
           return true;
        }
        function doOpenForum(){
            window.showModalDialog("/system/ForumList.jsf", null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doshowMoreStars(){
            window.showModalDialog("/self/StarsList.jsf", null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function showMoreVideo(){
            window.showModalDialog("/self/VideoNewsList.jsf", null, "dialogWidth:500px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function openURL(url){
            window.open(url, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.05+",width="+screen.width*0.9+",toolbar=no,scrollbars=yes,menubar=no");
        }

        // 待办事宜处理
        function LinkAction(itemID){
            document.all('form1:operID').value=itemID;
            document.all('form1:processMore').click();
        }
        // 关联操作
        function LinkOper(operID){
            document.all('form1:operID').value=operID;
            document.all('form1:doLinkOper').click();
        }
        function doQuery(){
            var name=document.all('name').value;
            if (name==""){
                alert('请输入姓名、姓名简拼或员工编号!');
                return false;
            }
            var url="/lead/PersonInfoList.jsf?superId=<%=Constants.ORG_BENBU%>&&queryMode=true&filter=(p.name like '%"+name+"%' or p.shortName like '%"+name+"%' or p.personCode like '%"+name+"%')";
            window.showModalDialog(url, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        function showQueryResult(qryId){
            window.showModalDialog("/pages/qry/ShowQueryResultDT.jsp?qryId=" + qryId, null, "dialogWidth:960px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

    </script>
    </c:verbatim>

<h:form id="form1">
    <x:saveState value="#{self_selfbulletinbb}"></x:saveState>
    <x:saveState value="#{self_selfnewsbb}"></x:saveState>
    <x:saveState value="#{emp_AddressBB}"></x:saveState>
    <x:saveState value="#{self_surveyBB}"></x:saveState>
    <h:inputHidden id="pageInit" value="#{self_selfbulletinbb.pageInit}"/>
    <h:inputHidden id="pageInit2" value="#{self_selfnewsbb.pageInit}"/>
    <h:inputHidden value="#{sys_videoNewsBB.initShow}"></h:inputHidden>

    <h:inputHidden id="operID" value="#{sys_inProcessBB.operID}"></h:inputHidden>
    
    <h:commandButton value="关联操作" id="doLinkOper" action="#{sys_inProcessBB.doLinkOper}" style="display:none"></h:commandButton>
    <h:commandButton value="关联待办事宜" id="processMore" action="#{sys_inProcessBB.doMoreSelf2}" style="display:none"></h:commandButton>

    <%
        SysAPI api = (SysAPI) SysContext.getBean("sys_SysAPI");
    %>
    <c:verbatim>
    <table width="99%" align="center" cellpadding="0" cellspacing="4" >

       <tr><td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  height="100">
                    <tr><td align="left">
                        <span style="font-size: 14pt; font-family: 楷体_GB2312"><strong>一、机构、岗位情况</strong></span><br>
                    </c:verbatim>
                        <h:outputText escape="false" value="#{leadself.orgInfo}"></h:outputText>
                    <c:verbatim>
                        <br>
                    </c:verbatim>
                        <h:outputText escape="false" value="#{leadself.postInfo}"></h:outputText>
                    <c:verbatim>
                         <%
                            if (!"".equals(Constants.LEAD_ORG_TABLE)){
                                out.println("<iframe width='100%' frameborder='0' height='140' src='"+Constants.LEAD_ORG_TABLE+"'></iframe>");
                            }
                         %>
                     </td></tr>


                    <tr><td align="left">
                        <span style="font-size: 14pt; font-family: 楷体_GB2312"><strong>二、人员情况</strong></span>
                        <table width="100%">
                            <tr><td>
                    </c:verbatim>
                              <h:inputHidden value="#{emp_d2AnaBB.degreeImage}"></h:inputHidden>
                              <h:inputHidden value="#{emp_d2AnaBB.ageImage}"></h:inputHidden>
                    <c:verbatim>
                                <strong><img src="/images/tips.gif">&nbsp;常用名单</strong><br>
                               <%
                                   IUserQryUCC userqryucc = (IUserQryUCC) SysContext.getBean("user_userQryUccImpl");
                                   IQueryUCC qryucc = (IQueryUCC) SysContext.getBean("qry_QueryUCCImpl");
                                   List list = userqryucc.queryUserQry(user.getUserId(), "SH0461");
                                   if (list != null && list.size() > 0) {
                                       out.println("<table width='90%' align='center'>");
                                       for (int j = 0; j < list.size(); j++) {
                                           out.println("<tr>");
                                           UserQryVO qryvo = (UserQryVO) list.get(j);
                                           QueryVO qry=(QueryVO)qryucc.findQueryVO(qryvo.getQryID());
                                           if (qry!=null){
                                                out.println("<td><img src='/images/common/handtip.gif'>&nbsp;<a target='_blank' href='/desktop/ShowQueryResult.jsf?qryId="+qryvo.getQryID()+"'>" + qry.getName() + "</a></td>");
                                           }
                                           else{
                                               out.println("<td>" + qryvo.getQryID() + "</td>");
                                           }

                                           if ((j+1)<list.size()){
                                               j++;
                                               qryvo = (UserQryVO) list.get(j);
                                               qry=(QueryVO)qryucc.findQueryVO(qryvo.getQryID());
                                               if (qry!=null){
                                                    out.println("<td><img src='/images/common/handtip.gif'>&nbsp;<a target='_blank' href='/desktop/ShowQueryResult.jsf?qryId="+qryvo.getQryID()+"'>" + qry.getName() + "</a></td>");
                                               }
                                               else{
                                                   out.println("<td>" + qryvo.getQryID() + "</td>");
                                               }
                                           }

                                           if ((j+1)<list.size()){
                                               j++;
                                               qryvo = (UserQryVO) list.get(j);
                                               qry=(QueryVO)qryucc.findQueryVO(qryvo.getQryID());
                                               if (qry!=null){
                                                    out.println("<td><img src='/images/common/handtip.gif'>&nbsp;<a target='_blank' href='/desktop/ShowQueryResult.jsf?qryId="+qryvo.getQryID()+"'>" + qry.getName() + "</a></td>");
                                               }
                                               else{
                                                   out.println("<td>" + qryvo.getQryID() + "</td>");
                                               }
                                           }
                                           if ((j+1)<list.size()){
                                               j++;
                                               qryvo = (UserQryVO) list.get(j);
                                               qry=(QueryVO)qryucc.findQueryVO(qryvo.getQryID());
                                               if (qry!=null){
                                                    out.println("<td><img src='/images/common/handtip.gif'>&nbsp;<a target='_blank' href='/desktop/ShowQueryResult.jsf?qryId="+qryvo.getQryID()+"'>" + qry.getName() + "</a></td>");
                                               }
                                               else{
                                                   out.println("<td>" + qryvo.getQryID() + "</td>");
                                               }
                                           }

                                           out.println("</tr>");
                                       }
                                       out.println("</table>");
                                   }

                               %>
                                <%
                                    if (!"".equals(Constants.LEAD_PERSON_INFO)){
                                %>
                                <strong><img src="/images/tips.gif">&nbsp;总量情况</strong><br>
                                <iframe width="100%" frameborder="0" height="300" src="<%=Constants.LEAD_PERSON_INFO%>"></iframe>
                                <%
                                    }
                                %>

                                <%
                                    if ("1".equals(Constants.LEAD_SHOW_DEGREE)){
                                %>
                                <strong><br><img src="/images/common/handtip.gif">&nbsp;在职人员学历分布</strong><br>
                                <iframe scrolling="auto" width="550" height="300" frameborder="0" src="/pages/qry/StaticResultPie.jsp?sessionName=degreeImage&height=250&width=500"></iframe>
                                <%
                                    }
                                %>

                        <%
                            if ("1".equals(Constants.LEAD_SHOW_AGE)){
                        %>

                                <strong><br>&nbsp;在职人员年龄分布</strong><br>
                                <iframe scrolling="auto" width="550" height="300" frameborder="0" src="/pages/qry/StaticResultPie.jsp?sessionName=ageImage&height=250&width=500"></iframe>
                               <%
                                   }
                               %>
                        
                            </td></tr>
                        </table>
                    </td></tr>


                    <tr><td align="left">
                        <%
                            if (!"".equals(Constants.LEAD_WAGE_INFO)) {
                                SelfOperateBO sb2 = SysCacheTool.findSelfOperate(Constants.LEAD_WAGE_INFO);
                        %>
                        <span style="font-size: 14pt; font-family: 楷体_GB2312"><strong>三、薪酬情况</strong></span>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" height="220">
                            <tr>
                               <td>
                                   <iframe width="100%" height="200" frameborder="0" src="<%out.print(sb2.getUrl());%>"></iframe>
                               </td>
                           </tr>
                        </table>
                        <%}%>

                    </td></tr>

                </table>
        </td></tr>
    </table>

  </c:verbatim>

</h:form>

