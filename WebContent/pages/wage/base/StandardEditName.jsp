<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript">
	    // 选择指标项
	    function selectInfoItem() {
	        showx = event.screenX - event.offsetX - 150;
	        showy = event.screenY - event.offsetY + 18;
	
	        retval = window.showModalDialog("/pages/wage/base/FormulaInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
	        if (retval != null) {
	            rs = retval.split("|");
	            document.all('form1:infoItem').value = rs[1];
	            var item=rs[0].split(".");
	            document.all('form1:saveAsField').value=item[1];
	        }
	    }
	    var dict_num;
	    function changeSet1(){
	    	dict_num=null;
	    	document.getElementById("form1:filterValue").value="";
	    	document.getElementById("form1:codeID").value="";
	    	var field=document.getElementById("form1:conditionfield").value;
	    	if(field!="-1"){
		    	$.post("/pages/custom/fieldCodeSet.jsp?field="+field, function(e){
		    		if(e!=-1){
			    		dict_num=e;
				    	$("#selCode1").show();
		    		}else{
		    			$("#selCode1").hide();
		    		}
		    	});
	    	}else{
	    		$("#selCode1").hide();
	    	}
	    }
        function selCode11(){
        	var field=document.getElementById("form1:conditionfield").value;
        	PopUpCodeDlgTwoControl(document.getElementById("form1:codeID"), document.getElementById("form1:filterValue"), dict_num);
        }
        function chkNull() {
	        if (document.all("form1:conditionfield").value != "" && document.all("form1:conditionfield").value != "-1") {
	            if (document.all("form1:conditionoper").value=="" || document.all("form1:conditionoper").value=="-1"){
	              alert("请选择操作符！");
	              return false;
	            }
	            if (document.all("form1:filterValue").value==""){
	               alert("请录入要比较的数值！");
	               return false;
	            }
	        }
	        if(forsubmit(document.forms(0))){
	        	if(dict_num!=null){
	        		document.getElementById("form1:filterValue").value=document.getElementById("form1:codeID").value;
	        	}
	        	return true;
	        }else{
	        	return false;
	        }
	    }
        $(function(){
	        var field=document.all("form1:conditionfield").value;
	        var value=document.all("form1:filterValue").value;
	        var url="/pages/custom/setFieldValue.jsp?field="+field+"&value="+value;
	        $.post(url, function(e){
	    		if(e!=-1){
	    			var v=e.split("|");
	    			document.getElementById("form1:codeID").value=value;
	    			document.getElementById("form1:filterValue").value=v[0];
	    			dict_num=v[1];
			    	$("#selCode1").show();
	    		}else{
	    			$("#selCode1").hide();
	    		}
	    	});
        });
    </script>

<x:saveState value="#{wage_standardBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="unitId" value="#{wage_standardBB.standard.unitId}"/>
    <h:inputHidden id="stdId" value="#{wage_standardBB.standard.stdId}"/>
    <h:inputHidden id="codeID" value=""/>
    <h:panelGrid align="center" width="95%">
        <h:panelGrid align="right" columns="3" cellspacing="2">
            <h:commandButton styleClass="button01" value="上一步" action="#{wage_standardBB.step3_setValue}"/>
            <h:commandButton styleClass="button01" value="保存" action="#{wage_standardBB.save}"
                             onclick="return chkNull();"/>
            <h:commandButton styleClass="button01" value="取消返回" action="#{wage_standardBB.list}"/>
        </h:panelGrid>
        <h:panelGrid width="100%" align="center" styleClass="table03" columns="2" columnClasses="td_form01,td_form02">
            <h:outputText value="标准表名称"/>
            <h:inputText id="name" value="#{wage_standardBB.standard.name}" alt="标准表名称|0" size="40" maxlength="50"/>

            <h:outputText value="标准表描述"/>
            <h:inputTextarea id="desc" value="#{wage_standardBB.standard.desc}" cols="80" rows="6"/>

            <h:outputText value="适用月份"/>
            <h:selectManyCheckbox value="#{wage_standardBB.standard.applyMonthList}" id="month"  >
                <c:selectItem itemValue="-1" itemLabel="全部月份"/>
                <c:selectItem itemValue="01" itemLabel="1"/>
                <c:selectItem itemValue="02" itemLabel="2"/>
                <c:selectItem itemValue="03" itemLabel="3"/>
                <c:selectItem itemValue="04" itemLabel="4"/>
                <c:selectItem itemValue="05" itemLabel="5"/>
                <c:selectItem itemValue="06" itemLabel="6"/>
                <c:selectItem itemValue="07" itemLabel="7"/>
                <c:selectItem itemValue="08" itemLabel="8"/>
                <c:selectItem itemValue="09" itemLabel="9"/>
                <c:selectItem itemValue="10" itemLabel="10"/>
                <c:selectItem itemValue="11" itemLabel="11"/>
                <c:selectItem itemValue="12" itemLabel="12"/>
            </h:selectManyCheckbox>
            
            <h:outputText value="是否公用标准"/>
            <h:selectOneRadio  value="#{wage_standardBB.standard.publicFlag}">
                 <c:selectItem itemValue="00901" itemLabel="是"></c:selectItem>
                 <c:selectItem itemValue="00900" itemLabel="否"></c:selectItem>
            </h:selectOneRadio>

            <h:outputText value="适用条件设定"/>
            <h:panelGroup>
                <h:selectOneMenu style="width:160px;" id="conditionfield" onchange="changeSet1();" value="#{wage_standardBB.standard.filterField}">
                   <c:selectItems value="#{wage_standardBB.filterFields}"></c:selectItems>
                </h:selectOneMenu>
                <h:selectOneMenu style="width:80px;" id="conditionoper" value="#{wage_standardBB.standard.filterOper}">
                    <c:selectItem itemValue="-1" itemLabel="比较符"></c:selectItem>
                    <c:selectItem itemValue=">" itemLabel="大于"></c:selectItem>
                    <c:selectItem itemValue=">=" itemLabel="大于等于"></c:selectItem>
                    <c:selectItem itemValue="<" itemLabel="小于"></c:selectItem>
                    <c:selectItem itemValue="<=" itemLabel="小于等于"></c:selectItem>
                    <c:selectItem itemValue="=" itemLabel="等于"></c:selectItem>
                    <c:selectItem itemValue="<>" itemLabel="不等于"></c:selectItem>
                </h:selectOneMenu>
                <h:inputText id="filterValue" value="#{wage_standardBB.standard.filterValue}"/>
                <c:verbatim>
                   <input id="selCode1" type="button" class="button_select" onclick="selCode11();" style="display: none;">
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="另存结果于"/>
            <h:panelGroup>
                <h:inputHidden id="saveAsField" value="#{wage_standardBB.standard.saveAsField}"></h:inputHidden>
                <h:inputText readonly="true" id="infoItem" value="#{wage_standardBB.standard.saveAsFieldDes}"></h:inputText>
                <c:verbatim>
                   <input type="button" class="button_select" onclick="selectInfoItem();">
                </c:verbatim>
            </h:panelGroup>

        </h:panelGrid>
    </h:panelGrid>
</h:form>
