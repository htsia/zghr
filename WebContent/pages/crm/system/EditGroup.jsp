<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
    function forCheck(){
        if(document.all("form1:gpName").value == ""){
                alert("�Ŷ����Ʋ���Ϊ��!");
                document.all("form1:gpName").focus();
                return false;
               }
        }
</script>

<x:saveState value="#{groupBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{groupBB.editInit}"></h:inputHidden>
<f:verbatim>
<table   width="95%" border="0" align="center"   >
  <tr>
    <td    align="right">
     </f:verbatim>
           <h:commandButton value="����" onclick="return forCheck();"
              styleClass="button01" action="#{groupBB.saveOrUpdate}" />
               <f:verbatim>&nbsp;</f:verbatim>
           <h:commandButton value="����"  styleClass="button01" onclick="window.close();"/>
     <f:verbatim>
   </td>
  </tr>
  </table>
<table id= "tree"  width="95%" border="0" align="center"  class="table02">
  <tr>
    <td class="td_form01 ">�Ŷ����ƣ�</td>
    <td >
      </f:verbatim>
        <h:inputText id="gpName" styleClass="inputDark" value="#{groupBB.group.groupName}"></h:inputText>  
        <h:inputText style="display:none"  value="#{groupBB.group.groupId}" />   
     <f:verbatim> 
      </td>
  </tr>
  </table>
    </f:verbatim>
    </h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    