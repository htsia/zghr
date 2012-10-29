<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
    function doSetConst(){
        var url="/wage/set/SetConst.jsf?setId=WAGE_DATACHECK&setName=数据检查参数";
        //alert(url);
        window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }

    function showInvalidData(checkId){
       var dateId=form1.all("form1:dateId").value;
       window.showModalDialog("/wage/payoff/showInvalidDate.jsf?dateId="+dateId+"&setID=" + document.all('form1:setID').value+"&CHKID="+checkId, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    function doCheck(){
        if (checkMutilSelect(form1.selItems)) {
            count = form1.selItems.length;
            var str = "";
            if (count != null) {
                for (i = 0; i < count; i++)
                    if (form1.selItems[i].checked) {
                        str += form1.selItems[i].value;
                    }
            } else
                str = form1.selItems.value;
            document.all("form1:selestr").value=str;
            return true;
        } else {
            alert("请选择检查项目！");
            return false;
        }
    }
</script>

<x:saveState value="#{wage_dataCheckBB}"/>
   <h:form id="form1" >
        <h:inputHidden value = "#{wage_dataCheckBB.pageInit}"></h:inputHidden>
        <h:inputHidden id="setID" value = "#{wage_dataCheckBB.setId}"></h:inputHidden>
        <h:inputHidden id="dateId" value = "#{wage_dataCheckBB.dateId}"></h:inputHidden>
        <h:inputHidden id="selestr"></h:inputHidden>
        <h:panelGrid width="100%" columns="2"  >
            <h:panelGrid align="right" columns="1">
                <h:panelGroup>
                    <h:commandButton value="检查参数" type="button" onclick="doSetConst()" styleClass="button01"/>
                    <h:commandButton value="开始检查" onclick="doCheck();" action="#{wage_dataCheckBB.checkData}"  styleClass="button01"/>
                </h:panelGroup>
             </h:panelGrid>
        </h:panelGrid>

		<h:panelGrid width="98%" columns="1" align="center">
				<h:panelGroup>
					<h:dataTable value="#{wage_dataCheckBB.checkList}" var="cklist" width="98%"  id="dateList"
                                 styleClass="table03" headerClass="td_top"  border="1" columnClasses="center,left" align="center" >

					    <h:column >
                            <f:facet name="header" >
                               <f:verbatim escape="false"><input style="width:30px;" type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selItems)"/>                                        </f:verbatim>
                            </f:facet>
                            <f:verbatim escape="false"><input style="width:30px;" type="checkbox" name="selItems" value="</f:verbatim><h:outputText value="#{cklist.checkId}"></h:outputText><f:verbatim>"></f:verbatim>
                        </h:column>

						<h:column>
							<f:facet name="header">
								<h:outputText value="检查事项" />
							</f:facet>
							<h:outputText value="#{cklist.checkDesc}" />
						</h:column>

                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="检查参数" />
                            </f:facet>
                            <h:outputText value="#{cklist.refParaDes}" />
                        </h:column>

                        <h:column>
                            <f:facet name="header">
                                <h:outputText value="不符合数据" />
                            </f:facet>
                            <h:commandLink  value="#{cklist.count}" rendered="#{cklist.haveData}" onclick="showInvalidData('#{cklist.checkId}');"/>
                        </h:column>

					</h:dataTable>
				</h:panelGroup>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>