<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim>
    
        <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
        <script language="javascript" src="/js/commonFuns.js"></script>
        <script language="javascript" src="/js/editor.js"></script>
        <script language="javascript" src="/js/editor_toolbar.js"></script>
    </c:verbatim>

    <script type="text/javascript">
         function doCheck(){
            if (document.all('form1:title').value==""){
                alert("��¼������!");
                return false;
            }
            PutTextareaValue(document.all('form1:textarea'),fGetContent());
            return true;
        }
    </script>

<x:saveState value="#{eva_itemKeyBB}"/>
<h:form id="form1" >
        <h:inputHidden id="pageInit" value="#{eva_itemKeyBB.editItem}"/>
<c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td width=100px class="td_form01" align="right">���</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputHidden value="#{eva_itemKeyBB.itemkeyBO.setID}" />
                    <h:inputText readonly="true" value="#{eva_itemKeyBB.itemkeyBO.setName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr>
            <td class="td_form01" align="right">��λ��Χ</td>
            <td class="td_form02" >
 </c:verbatim>
                <h:panelGroup>
                    <h:selectOneMenu id="orgID" value="#{eva_itemKeyBB.itemkeyBO.orguid}">
                        <c:selectItems value="#{eva_itemKeyBB.orgList}"></c:selectItems>
                    </h:selectOneMenu>
                </h:panelGroup>
<c:verbatim>
            </td>
            </tr>

            <tr>
                <td class="td_form01" align="right">����</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="title" value="#{eva_itemKeyBB.itemkeyBO.itemName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

    <tr>
        <td class="td_form01" align="right">ָ������</td>
        <td class="td_form02">
</c:verbatim>
            <h:selectOneRadio id="itemType" value="#{eva_itemKeyBB.itemkeyBO.itemType}">
                <c:selectItem itemValue='0' itemLabel='����'></c:selectItem>
                <c:selectItem itemValue='1' itemLabel='����'></c:selectItem>
                <c:selectItem itemValue='2' itemLabel='����'></c:selectItem>
            </h:selectOneRadio>
<c:verbatim>
        </td>
    </tr>
	 <tr>
        <td class="td_form01" align="right">����������������ָ�꣩</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText value="#{eva_itemKeyBB.itemkeyBO.itemFun}"></h:inputText>
<c:verbatim>
        </td>
    </tr>
    <tr>
        <td class="td_form01" align="right">�Ƿ���Ч</td>
        <td class="td_form02">
</c:verbatim>
             <h:selectOneRadio value="#{eva_itemKeyBB.itemkeyBO.validFlag}">
                      <c:selectItem itemValue='0' itemLabel='��Ч'></c:selectItem>
                      <c:selectItem itemValue='1' itemLabel='��Ч'></c:selectItem>
             </h:selectOneRadio><c:verbatim>
        </td>
    </tr>

    <tr>
        <td class="td_form01" align="right">��ʾ˳��</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_itemKeyBB.itemkeyBO.showSEQ}"></h:inputText>
<c:verbatim>
        </td>
    </tr>

    <tr>
        <td class="td_form01" align="right">����</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_itemKeyBB.itemkeyBO.itemDes}"></h:inputText>
<c:verbatim>
        </td>
    </tr>

    <tr>
        <td class="td_form01" align="right">��ֱ�׼</td>
        <td class="td_form02">
</c:verbatim>
             <h:inputTextarea id="textarea" rows="15" cols="60" style="display:none;"
                        value="#{eva_itemKeyBB.itemkeyBO.scoreStandard}" />
<c:verbatim>
        <script language="javascript">
            gFrame = 1;//1-�ڿ����ʹ�ñ༭��
            gContentId = "form1:textarea";//Ҫ�������ݵ�content ID
            OutputEditorLoading();
        </script>
        <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>

        </td>
    </tr>
    
    <tr>
        <td class="td_form01">��������</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_itemKeyBB.itemkeyBO.lowValue}"></h:inputText>
<c:verbatim>
        </td>
    </tr>

    <tr>
        <td class="td_form01">��������</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_itemKeyBB.itemkeyBO.highValue}"></h:inputText>
<c:verbatim>
        </td>
    </tr>

        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="����" onclick="return doCheck();" action="#{eva_itemKeyBB.saveItem}" styleClass="button01" />
                <h:commandButton value="����"  type="button" onclick="window.close()" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
