<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../include/taglib.jsp" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
         function doCheck(){
            if (document.all('form1:A001706').value==null || document.all('form1:A001706').value==""){
                alert("��¼�뿼�ں�!");
                return false;
            }
            return true;
        }
    </script>
    <x:saveState value="#{AttCardMgr_ChildBB}"/>
    <h:form id="form1">
    <h:inputHidden value="#{AttCardMgr_ChildBB.pageInit}"/>
    <h:inputHidden id="superId" value="#{AttCardMgr_ChildBB.superId}"/> 
    <h:inputHidden id="oldAttCardId" value="#{AttCardMgr_ChildBB.oldAttCard}"/>     
        <c:verbatim>
        <br>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95%>   
        <tr nowrap>
                 <td width="90" class=td_form01>����ְԱ:</td>
                  <td class=td_form01> </c:verbatim>
                  <h:outputText value="#{AttCardMgr_ChildBB.namelist}"></h:outputText>
                  <c:verbatim></td>
        </tr>                
            <tr nowrap>
                 <td width="90" class=td_form01>���ں�</td>
                 <td  class=td_form01>
 </c:verbatim>
                        <h:inputText styleClass="input" id="A001706"
                                     value="#{AttCardMgr_ChildBB.attCard}"
                                     alt="���ں�|1|s|50||"/>

                    <h:commandButton id="save" styleClass="button01" rendered="#{AttCardMgr_ChildBB.isExist==true}" value="����" onclick="return doCheck();" action="#{AttCardMgr_ChildBB.save}" />
                     <h:commandButton id="changesave" styleClass="button01" rendered="#{AttCardMgr_ChildBB.isExist==false}" value="����" onclick="return doCheck();" action="#{AttCardMgr_ChildBB.changeSave}" />
                      
                    </td>
<c:verbatim>
            </tr>
                    <tr nowrap>
                 <td width="90" class=td_form01>
                 </c:verbatim><h:outputText value="ԭ���ں�:" rendered="#{AttCardMgr_ChildBB.isExist==false}"></h:outputText><c:verbatim></td>
                  <td class=td_form01></c:verbatim>
                  <h:inputText styleClass="input" id="A001"
                                     value="#{AttCardMgr_ChildBB.oldAttCard}"
                                     alt="ԭ���ں�|1|s|50||"  readonly="true" rendered="#{AttCardMgr_ChildBB.isExist==false}"/>
                  <h:commandButton id="deletesave" styleClass="button01" rendered="#{AttCardMgr_ChildBB.isExist==false}" value="�˿�"  action="#{AttCardMgr_ChildBB.deleteCard}" /><c:verbatim></td>
        </tr> 
                            <tr nowrap>
                 <td width="90" class=td_form01>
                 </c:verbatim><h:outputText value="�ر���ʾ:" rendered="#{AttCardMgr_ChildBB.isExist==false}"></h:outputText><c:verbatim></td>
                  <td class=td_form01></c:verbatim>
                  <h:outputText  value="�˿����������������κ�ֵ��ֱ�ӵ���˿���ť����!" rendered="#{AttCardMgr_ChildBB.isExist==false}"/><c:verbatim>
                  </td>
        </tr> 
        </table>
</c:verbatim>
</h:form>
