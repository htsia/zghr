<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
       function add() {
    	   fPopUpMutiPostDlg(document.all("form1:postIds"), document.all("form1:postNames"),null); 
       }
       function selectPost(){
       	var str="";
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
                           if (str==""){
                               str+=chk[i].value;
                           }
                           else{
                               str+=","+chk[i].value;
                           }
                       }
                   }
               }
              if(str != null && str!=""){
             	 document.all("form1:itemIds").value =str;
             	 return true;
              }else{
           	  return false;
              }
              
           }else{
           	return false;
           }
           
       }
    </script>

<x:saveState value="#{xys_evaGroupMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaGroupMgrBB.initPost}"></h:inputHidden>
    <h:inputHidden value="#{xys_evaGroupMgrBB.groupId}"></h:inputHidden>
    <h:inputHidden id="postIds" value="#{xys_evaGroupMgrBB.postIds}"></h:inputHidden>
    <h:inputHidden id="itemIds" value="#{xys_evaGroupMgrBB.itemIds}"></h:inputHidden>
    <h:inputHidden id="postNames"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                  ��Ч���� ->������ά��
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{xys_evaGroupMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xys_evaGroupMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xys_evaGroupMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xys_evaGroupMgrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xys_evaGroupMgrBB.first1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaGroupMgrBB.pre1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaGroupMgrBB.next1}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_evaGroupMgrBB.last1}" styleClass="button01"></h:commandButton>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="����"  styleClass="button01" onclick="return add();" action="#{xys_evaGroupMgrBB.addPost}"></h:commandButton>
                <h:commandButton value=" ����ɾ�� "  styleClass="button01"  onclick="return selectPost();" action="#{xys_evaGroupMgrBB.deleteAll}"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{xys_evaGroupMgrBB.postList}" var="list" align="center" id="dateList"  rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
         <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.itemId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.postId}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
       
      
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="ɾ��" action="#{xys_evaGroupMgrBB.deletePost}" onclick="return confirm('ȷ��Ҫɾ��ѡ�и�λ��');"
                   styleClass="button01">
                  <x:updateActionListener property="#{xys_evaGroupMgrBB.itemId}" value="#{list.itemId}"/>
            </h:commandButton>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
