<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
	function group(){
		 document.all("group").className="activeTab";
		 document.all("person").className="tab";
		 document.all("dept").className="tab";
		 document.all("tree").src="/crm/customer/GroupShare.jsf?act=1";     
	}

    function person(){
   	 document.all("group").className="tab";
   	 document.all("person").className="activeTab";
   	 document.all("dept").className="tab";
   	 document.all("tree").src="/service/HandBookInfo.jsf?act=2";     
    }

    function dept(){
    	 document.all("person").className="tab";
      	 document.all("group").className="tab";
      	 document.all("dept").className="activeTab";
      	 document.all("tree").src="/service/ProjectManager.jsf?act=3";     
       }
    
</script>
<f:verbatim>
<br>
<table width="95%" align="center">
	<tr>
		<td id="group" align="center" width="10%" class="activeTab" onclick="group()">团队共享</td>

		<td id="person" align="center" width="10%" onclick="person()" class=tab>人员共享</td>

		<td  id="dept" align="center" width="10%" onclick="dept()" class=tab>部门共享</td>
	</tr>
   
		<tr>
			<td colspan="3">
			 <iframe id="tree" frameborder="0" framespacing="0"  class="table01"
				src ="/crm/customer/GroupShare.jsf"  scrolling="auto" width="101%" height="100%">
			</iframe> 
		     </td>
		</tr>
	</table>
 </f:verbatim>
 
 
 
 
 