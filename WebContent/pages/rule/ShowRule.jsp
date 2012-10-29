<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ include file="/pages/include/taglib.jsp" %>
<x:saveState value="#{rule_infobb}"/>
<c:verbatim><base target="_self"></c:verbatim>
<h:form>
 <h:inputHidden value="#{rule_infobb.initShowRule}"/>	
    <c:verbatim>
    <table width="100%">
         <tr><td class="td_title">
              <img src="/images/tips.gif" alt=""> 显示规章制度
         </td></tr>
     </table>
     <br>
     <table class="table03" width="98%" align="center">
         <tr>
             <td class="td_form01" width="20%">
               文件编号
             </td>
             <td class="td_form02" width="30%">
</c:verbatim>
                 <h:outputText value="#{rule_infobb.rfinfo.docno}"  />
    <c:verbatim>
             </td>

            <td class="td_form01" width="20%">
              发布时间
            </td>
            <td class="td_form02" width="30%">
    </c:verbatim>
             <h:outputText value="#{rule_infobb.rfinfo.publicDate}"  />
    <c:verbatim>
            </td>
         </tr>

         <tr>
            <td class="td_form01">
              标题
            </td>
            <td class="td_form02" colspan="3">
    </c:verbatim>
             <h:outputText value="#{rule_infobb.rfinfo.title}"  />
    <c:verbatim>
            </td>
         </tr>

         <tr>
            <td class="td_form01">
              关键字
            </td>
            <td class="td_form02" colspan="3">
    </c:verbatim>
             <h:outputText value="#{rule_infobb.rfinfo.keyWords}"  />
    <c:verbatim>
            </td>
         </tr>

         <tr>
            <td colspan="4" class=td_form02 align="left" valign="top">
    </c:verbatim>
                <h:outputText escape="false" value="<strong>内容:<br></strong>"  />
                <h:outputText  escape="false" value="#{rule_infobb.rfinfo.content}"  />
    <c:verbatim>
            </td>
         </tr>
         <tr>
             <td colspan="4" class=td_form02 align="left" valign="top">
    </c:verbatim>
                 <h:outputText escape="false" value="<strong>附件:<br></strong>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{rule_infobb.rfinfo.att1FileName}'>#{rule_infobb.rfinfo.att1Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{rule_infobb.rfinfo.att2FileName}'>#{rule_infobb.rfinfo.att2Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{rule_infobb.rfinfo.att3FileName}'>#{rule_infobb.rfinfo.att3Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{rule_infobb.rfinfo.att4FileName}'>#{rule_infobb.rfinfo.att4Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{rule_infobb.rfinfo.att5FileName}'>#{rule_infobb.rfinfo.att5Title}</a><br>"  />
    <c:verbatim>
             </td>
         </tr>
     </table>
    <table class="table03" width="98%"> 
       <tr><td align="right">
    </c:verbatim>
          <h:commandButton value="关闭窗口" type="button" onclick="window.close();"  styleClass="button01" />
    <c:verbatim>
        </td></tr>
    </table>
    </c:verbatim>
</h:form>