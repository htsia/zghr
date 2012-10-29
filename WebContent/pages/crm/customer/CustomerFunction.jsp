<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="../../include/taglib.jsp"%>
<%@page import="java.util.List"%>
<%@page import="com.hr319wg.sys.pojo.bo.CodeItemBO"%>
<%@page import="com.crm319wg.common.Constants "%>
<%@page import="com.crm319wg.customer.ucc.ICustomerUCC"%>
<%@page import="com.hr319wg.common.web.SysContext"%>
<%@page import="com.crm319wg.customer.pojo.bo.CustomerViewBO"%>
<%@page import="com.oa319wg.user.pojo.vo.OAUser"%>


<link href="../css/style1.css" rel="stylesheet" type="text/css"/>
	<script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
	<style type="text/css">
		body{ padding:0; margin:0;}
		.STYLE1 {color: #FFFFFF ;
		         font-size: 12px; }
		.STYLE3 {
	font-size: 12px;
	</style>
   <style>a{TEXT-DECORATION:none}</style>
   
    <script language="javascript">

    function createView(){
   	 window.showModalDialog("/crm/customer/CreateCustomerView.jsf?init=create", null, "dialogWidth:700px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
   	 window.parent.frames[1].location.reload();
   	  return false;
   	 }

    function mgerView(){
      	 window.showModalDialog("/crm/customer/CustomerViewManager.jsf", null, "dialogWidth:700px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
      	 window.parent.frames[1].location.reload();
      	  return false;
      	 }
    
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
       
    </script>
	

   <table width="100" height="100%" border="0" cellpadding="0" cellspacing="0" align="center">
              <tr>
                <td valign="top">
                  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                      <td height="6"></td>
                  </tr>

                      <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="23" background="/images/maininterface/hd_main_47.gif" id="imgmenu1" class="menu_title" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(1)" onMouseOut="this.className='menu_title';" style="cursor:hand"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="18%">&nbsp;</td>
                                <td width="82%" align="left" class="STYLE1">客户分组</td>
                              </tr>
                            </table>
                            </td>
                          </tr>

                          <tr>
                            <td background="/images/maininterface/hd_main_51.gif" id="submenu1">
                            <div class="sec_menu" >
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td>
                                    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    <%
                                    	CodeItemBO codeItemBO = null ;
                                                            			List list = SysCacheTool.queryCodeItemBySetId(Constants.CUTYPE_SETID);
                                                                         if(list != null && list.size() > 0){
                                                                        	 for(int i = 0 ; i < list.size() ; i++){
                                                                        		 codeItemBO = (CodeItemBO)list.get(i);
                                    %>
                                             
                                         <tr>
                                    <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif" alt="" width="13" height="13" /></td>
                                    <td width="84%" height="23" align="left">
                                      <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerList.jsf?init=<%=codeItemBO.getItemId()%>"  target="main1"><span class="STYLE3"><%=codeItemBO.getItemName()%></span></a></td>
                                      </tr>
                                    </table>
                                    </td>
                                  </tr>
                                  
                                             
                                             
                                             <%
                                                                                                                                                                         	}
                                                                                                                                                                                                              }
                                                                                                                                                                         %>
                                    
                                </table></td>
                              </tr>
                              
                              
                              <tr>
                                <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5" /></td>
                              </tr>
                            </table></div></td>
                          </tr>

                        </table></td>
                      </tr>
                </table>
				
				<table width="151" border="0" align="center" cellpadding="0" cellspacing="0">
                  <tr>
                      <td height="6"></td>
                  </tr>

                      <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="23" background="/images/maininterface/hd_main_47.gif" id="imgmenu2" class="menu_title" onMouseOver="this.className='menu_title2';" onClick="showsubmenu(2)" onMouseOut="this.className='menu_title';" style="cursor:hand"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="18%">&nbsp;</td>
                                <td width="82%" align="left" class="STYLE1">客户视图</td>
                              </tr>
                            </table>
                            </td>
                          </tr>

                          <tr>
                            <td background="/images/maininterface/hd_main_51.gif" id="submenu2">
                            <div class="sec_menu" >
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td>
                                    <table width="90%" border="0" align="center" cellpadding="0" cellspacing="0">
                                    
                                     
									 
									 
							   <tr>
                                    <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif"  alt="" width="13" height="13" /></td>
                                    <td width="84%" height="23" align="left">
                                      <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CreateCustomerView.jsf" onClick="return createView() ;" ><span class="STYLE3">创建视图</span></a></td>
                                      </tr>
                                    </table>
                                    </td>
                                  </tr>
                                  
                                    <tr>
                                    <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif"  alt="" width="13" height="13" /></td>
                                    <td width="84%" height="23" align="left">
                                      <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerViewManager.jsf" onClick="return mgerView() ;" ><span class="STYLE3">视图管理</span></a></td>
                                      </tr>
                                    </table>
                                    </td>
                                  </tr>
								  
								    <%
								  								    	try{
								  								    						        	 OAUser person = (OAUser)session.getAttribute(Constants.OA_USER_INFO);
								  								    						        	 ICustomerUCC iCustomerUCC = (ICustomerUCC) SysContext.getBean("crm_CustomerUCC");
								  								    									 CustomerViewBO customerViewBO = null ;
								  								    									 List list1 =  iCustomerUCC.getCustomerViewBOList(person.getUserId());
								  								    									if(list1 != null && list1.size() > 0){
								  								    										for(int i = 0 ; i < list1.size() ; i++){
								  								    											customerViewBO = (CustomerViewBO)list1.get(i);
								  								    %>
													
													
                                     <tr>
                                    <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/status.gif"  alt="" width="13" height="13" /></td>
                                    <td width="84%" height="23" align="left">
                                      <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerList.jsf?init=view&viewId=<%=customerViewBO.getViewId()%>"  target="main1"><span class="STYLE3"><%=customerViewBO.getViewName()%></span></a></td>
                                      </tr>
                                    </table>
                                    </td>
                                  </tr>
													<%
														}
																						}
																			         }catch(Exception e){
																			        	 
																			         }
													%>
								  
                                    
                                     <tr>
                                    <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif"  alt="" width="13" height="13" /></td>
                                    <td width="84%" height="23" align="left">
                                      <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerList.jsf?init=<%=Constants.ALL_CUSTOMER%>"  target="main1"><span class="STYLE3">所有客户</span></a></td>
                                      </tr>
                                    </table>
                                    </td>
                                  </tr>
                                    
                                    
                                  <tr>
                                    <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif"  alt="" width="13" height="13" /></td>
                                    <td width="84%" height="23" align="left">
                                      <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerList.jsf?init=<%=Constants.THIS_MONTH%>"  target="main1"><span class="STYLE3">本月新增客户</span></a></td>
                                      </tr>
                                    </table>
                                    </td>
                                  </tr>
                                  
                                
                                  
                                  
                                      <tr>
                                        <td width="16%" height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif"  alt="" width="13" height="13" /></td>
                                        <td width="84%" height="23" align="left">
                                          <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                          <tr>
                                            <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerList.jsf?init=<%=Constants.SHARE_CUSTOMER%>"  target="main1"><span class="STYLE3"> 共享给我的</span></a></td>
                                          </tr>
                                        </table>
                                        </td>
                                      </tr>
                                      
                                      
                                  <tr>
                                    <td height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif"  width="13" height="13" /></td>
                                    <td height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerList.jsf?init=<%=Constants.PRIVATE_CUSTOER%>" target="main1"><span class="STYLE3" > 我创建的</span></a></td>
                                        </tr>
                                    </table>
                                    </td>
                                  </tr>
                                  
                                      
                                  <tr>
                                    <td height="23" align="center"><img src="/images/maininterface/menu/AddPerson.gif"  width="13" height="13" /></td>
                                    <td height="23" align="left">
                                    <table width="95%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                          <td height="20" style="cursor:hand" onMouseOver="this.style.borderStyle='solid';this.style.borderWidth='1';borderColor='#7bc4d3'; "onmouseout="this.style.borderStyle='none'"><a href="/crm/customer/CustomerList.jsf?init=<%=Constants.THISMONTH_MODIFY%>" target="main1"><span class="STYLE3" > 本月修改客户</span></a></td>
                                        </tr>
                                    </table>
                                    </td>
                                  </tr>
                                   
                                </table></td>
                              </tr>
                              
                              
                              
                              
                              
                              
                              <tr>
                                <td height="5"><img src="/images/maininterface/hd_main_52.gif" width="151" height="5" /></td>
                              </tr>
                            </table></div></td>
                          </tr>

                        </table></td>
                      </tr>
                </table>
                </td>
              </tr>
            </table>