<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
   
    <script type="text/javascript">
        function forView() {
            forViewPersonDetail(document.all("form1:personId").value);
        }
    </script>

    <x:saveState value="#{emp_personListBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_personListBB.doReduceAudit}"/>
        <h:inputHidden id="code" value="#{emp_personListBB.code}"/>
        <h:inputHidden id="personId" value="#{emp_personListBB.reducebo.persID}"/>

        <c:verbatim>
        <table width="98%" align="center">
            <tr class="td_title">
                <td colspan=4 align="right">
         </c:verbatim>
                    <h:commandButton  styleClass="button01" value="详细信息" onclick="forView();" type="button" />
                    <h:commandButton id="cancel" styleClass="button01" value="退回" onclick="return forsubmit(document.forms(0))" action="#{emp_personListBB.auditReduceNO}" />
                    <h:commandButton id="save" styleClass="button01" value="同意" onclick="return forsubmit(document.forms(0))" action="#{emp_personListBB.auditReduceOK}" />
                    <h:commandButton type="button" styleClass="button01" value="关闭" onclick="window.close()"/>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2302","单位名称")%></td>
               <td class=td_form02 colspan=3>
</c:verbatim>
                    <h:outputText value="#{emp_personListBB.reducebo.orgName}"></h:outputText>
<c:verbatim>
               </td>
           </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("XTGL-1042","员工编号")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.personCode}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("MSG-0010","姓名")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.persName}"></h:inputText>
<c:verbatim>
                </td>
           </tr>

             <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("MSG-0012","性别")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.sex}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2308","参加工作时间")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.workTime}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-1015","身份证号")%> </td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.idCard}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2057","民族")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.personbo.folk}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2307","减员时间")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a016020}"></h:inputText>
<c:verbatim>
                </td>

                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2299","减员原因")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a016010des}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2306","原类别")%></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_personListBB.personbo.personType}"></h:inputText>
<c:verbatim>
               </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2298","变更后类别")%></td>
                <td class=td_form02 >
</c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a001054des}"></h:inputText>
<c:verbatim>
                </td>
           </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-2305","原状态")%></td>
               <td class=td_form02 >
 </c:verbatim>
                    <h:inputText readonly="true" value="#{emp_personListBB.personbo.state}"></h:inputText>
<c:verbatim>
               </td>
                <td class=td_form01><%=LanguageSupport.getResource("RYGL-2300","变更后状态")%></td>
                <td class=td_form02 >
 </c:verbatim>
                     <h:inputText readonly="true" value="#{emp_personListBB.reducebo.a001725des}"></h:inputText>
<c:verbatim>
                </td>
           </tr>

    <tr nowrap>
       <td class=td_form01><%=LanguageSupport.getResource("RYGL-2304","办理时间")%></td>
       <td class=td_form02 >
 </c:verbatim>
            <h:inputText readonly="true" value="#{emp_personListBB.reducebo.applyDate}"></h:inputText>
<c:verbatim>
       </td>
        <td class=td_form01><%=LanguageSupport.getResource("RYGL-2303","办理人")%></td>
        <td class=td_form02 >
 </c:verbatim>
             <h:inputText readonly="true" value="#{emp_personListBB.reducebo.applyIDName}"></h:inputText>
<c:verbatim>
        </td>
   </tr>

    <tr nowrap>
       <td class=td_form01>原因说明</td>
       <td class=td_form02 colspan=3>
 </c:verbatim>
            <h:inputTextarea rows="3" cols="60" value="#{emp_personListBB.reducebo.auditOption}"></h:inputTextarea>
<c:verbatim>
       </td>
   </tr>

    <tr nowrap>
       <td class=td_form01>回复消息</td>
       <td class=td_form02 colspan=3>
 </c:verbatim>
            <h:selectBooleanCheckbox value="#{emp_personListBB.autoMessage}"></h:selectBooleanCheckbox>
            <h:outputText value="自动发送"></h:outputText>
<c:verbatim>
       </td>
   </tr>

        </table>
 </c:verbatim>
    </h:form>
