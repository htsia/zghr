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
                 alert("���˳����Ϊ��!")
                 return false;
            }
            if (document.all("form1:name").value=="") {
                alert("��Ŀ����Ϊ��!")
                return false;
            }
            if (document.all("form1:field").value=="") {
                alert("��Ӧ�ֶβ���Ϊ��!")
                return false;
            }

              if (document.all("form1:field").value=="fix" && document.all("form1:caption").value==""){
                  alert("������д�̶��ַ���ֵ!");
                  return false;
              }

            if (document.all("form1:dateFormat").value=="") {
                alert("��Ҫ��д���ڸ�ʽ!")
                return false;
            }

           if (document.all("form1:width").value!=="" && document.all("form1:width").value!=="0"){
               if (document.all("form1:beforeChar").value=="" && document.all("form1:behindChar").value==""){
                   alert("������дǰ׺���׺�ַ�!");
                   return false;
               }
               if (document.all("form1:cutStyle").value==""){
                   alert("������д�ü���ʽ!");
                   return false;
               }
           }
           else if (document.all("form1:width").value==""){
               alert("��Ȳ���Ϊ��!")
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

            <h:outputText value="���˳��"/>
            <h:inputText styleClass="input"  id="seq" value="#{wage_bankitemeditBB.wcbo.arrangeOrder}" />

            <h:outputText value="��Ŀ����"/>
            <h:inputText styleClass="input"  id="name" value="#{wage_bankitemeditBB.wcbo.payName}" />

            <h:outputText value="��Ӧ�ֶ�" />
            <h:selectOneMenu id="field" value="#{wage_bankitemeditBB.wcbo.fieldID}">
                <c:selectItems value="#{wage_bankitemeditBB.fieldList}"></c:selectItems>
            </h:selectOneMenu>

            <h:outputText value="�̶��ַ���ֵ"/>
            <h:inputText id="caption" styleClass="input"  value="#{wage_bankitemeditBB.wcbo.caption}" />

            <h:outputText value="���(0��ʾ����)"/>
            <h:inputText styleClass="input"  id="width" value="#{wage_bankitemeditBB.wcbo.width}" />

            <h:outputText value="�Ƿ���ʾС����"/>
            <h:selectOneMenu value="#{wage_bankitemeditBB.wcbo.radixPoint}">
                <c:selectItem itemLabel="" itemValue=""></c:selectItem>
                <c:selectItem itemLabel="��ʾ" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="����ʾ" itemValue="0"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="�Ƿ���ȡ��"/>
            <h:selectOneMenu value="#{wage_bankitemeditBB.wcbo.roundVal}">
                <c:selectItem itemLabel="" itemValue=""></c:selectItem>
                <c:selectItem itemLabel="ȡ��" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="��ȡ��" itemValue="0"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="���ڸ�ʽ"/>
            <h:selectOneMenu id="dateFormat" value="#{wage_bankitemeditBB.wcbo.dateFormat}">
                <c:selectItem itemLabel="�������ֶ�" itemValue="-1"></c:selectItem>
                <c:selectItem itemLabel="yyyy-MM-dd" itemValue="yyyy-MM-dd"></c:selectItem>
                <c:selectItem itemLabel="yyyyMMdd" itemValue="yyyyMMdd"></c:selectItem>
                <c:selectItem itemLabel="yyyy-MM" itemValue="yyyy-MM"></c:selectItem>
                <c:selectItem itemLabel="yyyyMM" itemValue="yyyyMM"></c:selectItem>
            </h:selectOneMenu>

            <h:outputText value="ǰ׺�ַ�"/>
            <h:inputText styleClass="input"  id="beforeChar" value="#{wage_bankitemeditBB.wcbo.beforeChar}" />

            <h:outputText value="��׺�ַ�"/>
            <h:inputText id="behindChar" styleClass="input"  value="#{wage_bankitemeditBB.wcbo.behindChar}" />

            <h:outputText value="�ָ��ַ�(9-TAB)"/>
            <h:inputText id="separator" styleClass="input" value="#{wage_bankitemeditBB.wcbo.separator}" />

            <h:outputText value="�����ʽ"/>
            <h:selectOneMenu id="cutStyle" value="#{wage_bankitemeditBB.wcbo.cutStyle}">
                <c:selectItem itemLabel="" itemValue=""></c:selectItem>
                <c:selectItem itemLabel="��ü�" itemValue="1"></c:selectItem>
                <c:selectItem itemLabel="�Ҳü�" itemValue="0"></c:selectItem>
            </h:selectOneMenu>
        </h:panelGrid>

        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="����" action="#{wage_bankitemeditBB.save}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" value="ȡ������" onclick="window.close();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
