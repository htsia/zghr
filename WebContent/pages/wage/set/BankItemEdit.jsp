<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    
    <script type="text/javascript">
        function doCheck(){
            //debugger;
            if (document.all("form1:seq").value=="") {
                 alert("输出顺序不能为空!")
                 return false;
            }
            if (document.all("form1:name").value=="") {
                alert("项目不能为空!")
                return false;
            }
            if (document.all("form1:field").value=="") {
                alert("对应字段不能为空!")
                return false;
            }

              if (document.all("form1:field").value=="fix" && document.all("form1:caption").value==""){
                  alert("必须填写固定字符串值!");
                  return false;
              }

            if (document.all("form1:dateFormat").value=="") {
                alert("需要填写日期格式!")
                return false;
            }

           if (document.all("form1:width").value!=="" && document.all("form1:width").value!=="0"){
               if (document.all("form1:beforeChar").value=="" && document.all("form1:behindChar").value==""){
                   alert("必须填写前缀或后缀字符!");
                   return false;
               }
               if (document.all("form1:cutStyle").value==""){
                   alert("必须填写裁剪方式!");
                   return false;
               }
           }
           else if (document.all("form1:width").value==""){
               alert("宽度不能为空!")
               return false;
           }
           return true;
        }
    </script>

<x:saveState value="#{wage_bankitemeditBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_bankitemeditBB.pageInit}"/>

    <h:panelGrid align="center" width="90%">
        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">

            <h:outputText value="输出顺序"/>
            <h:inputText styleClass="input"  id="seq" value="#{wage_bankitemeditBB.wcbo.arrangeOrder}" />

            <h:outputText value="项目名称"/>
            <h:inputText styleClass="input"  id="name" value="#{wage_bankitemeditBB.wcbo.payName}" />

            <h:outputText value="对应字段" />
            <h:selectOneMenu id="field" value="#{wage_bankitemeditBB.wcbo.fieldID}">
                <c:selectItems value="#{wage_bankitemeditBB.fieldList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="固定字符串值"/>
            <h:inputText id="caption" styleClass="input"  value="#{wage_bankitemeditBB.wcbo.caption}" />

            <h:outputText value="宽度(0表示任意)"/>
            <h:inputText styleClass="input"  id="width" value="#{wage_bankitemeditBB.wcbo.width}" />

            <h:outputText value="是否显示小数点"/>
            <h:selectOneMenu value="#{wage_bankitemeditBB.wcbo.radixPoint}">
                <c:selectItem itemLabel="" itemValue=""></c:selectItem>
                <c:selectItem itemLabel="显示" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="不显示" itemValue="0"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="是否金额取整"/>
            <h:selectOneMenu value="#{wage_bankitemeditBB.wcbo.roundVal}">
                <c:selectItem itemLabel="" itemValue=""></c:selectItem>
                <c:selectItem itemLabel="取整" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="不取整" itemValue="0"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="日期格式"/>
            <h:selectOneMenu id="dateFormat" value="#{wage_bankitemeditBB.wcbo.dateFormat}">
                <c:selectItem itemLabel="非日期字段" itemValue="-1"></c:selectItem>
                <c:selectItem itemLabel="yyyy-MM-dd" itemValue="yyyy-MM-dd"></c:selectItem>
                <c:selectItem itemLabel="yyyyMMdd" itemValue="yyyyMMdd"></c:selectItem>
                <c:selectItem itemLabel="yyyy-MM" itemValue="yyyy-MM"></c:selectItem>
                <c:selectItem itemLabel="yyyyMM" itemValue="yyyyMM"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="前缀字符"/>
            <h:inputText styleClass="input"  id="beforeChar" value="#{wage_bankitemeditBB.wcbo.beforeChar}" />

            <h:outputText value="后缀字符"/>
            <h:inputText id="behindChar" styleClass="input"  value="#{wage_bankitemeditBB.wcbo.behindChar}" />

            <h:outputText value="分割字符(9-TAB)"/>
            <h:inputText id="separator" styleClass="input" value="#{wage_bankitemeditBB.wcbo.separator}" />

            <h:outputText value="输出方式"/>
            <h:selectOneMenu id="cutStyle" value="#{wage_bankitemeditBB.wcbo.cutStyle}">
                <c:selectItem itemLabel="" itemValue=""></c:selectItem>
                <c:selectItem itemLabel="左裁剪" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="右裁剪" itemValue="0"></c:selectItem>
            </h:selectOneMenu>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{wage_bankitemeditBB.save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
