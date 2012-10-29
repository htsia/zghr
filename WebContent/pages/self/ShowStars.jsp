<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function openAtt(){
        window.showModalDialog("/pages/self/ShowStarsAtt.jsp", null, "dialogWidth:300px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:no;");
        return false;
    }
</script>
<x:saveState value="#{self_starsBB}"></x:saveState>
<h:form>
    <h:inputHidden value="#{self_starsBB.pageInit}"></h:inputHidden>
    <c:verbatim>
    <table width="220" align="left" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;">
       <tr>
            <td valign="top" align="center" >
    </c:verbatim>
                <h:graphicImage style="width:90px;height:140px" value="/images/maininterface/stars/#{self_starsBB.photoFile}"></h:graphicImage>
   <c:verbatim>
            </td>
            <td align="left" width="127">
                 <table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
                 <tr><td >
</c:verbatim>
                  <h:outputText escape="false" value="<strong>编号:</strong>#{self_starsBB.perCode}"></h:outputText>
<c:verbatim>
                  </td></tr>

                  <tr><td>
 </c:verbatim>
                    <h:outputText escape="false" value="<strong>姓名:</strong>#{self_starsBB.name}"></h:outputText>
<c:verbatim>
                  </td></tr>

                    <tr><td >
 </c:verbatim>
                      <h:outputText escape="false" value="<strong>所在单位:</strong>"></h:outputText>
<c:verbatim>
                    </td></tr>

                    <tr><td >
 </c:verbatim>
                    <h:outputText value="#{self_starsBB.unit}"></h:outputText>
<c:verbatim>
                    </td></tr>

                    <tr><td >
 </c:verbatim>
                      <h:outputText escape="false" value="<strong>所在部门:<strong>"></h:outputText>
<c:verbatim>
                    </td></tr>

                    <tr><td>
 </c:verbatim>
                       <h:outputText value="#{self_starsBB.dept}"></h:outputText>
<c:verbatim>
                    </td></tr>

                    <tr><td align="left">
 </c:verbatim>
                       <h:commandButton value="打开附件" styleClass="button01" type="button" rendered="#{self_starsBB.haveAtt}" onclick="openAtt();"></h:commandButton>
<c:verbatim>
                    </td>
                    </tr>
         </table>
         </td>

        <tr>
           <td colspan=2 height=120>
               <marquee direction=up height=120 width=220 onMouseOut=this.start()   onMouseOver=this.stop() scrollamount=1 scrolldelay=40>
 </c:verbatim>
                 <h:outputText escape="false" value="#{self_starsBB.story}"></h:outputText>
<c:verbatim>
              </marquee>
           </td>
        </tr>
    <tr>
       <td height=13 colspan=2></td>
    </tr>

   </table>
</c:verbatim>
</h:form>


