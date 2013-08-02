<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.xys.eva.ucc.IXys360UCC" %>
<%@ page import="com.hr319wg.xys.eva.pojo.bo.*" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
  
   
   <br>
<script type="text/javascript">
	var xmlHttp;
	var itemId;
	 //创建XMLHttpRequest对象
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }
    
    function checkInputValue(pid) {
        itemId=pid;
        createXMLHttpRequest();
        xmlHttp.onreadystatechange = handleStateChange;
        xmlHttp.open("GET", "/pages/xys/eva/check360InputScore.jsp?itemId=" + pid, true);
        xmlHttp.send(null);
    }
    function handleStateChange() {
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
            	var results = xmlHttp.responseText;
            	if(results!=null&&results!=""){
	            	var result=results.split(",");
	            	var score=document.getElementById("socre_"+itemId).value;
	            	var resultHi=parseFloat(result[0]);
	            	var resultLow=parseFloat(result[1]);
	            	var dscroe1=true;
	            	if(""==score){
	            		dscroe1=false;
	            	}else{
	            		var reg=/^\d+(\.\d+)?$/;
	            		dscroe1=reg.test(score);
	            	}
	            	if(dscroe1==false){
	            		alert("请输入>0数字");
	            		document.getElementById("socre_"+itemId).value="";
	            		document.getElementById("socre_"+itemId).focus();
	            	}else{
		            	var dscroe=parseFloat(score);
		            	if(dscroe>resultHi||dscroe<resultLow){
		            		alert("请在打分区间["+resultLow+"-"+resultHi+"]内打分");
		            		document.getElementById("socre_"+itemId).value="";
		            		document.getElementById("socre_"+itemId).focus();
		            	}
	            	}
            	}
            }
        }
    }
   
   function checkAllInput(){
       var allinput=true;
       var doms=document.getElementsByTagName('input');
       if(doms!=null&&doms.length>0){
	        for(var i=0;i<doms.length;i++){
		        if(doms[i].id!=null&&doms[i].id.substring(0,6)=="socre_"&&(doms[i].value==null||doms[i].value=="")){
		        	allinput=false;
		        }
	        }
       }
       if(allinput==true){
          document.all('form1:savebutton').click();
       }else{
           alert("请输入各指标得分！");
       }
   }
</script>
<c:verbatim>
<style type="text/css">
    	.td_xys_top {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #333333;
			background-color: #F3F3F3;
			padding: 2px;
			border-right: 1px #4986d4 solid;
			border-bottom: 1px #4986d4 solid;
			height: 22px;
		}
		.td_xys_mid {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #333333;
			background-color: #FFFFFF;
			padding: 2px;
    		border-right: 1px #4986d4 solid;
			border-bottom: 1px #4986d4 solid;
			height: 22px;
    		text-align :left;
		}
		.input_xys {
			font-family: Verdana, Arial, Helvetica, sans-serif;
			font-size: 12px;
			color: #323232;
			background-color: #FFFFFF;
			height: 20px;
			border: 1px solid #4986d4;
		}
		textarea 
		{ 
		width:100%; 
		height:100%; 
		overflow-y:visible ;
		overflow-x:visible;
		padding:5px;
		margin:-2px;
		word-wrap:break-word;
		border:0px;
		} 
    </style>
   </c:verbatim>
