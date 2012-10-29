<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>

<script type="text/javascript">
      function doCheck(){
          if (document.all("form1:itemID").value==""){
              alert("必须选择引用字段!");
              return false;
          }
          if (document.all("form1:condType").value==""){
              alert("必须选择条件类型!");
              return false;
          }

          return true;
      }
    function doSelectInfoItem(itemNameObj,itemIDObj){
        debugger;
        if (document.all('form1:condType').value=='1'){
            selectInfoItem('B',itemNameObj,itemIDObj);
        }
        else if  (document.all('form1:condType').value=='2'){
            selectInfoItem('C',itemNameObj,itemIDObj);
        }
        else{
             selectInfoItem(document.all('form1:setType').value,itemNameObj,itemIDObj);
        }
    }
</script>
<x:saveState value="#{sys_itemRefBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{sys_itemRefBB.pageInit}"/>
    <h:inputHidden id="setType" value="#{sys_itemRefBB.setType}"/>

    <f:verbatim>
    <table  align="center" width="100%">
         <tr><td height=8 class="td_title" colspan="2">
             <img src="/images/tips.gif" >
              <%=LanguageSupport.getResource("XTGL-1233", " 设定引用关系")%>
         </td></tr>
     </table>

     <table  align="center" class="table03" width="98%">
        <tr><td  align="right" colspan="2" class="td_form01" height="28">
    </f:verbatim>
            <h:selectBooleanCheckbox value="#{sys_itemRefBB.saveSyn}"></h:selectBooleanCheckbox>
            <h:outputText value="保存时自动同步数据"></h:outputText>
            <h:commandButton value="保存" styleClass="button01" onclick="return doCheck();" action="#{sys_itemRefBB.save}"></h:commandButton>
            <h:commandButton value="取消定义" styleClass="button01" action="#{sys_itemRefBB.delete}" ></h:commandButton>
            <h:commandButton value="返回" type="button" styleClass="button01" onclick="window.close();"></h:commandButton>
     <f:verbatim>
         </td></tr>

         <tr><td class="td_form01">
           <%=LanguageSupport.getResource("XTGL-1235", "条件类型")%>
          </td>
          <td class="td_form02">
     </f:verbatim>
    
          <h:selectOneMenu id="condType" value="#{sys_itemRefBB.refbo.condType}">
              <c:selectItem itemValue="0" itemLabel="取当前值"></c:selectItem>
              <c:selectItem itemValue="1" itemLabel="关联机构"></c:selectItem>
              <c:selectItem itemValue="2" itemLabel="关联岗位"></c:selectItem>
              <c:selectItem itemValue="3" itemLabel="按条件取值"></c:selectItem>
          </h:selectOneMenu>
    
     <f:verbatim>
         </td></tr>

        <tr><td class="td_form01">
            <%=LanguageSupport.getResource("XTGL-1234", "引用字段")%>
         </td>

         <td class="td_form02">
    </f:verbatim>
         <h:inputHidden id="itemID" value="#{sys_itemRefBB.refbo.refId}"></h:inputHidden>
         <h:inputText id="itemName" value="#{sys_itemRefBB.refbo.refName}"></h:inputText>
         <h:commandButton type="button" onclick="doSelectInfoItem(document.all('form1:itemName'),document.all('form1:itemID'));" styleClass="button_select" ></h:commandButton>
    <f:verbatim>
        </td></tr>


        <tr>
        <td class="td_form01"> 
         <%=LanguageSupport.getResource("XTGL-1236", "条件语句")%>
        </td>
        <td class="td_form02">
           <table>
           <tr>
           <td>
            <%=LanguageSupport.getResource("XTGL-1152", "备选指标项")%>
               <input name="infoItemText" type="text" readonly  size="30">
               <input name="infoItemID" type="hidden"  >
               <input type="button" class="button_select" onclick="selectInfoItem(document.all('form1:setType').value,document.all('infoItemText'),document.all('infoItemID'))">
               <input type="button" class="button01" onclick="document.all('form1:condSQL').value+=document.all('infoItemID').value"  value="加入">
               <br>
               
                 <%=LanguageSupport.getResource("XTGL-1151", " 备选代码值")%>
               <input name="condValue" type="text" readonly dict_num='' code='' value=''>
               <input type="button" class="button_select" onclick="document.all('condValue').dict_num=document.all('infoItemID').value;PopUpCodeDlgOneControl('condValue')">
               <input type="button" class="button01" onclick="document.all('form1:condSQL').value+=document.all('condValue').code" value="加入">
           </td>
          </tr>
           <tr>
           <td>
    </f:verbatim>
        <h:inputTextarea value="#{sys_itemRefBB.refbo.condSQL}" id="condSQL" rows="8" cols="50"></h:inputTextarea>
    <f:verbatim>
            </td>
            </tr>
            <tr>
                <td>
                     <input type="button" class="button01" onclick="document.all('form1:condSQL').value='';"  value="<%=LanguageSupport.getResource("XTGL-1237", "清除")%>">
                     <input type="button" class="button01" onclick="document.all('form1:condSQL').value+='CurValue()';"  value="<%=LanguageSupport.getResource("XTGL-1238", "取当前记录值")%>">
                </td>
            </tr>
           </table>
        </td></tr>
    </table>
    </f:verbatim>
</h:form>
