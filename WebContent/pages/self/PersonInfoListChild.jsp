<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.emp.ucc.IAddressUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.emp.pojo.vo.AddressVO" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function forView(id) {
        if (document.all('form1:queryMode').value=='true'){
            windowOpen("<%=Constants.LEAD_SHOW_PERSONURL%>?flag=2&fk="+id+"&typeId=2001010000,2001010100&setId=A001", "aa", "", "1000", "600", "auto","10","1","yes");
        }
    }
</script>
<x:saveState value="#{emp_personBrowBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emp_personBrowBB.pageInit}"></h:inputHidden>
    <h:inputHidden value="#{emp_personBrowBB.superId}"></h:inputHidden>
    <h:inputHidden value="#{emp_personBrowBB.filter}"></h:inputHidden>
    <h:inputHidden id="queryMode" value="#{emp_personBrowBB.queryMode}"></h:inputHidden>

    <c:verbatim>
    <table cellspacing=10 border=0 width=98%>
        <tr>
        <td align="left">
    </c:verbatim>
            <h:outputText escape="false" value="<Strong>当前单位:</Strong>#{emp_personBrowBB.superName}"></h:outputText>
    <c:verbatim>
        </td>
        </tr>

        <tr>
        <td align="right">
    </c:verbatim>
            <h:outputText value="记录数:#{emp_personBrowBB.pagevo.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="页数:#{emp_personBrowBB.pagevo.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="每页有#{emp_personBrowBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="当前为第#{emp_personBrowBB.pagevo.currentPage}页"></h:outputText>
            <h:commandButton value="首页" action="#{emp_personBrowBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{emp_personBrowBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{emp_personBrowBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{emp_personBrowBB.last}" styleClass="button01"></h:commandButton>
    <c:verbatim>
        </td>
        </tr>
        </table>

        <table  cellspacing=10 border=0>
        <%
            IAddressUCC rc = (IAddressUCC) SysContext.getBean("emp_addressUCC");
            List list = (List) session.getAttribute("PersonList");
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    PersonBO pb = (PersonBO) list.get(i);
                    String id = pb.getPersonId();
                    String name = pb.getName();
                    String dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, pb.getDeptId());
                    String post = CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    String img = "/images/common/nophoto.JPG";
                    if (pb.getImageId() != null) img = "/file/tmp/" + pb.getImageId() + ".JPG";
                    AddressVO avo = rc.getAddressInfo(pb.getPersonId());
                    String officetel="";
                    String mobile="";
                    String email="";
                    if (avo!=null){
                        officetel=CommonFuns.filterNull(avo.getOfficeTel());
                        mobile=CommonFuns.filterNull(avo.getMobile());
                        email=CommonFuns.filterNull(avo.getEmail());
                    }
        %>
                <tr>
                    <td width=180 align="left" valign="top">
                            <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <strong>姓名:</strong><%=name%><br>
                            <strong>部门:</strong><%=dept%><br>
                            <strong>岗位:</strong><%=post%><br>
                     </td>
         <%
                    i++;
                    if (i>=list.size()) break;
                    pb = (PersonBO) list.get(i);
                    id = pb.getPersonId();
                    name = pb.getName();
                    dept = CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId());
                    post = CommonFuns.filterNull(CodeUtil.interpertCode(CodeUtil.TYPE_POST, pb.getPostId()));
                    img="/images/common/nophoto.JPG";
                    avo = rc.getAddressInfo(pb.getPersonId());
                    officetel="";
                    mobile="";
                    email="";
                    if (avo!=null){
                         officetel=CommonFuns.filterNull(avo.getOfficeTel());
                         mobile=CommonFuns.filterNull(avo.getMobile());
                         email=CommonFuns.filterNull(avo.getEmail());
                     }
                    if (pb.getImageId()!=null) img="/file/tmp/"+pb.getImageId()+".JPG";
        %>
                    <td width=180 align="left" valign="top">
                            <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                            <strong>姓名:</strong><%=name%><br>
                            <strong>部门:</strong><%=dept%><br>
                            <strong>岗位:</strong><%=post%><br>
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
                              avo = rc.getAddressInfo(pb.getPersonId());
                              officetel="";
                              mobile="";
                              email="";
                              if (avo!=null){
                                   officetel=CommonFuns.filterNull(avo.getOfficeTel());
                                   mobile=CommonFuns.filterNull(avo.getMobile());
                                   email=CommonFuns.filterNull(avo.getEmail());
                               }
                   %>
                               <td width=180 align="left" valign="top">
                                   <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                   <strong>姓名:</strong><%=name%><br>
                                   <strong>部门:</strong><%=dept%><br>
                                   <strong>岗位:</strong><%=post%><br>
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
                                avo = rc.getAddressInfo(pb.getPersonId());
                                officetel="";
                                mobile="";
                                email="";
                                if (avo!=null){
                                     officetel=CommonFuns.filterNull(avo.getOfficeTel());
                                     mobile=CommonFuns.filterNull(avo.getMobile());
                                     email=CommonFuns.filterNull(avo.getEmail());
                                 }
                     %>
                                 <td width=180 align="left" valign="top">
                                     <a onclick="forView('<%=id%>')"><img width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> src="<%=img%>" alt=""></a><br><br>
                                     <strong>姓名:</strong><%=name%><br>
                                     <strong>部门:</strong><%=dept%><br>
                                     <strong>岗位:</strong><%=post%><br>
                                  </td>

                </tr>
        <%
                }
            }
        %>
    </table>
    </c:verbatim>
</h:form>