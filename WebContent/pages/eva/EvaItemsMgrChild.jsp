<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<c:verbatim><script language=javascript src="/js/list.js"></script></c:verbatim>

<script type="text/javascript">
    function doAddItem(){
        var setID=document.all('form1:setID').value;
        if (setID==null || setID==""){
            alert("请先选择类别！");
            return false;
        }
        window.showModalDialog("/eva/itemKeyEdit.jsf?setID="+setID, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyItem(id){
        window.showModalDialog("/eva/itemKeyEdit.jsf?itemID="+id, null, "dialogWidth:700px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eva_itemKeyBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{eva_itemKeyBB.initList}"></h:inputHidden>
      <h:inputHidden id="setID" value="#{eva_itemKeyBB.setID}"></h:inputHidden>
      <c:verbatim>
          <table height="98%" width="98%" cellspacing="0" cellpadding="0" align="center">
		  <tr><td height=38 align="right" valign="middle">
    </c:verbatim>
                <h:commandButton value="增加" styleClass="button01" onclick="doAddItem();"></h:commandButton>
     <c:verbatim>
          </td></tr>

         <tr><td>
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
     </c:verbatim>
          <x:dataTable value="#{eva_itemKeyBB.itemList}"  id="dateList"  width="1060"
				headerClass="locked_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="0"
                columnClasses="td_middle_center_lock,td_middle_center_lock,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" >

              <x:column width="80" >
                    <f:facet name="header" >
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton value="修改" onclick="doModifyItem('#{briefList.itemID}');" styleClass="button01"></h:commandButton>
                    <h:commandButton value="删除" onclick="return confirm('确定要删除吗？')" styleClass="button01" action="#{eva_itemKeyBB.deleteItem}">
                          <x:updateActionListener property="#{eva_itemKeyBB.itemID}" value="#{briefList.itemID}"/>
                    </h:commandButton>
                </x:column>

               <x:column width="200">
					<f:facet name="header">
						<h:outputText value="指标名称" />
					</f:facet>
                    <h:outputText value="#{briefList.itemName}" ></h:outputText>
                </x:column>

              <x:column width="180">
                  <f:facet name="header">
                      <h:outputText value="指标类型" />
                  </f:facet>
                  <h:selectOneRadio value="#{briefList.itemType}" disabled="true">
                      <c:selectItem itemValue='0' itemLabel='定性'></c:selectItem>
                      <c:selectItem itemValue='1' itemLabel='定量'></c:selectItem>
                      <c:selectItem itemValue='2' itemLabel='计算'></c:selectItem>
                  </h:selectOneRadio>
              </x:column>

              <x:column width="120">
                  <f:facet name="header">
                      <h:outputText value="是否有效" />
                  </f:facet>
                  <h:selectOneRadio value="#{briefList.validFlag}" disabled="true">
                      <c:selectItem itemValue='0' itemLabel='无效'></c:selectItem>
                      <c:selectItem itemValue='1' itemLabel='有效'></c:selectItem>
                  </h:selectOneRadio>
              </x:column>

              <x:column width="60">
                  <f:facet name="header">
                      <h:outputText value="显示顺序" />
                  </f:facet>
                  <h:outputText value="#{briefList.showSEQ}" ></h:outputText>
              </x:column>

              <x:column width="200">
                  <f:facet name="header">
                      <h:outputText value="描述" />
                  </f:facet>
                  <h:outputText value="#{briefList.itemDes}" ></h:outputText>
              </x:column>

              <x:column width="60">
                  <f:facet name="header">
                      <h:outputText value="分数低限" />
                  </f:facet>
                  <h:outputText value="#{briefList.lowValue}" ></h:outputText>
              </x:column>

              <x:column width="60">
                  <f:facet name="header">
                      <h:outputText value="分数高限" />
                  </f:facet>
                  <h:outputText value="#{briefList.highValue}" ></h:outputText>
              </x:column>

			</x:dataTable>
	  <c:verbatim>
		   </div>
           </td></tr>
         </table>
         </c:verbatim>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
   tableFixCol=2;// 锁定两列
   listControl=document.all("form1:dateList");
   window.setInterval('setFixCol()', 700);
</script>


