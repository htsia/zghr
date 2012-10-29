<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<x:saveState value="#{emp_personBrowBB}"></x:saveState>
<h:form>
    <h:inputHidden value="#{emp_personBrowBB.jlBrow}"></h:inputHidden>
    <h:inputHidden value="#{emp_personBrowBB.superId}"></h:inputHidden>
    <h:inputHidden value="#{emp_personBrowBB.filter}"></h:inputHidden>
    <c:verbatim>
    <table cellspacing=10 border=0 width=98%>
        <tr>
        <td align="left">
    </c:verbatim>
            <h:outputText escape="false" value="#{emp_personBrowBB.superName}"></h:outputText>
    <c:verbatim>
        </td>
        <td align="right">
    </c:verbatim>
            <f:verbatim>
                      <%= LanguageSupport.getResource("COMM-1043", "记录数")%>：
            </f:verbatim>
            <h:outputText value="#{emp_personBrowBB.pagevo.totalRecord}"></h:outputText>
            <f:verbatim>
                      <%= LanguageSupport.getResource("COMM-1044", "页数 ")%>：
            </f:verbatim>
            <h:outputText value="#{emp_personBrowBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
              <f:verbatim>
                      <%= LanguageSupport.getResource("COMM-1045", "每页有 ")%>
            </f:verbatim>
            <h:outputText value="#{emp_personBrowBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
             <f:verbatim>
                      <%= LanguageSupport.getResource("COMM-1046", "当前为第 ")%>
            </f:verbatim>
            <h:outputText value="#{emp_personBrowBB.pagevo.currentPage}"></h:outputText>
               <f:verbatim>
                      <%= LanguageSupport.getResource("COMM-1047", "页 ")%>
            </f:verbatim>
            
            <h:commandButton value="首页" action="#{emp_personBrowBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{emp_personBrowBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{emp_personBrowBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{emp_personBrowBB.last}" styleClass="button01"></h:commandButton>
    <c:verbatim>
        </td></tr>
        </table>

        <table cellspacing=10 border=0>
        <%
            List list = (List) session.getAttribute("PersonList");
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    PersonBO pb = (PersonBO) list.get(i);
                    String id = pb.getPersonId();
                    String name = pb.getName();
                    String dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId());
                    String post = CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    String img="/images/common/nophoto.JPG";
                    if (pb.getImageId()!=null) img="/file/tmp/"+pb.getImageId()+".JPG";
        %>
                <tr>
                    <td align="center">
                            <a onclick="forViewPersonDoc('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <%=name%><br>
                            <%=dept%><br>
                            <%=post%><br><br>
                     </td>
         <%
                    i++;
                    if (i>=list.size()) break;
                    pb = (PersonBO) list.get(i);
                    id = pb.getPersonId();
                    name = pb.getName();
                    dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                    post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    img="/images/common/nophoto.JPG";
                    if (pb.getImageId()!=null) img="/file/tmp/"+pb.getImageId()+".JPG";
        %>
                    <td align="center">
                            <a onclick="forViewPersonDoc('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <%=name%><br>
                            <%=dept%><br>
                            <%=post%><br><br>
                     </td>
                  <%
                               i++;
                               if (i>=list.size()) break;
                               pb = (PersonBO) list.get(i);
                               id = pb.getPersonId();
                               name = pb.getName();
                               dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                               post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                              img="/images/common/nophoto.JPG";
                              if (pb.getImageId()!=null) img="/file/tmp/"+pb.getImageId()+".JPG";
                   %>
                               <td align="center">
                                       <a onclick="forViewPersonDoc('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                       <%=name%><br>
                                       <%=dept%><br>
                                       <%=post%><br><br>
                                </td>

                    <%
                                 i++;
                                 if (i>=list.size()) break;
                                 pb = (PersonBO) list.get(i);
                                 id = pb.getPersonId();
                                 name = pb.getName();
                                 dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                                 post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                                 img="/images/common/nophoto.JPG";
                                 if (pb.getImageId()!=null) img="/file/tmp/"+pb.getImageId()+".JPG";
                     %>
                                 <td align="center">
                                         <a onclick="forViewPersonDoc('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                         <%=name%><br>
                                         <%=dept%><br>
                                         <%=post%><br><br>
                                  </td>
                    <%
                                 i++;
                                 if (i>=list.size()) break;
                                 pb = (PersonBO) list.get(i);
                                 id = pb.getPersonId();
                                 name = pb.getName();
                                 dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                                 post=CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                                 img="/images/common/nophoto.JPG";
                                 if (pb.getImageId()!=null) img="/file/tmp/"+pb.getImageId()+".JPG";
                     %>
                                 <td align="center">
                                         <a onclick="forViewPersonDoc('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                         <%=name%><br>
                                         <%=dept%><br>
                                         <%=post%><br><br>
                                  </td>

                </tr>
        <%
                }
            }
        %>
    </table>
    </c:verbatim>
</h:form>