<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.user.pojo.bo.OperateBO"%>
<%@ page import="java.util.Hashtable"%>
<%@ page import="java.util.List"%>
<link href="../css/style1.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	padding: 0;
	margin: 0;
}

.STYLE1 {
	color: #FFFFFF
}
</style>

<script language="javascript"
	src="<%=request.getContextPath()%>/js/maininterface.js"></script>
<script language="javascript"
	src="<%=request.getContextPath()%>/js/index.js"></script>
<script language="javascript">
    function showsubmenu(sid){
        whichEl = eval("submenu" + sid);
        imgmenu = eval("imgmenu" + sid);
        if (whichEl.style.display == "none"){
            eval("submenu" + sid + ".style.display=\"\";");
            imgmenu.background="/images/maininterface/hd_main_47.gif";
        }
        else{
            eval("submenu" + sid + ".style.display=\"none\";");
            imgmenu.background="/images/maininterface/hd_main_48.gif";
        }
     }

      function hide(){
            A=document.getElementById('hide').style.display
            if(A=="none"){
                document.getElementById('hide').style.display="block"
                document.getElementById('frameshow').src="/images/button_1.gif";
            }
            if(A=="block"){
                document.getElementById('hide').style.display="none"
                document.getElementById('frameshow').src="/images/button_2.gif";
            }
       }
      function parentclick(id) {
          alert(id);
          parent.refreshList(id);
      }
      function changePage(page){
          parent.main.location.href=page;
      }
    </script>
<h:form id="form1">
	<f:verbatim>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td height="23" background="/images/maininterface/hd_main_47.gif"
					id="imgmenu1" onMouseOver="this.className='menu_title2';"
					onClick="showsubmenu(1)" onMouseOut="this.className='menu_title';"
					style="cursor: hand">
				<table width="100%" border="0">
					<tr>
						<td width="18%">&nbsp;</td>
						<td width="82%" align="left" class="STYLE1">考勤情况</td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td background="/images/maininterface/hd_main_51.gif" id="submenu1">
				<div class="sec_menu">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="90%" border="0" align="center" cellpadding="0"
							cellspacing="0">

							<tr>
								<td width="16%" height="23" align="center"><img
									src="/images/maininterface/menu/position.gif" alt="" width="13"
									height="13" /></td>
								<td width="84%" height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/personService.jsf')"><span
											class="STYLE3">排班信息</span></a></td>
									</tr>
								</table>
								</td>
							</tr>

							<tr>
								<td width="16%" height="23" align="center"><img
									src="/images/maininterface/menu/clock.gif" alt="" width="13"
									height="13" /></td>
								<td width="84%" height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/punchCardMessage.jsf')"><span
											class="STYLE3">打卡信息</span></a></td>
									</tr>
								</table>
								</td>
							</tr>


							<tr>
								<td height="23" align="center"><img
									src="/images/maininterface/menu/link.gif" width="13"
									height="13" /></td>
								<td height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/punchCardDayCollect.jsf')"><span
											class="STYLE3">日汇总</span></a></td>
									</tr>
								</table>
								</td>
							</tr>

							<tr>
								<td height="23" align="center"><img
									src="/images/maininterface/menu/AddPerson.gif" width="13"
									height="13" /></td>
								<td height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/punchCardMonthCollect.jsf')"><span
											class="STYLE3">月汇总</span></a></td>
									</tr>
								</table>
								</td>
							</tr>

						</table>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td height="5"><img src="/images/maininterface/hd_main_52.gif"
					width="151" height="5" /></td>
			</tr>
		</table>


		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="23" background="/images/maininterface/hd_main_47.gif"
					id="imgmenu2" onmouseover="this.className='menu_title2';"
					onclick="showsubmenu(2)" onmouseout="this.className='menu_title';"
					style="cursor: hand">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="18%">&nbsp;</td>
						<td width="82%" align="left" class="STYLE1">网上申请</td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td background="/images/maininterface/hd_main_51.gif" id="submenu2">
				<div class="sec_menu">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="90%" border="0" align="center" cellpadding="0"
							cellspacing="0">
							<tr>
								<td width="16%" height="23" align="center"><img
									src="/images/maininterface/menu/remind.gif" width="13"
									height="13" alt="" /></td>
								<td width="84%" height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/personLeave.jsf')"><span
											class="STYLE3">请假</span></a></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="23" align="center"><img
									src="/images/maininterface/menu/zhicheng.gif" width="13"
									height="13" /></td>
								<td height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/personEvection.jsf')"><span
											class="STYLE3">出差</span></a></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="23" align="center"><img
									src="/images/maininterface/menu/log.gif" width="13" height="13" /></td>
								<td height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/personOutWork.jsf')"><span
											class="STYLE3">公出</span></a></td>
									</tr>
								</table>
								</td>
							</tr>
							<%
   if ("0".equals(Constants.APPLY_SHOWCHANGE)){
%>
							<tr>
								<td width="16%" height="23" align="center"><img
									src="/images/maininterface/menu/InfoManage.gif" width="13"
									height="13" /></td>
								<td width="84%" height="23" align="left">
								<table width="95%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="cursor: hand"
											onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "
											onmouseout="this.style.borderStyle='none'"><a href="#"
											onclick="changePage('/attence/personChangeWork.jsf');"
><span
											class="STYLE3">换班</span></a></td>
									</tr>
								</table>
								</td>
							</tr>
							</tr>
							<%
  }
  %>
                                            <tr>
                                              <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/config.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="#" onclick="changePage('/attence/personAddWork.jsf')"><span class="STYLE3">加班</span></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                             <tr>
                                              <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/orgchart.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="#" onclick="changePage('/attence/networkholiday.jsf')"><span class="STYLE3">年假申请</span></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                             <tr>
                                              <td width="16%" height="23"  align="center"><img src="/images/maininterface/menu/orgchart.gif" width="13" height="13" /></td>
                                              <td width="84%" height="23" align="left"><table width="95%" border="0" cellspacing="0" cellpadding="0">
                                                  <tr>
                                                    <td height="20" style="cursor:hand" onmouseover="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="#" onclick="changePage('/attence/mrNetworkholiday.jsf')"><span class="STYLE3">年假拟报</span></a></td>
                                                  </tr>
                                              </table></td>
                                            </tr>
                                        </table></td>
                                  </tr>

                                  <tr>
                                    <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5" /></td>
                                  </tr>
                                </table>
                            </div>
                            </td>

                          </tr>
                        </table>



 
         
</f:verbatim>

</h:form>