<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
       function doAudit(cardID){
           window.showModalDialog("/system/auditRegEdit.jsf?cardID=" + cardID, "", "dialogWidth:300px; dialogHeight:350px; center:yes; status:0;");
       }
 </script>

<x:saveState value="#{user_regInfoBB}"/>
<h:form id="formInfoItemList">
    <h:inputHidden value="#{user_regInfoBB.initList}"></h:inputHidden>
    <c:verbatim>
    <table height=98% width=98%>
        <tr><td td height=20 class="td_title">
           <img src="/images/tips.gif" />
                <%=LanguageSupport.getResource("XTGL-0900","系统管理 ")%> -> 
    	        <%=LanguageSupport.getResource("XTGL-1034","审核注册申请")%>       
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
            <h:panelGroup>
            <h:selectBooleanCheckbox value="#{user_regInfoBB.onlyInit}" onclick="submit();" valueChangeListener="#{user_regInfoBB.statusChange}"></h:selectBooleanCheckbox>
            <f:verbatim>
            	<%=LanguageSupport.getResource("XTGL-1049","仅显示待审核")%>   
            </f:verbatim>
            <h:outputText value="  "></h:outputText>
            <f:verbatim>
            	<%=LanguageSupport.getResource("COMM-1043","记录数:")%>
            </f:verbatim>
            <h:outputText value="#{user_regInfoBB.page.totalRecord}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <f:verbatim>
            	<%=LanguageSupport.getResource("COMM-1044","页数:")%>
            </f:verbatim>
            <h:outputText value="#{user_regInfoBB.page.totalPage}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <f:verbatim>
            	<%=LanguageSupport.getResource("COMM-1045","每页有")%>
            </f:verbatim>
            <h:outputText value="#{user_regInfoBB.page.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
             <f:verbatim>
            	<%=LanguageSupport.getResource("COMM-1046","当前为第")%>
            </f:verbatim>
            <h:outputText value="#{user_regInfoBB.page.currentPage}"></h:outputText>
             <f:verbatim>
            	<%=LanguageSupport.getResource("COMM-1047","页")%>
            </f:verbatim>
            <h:commandButton value="首页" action="#{user_regInfoBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{user_regInfoBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{user_regInfoBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{user_regInfoBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
 <c:verbatim>
        </td></tr>

        <tr><td height=8 >
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
            <h:dataTable value="#{user_regInfoBB.regList}" var="list" id="dateList"
                     headerClass="td_top tr_fixrow" rowClasses="td_middle" styleClass="table03"   columnClasses="td_middle_left,td_middle_left"
                     border="0" align="left" width="100%">
                <h:column>
                    <f:facet name="header">
                       <f:verbatim>
		            			<%=LanguageSupport.getResource("XTGL-1050","报道时间")%>   
		                </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.enterTime}"/>
                </h:column>

            <h:column>
                <f:facet name="header">
                      <f:verbatim>
		            			<%=LanguageSupport.getResource("XTGL-1043","身份证号")%>   
		                </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.cardID}"/>
            </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
		            			<%=LanguageSupport.getResource("MSG-0010","姓名")%>
		                </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.name}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                      <f:verbatim>
		            			<%=LanguageSupport.getResource("XTGL-1054","增员方式")%>   
		                </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.addTypeDes}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                       <f:verbatim>
		            			<%=LanguageSupport.getResource("XTGL-1044","员工类别")%>   
		                </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.personTypeDes}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                    <f:verbatim>
		            			<%=LanguageSupport.getResource("XTGL-1051","状态")%>   
		                </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.statusDes}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                       <f:verbatim>
		            			<%=LanguageSupport.getResource("XTGL-1052","审核人")%>   
		                </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.auditOperName}"/>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <f:verbatim>
		            			<%=LanguageSupport.getResource("XTGL-1053","审核时间")%>   
		                </f:verbatim>
                    </f:facet>
                    <h:outputText escape="false" value="#{list.auditDate}"/>
                </h:column>

            <h:column>
                <f:facet name="header">
                     <f:verbatim>
		            			<%=LanguageSupport.getResource("YXGL-1026","操作")%>   
		                </f:verbatim>
                </f:facet>
                <h:commandButton value="审核" styleClass="button01" rendered="#{list.status=='0'}" onclick="doAudit('#{list.cardID}');"></h:commandButton>
            </h:column>
        </h:dataTable>
<c:verbatim>
        </div>
        </td></tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("formInfoItemList:dateList");
</script>

