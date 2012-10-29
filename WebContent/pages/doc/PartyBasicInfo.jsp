<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<html>
<head>

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
<title>档案浏览</title>
</head>
<body>

<x:saveState value="#{doc_PartyBrowseBackingBean}" />
<h:inputHidden value="#{doc_PartyBrowseBackingBean.pageInit}" />
<h:form>
	<h:panelGrid width="98%" align="center" columns="1" cellpadding="0"
		cellspacing="0">
		<h:panelGrid width="100%" align="center">
			<h:outputText escape="false" value="公司党组织基本情况表" 	style="font-size:24;text-align:center;width:100%" />
			<f:verbatim>
				<br>
			</f:verbatim>
			<h:panelGrid width="98%" columns="4" cellpadding="0"  styleClass="style1">
				<h:outputText escape="false" value="党组织名称"
					style="text-align:center;PADDING: 12px;height:40;width:100%;" />
				<h:outputText escape="false"
					value="#{doc_PartyBrowseBackingBean.partyVO.partyName}"
					style="PADDING: 12px;height:40;width:100%;" />

				<h:outputText escape="false" value="党组织类别"
					style="text-align:center;PADDING: 12px;height:40;width:100%;" />
				<h:outputText escape="false"
					value="#{doc_PartyBrowseBackingBean.partyVO.partyType}"
					style="PADDING: 12px;height:40;width:100%;" />
				<h:outputText escape="false" value="设立时间"
					style="align:center;PADDING: 12px;height:40;width:100%;" />
				<h:outputText escape="false"
					value="#{doc_PartyBrowseBackingBean.partyVO.partyEstablishDate}"
					style="PADDING: 12px;height:40;width:100%;" />

				<h:outputText escape="false" value="所在机构名称"
					style="text-align:center;PADDING: 12px;height:40;width:100%;" />
				<h:outputText escape="false"
					value="#{doc_PartyBrowseBackingBean.partyVO.partyMemberName}"
					style="PADDING: 12px;height:40;width:100%;" />

				<h:outputText escape="false" value="民主评议情况"
					style="text-align:center;PADDING-top: 140px;height:300;width:100%;" />
				<h:outputText escape="false"
					value="#{doc_PartyBrowseBackingBean.partyVO.partyDemoInfo}"
					style="PADDING: 12px;height:300;width:100%;" />

				<h:outputText escape="false" value="奖罚情况"
					style="text-align:center;PADDING-top: 140px;height:300;width:100%;" />
				<h:outputText escape="false"
					value="#{doc_PartyBrowseBackingBean.partyVO.partyRewardInfo}"
					style="PADDING: 12px;height:300;width:100%;" />


			</h:panelGrid>

		</h:panelGrid>

        <h:panelGrid align="center" columns="2" cellspacing="3">
            <h:commandButton value="打印预览"
                onclick="clearStatew();openPersonDoc();"
                styleClass="button" />
        </h:panelGrid>
	</h:panelGrid>
</h:form>

</body>
</html>
