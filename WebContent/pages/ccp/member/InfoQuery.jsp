<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@ page import="java.util.List"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  <script type="text/javascript">
        function forView(form, id, type) {
            forModifyPartyPersonDetail(id);
        }
        //单选择人员
        function fPopUpPartyPerDlg(obj1, obj2) {
            var obj11 = document.all(obj1);
            var obj21 = document.all(obj2);
            showx = event.screenX - event.offsetX - 150;
            // + deltaX;
            showy = event.screenY - event.offsetY + 18;
            // + deltaY;

            retval = window.showModalDialog("/pages/ccp/OrgTreeSelPerson.jsf", "", "dialogWidth:900px; dialogHeight:600px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split(",");
                if (obj2 != null) {
                    obj11.value = rs[1];
                    obj21.value = rs[0];
                } else {
                    obj11.value = rs[0];
                }
                return true;
            } else {
                return false;
            }
        }


        function forSel1() {
            if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                   document.forms(0).all('form1:queryPerson').click();
            }
         }
        
        function forSel() {
             PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'') 
             document.forms(0).all('form1:queryPerson').click();
              
        }
        function forPerson() {
            if (fPopUpPartyPerDlg("form1:personId")) {
                var pid = document.all("form1:personId").value;
                windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + pid, "", "status=no,toolbar=no,menubar=no,location=no", "900", "600", "no");
            }
        }
       
       function forPerson1() {
                var superId  = document.all("form1:superId").value ;
                if(superId == '' || superId == null){
                	  alert("请选择党组织 ！");
                	  return false ;
                    }
                showx = event.screenX - event.offsetX - 150;
                showy = event.screenY - event.offsetY + 18;
                var retval = window.showModalDialog("/pages/ccp/OrgTreeSelPerson.jsp", "", "dialogWidth:900px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
                if (retval != null) {
                    rs = retval.split(",");
                    document.all("form1:personId").value = rs[0];
                }
                if (document.all("form1:personId").value != "") {
                    pageCodeExchange(document.forms(0));
                    document.all('form1:addPartyNumber').click();
                    return true;
                }else {
                    pageCodeExchange(document.forms(0));
                    return false;
                }
           	    
        }
        
         
        function forSelPerson() {
            if (checkMutilSelect(document.forms(0).chk)) {
                windowOpen("/ccp/member/InfoMultiEditIndex.jsf", "plist", "status=no,toolbar=no,menubar=no,location=no", "1000", "800", "no");
                var obj = document.forms(0).chk ;
                var ids = "";
                if (ids.length == null) {
                    ids = obj.value + ",";
                } else {
                    for (i = 0; i < obj.length; i++) {
                        if (obj[i].checked) {
                            ids += obj[i].value + ",";
                        }
                    }
                }
                ids = ids.substr(0, ids.length - 1);
                document.forms(1).perids.value = ids;
                document.forms(1).target = "plist";
                document.forms(1).action = "/ccp/member/InfoMultiEditIndex.jsf";
                document.forms(1).submit();
                document.forms(1).target = "_self";
          } else {
             alert("请选择人员");
              return false;
         }
        }
        function forAdQry() {
            doAdvanceQuery("A", "ORG", "111", "Y", "", "((A001.A001009='012001') or (A001.A001009='012002')) and (A001.A001730<>'00901')", "Y", "<%=Constants.DEFAULT_QUERY_PARTYMEMBER%>", "Y");
        }
    </script>
 
<h:form id="form1">
	<h:inputHidden id="memberList"
		value="#{ccp_PartyMemberListBB.memberList}" />
	<h:inputHidden id="personType"
		value="#{ccp_PartyMemberListBB.personType}" />
	<h:inputHidden id="personTypeValue"
		value="#{ccp_PartyMemberListBB.personTypeValue}" />
	<h:inputHidden id="personId" value="#{ccp_PartyMemberListBB.personId}" />
	<h:inputHidden id="superId" value="#{ccp_PartyMemberListBB.superId}" />
	<h:inputHidden id="pageFlag" value="#{ccp_PartyMemberListBB.pageFlag}" />
	<h:inputHidden id="flag" value="#{ccp_PartyMemberListBB.flag}" />
	<h:inputHidden id="sessionFlag" value="#{ccp_PartyMemberListBB.sessionFlag}" />
	
	<c:verbatim>
		<input type="hidden" name="sessionFlag" value="2">
	</c:verbatim>
	<h:panelGroup>
		   <h:commandButton value="选择人员类别" type="button" styleClass="button01"
				onclick="forSel()" />
			<h:outputText value="#{ccp_PartyMemberListBB.personTypeValue}" />
		</h:panelGroup>
	<h:panelGrid width="100%" align="center" columns="2" border="0"
		cellspacing="0" cellpadding="0" styleClass="td_page">
		<h:panelGroup>
			<h:outputText value=" 姓名：" />
			<h:inputText id="partyName"
				value="#{ccp_PartyMemberListBB.personName}" size="10" />
			<h:commandButton value=" 查询 " styleClass="button01" id="queryPerson"
				action="#{ccp_PartyMemberListBB.queryPartyMember}" />
			<h:outputText value=" " />
			<h:commandButton value="高级查询" styleClass="button01"
				onclick="return forAdQry()" />
		</h:panelGroup>
		<h:panelGrid columns="1" align="right">
			<h:panelGroup>
				<h:commandButton value="维护多人" type="button" styleClass="button01"
					onclick="forSelPerson()" />
				  <f:verbatim>&nbsp;</f:verbatim>
			    <h:commandButton value="增加党员" type="button" styleClass="button01"
					onclick="forPerson1()" />
			   <h:commandButton id="addPartyNumber"    action ="#{ccp_PartyMemberListBB.addPartyNumber}" style="display:none" /> 
			</h:panelGroup>
		</h:panelGrid>
	</h:panelGrid>
	<c:verbatim>
		<jsp:include page="/pages/common/activepage/ActiveList.jsp">
			<jsp:param name="hasOperSign" value="true" />
			<jsp:param name="operSignType" value="checkbox" />
			<jsp:param name="hasEdit" value="true" />
			<jsp:param name="isEditList" value="false" />
			<jsp:param name="isCheckRight" value="true" />
			<jsp:param name="isRow" value="true" />
			<jsp:param name="rowFuncName" value="forView" />
			<jsp:param name="isPage" value="true" />
		</jsp:include>
	</c:verbatim>
</h:form>

<f:verbatim>
	<form id="form2"><input type="hidden" name="perids" /></form>
</f:verbatim>
