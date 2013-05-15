<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.hr319wg.sys.dao.ParameterDAO"%>
<%@page import="com.hr319wg.sys.pojo.bo.ParameterBO"%>
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
    String mode = request.getParameter("mode");     //֧�ֵļ�Ա���
    String afterType = CommonFuns.filterNull(request.getParameter("afterType"));     //֧�ֵļ�Ա���
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
                    out.println(LanguageSupport.getResource("RYGL-2371","������ԱҪ����"));
                    out.println(title);
                    out.println("&nbsp;&nbsp; <font color='red'>");
                    // ��������Ҫ����
                    if (!"0200221231".equals(mode) && ("1".equals(Constants.EMP_REDUCE_AFTER_APPROVE) || "2".equals(Constants.EMP_REDUCE_AFTER_APPROVE))){
                         out.println(LanguageSupport.getResource("RYGL-2372","ע��ֻ�����������Ч"));
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
                   Namelist="&nbsp;&nbsp;&nbsp;&nbsp;"+ Namelist;
                   out.println(Namelist);
               %>
                 </strong>
               </td>
            </tr>
           </table>

            <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr nowrap>
                <td width="140" class=td_form01><%=LanguageSupport.getResource("RYGL-2373","��Ա���") %></td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                                 value="#{emp_PersonDismissBB.personchangevo.changeType}" alt="��Ա���|0|s|50||"/>
<f:verbatim>
                        <%
                                out.print("<input type=\"button\" class=\"button_select\" onclick=\"PopUpCodeDlgOneControl('form1:A016010','"+mode+"')\">");
                        %>

                </td>
                <td  width="140" class=td_form01><%=LanguageSupport.getResource("RYGL-2374","��Ա����") %></td>
                <td class=td_form02>
 </f:verbatim>
                    <h:inputText styleClass="input" id="A016020" value="#{emp_PersonDismissBB.personchangevo.changeDate}"
                                 alt="��Ա����|0|s|50||"/>
 <f:verbatim>
                  <input type="button" class="button_date" onclick="selRetireTime();"></td>
            </tr>

            <tr nowrap>
                <td  class=td_form01 ><%=LanguageSupport.getResource("RYGL-2368","�������Ա���") %></td>
                <td class=td_form02>
 </f:verbatim>
                    <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                                 value="#{emp_PersonDismissBB.afterType}" alt="�������Ա���|0|s|50||"/>
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
     <h:outputText value="�����ǰ״̬" rendered="#{emp_PersonDismissBB.useA001725}"/>
<f:verbatim>
    </td>
     <td class='</f:verbatim><h:outputText value="td_form02" rendered="#{emp_PersonDismissBB.useA001725}"/><f:verbatim>'>
 </f:verbatim>
        <h:inputText styleClass="input" id="A001725" code="" dict="yes" dict_num="0145" rendered="#{emp_PersonDismissBB.useA001725}"
         value="#{emp_PersonDismissBB.afterStatus}" alt="�����ǰ״̬|0|s|50||"/>
        <h:commandButton type="button" styleClass="button_select" rendered="#{emp_PersonDismissBB.useA001725}" onclick="PopUpCodeDlgOneControl('form1:A001725')" />
 <f:verbatim>
 	 <%
	 	 InfoItemBO item=SysCacheTool.findInfoItem("A001", "A001725");
	     if(item!=null && "1".equals(item.getItemStatus())){
	    	 ParameterDAO dao = (ParameterDAO) SysContext.getBean("sys_parameterDAO");
	    	 ParameterBO bo = dao.getParameter("EMP_DEFAULT_AFTER_STATUS");
	    	 System.out.println(bo);
    	     if(bo!=null){
    	    	%>
    	    	<script type="text/javascript">
    	    		document.getElementById("form1:A001725").value="<%=bo.getValue()%>";
    	    	</script>
    	    	<%
    	     }
	     }
 	 %>
     </td>
     </tr>

     <tr nowrap>
     <td  class=td_form01 ><span id="changeLabel">�뿪��λ</span></td>
     <td class=td_form02>
  </f:verbatim>
         <h:inputText styleClass="input" id="changeUnit" readonly="true" value="#{emp_PersonDismissBB.personchangevo.changeUnit}"
                      alt="�뿪��λ|1|s|50||"/>
  <f:verbatim>
     </td>
             <td  class='</f:verbatim><h:outputText value="td_form01" rendered="#{sys_commonInfoBB.enableLeaveReason}"/><f:verbatim>' >
        </f:verbatim>
             <h:outputText value="��ְԭ��" rendered="#{sys_commonInfoBB.enableLeaveReason}"/>
        <f:verbatim>
             </td>
            <td class='</f:verbatim><h:outputText value="td_form02" rendered="#{sys_commonInfoBB.enableLeaveReason}"/><f:verbatim>'>
</f:verbatim>
               <h:inputText styleClass="input" id="reason" code="" dict="yes" dict_num="2237"  rendered="#{sys_commonInfoBB.enableLeaveReason}"
                value="#{emp_PersonDismissBB.personchangevo.reason}" alt="��ְԭ��|0|s|50||"/>
               <h:commandButton type="button" styleClass="button_select"  rendered="#{sys_commonInfoBB.enableLeaveReason}" onclick="PopUpCodeDlgOneControl('form1:reason')" />
<f:verbatim>
            </td>

         </tr>


    <tr nowrap>
         <td  class=td_form01 >
    </f:verbatim>
         <h:outputText value="��ע" />
    <f:verbatim>
         </td>
        <td colspan="3" class=td_form02>
</f:verbatim>
           <h:inputTextarea styleClass="input" id="memo" rows="2"  cols="60"
            value="#{emp_PersonDismissBB.personchangevo.memo}" />
<f:verbatim>
        </td>
     </tr>

    <tr nowrap>
         <td  class=td_form01 >
    </f:verbatim>
         <h:outputText value="����������(��ѡ��ʾ������)" />
    <f:verbatim>
         </td>
        <td colspan="3" class=td_form02>
    </f:verbatim>
                <h:inputText styleClass="input" id="toDept" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{emp_PersonDismissBB.personchangevo.toDept}"
                     alt="���ڻ���|1|s|50||"/>
    <f:verbatim>
                <input type="button" class="button_select" onclick="PopUpOrgDlgShowGroup('form1:toDept',2)">
        </td>
     </tr>
    </table>

        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 >
            <tr>
                <td align="left">
 </f:verbatim>
                  <h:selectBooleanCheckbox value="#{emp_PersonDismissBB.joinBlack}" rendered="#{sys_commonInfoBB.enableBlackSheet}"></h:selectBooleanCheckbox>
                  <h:outputText value="������ְ������" rendered="#{sys_commonInfoBB.enableBlackSheet}"></h:outputText>
<f:verbatim>
               </td>
               <td align="right">
</f:verbatim>
                  <h:commandButton id="save" styleClass="button01" value="����" onclick="return forsubmit(document.forms(0))" action="#{emp_PersonDismissBB.saveRetire}" />
 <f:verbatim>
             </td>
            </tr>
             <tr><td>
 </f:verbatim>
                 <h:outputText value="ԭ��" rendered="#{sys_commonInfoBB.enableBlackSheet}"></h:outputText>

                 <h:inputTextarea value="#{emp_PersonDismissBB.joinReason}" rendered="#{sys_commonInfoBB.enableBlackSheet}" rows="3" cols="60"></h:inputTextarea>
 <f:verbatim>
             </td></tr>
        </table>
 </f:verbatim>
        <script type="text/javascript">
        <%
              //out.println("hideChangeUnit();");
        %>
            interpret(document.forms(0));
        </script>
    </h:form>
