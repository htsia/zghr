<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script type="text/javascript">
        function saveItemSet(){
            var count = document.all('form1:showItem').options.length;
            if (count!=null){
                var item=document.all('form1:showItem').options[0].value;
                for (i = 1; i < count; i++) {
                    item+=","+document.all('form1:showItem').options[i].value
                }
                document.all('form1:showItemString').value=item;
            }
            else{
                document.all('form1:showItemString').value="";
            }
            return true;
        }
        function moveUP(){
            if (!isNature(document.all('form1:step').value)){
                alert("�ƶ�λ���Ƿ���");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
               forUpItem(form1.all('form1:showItem'));
            }
        }
        function moveDown(){
            if (!isNature(document.all('form1:step').value)){
                alert("�ƶ�λ���Ƿ���");
            }
            for(var i=0;i<parseInt(document.all('form1:step').value);i++){
              forDownItem(form1.all('form1:showItem'));
            }
        }

    </script>
<x:saveState value="#{emp_busiprocessBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emp_busiprocessBB.initShowItem}"></h:inputHidden>
    <h:inputHidden value="#{emp_busiprocessBB.setId}"></h:inputHidden>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="3" align="center" width="80%"      styleClass="table03" columnClasses="td_middle,td_middle,td_middle">
        <h:panelGrid columns="1">
            <h:panelGroup>
                 <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2395","ȫ����Ŀ") %>  
                 </f:verbatim>
            </h:panelGroup>
            <h:selectManyListbox id="allItem" style="width:15em" size="30" >
                <c:selectItems value="#{emp_busiprocessBB.allList}"/>
            </h:selectManyListbox>
        </h:panelGrid>

        <h:panelGrid columns="1" align="center">
            <h:commandButton type="button" value="���" onclick="forAddItem(form1.all('form1:showItem'),form1.all('form1:allItem'))" styleClass="button01"/>
            <h:commandButton type="button" value="ɾ��" onclick="removeItem(form1.all('form1:showItem'))" styleClass="button01"/>
            <c:verbatim><br></c:verbatim>
            <h:commandButton type="button" value="����" onclick="moveUP();" styleClass="button01"/>
            <h:commandButton type="button" value="����" onclick="moveDown();" styleClass="button01"/>
        </h:panelGrid>
        
        <h:panelGrid columns="1">
             <f:verbatim>
                    <%=LanguageSupport.getResource("RYGL-2396","��ѡ��Ŀ") %>  
                 </f:verbatim>
            <h:inputHidden id="showItemString"></h:inputHidden>            
            <h:selectManyListbox id="showItem" style="width:15em" size="30" >
                <c:selectItems value="#{emp_busiprocessBB.showList}"/>
            </h:selectManyListbox>
        </h:panelGrid>    
    </h:panelGrid>

    <c:verbatim><br></c:verbatim>

    <h:panelGrid columns="2" align="right" border="0">
        <h:panelGroup>
               <f:verbatim>
                    <%=LanguageSupport.getResource("JGGL-1030","ÿ���ƶ�λ��") %> �� 
                 </f:verbatim>
            <h:inputText id="step" value="" />
        </h:panelGroup>

        <h:panelGroup>
            <h:commandButton value="����"  action="#{emp_busiprocessBB.saveItemSet}"  onclick="return saveItemSet();" styleClass="button01"/>
            <h:commandButton value="�ر�" type="button" onclick="window.close()" styleClass="button01"/>
        </h:panelGroup>
    </h:panelGrid>
</h:form>
