<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
   <f:verbatim>
    <script type="text/javascript" language="javascript">
        function refreshList(sType) {
              document.all('stype').value=sType;
              if (document.all('showUse').checked){
                   document.list.location = "/system/InfoSetList.jsf?onlyUse=true&stype="+sType;
              }
              else{
                   document.list.location = "/system/InfoSetList.jsf?onlyUse=false&stype="+sType;
              }
        }
        function doExportInfoset(){
            window.showModalDialog("/system/SetInfoToExport.jsf", null, "dialogWidth:400px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        function changeStatus(){
            if (document.all('showUse').checked){
                document.tree.location.href = "/system/InfoSetTypeTree.jsf?onlyUse=true";
                document.list.location = "/system/InfoSetList.jsf?onlyUse=true&stype="+document.all('stype').value;
            }
            else{
                document.tree.location.href = "/system/InfoSetTypeTree.jsf";
                document.list.location = "/system/InfoSetList.jsf?onlyUse=false&stype="+document.all('stype').value;
            }
        }
    </script>

   <table width="100%"  height="100%" border="0" cellpadding="0" cellspacing="0">
       <tr height=20>
          <td colspan=2 class="td_title"><img src="/images/tips.gif"> 
              <%=LanguageSupport.getResource("XTGL-0900","系统管理")%> ->
              <%=LanguageSupport.getResource("XTGL-0905","指标管理")%>  
           
           </td>
          <td  class="td_title" align="right">
               <input id="showUse" type="checkbox" checked onclick="changeStatus();">
               <%=LanguageSupport.getResource("XTGL-1000"," 仅显示启用指标集")%>  
                                   
              <h:inputHidden id="stype"></h:inputHidden>
    </f:verbatim>
              <h:commandButton styleClass="button01" onclick="doExportInfoset()" type="button" value="导出结构信息"></h:commandButton>
<f:verbatim>
          </td>
       </tr>

       <tr>
           <td width="200" align="center" valign="top" class="explorer" id="showTree">
                 <iframe name="tree" scrolling="auto" frameborder="0"  width="100%"  height="100%" src="/system/InfoSetTypeTree.jsf?onlyUse=true" ></iframe>
           </td>

           <td width="10" class="ctrlbar" valign="middle">
               <img id="ctrlBnt" src="<%=request.getContextPath()%>/images/button_1.gif" onclick="ctrlbar()" style="cursor:pointer" alt="">
           </td>

           <td align="center" valign="top" class="explorer">
                 <iframe name="list" scrolling="auto" frameborder="0"  width="100%" height="100%" src="/system/InfoSetList.jsf?onlyUse=true"></iframe>
           </td>
     </tr>
   </table>
</f:verbatim>    
