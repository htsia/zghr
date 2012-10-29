<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function doCheck() {
            if (document.all("form1:content").value==""){
                alert("请录入内容!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{oa_worklogBB}"/>
<h:form id="form1">
        <h:inputHidden id="pageInit" value="#{oa_worklogBB.workLogEdit}"/>

        <c:verbatim>
            <table width="100%" align="center" styleClass="table03">
                <tr><td colspan="4" align="right">
        </c:verbatim>
                    <h:commandButton styleClass="button01" value="保存" action="#{oa_worklogBB.save}"
                                     onclick="return doCheck();"/>
                    <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
         <c:verbatim>          
                </td></tr>

                <tr>
                    <td class="td_form01">
         </c:verbatim>
                        <h:outputText value="处理人"/>
         <c:verbatim>
                    </td>
                    <td class="td_form02">
         </c:verbatim>
                         <h:inputText value="#{oa_worklogBB.oalog.processor}"/>
         <c:verbatim>
                    </td>
                     <td class="td_form01">
          </c:verbatim>
                         <h:outputText value="共享级别"/>
          <c:verbatim>
                     </td>
                     <td class="td_form02">
          </c:verbatim>
                        <h:selectOneMenu value="#{oa_worklogBB.oalog.shareDegree}">
                            <c:selectItem itemLabel="仅本人可见" itemValue="1"></c:selectItem>
                            <c:selectItem itemLabel="其他人可见" itemValue="2"></c:selectItem>
                        </h:selectOneMenu>
          <c:verbatim>    
                     </td>
                </tr>

              <tr>
                  <td class="td_form01">
           </c:verbatim>
                     <h:outputText value="内容"/>
           <c:verbatim>
                  </td>
                  <td class="td_form02" colspan="3">
           </c:verbatim>
                     <h:inputTextarea id="content" value="#{oa_worklogBB.oalog.content}" cols="80" rows="3"/>
           <c:verbatim>
                  </td>
              </tr>

               <tr>
                   <td class="td_form01">
        </c:verbatim>
                       <h:outputText value="提出人"/>
        <c:verbatim>
                   </td>
                   <td class="td_form02">
        </c:verbatim>
                        <h:inputText value="#{oa_worklogBB.oalog.apply}"/>
        <c:verbatim>
                   </td>
                    <td class="td_form01">
         </c:verbatim>
                        <h:outputText value="关联人员"/>
         <c:verbatim>
                    </td>
                    <td class="td_form02">
         </c:verbatim>
                        <h:inputText value="#{oa_worklogBB.oalog.linkPerson}"/>
         <c:verbatim>
                    </td>
               </tr>

             <tr>
                 <td class="td_form01">
          </c:verbatim>
                    <h:outputText value="处理意见"/>
          <c:verbatim>
                 </td>
                 <td class="td_form02" colspan="3">
          </c:verbatim>
                    <h:inputTextarea value="#{oa_worklogBB.oalog.process}" cols="80" rows="3"/>
          <c:verbatim>
                 </td>
             </tr>

              <tr><td colspan="4" class="td_form01" align="center">领导意见</td></tr>


              <tr>
                  <td class="td_form01">
           </c:verbatim>
                      <h:outputText value="上级意见时间"/>
           <c:verbatim>
                  </td>
                  <td class="td_form02" colspan="3">
           </c:verbatim>
                     <h:inputText  id="leadDate" value="#{oa_worklogBB.oalog.leadDate}" />
           <c:verbatim>
                     <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:leadDate')">
                  </td>
              </tr>

               <tr>
                   <td class="td_form01">
            </c:verbatim>
                       <h:outputText value="上级意见"/>
            <c:verbatim>
                   </td>
                   <td class="td_form02" colspan="3">
            </c:verbatim>
                      <h:inputTextarea value="#{oa_worklogBB.oalog.leaderop}" cols="80" rows="3"/>
            <c:verbatim>
                   </td>
               </tr>

                <tr>
                    <td class="td_form01">
             </c:verbatim>
                        <h:outputText value="主管意见时间"/>
             <c:verbatim>
                    </td>
                    <td class="td_form02" colspan="3">
             </c:verbatim>
                       <h:inputText id="superDate" value="#{oa_worklogBB.oalog.superDate}"/>
             <c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:superDate')">
                    </td>
                </tr>

                 <tr>
                     <td class="td_form01">
              </c:verbatim>
                         <h:outputText value="主管意见"/>
              <c:verbatim>
                     </td>
                     <td class="td_form02" colspan="3">
              </c:verbatim>
                        <h:inputTextarea value="#{oa_worklogBB.oalog.superop}" cols="80" rows="3"/>
              <c:verbatim>
                     </td>
                 </tr>

               <tr><td colspan="4" class="td_form01" align="center">处理结果</td></tr>

                  <tr>
                      <td class="td_form01">
           </c:verbatim>
                          <h:outputText value="完成时间"/>
           <c:verbatim>
                      </td>
                      <td class="td_form02">
           </c:verbatim>
                         <h:inputText id="resultDate" value="#{oa_worklogBB.oalog.resultDate}"/>
           <c:verbatim>
                        <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:resultDate')">
                      </td>
                       <td class="td_form01">
            </c:verbatim>
                           <h:outputText value="办理人"/>
            <c:verbatim>
                       </td>
                       <td class="td_form02">
            </c:verbatim>
                           <h:inputText value="#{oa_worklogBB.oalog.resultOper}" />
            <c:verbatim>
                       </td>
                  </tr>

                <tr>
                    <td class="td_form01">
             </c:verbatim>
                        <h:outputText value="处理结果"/>
             <c:verbatim>
                    </td>
                    <td class="td_form02" colspan="3">
             </c:verbatim>
                      <h:inputTextarea value="#{oa_worklogBB.oalog.result}" cols="80" rows="3"/>
             <c:verbatim>
                    </td>
                </tr>


               </table>
          </c:verbatim>
</h:form>
