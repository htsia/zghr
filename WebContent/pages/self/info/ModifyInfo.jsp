<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doselect(){
            if (form1.all("form1:newselect").dataType=="6"){
              PopUpCodeDlgOneControl('form1:new');
            }
            else if (form1.all("form1:newselect").dataType=="5"){
              PopUpCalendarDialog('form1:new');
            }
            else if (form1.all("form1:newselect").dataType=="15"){
              PopUpCalendarDlg_OnlyMonth('form1:new');
            }
        }
        function beforeSave(){
            if (form1.all("form1:modifields").value=="-1"){
                alert("请选择修改项目");
                return false;
            }
            if(forsubmit(document.forms(0))){
                return true;
            }
            return false;
        }
        function changeField() {
            form1.all("form1:newselect").style.display="none";
            var count = form1.all("form1:modifields").options.length;
            for(var i=0;i<count;i++){
                if (form1.all("form1:modifields").options[i].selected && i!=0){
                    // 格式=项目ID,数据类型,显示数值,数据库值,代码类
                    var values=form1.all("form1:modifields").options[i].value.split(",");
                    form1.all("form1:newselect").dataType=values[1];
                    if (values[1]=="6"){ // 代码字段
                        form1.all("form1:new").dict="yes";
                        form1.all("form1:new").dict_num=values[4];
                        form1.all("form1:new").readOnly=true;

                        form1.all("form1:old").dict="yes";
                        form1.all("form1:old").dict_num=values[4];
                        form1.all("form1:old").code=values[3];
                        form1.all("form1:old").value=values[2];
                        form1.all("form1:newselect").style.display="block";
                        form1.all("form1:newselect").className="button_select";
                    }
                    else if (values[1]=="5" || values[1]=="15"){
                        form1.all("form1:new").readOnly=true;
                        form1.all("form1:old").value=values[2];
                        form1.all("form1:newselect").style.display="block";
                        form1.all("form1:newselect").className="button_date";
                    }
                    else{
                        form1.all("form1:new").readOnly=false;
                        form1.all("form1:new").dict="";
                        form1.all("form1:new").dict_num="";

                        form1.all("form1:old").dict="";
                        form1.all("form1:old").dict_num="";
                        form1.all("form1:old").code="";
                        form1.all("form1:old").value=values[2];
                    }
                }
            }
            return false;
        }
    </script>

<x:saveState value="#{self_personEditBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden id="init" value="#{self_personEditBB.beginUpdate}"/>
    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
            <h:outputText value="姓名"/>
            <h:inputText id="name" readonly="true" value="#{self_personEditBB.smodi.persName}"/>

            <h:outputText value="修改参数" />
            <h:selectOneMenu id="modifields" value="#{self_personEditBB.fieldID}" onchange="changeField();">
                <f:selectItems value="#{self_personEditBB.updateFieldList}"></f:selectItems>
            </h:selectOneMenu>

            <h:outputText value="原值" />
            <h:inputText id="old" readonly="true" code="" dict="" dict_num="" value="#{self_personEditBB.smodi.oldValue}"/>

            <h:outputText value="新值" />
            <h:panelGroup>
                <h:inputText id="new"  value="#{self_personEditBB.smodi.newValue}"    code="" dict="" dict_num=""/>
                <c:verbatim>
                   <input type="button"  dataType="" class="button_select" id="form1:newselect"
                       onclick="doselect();" >
                </c:verbatim>
            </h:panelGroup>

            <h:outputText value="修改原因" />
            <h:inputTextarea id="reason"  value="#{self_personEditBB.smodi.reason}" rows="5" cols="25"/>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{self_personEditBB.Save}"
                             onclick="return beforeSave();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
    if (form1.all("form1:newselect").dataType=="6" || form1.all("form1:newselect").dataType=="5" || form1.all("form1:newselect").dataType=="15"){
        form1.all("form1:newselect").style.display="block";
    }
</script>
