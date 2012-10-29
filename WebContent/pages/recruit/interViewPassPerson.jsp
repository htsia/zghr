<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>

<script type="text/javascript">
	function doOK(){
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
	        document.all("form1:alldetailId").value = str;
	        return true;
	    }else{
	        alert("请选择要加入的人员!");
	        return false;
	    }
	}
    function showResult(personId,staus){
	   window.showModalDialog("/recruit/resumeDetail2.jsf?personId="+personId+"&status="+staus, "", "dialogHeight="+screen.height*0.7+"px; dialogWidth="+screen.width*0.7+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=yes;location=no; status=no");
       return true;
   }
</script>
<x:saveState value="#{interviewPersonApplayBB}" />
<h:form id="form1">
	<h:inputHidden value="#{interviewPersonApplayBB.initPassEdit}"></h:inputHidden>
	<c:verbatim>
		<table height="98%" width="98%" align="center">
			<tr>
				<td height="8"></c:verbatim> <h:panelGrid align="right" columns="2">
					<h:panelGroup>
						<h:selectBooleanCheckbox value="#{interviewPersonApplayBB.selectAll}" onclick="submit();" valueChangeListener="#{interviewPersonApplayBB.queryAll}" />
						<h:outputText value="显示全部"/>
						<h:outputText value=" "/>
						<h:outputText value="记录数:#{interviewPersonApplayBB.mypage.totalRecord}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="页数:#{interviewPersonApplayBB.mypage.totalPage}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="每页有#{interviewPersonApplayBB.mypage.pageSize}"></h:outputText>
						<h:outputText value="  "></h:outputText>
						<h:outputText value="当前为第#{interviewPersonApplayBB.mypage.currentPage}页"></h:outputText>
						<h:commandButton value="首页" action="#{interviewPersonApplayBB.first}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="上页" action="#{interviewPersonApplayBB.pre}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="下页" action="#{interviewPersonApplayBB.next}"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="尾页" action="#{interviewPersonApplayBB.last}"
							styleClass="button01"></h:commandButton>
					</h:panelGroup>
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim> 
				
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01" align="center" styleClass="table03">
            <h:panelGroup>
				<h:commandButton styleClass="button01" value="批量上报" action="#{interviewPersonApplayBB.applayOneMore}" onclick="return doOK();" />
	             <h:outputText value=" "/>
	            <h:commandButton value="计算面试得分" styleClass="button01" action="#{interviewPersonApplayBB.caclScore}">
                </h:commandButton>
	            <h:inputHidden id="alldetailId" value=""></h:inputHidden>
            </h:panelGroup>
	</h:panelGrid>
				<x:dataTable value="#{interviewPersonApplayBB.personList}" width="100%"
					var="list" rowIndexVar="index" align="center" id="dateList"
					headerClass="td_top"
					columnClasses="td_middle,td_middle_center,td_middle,td_middle_center,td_middle"
					styleClass="table03">
					<h:column>
						<f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.detailId}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="序号" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.personName}" />
					</h:column>
					<h:column rendered="#{interviewPersonApplayBB.postMode=='0'}">
						<c:facet name="header">
							<h:outputText value="岗位名称" />
						</c:facet>
						<h:outputText value="#{list.postName}" />
					</h:column>
                    <h:column rendered="#{interviewPersonApplayBB.postMode=='1'}">
						<c:facet name="header">
							<h:outputText value="岗位类型" />
						</c:facet>
						<h:outputText value="#{list.postType}" />
					</h:column>
                    <h:column rendered="#{interviewPersonApplayBB.postMode=='1'}">
						<c:facet name="header">
							<h:outputText value="专业" />
						</c:facet>
						<h:outputText value="#{list.majorType}" />
					</h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="面试得分" />
						</c:facet>
						<h:outputText value="#{list.ivScore}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="打分情况" />
						</c:facet>
						<h:outputText value="#{list.ivScoreDes}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="状态" />
						</c:facet>
						<h:outputText value="#{list.statusDes}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="拟录人员上报" styleClass="button01" rendered="#{list.status==3}" action="#{interviewPersonApplayBB.applay}">
							<x:updateActionListener property="#{interviewPersonApplayBB.detailId}" value="#{list.detailId}" />
						</h:commandButton>
                        <h:commandButton value="简历信息"  styleClass="button01" onclick="return showResult('#{list.personId}','#{list.status}');"/>
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>