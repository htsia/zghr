<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"  %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

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
            
            var vars=str.split("|");
        	document.all('form1:personStr').value=vars[1];
        }
        else{
            alert("��ѡ��Ҫ�������Ա!");
        }
    }

    function doCancel() {
       window.close();
    }
    function forViewPost(id) {
        windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
    }
</script>
<x:saveState value="#{teamMgrBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{teamMgrBB.initAdd}"></h:inputHidden>
    <h:inputHidden id="personStr"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td height=8>
        </td></tr>

        <tr><td height=8 align="left">
  
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
              <f:verbatim>
               <%=LanguageSupport.getResource("COMM-1048","��")%>
              </f:verbatim>
            <h:outputText value="#{teamMgrBB.pagevo.totalPage}"></h:outputText>
             <f:verbatim>
               <%=LanguageSupport.getResource("COMM-1047","ҳ")%>
              </f:verbatim>
            <h:outputText value="  "></h:outputText>
             <f:verbatim>
               <%=LanguageSupport.getResource("COMM-1045","ÿҳ��")%>
              </f:verbatim>
            <h:outputText value="#{teamMgrBB.pagevo.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <f:verbatim>
               <%=LanguageSupport.getResource("COMM-1046","��ǰΪ��")%>
              </f:verbatim>
            <h:outputText value="#{teamMgrBB.pagevo.currentPage}"></h:outputText>
             <f:verbatim>
               <%=LanguageSupport.getResource("COMM-1047","ҳ")%>
              </f:verbatim>
            <h:commandButton value="��ҳ" action="#{teamMgrBB.addfirst}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{teamMgrBB.addpre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{teamMgrBB.addnext}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{teamMgrBB.addlast}" styleClass="button01"></h:commandButton>
            <h:outputText value="  "></h:outputText>
           <h:commandButton value="ȷ��" styleClass="button01"  onclick="doOK();" action="#{teamMgrBB.addPerson}"></h:commandButton>
           <h:commandButton value="����" styleClass="button01"   onclick="doCancel();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{teamMgrBB.addPersonList}" var="list" width="100%" id="dateList"
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
                               <%=LanguageSupport.getResource("RYGL-2014","Ա������")%> 
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personCode}"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
                               <%=LanguageSupport.getResource("RYGL-1016","����")%> 
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.name}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                           <f:verbatim>
                               <%=LanguageSupport.getResource("RYGL-2399","����")%> 
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.orgId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                               <f:verbatim>
                               <%=LanguageSupport.getResource("GWGL-1017","����")%> 
                            </f:verbatim>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.deptId}"/>
                    </h:column>
                     <h:column>
                    <f:facet name="header">
                     <f:verbatim>
                               <%=LanguageSupport.getResource("RYGL-2400","��λ")%> 
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
