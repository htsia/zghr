<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function forSave(){
	 if (forCheck()== true) {
       forsubmit(document.forms(0));
       return true ;
   }
	 else {
		  return false ;
       }
	   }

function forCheck(){

   if(document.all("form1:name").value == ""){
           alert("公司名字不能为空!");
           document.all("form1:name").focus();
           return false;
          }
   if(document.all("form1:cu_nation").value == ""){
       alert("国籍不能为空!");
       document.all("form1:cu_nation").focus();
       return false;
      }
   if(document.all("form1:cu_city").value == ""){
       alert("城市不能为空!");
       document.all("form1:cu_city").focus();
       return false;
      }
   else{
       return true ;
       }  
       true ;
   }

</script>
<x:saveState value="#{competitionBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{competitionBB.editInit}"></h:inputHidden>
     <h:inputHidden value="#{competitionBB.compeId}"></h:inputHidden>
<f:verbatim>
  
   <table width="101%">
	    <tr>
		    <td class="td_title" width="100%"></f:verbatim>
		       <h:graphicImage value="/images/tips.gif"  />
			   <h:outputText value="竞争对手 - > 编辑" ></h:outputText></td>
		      <f:verbatim>
		    </tr>
	    
  </table>
  
  <table id= "tree"  width="95%" border="0" align="center" >
  <tr>
    <td colspan="4"  align="right">
     </f:verbatim>
           <h:commandButton value="保存"
            onclick="return forSave();"  styleClass="button01" action="#{competitionBB.saveOrUpdateCompetitionBO}" />
            <f:verbatim>&nbsp;</f:verbatim>
           <h:commandButton value="返回"  styleClass="button01" onclick="window.close();"/>
     <f:verbatim>
    </td>
  </tr>
  </table>

  <table id= "tree"  width="95%" border="1" align="center"  class="table03">
  
  <tr>
    <td class="td_form01 td_form_required">公司名称：</td>
    <td >
      </f:verbatim>
        <h:inputText id="name" styleClass="inputDark" value="#{competitionBB.competitionBO.compeName}"></h:inputText>     
     <f:verbatim> 
      
    </td>
  
    <td class="td_form01 td_form_required">国&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;籍：</td>
    <td > </f:verbatim>
        <h:inputText styleClass="inputDark" id="cu_nation" code="" dict="yes" dict_num="0106"
                     readonly="true"
                     value="#{competitionBB.competitionBO.nation}"></h:inputText>    
       <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:cu_nation')" />
                      
     <f:verbatim> 
     </td>
  </tr>
  <tr>
    <td class="td_form01 ">邮编：</td>
    <td> 
     </f:verbatim>
        <h:inputText styleClass="inputDark" value="#{competitionBB.competitionBO.zip}"></h:inputText>     
     <f:verbatim>
     </td>
    <td class="td_form01 td_form_required">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：</td>
    <td>
    
    </f:verbatim>
        <h:inputText  styleClass="inputDark" id="cu_city" code="" dict="yes" dict_num="0105"
                     readonly="true"
                     value="#{competitionBB.competitionBO.city}"></h:inputText> 
        <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:cu_city')" />          
     <f:verbatim>
   </td >
  </tr>
  
  <tr>
    <td class="td_form01 ">地址：</td>
    <td colspan="3"> </f:verbatim>
        <h:inputText styleClass="inputDark" value="#{competitionBB.competitionBO.compeAddr}" size="69"></h:inputText>     
     <f:verbatim> </td>
  </tr>
  <tr>
    <td class="td_form01 ">网站：</td>
    <td colspan="3"> </f:verbatim>
        <h:inputText styleClass="inputDark" value="#{competitionBB.competitionBO.webUrl}" size="69"></h:inputText>     
     <f:verbatim> </td>
  </tr>
  <tr>
    <td height="17" colspan="4" class="td_form01 ">描述：<br>
    </f:verbatim>
        <h:inputTextarea value="#{competitionBB.competitionBO.description}" rows="10" cols="82">
        </h:inputTextarea>
     <f:verbatim>
    </td>
  </tr>
  
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>

















