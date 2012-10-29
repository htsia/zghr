<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
        function add(id,id1) {
    		var groupid = document.all('form1:groupid').value;
    		var groupname = document.all('form1:groupname').value;
    		var timename = document.all('form1:place').value;
    		var desc = document.all('form1:desc').value;
    	if (groupid != null && groupid != "" && groupname != null && groupname != "") {	
    		if (id != null && id != "" && id1 != null && id1 != "") {
    		  if (timename != null && timename != "") {
        		  if(!isNaN(id1)){
            		  //var a=timename.substring(timename.length-1,timename.length);
            		  //if(a=="\'"){
            			  //var b = timename.substring(0,timename.length-1);
            			  //document.all('form1:place').value = b + ""+id1+"'";
                	  //}else{
                		  document.all('form1:place').value = timename+""+id1;
                    	 //}
        		  }else if(id1=="AND"){
        			  document.all('form1:place').value = timename + " "+id1+ " ";
            	  }else if(id1=="OR"){
            		  document.all('form1:place').value = timename + " "+id1+ " ";
            	  }else if(id1=="!="){
            		  document.all('form1:place').value = timename + "<>";
            	  }else if(id1=="=="){
            		  document.all('form1:place').value = timename + "=";
            	  }else{
        			  document.all('form1:place').value = timename + ""+id1;
        		  }
    		  } else {
    			 document.all('form1:place').value = id;
    		  }
    		  if (desc != null && desc != "") {
    			  if(!isNaN(id)){
            		  var a=desc.substring(desc.length-1,desc.length);
            		  if(a=="天"){
            			  var b = desc.substring(0,desc.length-1);
            			  document.all('form1:desc').value = b + ""+id+"天";
                	  }else{
                		  //document.all('form1:desc').value = desc + ""+id+"天";
                		  document.all('form1:desc').value = desc + ""+id;
                      }
    			  }else if(id=="\&&"){
        			  document.all('form1:desc').value = desc + "和";
            	  }else if(id=="\||"){
            		  document.all('form1:desc').value = desc + "或";
            	  }else if(id=="!="){
            		  document.all('form1:desc').value = desc + "不等于";
            	  }else if(id=="=="){
            		  document.all('form1:desc').value = desc + "等于";
            	  }else if(id=="="){
            		  document.all('form1:desc').value = desc + "等于";
            	  }else if(id==">"){
            		  document.all('form1:desc').value = desc + "大于";
            	  }else if(id=="<"){
            		  document.all('form1:desc').value = desc + "小于";
            	  }else if(id=="<="){
            		  document.all('form1:desc').value = desc + "小于等于";
            	  }else if(id==">="){
            		  document.all('form1:desc').value = desc + "大于等于";
            	  }else{
    				  document.all('form1:desc').value = desc + ""+id;
    			  }
     		  } else {
     			 document.all('form1:desc').value = id;
     		  }
    		}else{
                alert("请选择运算符号");
        	 }
		}else{
            alert("请选择条件值");
    	 }
        }
    	function add1() {
    		var groupid = document.all('form1:groupid').value;
    		var groupname = document.all('form1:groupname').value;
    		var timename = document.all('form1:place').value;
    		var desc = document.all('form1:desc').value;
    		if (groupid != null && groupid != "" && groupname != null && groupname != "") {
    		  if (timename != null && timename != "") {
    			 document.all('form1:place').value = timename + ""+groupid;
    		  } else {
    			 document.all('form1:place').value = groupid;
    		  }
    		  if (desc != null && desc != "") {
     			 document.all('form1:desc').value = desc + ""+groupname;
     		  } else {
     			 document.all('form1:desc').value = groupname;
     		  }
    		}else{
                alert("请选择条件值");
        	 }
    	}
    </script>
    <x:saveState value="#{attexecluderuletitemBB}"></x:saveState>
    <h:form id="form1">
    <h:inputHidden id="initEdit" value="#{attexecluderuletitemBB.initEdit}" />
    <h:panelGrid width="95%" align="center">
    		<h:panelGrid align="right" columns="4" cellspacing="2">
			<h:outputText value=""></h:outputText>
			<h:commandButton styleClass="button01" value="保存"
				action="#{attexecluderuletitemBB.save}" />
			<h:commandButton styleClass="button01" value="返回"
				onclick="window.close();" />
		</h:panelGrid>
				<h:panelGrid width="100%" align="center" columns="2"
			styleClass="table03" columnClasses="td_form01,td_form02">
						<h:outputText value="规则描述" />
			<h:inputTextarea id="desc"
				value="#{attexecluderuletitemBB.bo.contentDes}" cols="80" rows="5"></h:inputTextarea>
						<h:outputText value="条件值" />
			<h:panelGroup>
				<h:inputText readonly="true" alt="条件值|0|s" id="groupname"
					dict="yes" dict_num="INFOITEM" style="width:250"
					value="#{attexecluderuletitemBB.contentDesNames}" />
				<h:inputHidden id="groupid" value="#{attexecluderuletitemBB.contentSqlName}" />
				<h:outputText value=" " />
				<h:commandButton type="button" styleClass="button_select"
					onclick="PopUpRuleItem(document.all('form1:groupid'),document.all('form1:groupname'))" />
				<h:commandButton type="button" styleClass="button01"
					onclick="add1()" value="加入定义" />
			</h:panelGroup>
						<h:outputText value="运算符号" />
			<h:panelGrid width="100%" columns="3">
							<h:panelGroup>
					<c:verbatim escape="false">
						<input type="button" class="button01" style="width: 50px"
							value="7" onclick="add('7','7');">
						<input type="button" class="button01" style="width: 50px"
							value="8" onclick="add('8','8');">
						<input type="button" class="button01" style="width: 50px"
							value="9" onclick="add('9','9');">
						<input type="button" class="button01" style="width: 50px"
							onclick="add('>', '>');" value=">">
													<input type="button" class="button01" style="width: 50px"
							value="=" onclick="add('=','=');">
					</c:verbatim>
				</h:panelGroup>
								<h:outputText value="" />
				<h:panelGroup>
                      <h:outputText value="" />
                      <h:outputText value="" />
                      <h:outputText value="" />
                      <h:outputText value="" />
                      <h:outputText value="" />
                      <h:outputText value="" />
                </h:panelGroup>
              <h:panelGroup>
              <c:verbatim escape="false">
                <input type="button" class="button01"  style="width:50px" value="4" onclick="add('4','4');">
                <input type="button" class="button01"  style="width:50px" value="5" onclick="add('5','5');">
                <input type="button" class="button01"  style="width:50px" value="6" onclick="add('6','6');">
                <input type="button" class="button01"  style="width:50px" onclick="add('<','<');" value="<">
               <input type="button" class="button01" style="width: 50px" value="AND" onclick="add('&&','AND');">
               </c:verbatim>
             </h:panelGroup>
     <h:outputText value=""/>
        <h:panelGroup>
       <h:outputText value="" />
       <h:outputText value="" />
       <h:outputText value="" />
       <h:outputText value="" />
       <h:outputText value="" />
       <h:outputText value="" />
        </h:panelGroup>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px"  value="1" onclick="add('1','1');">
                <input type="button" class="button01" style="width:50px" value="2" onclick="add('2','2');">
                <input type="button" class="button01" style="width:50px" value="3" onclick="add('3','3');">
                <input type="button" class="button01" style="width:50px" onclick="add('>=','>=');" value=">=">
                <input type="button" class="button01" style="width: 50px" value="!=" onclick="add('!=','!=');">
            </c:verbatim>
        </h:panelGroup>
