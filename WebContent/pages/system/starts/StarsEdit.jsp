<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function AddAttech() {
        if (document.all('form1:title').value==null){
            alert("请输入标题");
            return false;
        }
        if (document.all('form1:excelFile').value==null){
            alert("请选择文件");
            return false;
        }
        return true;
     }
</script>

<x:saveState value="#{sys_StarsBB}"/>
      <h:form id="form1" enctype="multipart/form-data">
 	  <h:inputHidden value="#{sys_StarsBB.pageInit}" />
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" columns="2">
          <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
				<%=LanguageSupport.getResource("XTGL-0900", "系统管理")%>->
				<%=LanguageSupport.getResource("XTGL-0953", "员工风采")%>->
				<%=LanguageSupport.getResource("XTGL-1367", "信息修改")%>
			</f:verbatim>
            </h:panelGroup>

          <h:panelGrid border="0" columns="2" cellpadding="0" align="right">
              <h:panelGroup>
                  <h:commandButton value="发布" action="#{sys_StarsBB.save}" styleClass="button01" />
                  <h:commandButton value="返回" onclick="window.close()" type="button" styleClass="button01" />
              </h:panelGroup>
          </h:panelGrid>

       </h:panelGrid>

        <f:verbatim>
            <br>

        <table border="0"  align="center" cellspacing="2"    class="table03" cellpadding="10"	>
			<tr>
                <td class="td_form01" width=60px>
                <%=LanguageSupport.getResource("XTGL-1315",  "显示单位范围")%>
                    </td>
                <td class="td_form02" >
        </f:verbatim>
                    <h:panelGroup>
                        <h:selectOneMenu id="orgID" value="#{sys_StarsBB.starsbo.orgID}">
                            <c:selectItems value="#{sys_StarsBB.orgList}"></c:selectItems>
                        </h:selectOneMenu>
                    </h:panelGroup>
        <f:verbatim>
                </td>

                <td class="td_form01">
                  <%=LanguageSupport.getResource("MSG-0010",  "姓名")%>
               </td>
                <td class="td_form02">
        </f:verbatim>
                    <h:inputHidden id="itemID" value="#{sys_StarsBB.starsbo.itemID}"></h:inputHidden>
                    <h:inputHidden id="recID" value="#{sys_StarsBB.starsbo.persID}"></h:inputHidden>
                    <h:inputText readonly="true" id="name" styleClass="input" value="#{sys_StarsBB.starsbo.persName}" />
                    <h:commandButton  styleClass="button01" value="选择人员" action="#{sys_StarsBB.addPerson}" onclick="return fPopUpPerDlg('form1:name', 'form1:recID', '','1');"></h:commandButton>
<f:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">
                  <%=LanguageSupport.getResource("XTGL-1101",  "是否显示")%>
                  </td>
                <td class="td_form02" >
</f:verbatim>
                    <h:panelGroup>
                        <h:selectOneMenu id="isShow" value="#{sys_StarsBB.starsbo.isShow}">
                            <c:selectItem itemValue="0" itemLabel="不显示"></c:selectItem>
                            <c:selectItem itemValue="1" itemLabel="显示"></c:selectItem>
                        </h:selectOneMenu>
                    </h:panelGroup>
<f:verbatim>
                </td>

                <td class="td_form01">
                	 <%=LanguageSupport.getResource("XTGL-1005",  "显示顺序")%>
                 </td>
                <td class="td_form02">
</f:verbatim>
                    <h:inputText  id="showseq" styleClass="input" value="#{sys_StarsBB.starsbo.showseq}" />
<f:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">
                 <%=LanguageSupport.getResource("XTGL-1102",  "事迹")%>
                </td>
                <td class="td_form02" colspan=3>
</f:verbatim>
                 <h:inputTextarea id="textarea" rows="10" cols="80" value="#{sys_StarsBB.starsbo.story}" />
<f:verbatim>
                </td>
            </tr>

            <tr>
            <td class="td_form01">
                <%=LanguageSupport.getResource("XTGL-1368",  "图片")%>
            </td>
            <td class="td_form02" colspan=3>
                <table>
                <tr><td>
</f:verbatim>
                  <h:inputHidden id="file" value="#{sys_StarsBB.starsbo.photoFile}"></h:inputHidden>
                  <h:graphicImage value="/images/maininterface/stars/#{sys_StarsBB.starsbo.photoFile}"  />
<f:verbatim>
                </td></tr>
                 <tr><td>
</f:verbatim>
                  <x:inputFileUpload id="blobFile" styleClass="input" value="#{sys_StarsBB.blobFile}"  storage="file" size="25" />
<f:verbatim>
                  </td></tr>
                </table>
           </td>
           </tr>

            <tr>
            <td class="td_form01">
                <%=LanguageSupport.getResource("XTGL-1301",  "附件列表")%>
                </td>
            <td class="td_form02" colspan=3 align="right">
                <br>
                <%=LanguageSupport.getResource("XTGL-1105",  "标题")%>
</f:verbatim>
                <h:inputText id="title" value="#{sys_StarsBB.title}"/>
                <x:inputFileUpload styleClass="input" id="excelFile" value="#{sys_StarsBB.excelFile}"  storage="file" size="25" />
                <h:commandButton   styleClass="button02" value="上传" onclick="return AddAttech();" action="#{sys_StarsBB.uploadFile}"/>
                <f:verbatim><br><br></f:verbatim>
                <h:dataTable value="#{sys_StarsBB.attList}" var="list" align="center"
                                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                                 styleClass="table03" width="98%" >
                        <h:column>
                            <c:facet name="header">
                                <f:verbatim>
			                       	<%=LanguageSupport.getResource("XTGL-1099", "序号")%>
			                     </f:verbatim>
                            </c:facet>
                            <h:outputText value="#{list.index}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header">
                              <f:verbatim>
			                       	<%=LanguageSupport.getResource("XTGL-1015", "描述")%>
			                     </f:verbatim>
                            </c:facet>
                            <h:outputText value="#{list.attTitle}"/>
                        </h:column>

                        <h:column>
                            <c:facet name="header">
                            <f:verbatim>
			                       	<%=LanguageSupport.getResource("YXGL-1026", "操作")%>
			                </f:verbatim>
                           </c:facet>
                                <h:commandButton value="删除" styleClass="button01"  action="#{sys_StarsBB.deleteAtt}" onclick="return confirm('确认删除？')">
                                    <x:updateActionListener property="#{sys_StarsBB.index}" value="#{list.index}"/>
                                </h:commandButton>
                        </h:column>
                 </h:dataTable>
<f:verbatim>
            </td>
        </tr>
       </table>
</f:verbatim>
	</h:form>


