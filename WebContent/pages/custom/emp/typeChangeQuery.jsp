<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.sys.pojo.bo.WFTypeBO" %>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function selPerson(){
	window.showModalDialog("/custom/emp/selTypeChangePerson.jsf?act=init", null, "dialogWidth:600px; dialogHeight:270px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson(){
	  var str=" |";
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
                    if (i==0){
                        str+=chk[i].value;
                    }
                    else{
                        str+=","+chk[i].value;
                    }
                }
            }
        }
       if(str != null && str!=""){
      	 var vars=str.split("|");
      	 document.getElementById("form1:personStr").value = vars[1];
      }
    }
}
function effect(){
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
	                  if (i==0){
	                      str+=chk[i].value;
	                  }
	                  else{
	                      str+=","+chk[i].value;
	                  }
	              }
	          }
	      }
      	  document.getElementById("form1:typeChangeIDs").value = str;
	      return true;
      }
      else{
           alert("请选择要生效的人员！");
           return false;
       }
}

function selectPerson2(id){
    window.showModalDialog("/wage/adjust/CommonAdjustEdit.jsf?itemID="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}

</script>
					
<x:saveState value="#{empTypeChangeBB}" />
<h:form id="form1">
	<h:inputHidden id="pageInit" value="#{empTypeChangeBB.pageInit}" />
	<h:inputHidden id="typeChangeIDs" value="#{empTypeChangeBB.typeChangeIDs}" />
	<f:verbatim>
		<table height=96% width=100%>
			<tr>
				<td height=8>
					<table width="95%" borer=1>
						<tr>
							<td align="left">
							</f:verbatim> 
								<h:outputText escape="false" value="<strong>当前机构：#{empTypeChangeBB.orgName}</strong>"/>
					            <h:outputText value="  姓名或编号："/>
					            <h:inputText value="#{empTypeChangeBB.name}" size="15"/>
								<h:outputText value="  时间从"/>
								<h:inputText value="#{empTypeChangeBB.time}" id="time" styleClass="input Wdate" size="15"
										readonly="true" alt="日期|1|d|50||" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:time'})"
										onkeypress ="enterKeyDown('form1:time')"/>
								<h:outputText value="至"/>
								<h:inputText value="#{empTypeChangeBB.time2}" id="time2" styleClass="input Wdate" size="15"
										readonly="true" alt="日期|1|d|50||" onclick="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',el:'form1:time2'})"
										onkeypress ="enterKeyDown('form1:time2')"/>
							    <h:commandButton value="查询" styleClass="button01"  onclick="return disPlayProcessBar();"
										action="#{empTypeChangeBB.doQuery}"></h:commandButton>
							<f:verbatim>
							</td>
							<td align="right">
								</f:verbatim>
								<h:commandButton value="选择人员" styleClass="button01"
										onclick="return selPerson()" />
								<h:outputText value="  "/>
								
                                <h:commandButton value="人事信息生效"
									styleClass="button01" onclick="return effect();"
									action="#{empTypeChangeBB.effect}"/>
								<f:verbatim>
							</td>
						</tr>
						<tr>
							<td align="right" colspan="2">
							</f:verbatim>
                                   
								<h:panelGroup>
									<h:outputText value="生效"/>
									<h:selectBooleanCheckbox onclick="submit();" value="#{empTypeChangeBB.apprived}" valueChangeListener="#{empTypeChangeBB.queryApprived}"/>
									<h:outputText value="  "/>									
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1043","记录数")%>:
              	</f:verbatim>
									<h:outputText value="#{empTypeChangeBB.mypage.totalRecord}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1044", "页数")%>:
              	</f:verbatim>
									<h:outputText value="#{empTypeChangeBB.mypage.totalPage}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1045","每页有")%>
									</f:verbatim>
									<h:outputText value="#{empTypeChangeBB.mypage.pageSize}"></h:outputText>
									<h:outputText value="  "></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1046","当前为第")%>
									</f:verbatim>
									<h:outputText value="#{empTypeChangeBB.mypage.currentPage}"></h:outputText>
									<f:verbatim>
										<%=LanguageSupport.getResource("COMM-1047", "页")%>
									</f:verbatim>
									<h:commandButton value="首页"
										action="#{empTypeChangeBB.first}" styleClass="button01"></h:commandButton>
									<h:commandButton value="上页" action="#{empTypeChangeBB.pre}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="下页" action="#{empTypeChangeBB.next}"
										styleClass="button01"></h:commandButton>
									<h:commandButton value="尾页" action="#{empTypeChangeBB.last}"
										styleClass="button01"></h:commandButton>
									<h:outputText value="  "></h:outputText>
								</h:panelGroup>
							    <f:verbatim>
							</td>
						</tr>
					</table></td>
			</tr>

			<tr>
				<td>
					<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
						</f:verbatim>
						<h:dataTable value="#{empTypeChangeBB.list}"
							var="list" align="center" id="dateList"
							headerClass="td_top tr_fixrow"
							columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
							styleClass="table03" width="95%">
							<h:column>
								<f:facet name="header">
									<f:verbatim escape="false">
										<input type="checkbox" name="all"
											onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)" />
									</f:verbatim>
								</f:facet>
								<f:verbatim escape="false">
									<div align="center">
										<input type="checkbox" name="selectItem"
											value="</f:verbatim>
                    <h:outputText value="#{list.typeChangeID}"/>
                    <f:verbatim escape="false">" />
									</div>
								</f:verbatim>
							</h:column>

							<h:column>
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("MSG-0010", "姓名")%>
								</f:verbatim>
								</c:facet>
								<f:verbatim>
                                    <a href="javascript:forModifyPersonDetail('</f:verbatim><h:outputText value="#{list.personID}" /><f:verbatim>')">
                                </f:verbatim>
                                    <h:outputText value="#{list.name}" />
                                <f:verbatim>
                                    </a>
                                </f:verbatim>
                            </h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="员工编号"/>
								</c:facet>
								<h:outputText value="#{list.personCode}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="所在单位"/>
								</c:facet>
								<h:outputText value="#{list.orgName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="所在部门"/>
								</c:facet>
								<h:outputText value="#{list.deptName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="原人员类别"/>
								</c:facet>
								<h:outputText value="#{list.oldTypeDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="新人员类别"/>
								</c:facet>
								<h:outputText value="#{list.newTypeDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="申请日期"/>
								</c:facet>
								<h:outputText value="#{list.changeDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="生效日期"/>
								</c:facet>
								<h:outputText value="#{list.changedDate}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<h:outputText value="操作人"/>
								</c:facet>
								<h:outputText value="#{list.applyPersonName}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("XTGL-1051", "状态")%>
								</f:verbatim>
								</c:facet>
								<h:outputText value="#{list.statusDes}" />
							</h:column>
							<h:column>
								<c:facet name="header">
								<f:verbatim>
								    <%=LanguageSupport.getResource("YXGL-1026", "操作")%>
								</f:verbatim>
								</c:facet>
								<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
									action="#{empTypeChangeBB.delete}" styleClass="button01">
									<x:updateActionListener value="#{list.typeChangeID}"
										property="#{empTypeChangeBB.operID}"/>
								</h:commandButton>
								<h:commandButton value="拟定薪资" styleClass="button01"
									onclick="return selectPerson2('#{list.linkAdjustID}');"
									rendered="#{list.status=='0'}" />
							</h:column>
						</h:dataTable>
						<f:verbatim>
					</div></td>
			</tr>
		</table>
	</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
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