<h:outputText value=""/>
        <h:panelGroup>
                    <h:outputText value="" />
                    <h:outputText value="" />
                    <h:outputText value="" />
                    <h:outputText value="" />
                    <h:outputText value="" />
                    <h:outputText value="" />
        </h:panelGroup>
        <h:panelGroup>
            <c:verbatim escape="false">
                <input type="button" class="button01" style="width:50px" value="0" onclick="add('0','0');">
                <input type="button" class="button01" style="width:50px" onclick="add('||','OR');" value="OR">
                <input type="button" class="button01" style="width:50px" onclick="add('==','==');"
                       value="==">
                <input type="button" class="button01" style="width:50px" onclick="add('<=','<=');" value="<=">
                													
            </c:verbatim>
			<h:commandButton styleClass="button01" style="width:50px" value="clear"
				action="#{attexecluderuletitemBB.clear}" />
        </h:panelGroup>
        <h:panelGroup>
<h:outputText value="" />
        </h:panelGroup>

        <h:panelGroup>
            <c:verbatim escape="false">
<h:outputText value="" />
<h:outputText value="" />
            </c:verbatim>
        </h:panelGroup>
            </h:panelGrid>
                <h:outputText value="定义"></h:outputText>
			<h:inputTextarea id="place"
				value="#{attexecluderuletitemBB.bo.contentSql}" cols="80" rows="5"></h:inputTextarea>

    </h:panelGrid>
    </h:panelGrid>
    </h:form>
    <c:verbatim escape="false">
    <script type="text/javascript" language="javascript">
        interpret(document.forms(0));
    </script>
</c:verbatim>
