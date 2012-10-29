<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<script type="text/javascript">
        function doCheck(){
            if (document.all("form1:A016030").value==""){
                alert("请选择接收部门!")
                return false;
            }
            if (document.all("form1:A016010").value==""){
                alert("请选择增员类别!")
                return false;
            }
            return forsubmit(document.forms(0));
        }
        function selPost(){
            var deptId=document.all("form1:A016030").code;
            PopUpPostDlgByDept(document.all("form1:toPostId"),null,deptId);
        }
        function selTime() {
            <%
               InfoItemBO workTime=SysCacheTool.findInfoItem("","A016020");
               if (InfoItemBO.DATA_TYPE_DATE6.equals(workTime.getItemDataType())){
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
    <h:form id="form1">
        <h:inputHidden value="#{emp_PersonDismissBB.receiveEdit}"/>
       <c:verbatim>
        <table width="98%" align="center">
            <tr class="td_title">
                <td colspan=2 align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="接收" onclick="return doCheck();" action="#{emp_PersonDismissBB.saveReceive}" />
                    <h:commandButton type="button" styleClass="button01" value="关闭" onclick="window.close()"/>
<c:verbatim>
                </td>
            </tr>
            <tr nowrap>
               <td class=td_form01>  <%=LanguageSupport.getResource("MSG-0010","姓名") %></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_PersonDismissBB.changevo.name}"></h:inputText>
<c:verbatim>
               </td>
           </tr>
            <tr nowrap>
               <td class=td_form01>  <%=LanguageSupport.getResource("RYGL-2155","调出单位") %></td>
               <td class=td_form02>
</c:verbatim>
                    <h:inputText readonly="true" value="#{emp_PersonDismissBB.changevo.fromOrgName}"></h:inputText>
<c:verbatim>
               </td>
           </tr>

            <tr nowrap>
                <td class="td_form01 td_form_required" width="120"> <%=LanguageSupport.getResource("XTGL-1047","增员类别") %></td>
                <td class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                                 readonly="true" value="#{emp_PersonDismissBB.personchangevo.changeType}"
                                 alt="增员类别|0|s|50||"/>
                    <h:commandButton type="button" styleClass="button_select"    onclick="PopUpCodeDlgOneControl('form1:A016010','0200300008')" />
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2282","增员时间") %></td>
                <td class=td_form02>
</c:verbatim>
                    <h:inputText styleClass="input" id="A016020" value="#{emp_PersonDismissBB.personchangevo.changeDate}"
                                 readonly="true" />
                    <h:commandButton type="button" styleClass="button_date" onclick="selTime();" />
<c:verbatim>
                </td>
            </tr>

             <tr nowrap>
                <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2019","调入部门") %></td>
                <td class=td_form02 >
</c:verbatim>
                    <h:inputText styleClass="input" id="A016030" value="#{emp_PersonDismissBB.changevo.toDepId}" dict="yes" dict_num="OU"  code=""
                            readonly="true"    alt="调入部门|1|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_org" onclick="PopUpOrgDlgShowGroup('form1:A016030',2)">
                </td>
            </tr>

    <tr nowrap>
       <td class="td_form01">调入岗位</td>
       <td class=td_form02 >
   </c:verbatim>
           <h:inputText styleClass="input" id="toPostId" value="#{emp_PersonDismissBB.changevo.toPostId}" dict="yes" dict_num="PO"  code=""
                   readonly="true"    alt="调入岗位|1|s|50||"/>
   <c:verbatim>
           <input type="button" class="button_post" onclick="selPost();">
       </td>
   </tr>

       <tr nowrap>
          <td class="td_form01">岗位级别</td>
          <td class=td_form02 >
      </c:verbatim>
              <h:inputText styleClass="input" id="toPostIdLevel" value="#{emp_PersonDismissBB.changevo.toPostLevel}" dict="yes" dict_num="2238"  code=""
                      readonly="true"    alt="岗位级别|1|s|50||"/>
      <c:verbatim>
              <input type="button" class="button_post" onclick="PopUpCodeDlgOneControl('form1:toPostIdLevel');">
          </td>
      </tr>

        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript" language="javascript">
	interpret(document.forms(0));
</script>
