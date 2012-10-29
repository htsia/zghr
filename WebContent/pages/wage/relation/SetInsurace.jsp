<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<base target="_self">
<x:saveState value="#{wage_salaryRelationBB}"/>
<script type="text/javascript">
   function doSetByOld(){
      for(i=0;i<document.all('form1:data').rows.length-1;i++){
          document.all('form1:data_'+i+':new').value=document.all('form1:data_'+i+':old').value;
      }
       return false;
   }
</script>
<h:form id="form1">
    <h:inputHidden value="#{wage_salaryRelationBB.setInsurace}"/>
    <h:inputHidden value="#{wage_salaryRelationBB.chid}"/>

    <h:panelGrid width="98%"  align="center"  bgcolor="#FFFFFF" cellpadding="0" columns="2"
                    cellspacing="0" styleClass="td_title">
        <h:panelGrid width="60%" >
            <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="薪酬基本信息"/>
            </h:panelGroup>
       </h:panelGrid>
        <h:panelGrid width="40%" align="right" >
             <h:panelGroup>
                 <h:commandButton value="设定为原值" type="button" styleClass="button01" onclick="doSetByOld();"></h:commandButton>
                 <h:commandButton value="保存" styleClass="button01" action="#{wage_salaryRelationBB.saveNewInsuracd}"></h:commandButton>
                 <h:commandButton value="返回" styleClass="button01" type="button" onclick="window.close();"></h:commandButton>
             </h:panelGroup>
        </h:panelGrid>
    </h:panelGrid>
    <br>
    <x:dataTable rowIndexVar="index" id="data" width="100%" align="center"
             value="#{wage_salaryRelationBB.baseInfoList}" var="paylist"  headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03">
           <h:column>
                <f:facet name="header">
                    <h:outputText value="序号"></h:outputText>
                </f:facet>
                <h:outputText value="#{index+1}"  />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="项目"></h:outputText>
                </f:facet>
                <h:outputText value="#{paylist[0]}"   />
            </h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText value="原数值"></h:outputText>
                </f:facet>
                <h:inputText readonly="true" id="old" value="#{paylist[1]}"  />
            </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText value="拟定额"> </h:outputText>
            </f:facet>
            <h:inputText id="new" value="#{paylist[2]}"  />
        </h:column>

        </x:dataTable>
</h:form>