<x:saveState value="#{person_360AuditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{person_360AuditBB.initInput}"></h:inputHidden>
     <h:inputHidden value="#{person_360AuditBB.objId}"></h:inputHidden>
    <h:commandButton id="savebutton" value="保存" style="display:none;" action="#{person_360AuditBB.saveScore}"></h:commandButton>
    <c:verbatim>
   <table width=98% align="center" >
   	  <tr><td colspan="2" height="10"></td></tr>
   	   <%
       String objId =(String)session.getAttribute("objId");
   	   Xys360SbjBO sbj=(Xys360SbjBO)session.getAttribute("sbj");
   	   Xys360ObjBO obj=null;
   	   IXys360UCC ucc = null;
       try {
           ucc = (IXys360UCC) SysContext.getBean("xys360UCC");
           obj=ucc.findXys360ObjBOById(objId);
       }
       catch (Exception e) {
		   e.printStackTrace();
       }
       PersonBO pb=SysCacheTool.findPersonById(obj.getPersonId());
       
   %>
       <tr>
           <td align="center" width="60%">
               <span style="font-size:18px;font-weight:bold;" ><%=pb.getName()%>能力态度考核</span>
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
           
       </tr>

       <tr><td height=8>
       </td></tr>

       <tr><td width="60%" valign="top" align="center">
           <table class="table02"  align="center" width="100%">
               <%
                   List nlList=new ArrayList();//能力指标集
                   List tdList=new ArrayList();//态度指标集
                   List list=ucc.getXys360ObjKeyBOByObjId(objId);
                   if(list!=null&&list.size()>0){
                	  for(int i=0;i<list.size();i++){
                		  Xys360ObjKeyBO key=(Xys360ObjKeyBO)list.get(i);
                		  if(key.getKeyType().equals("1")){//能力指标
                			  nlList.add(key);
                		  }else{//态度指标
                			  tdList.add(key);
                		  }
                	  }
                   }
                   if(list!=null&&list.size()>0){
                	   out.println("<tr>");
                	   out.println("<td class='td_middle'>类型</td>");
                	   out.println("<td class='td_middle'>指标名称</td>");
                	   out.println("<td class='td_middle'>指标权重</td>");
                	   out.println("<td class='td_middle'>指标说明</td>");
                	   out.println("<td class='td_middle'>分数</td>");
                	   out.println("</tr>");
                	   
                	   if(nlList!=null&&nlList.size()>0){
                		   out.println("<tr>");
	                        out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(nlList.size()) + "'>");
	                        out.println("能力考核");
	                        out.println("</td>");
	                        Xys360ObjKeyBO key=(Xys360ObjKeyBO)nlList.get(0);
	                        Xys360ObjScoreBO score=ucc.findEqualsXys360ObjScoreBO(sbj.getSbjId(),key.getKeyId());
	                        out.println("<td class='td_middle_left'>"+key.getKeyName()+"</td>");
	                 	    out.println("<td class='td_middle_left'>"+key.getWeight()+"%</td>");
	                 	    out.println("<td class='td_middle_left'><textarea rows='8' cols='100' readonly='true'>"+key.getKeyDesc()+"</textarea></td>");
	                 	    out.println("<td class='td_middle_left'>");
	                 	    out.println("<input id='socre_"+key.getKeyId()+"' value='"+CommonFuns.filterNull(score.getScore())+"' name='"+key.getKeyId()+"' type='text' class='input' onchange=\"checkInputValue('"+key.getKeyId()+"')\">");
	                 	    out.println("</td>");
	                 	    out.println("</tr>");
                		    for(int i=1;i<nlList.size();i++){
                		    	key=(Xys360ObjKeyBO)nlList.get(i);
                		    	score=ucc.findEqualsXys360ObjScoreBO(sbj.getSbjId(),key.getKeyId());
                		    	out.println("<tr>");
    	                        out.println("<td class='td_middle_left'>"+key.getKeyName()+"</td>");
    	                 	    out.println("<td class='td_middle_left'>"+key.getWeight()+"%</td>");
    	                 	    out.println("<td class='td_middle_left'><textarea rows='8' cols='100' readonly='true'>"+key.getKeyDesc()+"</textarea></td>");
    	                 	   out.println("<td class='td_middle_left'>");
    	                 	    out.println("<input id='socre_"+key.getKeyId()+"' value='"+CommonFuns.filterNull(score.getScore())+"' name='"+key.getKeyId()+"' type='text' class='input' onchange=\"checkInputValue('"+key.getKeyId()+"')\">");
    	                 	   out.println("</td>");
    	                 	    out.println("</tr>");
                		    }
                	   }
                	   
                	   
                	   if(tdList!=null&&tdList.size()>0){
                		   out.println("<tr>");
	                        out.println("<td valign='center' class='td_middle_left' align='center' rowspan='" + String.valueOf(tdList.size()) + "'>");
	                        out.println("态度考核");
	                        out.println("</td>");
	                        Xys360ObjKeyBO key=(Xys360ObjKeyBO)tdList.get(0);
	                        Xys360ObjScoreBO score=ucc.findEqualsXys360ObjScoreBO(sbj.getSbjId(),key.getKeyId());
	                        out.println("<td class='td_middle_left'>"+key.getKeyName()+"</td>");
	                 	    out.println("<td class='td_middle_left'>"+key.getWeight()+"%</td>");
	                 	    out.println("<td class='td_middle_left'><textarea rows='8' cols='100' readonly='true'>"+key.getKeyDesc()+"</textarea></td>");
	                 	   out.println("<td class='td_middle_left'>");
	                 	    out.println("<input id='socre_"+key.getKeyId()+"' value='"+CommonFuns.filterNull(score.getScore())+"' name='"+key.getKeyId()+"' type='text' class='input' onchange=\"checkInputValue('"+key.getKeyId()+"')\">");
	                 	   out.println("</td>");
	                 	    out.println("</tr>");
                		    for(int i=1;i<tdList.size();i++){
                		    	key=(Xys360ObjKeyBO)tdList.get(i);
                		    	score=ucc.findEqualsXys360ObjScoreBO(sbj.getSbjId(),key.getKeyId());
                		    	out.println("<tr>");
    	                        out.println("<td class='td_middle_left'>"+key.getKeyName()+"</td>");
    	                 	    out.println("<td class='td_middle_left'>"+key.getWeight()+"%</td>");
    	                 	    out.println("<td class='td_middle_left'><textarea rows='8' cols='100' readonly='true'>"+key.getKeyDesc()+"</textarea></td>");
    	                 	   out.println("<td class='td_middle_left'>");
    	                 	    out.println("<input id='socre_"+key.getKeyId()+"' value='"+CommonFuns.filterNull(score.getScore())+"' name='"+key.getKeyId()+"' type='text' class='input' onchange=\"checkInputValue('"+key.getKeyId()+"')\">");
    	                 	   out.println("</td>");
    	                 	    out.println("</tr>");
                		    }
                	   }
	                   
                   }
               %>
           </table>
       </td>
        
   </table>
    </c:verbatim>
</h:form>  

