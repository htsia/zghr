<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">

       function add() {
            window.showModalDialog("/xys/eva/RelSetPostAdd.jsf?postId="+document.all('form1:postId').value, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
            window.showModalDialog("/xys/eva/RelSetPostEdit.jsf?relId="+id, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
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
             	 document.all("form1:relIds").value =str;
             	 return true;
              }else{
           	  return false;
              }
              
           }else{
           	return false;
           }
       }

    </script>

<x:saveState value="#{xys_evaRelSetMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaRelSetMgrBB.initEvaList}"></h:inputHidden>
    <h:inputHidden id="postId" value="#{xys_evaRelSetMgrBB.postId}"></h:inputHidden>
    <h:inputHidden id="relIds" value="#{xys_evaRelSetMgrBB.relIds}"></h:inputHidden>
     <c:verbatim>
         <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 ��Ч���� ->���˹�ϵ
           </td>
        </tr>
    </table>
       <table height=95% width=98% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
         <h:panelGrid align="left" columns="2">
             <h:panelGroup>
	            <h:outputText value="��λ���ƣ�#{xys_evaRelSetMgrBB.postName}"></h:outputText>
            </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
	            <h:commandButton value="���ӿ��˹�ϵ"  styleClass="button01"  onclick="add()"></h:commandButton>
	            <h:commandButton value=" ����ɾ�� "  styleClass="button01"  onclick="return selectPost();" action="#{xys_evaRelSetMgrBB.deleteAllRel}"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{xys_evaRelSetMgrBB.evaList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.relId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����"/></c:facet>
            <h:outputText value="#{list.evaPostId}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���˹�ϵ"/></c:facet>
            <h:outputText value="#{list.evaTypeDes}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modify('#{list.relId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" action="#{xys_evaRelSetMgrBB.deleteRel}" onclick="return confirm('ȷʵҪɾ���ÿ��˹�ϵ��');" styleClass="button01">
                   <x:updateActionListener property="#{xys_evaRelSetMgrBB.relId}" value="#{list.relId}"/>
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
