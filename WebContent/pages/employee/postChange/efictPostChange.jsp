<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<script type="text/javascript">
	
</script>
    <x:saveState value="#{emppostChangeMgrBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emppostChangeMgrBB.initEfictPersons}"/>
        <h:inputHidden id="personIds" value="#{emppostChangeMgrBB.personIds}"></h:inputHidden>
        <c:verbatim>
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
			<tr nowrap>
            	<td class=td_form01 >人员</td>
                <td class=td_form02 >
</c:verbatim>
                   <h:inputTextarea value="#{emppostChangeMgrBB.personNames}" rows="3" cols="50" disabled="true">
                   </h:inputTextarea>
<c:verbatim>
                </td>
            </tr>

            <tr nowrap>
                <td class=td_form01><%=LanguageSupport.getResource("XTGL-1297","生效时间")%></td>
                <td class=td_form02>
</c:verbatim>
                <h:inputText styleClass="input" id="efictDate" value="#{emppostChangeMgrBB.efictDate}"
                     readonly="true" alt="日期|1|d|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:efictDate')" rendered="#{emppostChangeMgrBB.dateShowMode=='8'}"></h:commandButton>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:efictDate')" rendered="#{emppostChangeMgrBB.dateShowMode=='6'}"></h:commandButton>
<c:verbatim> 
               </td>
            </tr>
			
    <tr nowrap>
        <td class=td_form01>简历子集增加记录</td>
        <td class=td_form02>
</c:verbatim>
        <h:selectOneRadio value="#{emppostChangeMgrBB.addResume}">
            <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
            <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
        </h:selectOneRadio>
<c:verbatim>
       </td>
    </tr>

        </table>
        <br>
        <table  border=0 align=center cellpadding=0 cellspacing=0 width='100%'>
            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="生效"  action="#{emppostChangeMgrBB.shengxiao}" />
                    <h:commandButton id="quit" type="button" styleClass="button01" value="取消"   onclick="window.close();"/>
<c:verbatim>
            </td>
            </tr>
        </table>
</c:verbatim>
    </h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>