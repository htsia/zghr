<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<script type="text/javascript">
         function clearws() {
		    document.getElementById("checkSubmitFlg").value="0"; 
        }
        function clearStatew() {
            setInterval("clearws()",2000);
        }
        function openPersonDoc(){
        	var perId = document.all("form1:personId").value;
        	window.open('/doc/OrgBasicInfo.jsf?fk='+perId+"&print=1",'newwindow','top=0,left=0,toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,location=no,status=yes');
        }
         function OpenRpt(){
             if (document.all("form1:ReportID").value=="-1"){
                 alert("请先选择表格样式！");
                 return false;
             }
             doShowOrgTable(document.all("form1:ReportID").value,document.all('form1:personId').value);
             return false;
         }
    
</script>
<c:verbatim>
<style type="text/css">
<!--
.style1
{
    font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border:2px solid #555555;
}
.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555; 
	border:1px solid #555555;
}
.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	vertical-align:middle;
	font-family: "宋体";
	border:1px solid #555555;
}
-->
</style>
</c:verbatim>

<x:saveState value="#{doc_OrgBrowseBackingBean}" />
<h:form id="form1">
	<h:inputHidden value="#{doc_OrgBrowseBackingBean.pageInit}" />
	<h:inputHidden id = "personId" value="#{doc_OrgBrowseBackingBean.orgId}"/>
	<h:panelGrid width="98%" align="center" columns="1" cellpadding="0"		cellspacing="0">
        <h:panelGrid align="center" columns="3" cellspacing="3" >
            <h:commandButton value="打印" type="button" id="print"
                onclick="clearStatew();openPersonDoc();"
                styleClass="button01" />

            <h:selectOneMenu id="ReportID" style="width:190px">
                <c:selectItems value="#{doc_OrgBrowseBackingBean.regTableList}"/>
            </h:selectOneMenu>
            <h:commandButton styleClass="button01" type="button" value="导出" onclick="OpenRpt();"></h:commandButton>

        </h:panelGrid>

		<h:panelGrid width="100%" align="center">
			<h:panelGroup>
                <h:outputText escape="false" value="组织机构基本情况" style="font-size:24;text-align:center;width:580px" />
                <h:outputText escape="false" value="机构代码：#{doc_OrgBrowseBackingBean.orgVO.orgCode}" style="font-size:12;text-align:center;width:20%" />
			</h:panelGroup>
    		<c:verbatim>
				<br>
    		</c:verbatim>
             <h:panelGrid  align="center" columns="1" cellpadding="0" border="1">
				<h:panelGrid styleClass="style1" columns="6">
                    <h:outputText escape="false" value="机构名称"
                        style="height:40px;text-align:center;PADDING: 12px;width:100px;" />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.name}"
                        style="height:40px;PADDING: 12px;width:120px;" />

                    <h:outputText escape="false" value="机构级别"
                        style="height:40px;text-align:center;PADDING: 12px;width:100px;" />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.level}"
                        style="height:40px;PADDING: 12px;width:120px; " />
                    <h:outputText escape="false" value="机构类别"
                        style="height:40px;text-align:center;PADDING: 12px;width:100px;" />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.orgClass}"
                        style="height:40px;PADDING: 12px;width:120px;" />

                    <h:outputText escape="false" value="机构隶属<br>关系描述"
                        style="height:40px;text-align:center;PADDING: 5px;width:100px; " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.subRelation}"
                        style="height:40px;PADDING: 12px;width:120px;" />

                    <h:outputText escape="false" value="机构负责人"
                        style="height:40px;text-align:center;PADDING: 12px;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.manager}"
                        style="height:40px;PADDING: 12px;width:120px; " />
                    <h:outputText escape="false" value="机构设立时间"
                        style="height:40px;text-align:center;padding-left:2;padding-top:12px;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.establishDate}"
                        style="height:40px;PADDING: 12px;width:120px;" />

                    <h:outputText escape="false" value="党组织设置情况"
                        style="height:40px;text-align:center;padding-left:2;padding-top:12;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.partyBasicInfo}"
                        style="height:40px;PADDING: 12px; width:120px;  " />

                    <h:outputText escape="false" value="机构所在地"
                        style="height:40px;text-align:center;PADDING: 12px;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.address}"
                        style="height:40px;PADDING: 12px; width:120px;  " />

                    <h:outputText escape="false" value="主管机构"
                        style="height:40px;PADDING: 12px;text-align:center;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.superId}"
                        style="height:40px;PADDING: 12px; width:120px; " />

                    <h:outputText escape="false" value="通信地址"
                        style="height:40px;text-align:center;PADDING: 12px;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.postAddress}"
                        style="height:40px;PADDING: 12px;width:120px;  " />
                    <h:outputText escape="false" value="邮政编码"
                        style="height:40px;text-align:center;PADDING: 12px;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.postCode}"
                        style="height:40;PADDING: 12px; width:120px;  " />
                    <h:outputText escape="false" value="电话号码"
                        style="height:40;text-align:center;PADDING: 12px;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.phone}"
                        style="height:40px;PADDING: 12px; width:120px; " />
                </h:panelGrid>
                <h:panelGrid columns="2" styleClass="style1">
                    <h:outputText escape="false" value="业务经营范围"
                        style="height:140px;text-align:center;padding-top:60px;PADDING-left: 8px;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.buzRange}"
                        style="height:140px;PADDING: 12px;width:572px;  " />
                </h:panelGrid>

                <h:panelGrid columns="2" styleClass="style1">
                    <h:outputText escape="false" value="机构变动情况"
                        style="height:140px;padding-top:60px;PADDING-left: 8px;text-align:center;width:100px;  " />
                    <h:outputText escape="false"
                        value="#{doc_OrgBrowseBackingBean.orgVO.changeInfo}"
                        style="height:140px;padding-top:50px;PADDING-left: 8px;width:572px;" />
                </h:panelGrid>

                <h:panelGrid columns="2" styleClass="style1">
                    <h:outputText escape="false" value="机构照片"
                        style="height:300px;text-align:center;vertical-align:middle;padding-top:60px;PADDING-left: 8px;width:100px; " />
                    <h:graphicImage alt="No Image" width="572" height="300" style="text-algin:center;"
                        value="/pages/common/photo.jsp?id=#{doc_OrgBrowseBackingBean.orgVO.photo}" />
                </h:panelGrid>
            </h:panelGrid>
		</h:panelGrid>

	</h:panelGrid>
</h:form>


