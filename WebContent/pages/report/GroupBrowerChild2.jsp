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
                  //alert(arg);
                  window.showModalDialog("/report/ProcessReport.jsf?" + arg, null, "dialogWidth:750px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
               }
              else{
                 alert("��ѡ��Ҫͳ�Ƶı���");
              }
              return false;
        }
        function DoCheck(){
              if (checkMutilSelect(form1.chk)) {
                  var arg=getAllSelectValue(form1.chk,"^");

                  arg="Command=8&UnitID="+document.all("form1:UnitID").value+"&ReportList="+arg;
                  //alert(arg);
                  window.showModalDialog("/report/ProcessReport.jsf?" + arg, null, "dialogWidth:750px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
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

<x:saveState value="#{Rpt_GroupIndexBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{Rpt_GroupIndexBB.initShowChild}"></h:inputHidden>
    <h:inputHidden id="UnitID" value="#{Rpt_GroupIndexBB.unitId}"/>
    <h:inputHidden id="processDate" value="#{Rpt_GroupIndexBB.processDate}"></h:inputHidden>
    <c:verbatim>
    <br>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
            <td  height=5 colspan=2>
            </td>
        </tr>
        <tr>
            <td  align="left">
</c:verbatim>
                <h:outputText escape="false" value="<strong>��ǰͳ�Ƶ�λ</strong>"/>
                <h:outputText value="#{Rpt_GroupIndexBB.unitName}"/>

                <h:outputText escape="false" value="<strong>��ǰ״̬</strong>"/>
                <h:outputText value="#{Rpt_GroupIndexBB.date.stautsDes}"/>

                <h:outputText escape="false" value="<strong>ͳ����Ա</strong>"/>
                <h:outputText value="#{Rpt_GroupIndexBB.date.createID}"/>

                <h:outputText escape="false" value="<strong>��ϵ�绰</strong>"/>
                <h:outputText value="#{Rpt_GroupIndexBB.date.officeTel}"/>
<c:verbatim>
            </td>
            <td>
            </td>
       </tr>

        <tr>
            <td align="right" colspan=2>
                <input Class="button01" type="button" onclick="DirectOpenRpt();" value="��ʾ">
                <input Class="button01" type="button" onclick="DoCheck();" value="У��">
            </td>
        </tr>
        <tr><td height=10></td></tr>
    <tr>
    <td colspan=3>
        <table  width=100% class="table03">
            <%
                       List reportList=(List)session.getAttribute("reportList");
                       int j=0;

                       while(true){
                           // ÿ��3��
                           if (j<reportList.size()){
                              out.println("<tr>");
                              SelectItem item= (SelectItem)(reportList.get(j));
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
            %>
        </table>
    </td>
    </tr>
    </table>
</c:verbatim>
</h:form>