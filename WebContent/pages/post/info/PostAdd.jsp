<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
	String flag = (String) request.getAttribute("flag");
	String sysDate = CommonFuns.getSysDate("yyyy-MM-dd");
%>
<script type="text/javascript">
    var info = "";
 //XMLHttpRequest״̬�ı�ʱҪִ�еĺ���
function handleStateChange() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
            //������xml�ļ��õ��Ľ��,��̬����
            parseResults();
        }
    }
}

//������xml�ļ��õ��Ľ��
function parseResults() {
    var results = xmlHttp.responseXML;
    var orgs = null;
    var trees = results.getElementsByTagName("message");
    for (var i = 0; i < trees.length; i++) {
        orgs = trees[i];
        info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
    }
}
//����XMLHttpRequest����
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}
    function forSave() {
        if (forCheck()) {
            return forsubmit(document.forms(0));
        }
        return false;
    }

        function forView(id) {
            windowOpen("/post/info/PostNote.jsf?postid="+id,"aa","","800","700","yes","10","10","yes");            
        }     
        function forPer() {
            var postClass = document.all("form1:C001001").value;
            if (postClass == null || postClass == "") {
                alert("����ѡ���λ����");
                return;
            } else {
                if (document.all("per").style.display == "none") {
                    document.all("per").style.display = "";
                    document.forms(0).bper.value = "���ظ�λģ��";
                } else {
                    document.all("per").style.display = "none";
                    document.forms(0).bper.value = "�鿴��λģ��";
                }
            }
        }
        function forSelect() {
            if(forsubmit(document.forms(0))){
                document.all("form1:selPost").click();
             }
        }
        function forCheck() {
            var queryString = createQueryString("C001",document.forms(0));
            createXMLHttpRequest();
            xmlHttp.open("POST", "/pages/ajax/Check.jsp", false);
            xmlHttp.onreadystatechange = handleStateChange;
            xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
            xmlHttp.send(queryString);

            if (info != null && info != "" && info != "no") {
                alert(info);
                return false;
            }
            return true;
        }

    </script>
