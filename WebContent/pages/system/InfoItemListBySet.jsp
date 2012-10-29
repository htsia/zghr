<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
       function setRef(itemID){
           window.showModalDialog("/system/ItemRefRelation.jsf?desField="+itemID, null, "dialogWidth:700px; dialogHeight:420px;center:center;resizable:yes;status:no;scroll:yes;");
           return false;
       }
       function setCodeRelation(itemID){
           window.showModalDialog("/system/ItemCodeRelation.jsf?desField="+itemID, null, "dialogWidth:700px; dialogHeight:420px;center:center;resizable:yes;status:no;scroll:yes;");
           return false;
       }
       function showProcessBar() {
          x = document.body.clientWidth / 2 - 150;
          y = document.body.clientHeight / 2;
          document.all('processbar').style.top = y;
          document.all('processbar').style.left = x;
          document.all('processbar').style.display = "";
          return true;
       }
       function addInfoItem(){
           window.showModalDialog("/system/InfoItemEditBySet.jsf?setId="+document.all('formInfoItemList:setId').value, null, "dialogWidth:800px; dialogHeight:520px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
       function modifyInfoItem(itemID){
           window.showModalDialog("/system/InfoItemEditBySet.jsf?itemId="+itemID+"&setId="+document.all('formInfoItemList:setId').value, null, "dialogWidth:800px; dialogHeight:520px;center:center;resizable:yes;status:no;scroll:yes;");
           return true;
       }
 </script>

<x:saveState value="#{sys_infoItemListBB}"/>
<h:form id="formInfoItemList">
    <h:inputHidden id="pageInit" value="#{sys_infoItemListBB.initBySet}"></h:inputHidden>
    <h:inputHidden id="setId" value="#{sys_infoItemListBB.setId}"></h:inputHidden>
    <h:inputHidden value="#{sys_infoItemListBB.set_sType}"></h:inputHidden>
    <c:verbatim>
    <table height=98% width=660>
        <tr>
            <td height=8 align=left>
    </c:verbatim>
			    <f:verbatim>
				    <strong><%=LanguageSupport.getResource("XTGL-1202","指标集")%> :</strong>
			    </f:verbatim>
                 <h:outputText value="#{sys_infoItemListBB.setNameEx}"/>
<c:verbatim>
             </td>
      </tr>
       <tr>
             <td align=left height=8>
</c:verbatim>
                <h:panelGroup>
                    <h:selectBooleanCheckbox value="#{sys_infoItemListBB.orderByName}" id="nameselect" onclick="submit()" valueChangeListener="#{sys_infoItemListBB.viewInfoitem}" />  
	                <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1007","按名称排序")%> 
				    </f:verbatim>
                    <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                    <h:selectBooleanCheckbox  value="#{sys_infoItemListBB.showOnlyUser}" onclick="submit()" valueChangeListener="#{sys_infoItemListBB.viewUserInfoitem}" />
                     <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1204","仅显示用户指标")%> 
				    </f:verbatim>
                    <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                    <h:selectBooleanCheckbox  value="#{sys_infoItemListBB.showOnlyOpen}" onclick="submit()" valueChangeListener="#{sys_infoItemListBB.viewOpenInfoitem}" />
                    <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1203","仅显示启用指标")%> 
				    </f:verbatim>
                    <c:verbatim>&nbsp;&nbsp;</c:verbatim>

                    <h:commandButton value="新 建" onclick="addInfoItem();" styleClass="button01" action="#{sys_infoItemListBB.queryInfoItems}" />
                    <h:commandButton value="删 除" action="#{sys_infoItemListBB.deleteInfoItems}" styleClass="button01"   onclick="return checkBatchDelete('selectItem')" />
                    <h:commandButton value="启 用" action="#{sys_infoItemListBB.makeStatusOpen}" styleClass="button01"  />
                    <h:commandButton value="禁 用" action="#{sys_infoItemListBB.makeStatusBan}" styleClass="button01"  />
                 </h:panelGroup>
<c:verbatim>
             </td>
       </tr>
        <tr><td height=8></td></tr>

        <tr><td >
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
            <h:dataTable value="#{sys_infoItemListBB.iItems}" var="list" id="dateList"
                     headerClass="td_top tr_fixrow" rowClasses="td_middle" styleClass="table03"   columnClasses="td_middle_left,td_middle_left"
                     border="0" align="left" width="100%">
            <h:column>
                <f:facet name="header">
                    <f:verbatim escape="false">
                        <input type="checkbox" name="all"
                               onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                    </f:verbatim>
                </f:facet>
                <f:verbatim escape="false">
                 <div align="center">    <input type="checkbox" name="selectItem" value="</f:verbatim>
                <h:outputText value="#{list.itemId}"/>
                <f:verbatim escape="false">"/></div></f:verbatim>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <f:verbatim>
					    <%=LanguageSupport.getResource("JGGL-1058","名称")%> 
				    </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.itemNameEx}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1003","范围")%> 
				    </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.itemScaleName}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                     <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1200","是否必填项")%> 
				    </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.itemNotNull}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                     <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1199","数据类型")%> 
				    </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.itemDataType}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                      <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1005","显示顺序")%> 
				    </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.itemSequence}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <f:verbatim>
					    <%=LanguageSupport.getResource("XTGL-1015","状态")%> 
				    </f:verbatim>
                </f:facet>
                <h:outputText escape="false" value="#{list.itemStatus}"/>
            </h:column>

            <h:column>
                <f:facet name="header">
                    <f:verbatim>
					   <%=LanguageSupport.getResource("YXGL-1026","操作")%>  
				    </f:verbatim>
                </f:facet>
                <h:panelGrid align="left" cellspacing="2" columns="3">
                    <h:commandButton value="修改" onclick="modifyInfoItem('#{list.itemId}');" action="#{sys_infoItemListBB.queryInfoItems}" styleClass="button01"  />
                </h:panelGrid>
            </h:column>
        </h:dataTable>
<c:verbatim>
        </div>
        </td></tr>
    </table>
</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("formInfoItemList:dateList");
</script>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>

