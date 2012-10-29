<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.user.ucc.IUserReportUCC"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="javax.faces.model.SelectItem"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript">
        function doDocument(){
            if (checkMutilSelect(form1.chk)) {
                var arg="";
                var len=form1.chk.length;
                for(var i=0;i<len;i++){
                    if (form1.chk[i].checked){
                        if (arg==""){
                           arg=form1.chk[i].value;
                        }
                        else {
                           arg=arg+"^"+form1.chk[i].value;
                        }
                    }
                 }
                window.showModalDialog("/report/GroupArchiveReport.jsf?ReportIDs="+arg+"&date="+document.all('form1:processDate').value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
             }
            else{
               alert("��ѡ��Ҫ�ϱ��ı���");
            }
            return false;
        }
        function DoSelectAll(isSelect){
                 var i=0;
                 var len=form1.chk.length;
                 for(i=0;i<len;i++){
                    form1.chk[i].checked=isSelect;
                 }
                 return false;
             }
        function DoStatic(){
              if (checkMutilSelect(form1.chk)) {
                  var arg="";
                  var len=form1.chk.length;
                  for(var i=0;i<len;i++){
                      if (form1.chk[i].checked){
                          if (arg==""){
                             arg=form1.chk[i].value;
                          }
                          else {
                             arg=arg+"^"+form1.chk[i].value;
                          }
                      }
                   }

                  arg="Command=7&Parameter="+document.all('form1:processDate').value+"&UnitID="+document.all("form1:UnitID").value+"&ReportList="+arg;

                  window.showModalDialog("/report/ProcessReport.jsf?" + arg, null, "dialogWidth:750px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
               }
              else{
                 alert("��ѡ��Ҫͳ�Ƶı���");
              }
              return false;
        }
        function DoCheck(){
              if (checkMutilSelect(form1.chk)) {
                  var arg="";
                  var len=form1.chk.length;
                  for(var i=0;i<len;i++){
                      if (form1.chk[i].checked){
                          if (arg==""){
                             arg=form1.chk[i].value;
                          }
                          else {
                             arg=arg+"^"+form1.chk[i].value;
                          }
                      }
                   }

                  arg="Command=8&UnitID="+document.all("form1:UnitID").value+"&ReportList="+arg;
                  //alert(arg);
                  window.showModalDialog("/report/ProcessReport.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
               }
              else{
                 alert("��ѡ��Ҫͳ�Ƶı���");
              }
              return false;
        }
        function DirectOpenRpt(){
            var v=selectOnlyOne(form1.chk)
            if (v==null){
                alert("��ѡ��Ҫͳ�Ƶı���");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+v+"&ID=&ORGUID="+document.all("form1:UnitID").value+"&Parameter="+document.all('form1:processDate').value+"&Command=0";
            window.open(url);
            return false;
        }
        function OpenRpt(){
            var v=selectOnlyOne(form1.chk)
            if (v==null){
                alert("��ѡ��Ҫͳ�Ƶı���");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+v+"&ID=&ORGUID="+document.all("form1:UnitID").value+"&Parameter="+document.all('form1:processDate').value+"&Command=";
            window.open(url);
            return false;
        }
    </script>

<x:saveState value="#{Rpt_InfoIndexBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{Rpt_InfoIndexBB.inithandBook}"/>
    <h:inputHidden id="UnitID" value="#{Rpt_InfoIndexBB.unitId}"/>
    <c:verbatim>
    <br>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td align="left">
</c:verbatim>
                <h:outputText value="��ǰͳ�Ƶ�λ:"/>
                <h:outputText value="#{Rpt_InfoIndexBB.unitName}"/>
<c:verbatim>
            </td>

            <td>
 </c:verbatim>
               <h:outputText value="ͳ�����ڣ�"></h:outputText>
               <h:inputText readonly="true" id="processDate" value="#{Rpt_InfoIndexBB.staticdate}"></h:inputText>
<c:verbatim>
            </td>

            <td align="right">
                <input Class="button01" type="button" onclick="DoSelectAll(true);" value="ȫѡ">
                <input Class="button01" type="button" onclick="DoSelectAll(false);" value="ȫ��">
                <input Class="button01" type="button" onclick="OpenRpt();" value="��ͳ�ƺ���ʾ">
                <input Class="button01" type="button" onclick="DirectOpenRpt();" value="ֱ����ʾ">
                <input Class="button01" type="button" onclick="DoStatic();" value="ͳ��">
                <input Class="button01" type="button" onclick="DoCheck();" value="У��">
 </c:verbatim>
                <h:commandButton onclick="return doDocument();" type="button" styleClass="button01" value="�鵵" />
                <h:commandButton  styleClass="button01" value="����" action="dateList" />
<c:verbatim>
            </td>
        </tr>
        <tr><td height=10></td></tr>
    <tr>
    <td colspan=3>
        <table  width=100% class="table03">
            <%
               String OperID="077201"; // �ֲ�
               User user = (User) (session.getAttribute(Constants.USER_INFO));
               IUserReportUCC rc=(IUserReportUCC) SysContext.getBean("user_userReportUccImpl");
               List reportListDir=rc.queryUserRptDirToWeb(user.getUserId(),OperID);
               int i=0;
               while (true) {
                   if (i<reportListDir.size()){
                       SelectItem item= (SelectItem)(reportListDir.get(i));
                       out.println("<tr>");
                       out.println("<td colspan=3 class='td_middle_left'>");  // ����ʾĿ¼
                        out.println(item.getLabel());
                       out.println("</td>");
                       List reportList=rc.queryUserRptToWebStringByDir(user.getUserId(),OperID,item.getValue().toString());
                       int j=0;

                       while(true){
                           // ÿ��3��
                           if (j<reportList.size()){
                              out.println("<tr>");
                              item= (SelectItem)(reportList.get(j));
                              out.println("<td width='33%' class='td_middle_left'><input type=checkbox name=chk value="+item.getValue()+">"+item.getLabel()+"</td>");
                              j++;

                              if (j<reportList.size()){
                                 item= (SelectItem)(reportList.get(j));
                                 out.println("<td width='33%' class='td_middle_left'><input type=checkbox name=chk value="+item.getValue()+">"+item.getLabel()+"</td>");
                                 j++;
                              }
                              else{out.println("<td width='33%' class='td_middle_left'></td>");}

                              if (j<reportList.size()){
                                 item= (SelectItem)(reportList.get(j));
                                 out.println("<td class='td_middle_left'><input type=checkbox name=chk value="+item.getValue()+">"+item.getLabel()+"</td>");
                                 j++;
                               }
                               else{out.println("<td class='td_middle_left'></td>");}
                               out.println("</tr>");
                          }
                          else{
                               break;
                          }
                       } // �������ѭ��
                       i++;
                       out.println("</tr>");
                   }
                   else { break;}
               }  // ����Ŀ¼ѭ��
            %>
        </table>
    </td>
    </tr>
    </table>
</c:verbatim>
</h:form>
