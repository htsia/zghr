<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

    <script type="text/javascript">
        function selectPost(){
            document.all('form1:postid').value="";
            fPopUpPostDlg('form1:postid','form1:postiddes');
            if (document.all('form1:postid').value==""){
                alert("请选择岗位!")
                return false;
            }
            return true;
        }
       
        function selectRecuNeed(){
        	 var reval = window.showModalDialog("/recruit/needListQuery.jsf", null, "dialogWidth:"+screen.width*0.50+"px; dialogHeight:"+screen.height*0.60+"px;center:center;resizable:yes;status:no;scroll:no;");
     		if (reval != null && reval!="") {
             	var vars=reval.split("|");
             	document.all("form1:needStr").value = vars[1];
                return true;
             } else {
                 return false;
             }
        }
        function signCount(id){
            window.showModalDialog("/recruit/outterSignPersonCount.jsf?itemID="+id, null, "dialogWidth:350px; dialogHeight:260px; status:0;resizable:yes");
            document.all('form1:refresh').click();
            return true;
        }
        function addPost(){
        	window.showModalDialog("/recruit/outterAddPost.jsf?planId="+document.all("form1:planID").value, null, "dialogWidth:350px; dialogHeight:260px; status:0;resizable:yes");
        	document.all('form1:refresh').click();
        	return true;
        }
        function modifyPost(id){
        	window.showModalDialog("/recruit/outterAddPost.jsf?itemId="+id, null, "dialogWidth:350px; dialogHeight:260px; status:0;resizable:yes");
        	document.all('form1:refresh').click();
        	return true;
        }
    </script>

      <x:saveState value="#{recruit_outterPostBB}"></x:saveState>
      <h:form id="form1">
      <h:inputHidden id="initPublish" value="#{recruit_outterPostBB.initPublish}"></h:inputHidden>
      <h:inputHidden id="planID" value="#{recruit_outterPostBB.planId}"></h:inputHidden>
      <h:inputHidden id="needStr" value=""/>
      <h:commandButton id="refresh" value="刷新" style="display:none;"  action="#{recruit_outterPostBB.refresh}"></h:commandButton>
<c:verbatim>
          <table height=96% width=98% align="center">
          <tr><td height=8>
</c:verbatim>
          <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
             <h:panelGroup>
                  <h:graphicImage value="/images/tips.gif" />
                  <h:outputText value=" 招聘管理 ->  外部招聘"/>
              </h:panelGroup>
              <h:panelGrid align="right">
                  <h:inputHidden id="postid" value="#{recruit_outterPostBB.postid}"></h:inputHidden>
                  <h:inputHidden id="postiddes" ></h:inputHidden>
                  <h:panelGroup>
                  <h:commandButton value="导入需求" styleClass="button01" onclick="return selectRecuNeed();" action="#{recruit_outterPostBB.addNeed}" rendered="#{recruit_outterPostBB.modeType=='0'}"></h:commandButton>
                  <h:outputText value=" " rendered="#{recruit_outterPostBB.modeType=='0'}"></h:outputText>
                  <h:commandButton value="新增" styleClass="button01" onclick="return selectPost();" action="#{recruit_outterPostBB.addPost}" rendered="#{recruit_outterPostBB.modeType=='0'}"></h:commandButton>
                  <h:commandButton value="新增" styleClass="button01" type="button" onclick="return addPost();"  rendered="#{recruit_outterPostBB.modeType=='1'}"></h:commandButton>
                  </h:panelGroup>
              </h:panelGrid>
          </h:panelGrid>
<c:verbatim>
         </td></tr>

          <tr>
              <td>
                  <div style='width:100%;height:100%;overflow:auto' id=datatable>
</c:verbatim>
                      <x:dataTable value="#{recruit_outterPostBB.postlist}" var="list"  rowIndexVar="index" id="data"
                                           headerClass="td_top tr_fixrow"
                                           columnClasses="td_middle" styleClass="table03" width="95%" border="0">

                          <h:column>
                              <c:facet name="header"><h:outputText value="序号"/></c:facet>
                              <h:outputText value="#{index+1}"/>
                          </h:column>

                          <h:column>
                              <c:facet name="header"><h:outputText value="公布时间"/></c:facet>
                              <h:outputText value="#{list.publishDate}"/>
                          </h:column>
                          <h:column rendered="#{recruit_outterPostBB.modeType=='0'}">
                              <c:facet name="header"><h:outputText value="所在部门"/></c:facet>
                              <h:outputText value="#{list.deptname}"/>
                          </h:column>

                          <h:column rendered="#{recruit_outterPostBB.modeType=='0'}">
                              <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
                              <h:commandLink value="#{list.postName}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
                          </h:column>
                          <h:column rendered="#{recruit_outterPostBB.modeType=='1'}">
                              <c:facet name="header"><h:outputText value="岗位类型"/></c:facet>
                              <h:outputText value="#{list.postType}"/>
                          </h:column>
                          <h:column rendered="#{recruit_outterPostBB.modeType=='1'}">
                              <c:facet name="header"><h:outputText value="专业名称"/></c:facet>
                              <h:outputText value="#{list.majorType}"/>
                          </h:column>
						 <h:column>
                              <c:facet name="header"><h:outputText value="需求人数"/></c:facet>
                              <h:outputText value="#{list.needCount}"/>
                          </h:column>
                      	<h:column>
                            <c:facet name="header"><h:outputText value="操作"/></c:facet>
                            <h:commandButton value="填报人数" styleClass="button01" type="button" onclick="signCount('#{list.itemId}')" rendered="#{recruit_outterPostBB.modeType=='0'}"></h:commandButton>
                            <h:commandButton value="修改" styleClass="button01" type="button" onclick="return modifyPost('#{list.itemId}');"  rendered="#{recruit_outterPostBB.modeType=='1'}"></h:commandButton>
                 			<h:commandButton value="删除" styleClass="button01"  action="#{recruit_outterPostBB.delete}">
                                 <x:updateActionListener property="#{recruit_outterPostBB.itemID}" value="#{list.itemId}"/>
                            </h:commandButton>

                        </h:column>
                  </x:dataTable>
<c:verbatim>
                  </div>
              </td>
          </tr>
        </table>
</c:verbatim>
    </h:form>

<c:verbatim>
<script type="text/javascript">
    setDataTableOver("form1:data");
</script>
</c:verbatim>
