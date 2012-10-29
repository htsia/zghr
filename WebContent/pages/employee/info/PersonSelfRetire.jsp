<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String mode = CommonFuns.filterNull(request.getParameter("mode"));     //支持的减员类别
    String afterType = CommonFuns.filterNull(request.getParameter("afterType"));     //支持的减员类别
    String title = "";
    if ("TOMCAT".equals(CommonFuns.getAppType())) {
        title = CommonFuns.getParaFromURL(request.getQueryString(), "title");
    } else {
        title = request.getParameter("title");
    }

%>
    <script type="text/javascript">
        function hideChangeUnit(){
             document.all('changeLabel').style.display="none";
             document.all('form1:changeUnit').style.display="none";
        }
        function selRetireTime(){
        <%
           InfoItemBO retireTime=SysCacheTool.findInfoItem("","A016020");
           if (InfoItemBO.DATA_TYPE_DATE6.equals(retireTime.getItemDataType())){
        %>
            PopUpCalendarDlg_OnlyMonth("form1:A016020");
        <%
           }
           else{
         %>
             PopUpCalendarDialog("form1:A016020");
        <%
         }
        %>

        }
    </script>

    <x:saveState value="#{emp_PersonDismissBB}"/>
    <x:saveState value="#{sys_commonInfoBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{emp_PersonDismissBB.pageInit}"/>
        <%
            String ids = (String)request.getAttribute("perIds");
        %>
<f:verbatim>
        <input type="hidden" name="pids" value="<%=ids%>">
        <br>

        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td >
                 <strong>
                  <%
                    out.println("<font color='red'>");
                    // 死亡不需要审批
                    if (!"0200221231".equals(mode) && ("1".equals(Constants.EMP_REDUCE_AFTER_APPROVE) ||"2".equals(Constants.EMP_REDUCE_AFTER_APPROVE))){
                         out.println(LanguageSupport.getResource("RYGL-2372","注意只有审批后才生效"));
                    }
                    out.println("</font></strong><br>");
                   String Namelist="";
                   String []pelist=ids.split(",");
                   for(int i=0;i<pelist.length;i++){
                      PersonBO pb=SysCacheTool.findPersonById(pelist[i]);
                      if (Namelist.equals("")){
                         Namelist=pb.getName();
                      }
                      else{
                         Namelist=Namelist+","+ pb.getName();
                      }
                   }
                   Namelist=Namelist+"申请离职";
                   out.println(Namelist);
               %>
                 </strong>
               </td>
            </tr>
           </table>

            <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr nowrap>
                <td width="140" class=td_form01><%=LanguageSupport.getResource("RYGL-2373","减员类别") %></td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                                 value="#{emp_PersonDismissBB.personchangevo.changeType}" alt="减员类别|0|s|50||"/>
<f:verbatim>
                        <%
                                out.print("<input type=\"button\" class=\"button_select\" onclick=\"PopUpCodeDlgOneControl('form1:A016010','"+mode+"')\">");
                        %>

                </td>
                <td  width="140" class=td_form01><%=LanguageSupport.getResource("RYGL-2374","减员日期") %></td>
                <td class=td_form02>
 </f:verbatim>
                    <h:inputText styleClass="input" id="A016020" value="#{emp_PersonDismissBB.personchangevo.changeDate}"
                                 alt="减员日期|0|s|50||"/>
 <f:verbatim>
                  <input type="button" class="button_date" onclick="selRetireTime();"></td>
            </tr>

            <tr nowrap>
                <td  class=td_form01 ><%=LanguageSupport.getResource("RYGL-2368","变更后人员类别") %></td>
                <td class=td_form02>
 </f:verbatim>
                    <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                                 value="#{emp_PersonDismissBB.afterType}" alt="变更后人员类别|0|s|50||"/>
 <f:verbatim>
                     <%
                      if (!"".equals(afterType)){
                         out.print("<input type='button' class='button_select' onclick=\"PopUpCodeDlgOneControl('form1:A001054','"+afterType+"')\">");
                      }
                      else{
                        out.print("<input type='button' class='button_select' onclick=\"PopUpCodeDlgOneControl('form1:A001054','013520')\">");
                      }
                     %>
                </td>
     <td  class='</f:verbatim><h:outputText value="td_form01" rendered="#{emp_PersonDismissBB.useA001725}"/><f:verbatim>' >
</f:verbatim>
     <h:outputText value="变更后当前状态" rendered="#{emp_PersonDismissBB.useA001725}"/>
<f:verbatim>
    </td>
     <td class='</f:verbatim><h:outputText value="td_form02" rendered="#{emp_PersonDismissBB.useA001725}"/><f:verbatim>'>
 </f:verbatim>
        <h:inputText styleClass="input" id="A001725" code="" dict="yes" dict_num="0145" rendered="#{emp_PersonDismissBB.useA001725}"
         value="#{emp_PersonDismissBB.afterStatus}" alt="变更后当前状态|0|s|50||"/>
        <h:commandButton type="button" styleClass="button_select" rendered="#{emp_PersonDismissBB.useA001725}" onclick="PopUpCodeDlgOneControl('form1:A001725')" />
 <f:verbatim>
     </td>
     </tr>

     <tr nowrap>
     <td  class=td_form01 ><span id="changeLabel">离开单位</span></td>
     <td class=td_form02>
  </f:verbatim>
         <h:inputText styleClass="input" id="changeUnit" readonly="true" value="#{emp_PersonDismissBB.personchangevo.changeUnit}"
                      alt="离开单位|1|s|50||"/>
  <f:verbatim>
     </td>
             <td  class='</f:verbatim><h:outputText value="td_form01" rendered="#{sys_commonInfoBB.enableLeaveReason}"/><f:verbatim>' >
        </f:verbatim>
             <h:outputText value="离职原因" rendered="#{sys_commonInfoBB.enableLeaveReason}"/>
        <f:verbatim>
             </td>
            <td class='</f:verbatim><h:outputText value="td_form02" rendered="#{sys_commonInfoBB.enableLeaveReason}"/><f:verbatim>'>
</f:verbatim>
               <h:inputText styleClass="input" id="reason" code="" dict="yes" dict_num="2237"  rendered="#{sys_commonInfoBB.enableLeaveReason}"
                value="#{emp_PersonDismissBB.personchangevo.reason}" alt="离职原因|0|s|50||"/>
               <h:commandButton type="button" styleClass="button_select"  rendered="#{sys_commonInfoBB.enableLeaveReason}" onclick="PopUpCodeDlgOneControl('form1:reason')" />
<f:verbatim>
            </td>

         </tr>


     <tr nowrap>
         <td  class=td_form01 >
    </f:verbatim>
         <h:outputText value="备注" />
    <f:verbatim>
         </td>
        <td colspan="3" class=td_form02>
</f:verbatim>
           <h:inputTextarea styleClass="input" id="memo" rows="2"  cols="60"
            value="#{emp_PersonDismissBB.personchangevo.memo}" />
<f:verbatim>
        </td>

        </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 >
            <tr>
                <td align="left">
               </td>
               <td align="right">
</f:verbatim>
                  <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_PersonDismissBB.saveRetire}" />
 <f:verbatim>
             </td>
            </tr>
        </table>
 </f:verbatim>
        <script type="text/javascript">
            interpret(document.forms(0));
        </script>
    </h:form>
