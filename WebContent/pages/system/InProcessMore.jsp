<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doCheckSelect() {
        if (!checkMutilSelect(formCodeItemList.selectItem)) {
            alert("请选择项目!");
            return false;
        }
        return true;
    }

    function changeCode(){
         PopUpCodeDlgTwoControlSelectAll(document.all('formCodeItemList:showcode'),document.all('formCodeItemList:showvalue'),document.all('formCodeItemList:setid').value);
         if (document.all('formCodeItemList:showcode').value==""){
             document.all('formCodeItemList:showcode').value="-1";
         }
         document.all("formCodeItemList").submit();
         return true;
    }
    function doLinkAction(itemID){
        window.opener.LinkAction(itemID);
        window.close();
    }
</script>
    <h:form id="form1">
       <c:verbatim>
       <table width="97%" height="96%" cellpadding="0" align="center"cellspacing="0" border="0" >
			<tr  >
				<td class="td_title" height=2>
       </c:verbatim>
            <f:verbatim>
                 <%=LanguageSupport.getResource("XTGL-1204","代办事宜")%>  
            </f:verbatim>
       <c:verbatim> 
                </td>
            </tr>

            <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
              <x:dataTable  headerClass="td_top" styleClass="table03"  width="100%"
                                               columnClasses="td_middle_left,td_middle_left" id="linkList"  align="center" border="0"  value="#{sys_inProcessBB.moreList}"    var="list">
                          <h:column>
                              <c:facet name="header">
                             <f:verbatim>
			                         <font style="width:140px; color:#333333; " >
			                		    <%=LanguageSupport.getResource("XTGL-1205","发起时间")%>  
		                            </font>
		           			  </f:verbatim>
                              </c:facet>
                              <h:outputText value="#{list.sendDate}" style="width:140px;" />
                          </h:column>

                          <h:column>
                              <c:facet name="header">
                            <f:verbatim>
		                       <font style="width:140px; color:#333333; " >
		                		 <%=LanguageSupport.getResource("XTGL-1206","发起人")%>  
		                       </font>
		           			 </f:verbatim>
                               </c:facet>
                              <h:outputText value="#{list.sendPersonName}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header">
		                     <f:verbatim>
		                         <font style="width:140px; color:#333333; " >
		                		 <%=LanguageSupport.getResource("XTGL-1207","说明")%>  
		                         </font>
		           			 </f:verbatim>
                              </c:facet>
                              <h:outputText value="#{list.content}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header">
                                 <f:verbatim>
					                    <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
					             </f:verbatim>
                               </c:facet>
                              <h:commandButton value="查看" styleClass="button01" type="button" onclick="showWorkFlowLog('#{list.processID}');" rendered="#{list.processID!=null && list.processID!=''}"></h:commandButton>
                              <h:commandButton value="处理" type="button" styleClass="button01" onclick="doLinkAction('#{list.itemID}')">
                              </h:commandButton>
                          </h:column>
                </x:dataTable>
<c:verbatim>
            </div>
            </td></tr>
        </table>
</c:verbatim>
    </h:form>