<h:form id="form1">
	<h:panelGrid styleClass="td_title" width="100%" border="0"
		cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<f:verbatim>
				<%=LanguageSupport.getResource("GWGL-0200","��λ����")%> ->
                <%=LanguageSupport.getResource("GWGL-0216","������λ")%>
			</f:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<f:verbatim>
		<br>
		<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td align="right">
                 <strong>��λ���</strong>
                </f:verbatim> <h:inputText styleClass="input"
						id="C001003"
						value="#{post_PostAddBB.postvo.postCode}" alt="��λ���|1|s|50||" />
    <f:verbatim>
            </td></tr>
        </table>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0 class=table03>
              <tr nowrap>
				<td class="td_form01 td_form_required" width=140><%=LanguageSupport.getResource("JJGGL-1078",	"��λ����")%>
				</td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="C001005" value="#{post_PostAddBB.postvo.name}"
						alt="��λ����|0|s|50||" /> <f:verbatim>
				</td>
				<td class="td_form01 td_form_required" width=140><%=LanguageSupport
							.getResource("GWGL-1005", "��������")%></td>
				<td class=td_form02></f:verbatim>
                        <h:inputText styleClass="input"
						id="C001010" code="" dict="yes" dict_num="OU" readonly="true"
						value="#{post_PostAddBB.postvo.orgId}" alt="��������|0|s|50||" />
    <f:verbatim>
						<input type="button" class="button_org"	onclick="PopUpOrgDlgShowGroup('form1:C001010',1)">
				</td>
			</tr>

			<tr nowrap>
				<td class=td_form01><%=LanguageSupport.getResource("GWGL-1006","ֱ���ϼ���λ")%></td>
				<td class=td_form02>
    </f:verbatim>
                        <h:inputText styleClass="input"
						id="C001015" code="" dict="yes" dict_num="PO" readonly="true"
						value="#{post_PostAddBB.postvo.superId}" alt="�ϼ���λ|1|s|50||" /> <f:verbatim>
						<input type="button" class="button_select"
							onclick="fPopUpPostDlg('form1:C001015',null,document.all('form1:C001010').code)">
				</td>
                <td class=td_form01 id="C001025_TD1">
					<%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"C001025")%>
                </td>
                <td class=td_form02 id="C001025_TD2">
				</f:verbatim>
                        <h:inputText styleClass="input"    code="" dict="yes" dict_num="2244" readonly="true"
                        id="C001025" value="#{post_PostAddBB.postvo.postType}"
                        alt="��λ����|1|s|10||" />
				<f:verbatim>
                <input type="button" class="button_select"
                    onclick="PopUpCodeDlgOneControl('form1:C001025')">
                </td>
                <script type="text/javascript">
                    <%
                        InfoItemBO item=SysCacheTool.findInfoItem("","C001025");
                        if (item==null || "0".equals(item.getItemStatus())){
                            out.println("document.all('C001025_TD1').style.display='none';");
                            out.println("document.all('C001025_TD2').style.display='none';");
                        }
                    %>
                </script>
			</tr>
			<tr nowrap>
				<td class="td_form01 td_form_required">
                <%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"C001001")%>
                </td>
				<td class=td_form02></f:verbatim> 
					<h:inputText styleClass="input"
						id="C001001" code="" dict="yes" dict_num="0110" readonly="true"
						value="#{post_PostAddBB.postvo.postClass}" alt="��λ���|0|s|50||" />
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:C001001')">
				</td>
				<td class=td_form01>
					<%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"C001020")%>
                </td>
				<!-- �޸Ŀ�ʼ1 -->
				<td class=td_form02></f:verbatim>
					<h:inputText styleClass="input"   
						id="C001020" code="" dict="yes" dict_num="3018" readonly="true"
						value="#{post_PostAddBB.postvo.postLevel}" alt="��λ�ȼ�|1|s|10||" /> 
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:C001020')">
                </td>
				<!-- �޸Ľ���1 -->
			</tr>
			
			
			
			<tr nowrap>
				<td class="td_form01">н��</td>
				<td class=td_form02></f:verbatim> 
					<h:inputText styleClass="input"
						id="wageClass" code="" dict="yes" dict_num="3051" 
						value="#{post_PostAddBB.wageClass}" alt="н��|0|s|50||" />
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:wageClass')">
				</td>
				<td class="td_form01">��������</td>
				<!-- �޸Ŀ�ʼ1 -->
				<td class=td_form02></f:verbatim>
					<h:inputText styleClass="input"   
						id="wageXL" code="" dict="yes" dict_num="3056" 
						value="#{post_PostAddBB.wageXL}" alt="��������|1|s|10||" /> 
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:wageXL')">
                </td>
				<!-- �޸Ľ���1 -->
			</tr>
			
			
			<tr nowrap>
				<td class="td_form01 td_form_required">�������</td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="C001030" value="#{post_PostAddBB.postvo.updateDate}"
						alt="��������|0|d|50||" /> <f:verbatim>
						<input type="button" class="button_date"
							onclick="PopUpCalendarDialog('form1:C001030')">
				</td>
            <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("GWGL-1009", "��λ����")%>
            </td>
            <td class=td_form02 ></f:verbatim>
                    <h:inputText
                    styleClass="input" id="C001735"
                    value="#{post_PostAddBB.postvo.workOut}" alt="��λ����|0|i|50||" /> <f:verbatim>
            </td>

			</tr>

			<tr nowrap>
				<td class=td_form01><%=LanguageSupport.getResource("GWGL-1010", "��λĿ��")%></td>
				<td class=td_form02 colspan="3"></f:verbatim> <h:inputTextarea rows="3"
						id="C001035" cols="80" value="#{post_PostAddBB.postvo.postOrder}" />
					<f:verbatim>
				</td>
			</tr>
		</table>
		<br>
		<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
			<tr>
				<td align=right></f:verbatim>
                        <h:commandButton value="���� "
						onclick="return forSave();"
						styleClass="button01" action="#{post_PostAddBB.savePost}" />
                        <h:commandButton
						id="selPost" action="#{post_PostAddBB.queryPost}"
						style="display:none" />
                       <f:verbatim>
						<input name="mod1" type="button" class="button01"
							value=" <%=LanguageSupport
							.getResource("GWGL-1011", "ѡ���λģ��")%>"
							onclick="forSelect()"  style="display:none">
				</td>
			</tr>
		</table>
		<table width=95% border="0" align="center" cellpadding="0"
			cellspacing="0" id="per" <%if ("show".equals(flag)) {%>
			style="display: block" <%} else {%> style="display:none" <%}%>>
			<tr>
				<td></f:verbatim> <h:dataTable width="100%"
						value="#{post_PostAddBB.postlist}" var="list" border="1"
						align="center" headerClass="td_top" rowClasses="td_middle"
						styleClass="table03">
						<h:column>
							<c:facet name="header"></c:facet>
							<c:verbatim escape="false">
								<div align=center>
									<input type="radio" name="chk"
										value="</c:verbatim>
                <h:outputText value="#{list.postId}"/><c:verbatim>">
								</div>
							</c:verbatim>
						</h:column>
						<h:column>
							<c:facet name="header">
							    <f:verbatim>
							      <%=LanguageSupport.getResource("GWGL-1011", "�鿴")%>
							    </f:verbatim>
							</c:facet>
							<c:verbatim escape="false">
								<a onMouseOver=linkOver(this) onMouseOut=linkOut(this)
									onclick="forView(</c:verbatim><h:outputText
                    value="#{list.postId}"/><c:verbatim>)">
                       <f:verbatim>
							    <%=LanguageSupport.getResource("GWGL-1012", "�鿴")%>
					   </f:verbatim>
                             </a>
							</c:verbatim>
						</h:column>
						<h:column>
							<c:facet name="header">
							     <f:verbatim>
							        <%=LanguageSupport.getResource("JGGL-1077", "��λ����")%>
					  		    </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.name}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							      <f:verbatim>
							        <%=LanguageSupport.getResource("JGGL-1024", "��������")%>
					  		    </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.orgId}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							  <f:verbatim>
							        <%=LanguageSupport.getResource("JGGL-1079", "��λ����")%>
					  	     </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.postClass}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							 <f:verbatim>
							        <%=LanguageSupport.getResource("GWGL-1008", "��λ�ȼ�")%>
					  	     </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.postLevel}" />
						</h:column>
					</h:dataTable> <f:verbatim>
				</td>
			</tr>
		</table>
	</f:verbatim>
</h:form>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
