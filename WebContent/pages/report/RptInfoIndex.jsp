<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.faces.model.SelectItem"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script language="javascript">
        function doShowStatus(){
             <%
                User user=(User)session.getAttribute(Constants.USER_INFO);
                out.print(" var orguid='"+user.getOrgId()+"'");

             %>
             window.showModalDialog("/report/showRptStatus.jsf?Orguid="+orguid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
             return false;
        }

        function doDocument(){
            if (checkMutilSelect(form1.chk)) {
                var arg=getAllSelectValue(form1.chk,"^");
                var processDate=document.all('form1:processDate').value;
                if (document.all('form1:staticWeek')!=null && document.all('form1:staticWeek')!=undefined){
                    processDate+="@"+document.all('form1:staticWeek');
                }
                window.showModalDialog("/report/ArchiveReport.jsf?setID="+document.all('form1:setID').value+"&dateId="+document.all('form1:dateId').value+"&ReportIDs="+arg+"&date="+processDate, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
             }
            else{
               alert("请选择要上报的报表");
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
                  var arg=getAllSelectValue(form1.chk,"^");
                  var processDate=document.all('form1:processDate').value;
                  if (document.all('form1:staticWeek')!=null && document.all('form1:staticWeek')!=undefined){
                      processDate+="@"+document.all('form1:staticWeek');
                  }
                  arg="Command=7&Parameter="+processDate+"&UnitID="+document.all("form1:UnitID").value+"&ReportList="+arg;
                 //  alert(arg);
                  window.showModalDialog("/report/ProcessReport.jsf?" + arg, null, "dialogWidth:750px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
               }
              else{
                 alert("请选择要统计的报表");
              }
              return false;
        }
        function DoCheck(){
              if (checkMutilSelect(form1.chk)) {
                  var arg=getAllSelectValue(form1.chk,"^");

                  arg="Command=8&UnitID="+document.all("form1:UnitID").value+"&ReportList="+arg;
                  //alert(arg);
                  window.showModalDialog("/report/ProcessReport.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:580px;center:center;resizable:yes;status:no;scroll:yes;");
               }
              else{
                 alert("请选择要校核的报表");
              }
              return false;
        }
        function DirectOpenRpt(){
            var v=selectOnlyOne(form1.chk)
            if (v==null){
                alert("请选择要统计的报表");
                return false;
            }
            var processDate=document.all('form1:processDate').value;
            if (document.all('form1:staticWeek')!=null && document.all('form1:staticWeek')!=undefined){
                processDate+="@"+document.all('form1:staticWeek');
            }

            var url="/pages/report/ServerReportShow.jsp?RptCode="+v+"&ID=&ORGUID="+document.all("form1:UnitID").value+"&Parameter="+processDate+"&Command=0";
            window.open(url);
            return false;
        }
        function OpenRpt(){
            var v=selectOnlyOne(form1.chk)
            if (v==null){
                alert("请选择要统计的报表");
                return false;
            }
            var processDate=document.all('form1:processDate').value;
            if (document.all('form1:staticWeek')!=null && document.all('form1:staticWeek')!=undefined){
                processDate+="@"+document.all('form1:staticWeek');
            }

            var url="/pages/report/ServerReportShow.jsp?RptCode="+v+"&ID=&ORGUID="+document.all("form1:UnitID").value+"&Parameter="+processDate;
            window.open(url);
            return false;
        }

    </script>

<x:saveState value="#{Rpt_InfoIndexBB}"/>
<h:form id="form1">
     <h:inputHidden id="flowState" value="#{Rpt_InfoIndexBB.flowState}"/>
    <h:inputHidden id="UnitID" value="#{Rpt_InfoIndexBB.unitId}"/>
    <h:inputHidden id="dateId" value="#{Rpt_InfoIndexBB.dateId}"/>
     <h:inputHidden id="setID" value="#{Rpt_InfoIndexBB.setID}"/>
    <c:verbatim>
    <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr><td height=10 colspan=3></td></tr>
        <tr>
            <td align="left">
</c:verbatim>
                <h:outputText value="当前统计单位:"/>
                <h:outputText value="#{Rpt_InfoIndexBB.unitName}"/>
<c:verbatim>
            </td>

            <td>
</c:verbatim>
               <h:outputText value="统计日期："></h:outputText>
               <h:inputText readonly="true" id="processDate" value="#{Rpt_InfoIndexBB.staticdate}"></h:inputText>
               <h:outputText value="统计周：" rendered="#{Rpt_InfoIndexBB.staticWeek!=null && Rpt_InfoIndexBB.staticWeek!=''}"></h:outputText>
               <h:inputText readonly="true" id="staticWeek" rendered="#{Rpt_InfoIndexBB.staticWeek!=null && Rpt_InfoIndexBB.staticWeek!=''}" value="#{Rpt_InfoIndexBB.staticWeek}" style="width:40px"></h:inputText>
<c:verbatim>
            </td>

            <td align="right">
                <input Class="button01" type="button" onclick="DoSelectAll(true);" value="全选">
                <input Class="button01" type="button" onclick="DoSelectAll(false);" value="全撤">
                <input Class="button01" type="button" onclick="OpenRpt();" value="预览">
                <input Class="button01" type="button" onclick="DoStatic();" value="统计">
                <input Class="button01" type="button" onclick="DoCheck();" value="校验">
</c:verbatim>
                <h:commandButton onclick="return doDocument();" type="button" styleClass="button01" value="归档"   rendered="true"  />
                <h:commandButton styleClass="button01" action="#{Rpt_InfoIndexBB.endReprot}"  value="结束"  rendered="#{Rpt_InfoIndexBB.flowState}" />
                <h:commandButton  styleClass="button01" value="返回" action="dateList" />
<c:verbatim>
            </td>
        </tr>


    <tr><td height=30 colspan=3>
          <input   type="checkbox" name= "chkAll"   onclick="selectAll(document.form1.chkAll, document.form1.chk);"><strong>
         </c:verbatim>
              <h:outputLabel  value="#{Rpt_InfoIndexBB.setName}"></h:outputLabel>
         <c:verbatim>
         </strong>
    </td></tr>

    <tr>
    <td colspan=3>
        <table  width=100% class="table03">
            <%
                       List reportList=(List)session.getAttribute("reportList");
                       int j=0;
                       if (reportList!=null){
                       while(true){
                           // 每行3列
                           if (j<reportList.size()){
                              out.println("<tr>");
                              SelectItem item= (SelectItem)(reportList.get(j));
                              out.println("<td width='33%' class='td_middle_left'><input  type=checkbox name=chk value="+item.getValue()+">"+item.getLabel()+"</td>");
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
                       } // 结束表格循环
                      }
            %>
        </table>
    </td>
    </tr>
    </table>
</c:verbatim>
</h:form>
