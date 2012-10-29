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
 //XMLHttpRequest状态改变时要执行的函数
function handleStateChange() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
            //解析从xml文件得到的结果,动态画树
            parseResults();
        }
    }
}

//解析从xml文件得到的结果
function parseResults() {
    var results = xmlHttp.responseXML;
    var orgs = null;
    var trees = results.getElementsByTagName("message");
    for (var i = 0; i < trees.length; i++) {
        orgs = trees[i];
        info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
    }
}
//创建XMLHttpRequest对象
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
                alert("请先选择岗位分类");
                return;
            } else {
                if (document.all("per").style.display == "none") {
                    document.all("per").style.display = "";
                    document.forms(0).bper.value = "隐藏岗位模板";
                } else {
                    document.all("per").style.display = "none";
                    document.forms(0).bper.value = "查看岗位模板";
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
				<%=LanguageSupport.getResource("GWGL-0200","岗位管理")%> ->
                <%=LanguageSupport.getResource("GWGL-0216","新增岗位")%>
			</f:verbatim>
		</h:panelGroup>
	</h:panelGrid>
	<f:verbatim>
		<br>
		<table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td align="right">
                 <strong>岗位编号</strong>
                </f:verbatim> <h:inputText styleClass="input"
						id="C001003"
						value="#{post_PostAddBB.postvo.postCode}" alt="岗位编号|1|s|50||" />
    <f:verbatim>
            </td></tr>
        </table>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0 class=table03>
              <tr nowrap>
				<td class="td_form01 td_form_required" width=140><%=LanguageSupport.getResource("JJGGL-1078",	"岗位名称")%>
				</td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="C001005" value="#{post_PostAddBB.postvo.name}"
						alt="岗位名称|0|s|50||" /> <f:verbatim>
				</td>
				<td class="td_form01 td_form_required" width=140><%=LanguageSupport
							.getResource("GWGL-1005", "隶属机构")%></td>
				<td class=td_form02></f:verbatim>
                        <h:inputText styleClass="input"
						id="C001010" code="" dict="yes" dict_num="OU" readonly="true"
						value="#{post_PostAddBB.postvo.orgId}" alt="隶属机构|0|s|50||" />
    <f:verbatim>
						<input type="button" class="button_org"	onclick="PopUpOrgDlgShowGroup('form1:C001010',1)">
				</td>
			</tr>

			<tr nowrap>
				<td class=td_form01><%=LanguageSupport.getResource("GWGL-1006","直接上级岗位")%></td>
				<td class=td_form02>
    </f:verbatim>
                        <h:inputText styleClass="input"
						id="C001015" code="" dict="yes" dict_num="PO" readonly="true"
						value="#{post_PostAddBB.postvo.superId}" alt="上级岗位|1|s|50||" /> <f:verbatim>
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
                        alt="岗位类型|1|s|10||" />
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
						value="#{post_PostAddBB.postvo.postClass}" alt="岗位类别|0|s|50||" />
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:C001001')">
				</td>
				<td class=td_form01>
					<%=CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM,"C001020")%>
                </td>
				<!-- 修改开始1 -->
				<td class=td_form02></f:verbatim>
					<h:inputText styleClass="input"   
						id="C001020" code="" dict="yes" dict_num="3018" readonly="true"
						value="#{post_PostAddBB.postvo.postLevel}" alt="岗位等级|1|s|10||" /> 
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:C001020')">
                </td>
				<!-- 修改结束1 -->
			</tr>
			
			
			
			<tr nowrap>
				<td class="td_form01">薪级</td>
				<td class=td_form02></f:verbatim> 
					<h:inputText styleClass="input"
						id="wageClass" code="" dict="yes" dict_num="3051" 
						value="#{post_PostAddBB.wageClass}" alt="薪级|0|s|50||" />
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:wageClass')">
				</td>
				<td class="td_form01">工资序列</td>
				<!-- 修改开始1 -->
				<td class=td_form02></f:verbatim>
					<h:inputText styleClass="input"   
						id="wageXL" code="" dict="yes" dict_num="3056" 
						value="#{post_PostAddBB.wageXL}" alt="工资序列|1|s|10||" /> 
					<f:verbatim>
					<input type="button" class="button_select"
						onclick="PopUpCodeDlgOneControl('form1:wageXL')">
                </td>
				<!-- 修改结束1 -->
			</tr>
			
			
			<tr nowrap>
				<td class="td_form01 td_form_required">添加日期</td>
				<td class=td_form02></f:verbatim> <h:inputText styleClass="input"
						id="C001030" value="#{post_PostAddBB.postvo.updateDate}"
						alt="更新日期|0|d|50||" /> <f:verbatim>
						<input type="button" class="button_date"
							onclick="PopUpCalendarDialog('form1:C001030')">
				</td>
            <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("GWGL-1009", "岗位编制")%>
            </td>
            <td class=td_form02 ></f:verbatim>
                    <h:inputText
                    styleClass="input" id="C001735"
                    value="#{post_PostAddBB.postvo.workOut}" alt="岗位编制|0|i|50||" /> <f:verbatim>
            </td>

			</tr>

			<tr nowrap>
				<td class=td_form01><%=LanguageSupport.getResource("GWGL-1010", "岗位目的")%></td>
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
                        <h:commandButton value="保存 "
						onclick="return forSave();"
						styleClass="button01" action="#{post_PostAddBB.savePost}" />
                        <h:commandButton
						id="selPost" action="#{post_PostAddBB.queryPost}"
						style="display:none" />
                       <f:verbatim>
						<input name="mod1" type="button" class="button01"
							value=" <%=LanguageSupport
							.getResource("GWGL-1011", "选择岗位模板")%>"
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
							      <%=LanguageSupport.getResource("GWGL-1011", "查看")%>
							    </f:verbatim>
							</c:facet>
							<c:verbatim escape="false">
								<a onMouseOver=linkOver(this) onMouseOut=linkOut(this)
									onclick="forView(</c:verbatim><h:outputText
                    value="#{list.postId}"/><c:verbatim>)">
                       <f:verbatim>
							    <%=LanguageSupport.getResource("GWGL-1012", "查看")%>
					   </f:verbatim>
                             </a>
							</c:verbatim>
						</h:column>
						<h:column>
							<c:facet name="header">
							     <f:verbatim>
							        <%=LanguageSupport.getResource("JGGL-1077", "岗位名称")%>
					  		    </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.name}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							      <f:verbatim>
							        <%=LanguageSupport.getResource("JGGL-1024", "所属机构")%>
					  		    </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.orgId}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							  <f:verbatim>
							        <%=LanguageSupport.getResource("JGGL-1079", "岗位分类")%>
					  	     </f:verbatim>
							</c:facet>
							<h:outputText value="#{list.postClass}" />
						</h:column>
						<h:column>
							<c:facet name="header">
							 <f:verbatim>
							        <%=LanguageSupport.getResource("GWGL-1008", "岗位等级")%>
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
