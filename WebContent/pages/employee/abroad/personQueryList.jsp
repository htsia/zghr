<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"  %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"  %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doOK() {
      	var str=" |";
        chk=document.forms(0).selectItem;
        if (checkMutilSelect(chk)){
            var size = chk.length;
            if (size == null) {
                if (chk.checked) {
                    str+=chk.value;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (chk[i].checked) {
                        if (i==0){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           	window.returnValue=str;
            window.close();
        }
        else{
            alert("请选择要加入的人员!");
        }
    }

    function doCancel() {
        window.returnValue="";
        window.close();
    }
    function forViewPost(id) {
        windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
    }
    function check(){
        if(document.all('form1:codValue').value==""){
            alert("查询条件为空时查询全部");
        }
    }
</script>
<x:saveState value="#{deptSelPersonBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{deptSelPersonBB.initAdd}"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td height=8>
        </td></tr>

        <tr><td height=8 align="left">
    </c:verbatim>
    <c:verbatim>
        </td></tr>

        <tr><td height=8 align="right">
         <%=LanguageSupport.getResource("XTGL-1013","姓名或员工编号 ")%> ：
    </c:verbatim>
            <h:inputText id="codValue" value="#{deptSelPersonBB.codValue}"></h:inputText>
            <h:outputText value="  "></h:outputText>
            <h:commandButton value="查询" onclick="check()" action="#{deptSelPersonBB.QueryAddPerson2}" styleClass="button01"></h:commandButton>
    		  <f:verbatim>
		          <%=LanguageSupport.getResource("COMM-1048","共 ")%> 
            </f:verbatim>
    		<h:outputText value="#{deptSelPersonBB.mypage.totalPage}"></h:outputText>
    		 <f:verbatim>
		          <%=LanguageSupport.getResource("COMM-1047","页")%>
            </f:verbatim>
    		
    		
            <h:outputText value="  "></h:outputText>
             <f:verbatim>
		          <%=LanguageSupport.getResource("COMM-1045","每页有")%>
            </f:verbatim>
            <h:outputText value="#{deptSelPersonBB.mypage.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
              <f:verbatim>
		          <%=LanguageSupport.getResource("COMM-1046","当前为第")%>
            </f:verbatim>
            <h:outputText value="#{deptSelPersonBB.mypage.currentPage}"></h:outputText>
              <f:verbatim>
		          <%=LanguageSupport.getResource("COMM-1048","页")%>
            </f:verbatim>
            <h:commandButton value="首页" action="#{deptSelPersonBB.addfirst}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{deptSelPersonBB.addpre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{deptSelPersonBB.addnext}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{deptSelPersonBB.addlast}" styleClass="button01"></h:commandButton>
            <h:outputText value="  "></h:outputText>
           <h:commandButton value="确定" styleClass="button01" type="button" onclick="doOK();"></h:commandButton>
           <h:commandButton value="取消" styleClass="button01" type="button" onclick="doCancel();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{deptSelPersonBB.addPersonList}" var="list" width="100%" id="dateList"
                        styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                    <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.personId}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                  <f:verbatim>
		        	  <%=LanguageSupport.getResource("RYGL-2014","员工编码")%> 
                  </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personCode}"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                          <f:verbatim>
				        	  <%=LanguageSupport.getResource("RYGL-1016","姓名")%> 
		                  </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.name}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
				        	  <%=LanguageSupport.getResource("YXGL-1028","机构")%> 
		                     </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.orgId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                           <f:verbatim>
				        	  <%=LanguageSupport.getResource("YXGL-1029","部门")%> 
		                  </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.deptId}"/>
                    </h:column>
                     <h:column>
                    <f:facet name="header">
                         <f:verbatim>
				        	  <%=LanguageSupport.getResource("JGGL-1085","岗位")%> 
		                  </f:verbatim>
                    </f:facet>
                    <h:commandLink value="#{list.postType}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
                	</h:column>
                </h:dataTable>
    <c:verbatim>
        </div>
        </td></tr>
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
