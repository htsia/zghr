<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <base target="_self">
    <script type="text/javascript">
        function doCheck(){
           if (checkMutilSelect(document.form1.selected_ids)){
               var str="";
               if (document.form1.selected_ids.length == null) {
                   str=document.form1.selected_ids.value;
               } else {
                   for (var i = 0; i < document.form1.selected_ids.length; i++) {
                       if (document.form1.selected_ids[i].checked) {
                           if (str=="") {
                               str=document.form1.selected_ids[i].value;
                           }
                           else{
                               str+=","+document.form1.selected_ids[i].value;
                           }
                       }
                   }
               }
               document.all('form1:ids').value=str;
           }
           else{
               alert("请选择开介绍信人员!");
               return false;
           }
        }
    </script>

<x:saveState value="#{emp_letterBB}"/>
<h:form id="form1">
   <h:inputHidden id="initWorkLetter" value="#{emp_letterBB.initWorkLetter}"/>
   <h:inputHidden id="ids" value="#{emp_letterBB.ids}"></h:inputHidden>
   <table height=98% width=98% align="center">
   <tr><td height=8px>
       <table width="100%" class="td_title" >
           <tr >
               <td  height="25px" width="50%" >
                   <h:graphicImage  value="/images/tips.gif" />
                    <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2173", "新开工人调转介绍信")%>
					</f:verbatim> 
               </td>
               <td  height="25px" width="50%" align="right">
                   <h:commandButton  styleClass="button01" value="确认" onclick="return doCheck();" action="#{emp_letterBB.openWorkLetter}"></h:commandButton>
                   <h:commandButton type="button" styleClass="button01" onclick="window.close();" value="退出"></h:commandButton>
                </td>
           </tr>
       </table>
    </td></tr>

    <tr><td height=8px>
           <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2161", "介绍信编号")%>:
		   </f:verbatim> 
            <h:inputText readonly="true" value="#{emp_letterBB.wlbo.letterNO}"/>
            <h:outputText value="    "></h:outputText>
            <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2207", "选择调往单位")%>:
		    </f:verbatim> 
            <h:selectOneMenu value="#{emp_letterBB.superID}">
                <c:selectItems value="#{emp_letterBB.orgList}"></c:selectItems>
            </h:selectOneMenu>
            <h:commandButton value="查询" styleClass="button01" action="#{emp_letterBB.getPersonBySupeID}"></h:commandButton>
       </td></tr>

     <tr><td >
         <div style='width:100%;height:100%;overflow:auto' id='datatable'>
        <h:dataTable value="#{emp_letterBB.personList}" var="list" align="center"  id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03"  >
            <h:column>
                 <c:facet name="header">
                     <c:verbatim escape="false">
                     <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                     </c:verbatim>
                </c:facet>
                 <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                 <h:outputText value="#{list.chgId}"/>
                <c:verbatim>"></c:verbatim>
             </h:column>

            <h:column>
                <c:facet name="header">
               <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2163", "申请日期")%>
		       </f:verbatim> 
               </c:facet>
                <h:outputText value="#{list.applyDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header">
                  <f:verbatim>
						<%=LanguageSupport.getResource("XTGL-1042", "员工编号")%>
		       </f:verbatim> 
               </c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                   <f:verbatim>
						<%=LanguageSupport.getResource("MSG-0010", "姓名")%>
		       </f:verbatim> 
                 </c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2146", "原单位")%>
		        </f:verbatim> 
                </c:facet>
                <h:outputText value="#{list.fromOrgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2164", "调往单位")%>
		        </f:verbatim> 
               </c:facet>
                <h:outputText value="#{list.toOrgName}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2165", "原单位意见")%>
		        </f:verbatim> 
                 </c:facet>
                <h:outputText value="#{list.fromOpinion}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                   <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2172", "原单位审批原因")%>
		           </f:verbatim> 
                  </c:facet>
                <h:outputText value="#{list.fromReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                   <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2171", "原单位审批时间")%>
		           </f:verbatim> 
                    </c:facet>
                <h:outputText value="#{list.fromDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2170", "原单位合同情况")%>
		           </f:verbatim> 
                 </c:facet>
                <h:outputText value="#{list.cont_old_end}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2169", "调入单位意见")%>
		           </f:verbatim> 
                </c:facet>
                <h:outputText value="#{list.toOpinion}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2168", "调入单位审批原因")%>
		           </f:verbatim> 
                 </c:facet>
                <h:outputText value="#{list.toReason}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                  <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2167", "调入单位审批时间")%>
		           </f:verbatim> 
                </c:facet>
                <h:outputText value="#{list.toDate}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                 <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2166", "新单位合同情况")%>
		           </f:verbatim> 
                </c:facet>
                <h:outputText value="#{list.cont_new_begin}"/>
            </h:column>

            <h:column>
                <c:facet name="header">
                   <f:verbatim>
						<%=LanguageSupport.getResource("RYGL-2151", "办理状态")%>
		           </f:verbatim> 
                </c:facet>
                <h:outputText value="#{list.applyStatusDes}"/>
            </h:column>
        </h:dataTable>
         </div>
    </td></tr>
   </table>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
