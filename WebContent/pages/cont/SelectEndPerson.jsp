<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
   <script type="text/javascript" language="javascript">
   function selectNewPerson() {
        var field = form1.all('selected_ids');
        if (checkMutilSelect(field)) {
            revalue = "";
            count = field.length;
            if (count != null) {
                for (i = 0; i < count; i++)
                    if (field[i].checked) {
                        revalue += field[i].value + ",";
                    }
            } else {
                revalue = field.value;
            }
            window.returnValue = revalue;
            //alert(revalue);
            window.close();
        } else {
            alert("��ѡ����Ա��");
            return false;
        }
    }
</script>

<h:form id="form1">
    <h:inputHidden id="init_a" value="#{cont_contSelectEndPersonBB.init_a}"/>
    <c:verbatim>
        <table width=98% height=98% align="center">
            <tr><td height=8>
    </c:verbatim>
        <h:panelGrid width="100%" columns="2" styleClass="td_title"  border="0" cellspacing="0" cellpadding="0" >
            <h:panelGroup>
               <h:graphicImage value="/images/tips.gif" />
               <h:outputText value="ѡ���ͬ����Ա��" ></h:outputText>
            </h:panelGroup>

            <h:panelGrid  border="0"  cellspacing="0" align="right" columns="2" >
                <c:verbatim escape="false"> <input type="button"  class="button01" value="ȷ��" onclick="selectNewPerson()"> </c:verbatim>
                <h:commandButton  styleClass="button01" value="ȡ��" onclick="javascript:window.close();"/>
             </h:panelGrid>

        </h:panelGrid>
    <c:verbatim>
            </td></tr>

           <tr><td height=8>
     </c:verbatim>
        <h:panelGrid align="right" styleClass="locked_top" columns="2" width="98%">
            <h:panelGrid  border="0"  cellspacing="0" align="left" columns="3" >
                <h:outputText value="������Ա����ţ�"/>
                <h:inputText styleClass="input" size="20" id="personNameQry" value="#{cont_contSelectEndPersonBB.personNameQry}"/>
                <h:commandButton styleClass="button01" value=" ��ѯ " action="#{cont_contSelectEndPersonBB.doQuery}"/>
            </h:panelGrid>

            <h:panelGroup>
                <h:outputText value="��¼��:#{cont_contSelectEndPersonBB.pagevo.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ҳ��:#{cont_contSelectEndPersonBB.pagevo.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="ÿҳ��#{cont_contSelectEndPersonBB.pagevo.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��ǰΪ��#{cont_contSelectEndPersonBB.pagevo.currentPage}ҳ"></h:outputText>
                <h:commandButton value="��ҳ" action="#{cont_contSelectEndPersonBB.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{cont_contSelectEndPersonBB.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="��ҳ" action="#{cont_contSelectEndPersonBB.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="βҳ" action="#{cont_contSelectEndPersonBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>
     <c:verbatim>
         </td></tr>

          <tr><td>
              <div style='width:100%;height:100%;overflow:auto' id=datatable>
     </c:verbatim>
                <x:dataTable value="#{cont_contSelectEndPersonBB.bos}" var="list"  rowIndexVar="index"
                                         headerClass="td_top" align="center" id="dateList"
                                         rowClasses="td_middle" styleClass="table03" width="98%" border="1">
                                 <h:column>
                                      <c:facet name="header">
                                          <c:verbatim escape="false">
                                          <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selected_ids)"/>
                                          </c:verbatim>
                                          </c:facet>
                                      <c:verbatim escape="false"><input type="checkbox" name="selected_ids" value="</c:verbatim>
                                      <h:outputText value="#{list.personId}"/>
                                      <c:verbatim>"></c:verbatim>
                                  </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="���"/></c:facet>
                            <h:outputText value="#{index+1}"/>
                        </h:column>

                        <h:column>
                            <c:facet name="header"><h:outputText value="��ͬ���"/></c:facet>
                            <h:outputText value="#{list.contCode}"/>
                        </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
                        <h:outputText value="#{list.contPersonBO.personCode}"/>
                    </h:column>

                        <h:column>
                            <c:facet name="header"><h:outputText value="����"/></c:facet>
                            <h:outputText value="#{list.personName}"/>
                        </h:column>

                        <h:column>
                            <c:facet name="header"><h:outputText value="��ͬ��ʼʱ��"/></c:facet>
                            <h:outputText value="#{list.contStartDate}"/>
                        </h:column>
                        <h:column>
                            <c:facet name="header"><h:outputText value="��ͬ����ʱ��"/></c:facet>
                            <h:outputText value="#{list.contEndDate}"/>
                        </h:column>

                    </x:dataTable>
<c:verbatim>
               </div>
          </td></tr>
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
