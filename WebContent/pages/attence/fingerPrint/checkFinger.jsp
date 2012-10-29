<%@ page import="com.hr319wg.common.Constants" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doCheck(template){
        if (template==''){
            alert("指纹模板不正确!");
        }
        if (document.all('FingerPrint').CheckFinger(template)){
            alert("比对成功！");
        }
        else{
            alert("比对失败！");
        }
    }
</script>
<x:saveState value="#{sys_fingerBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{sys_fingerBB.checkFinger}"></h:inputHidden>
    <f:verbatim>
    <OBJECT id="FingerPrint" style="Z-INDEX: 101; LEFT: -88px; POSITION: absolute; TOP: -32px"  width="0" height="0"
        classid="clsid:85A22EF6-F089-424D-9956-2C835E1FB99B" VIEWASTEXT>
    </OBJECT>

    <table width=98% class="table02">
        <tr>
        <td height=8 colspan="4" align="right">
    </f:verbatim>
         <h:commandButton styleClass="button01" value="核对" onclick="doCheck('#{sys_fingerBB.fpbo.finger}')" type="button"></h:commandButton>
         <h:commandButton styleClass="button01" value="关闭" onclick="window.close();" type="button"></h:commandButton>
    <f:verbatim>
        </td>
        </tr>

     <tr>
        <td height=8 class="td_form01">
            员工编号
        </td >
        <td class="td_form02">
        </f:verbatim>
             <h:outputText value="#{sys_fingerBB.personbo.personCode}"></h:outputText>
        <f:verbatim>
        </td>

         <td height=8 class="td_form01">
             姓名
         </td >
         <td class="td_form02">
         </f:verbatim>
              <h:outputText value="#{sys_fingerBB.personbo.name}"></h:outputText>
         <f:verbatim>
         </td>
     </tr>
         <tr>
            <td height=8 class="td_form01">
                身份证号
            </td >
            <td class="td_form02">
         </f:verbatim>
              <h:outputText value="#{sys_fingerBB.personbo.idCard}"></h:outputText>
         <f:verbatim>
            </td>
            <td height=8 colspan=2 rowspan=7>
         </f:verbatim>
              <h:graphicImage id="imageId" value="/file/tmp/#{sys_fingerBB.personbo.imageId}.JPG"></h:graphicImage>
         <f:verbatim>
             <script type="text/javascript">
                 document.all("form1:imageId").height=<%=Constants.PHOTOHEIGHT%>;
                 document.all("form1:imageId").width=<%=Constants.PHOTOWIDTH%>;
             </script>
            </td >
        </tr>
        <tr>
           <td height=8 class="td_form01">
               出生日期
           </td >
           <td class="td_form02">
           </f:verbatim>
                <h:outputText value="#{sys_fingerBB.personbo.birth}"></h:outputText>
           <f:verbatim>
           </td>
       </tr>
               <tr>
                  <td height=8 class="td_form01">
                      性别
                  </td >
                  <td class="td_form02">
                  </f:verbatim>
                       <h:outputText value="#{sys_fingerBB.personbo.sex}"></h:outputText>
                  <f:verbatim>
                  </td>
              </tr>
                      <tr>
                         <td height=8 class="td_form01">
                             民族
                         </td >
                         <td class="td_form02">
                         </f:verbatim>
                              <h:outputText value="#{sys_fingerBB.personbo.folk}"></h:outputText>
                         <f:verbatim>
                         </td>
                     </tr>

               <tr>
                  <td height=8 class="td_form01">
                      进入本系统时间
                  </td >
                  <td class="td_form02">
                  </f:verbatim>
                       <h:outputText value="#{sys_fingerBB.personbo.sysTime}"></h:outputText>
                  <f:verbatim>
                  </td>
              </tr>

        <tr>
           <td height=8 class="td_form01">
               所在单位
           </td >
           <td class="td_form02">
           </f:verbatim>
                <h:outputText value="#{sys_fingerBB.personbo.orgName}"></h:outputText>
           <f:verbatim>
           </td>
       </tr>
               <tr>
                  <td height=8 class="td_form01">
                      所在部门
                  </td >
                  <td class="td_form02">
                  </f:verbatim>
                       <h:outputText value="#{sys_fingerBB.personbo.deptName}"></h:outputText>
                  <f:verbatim>
                  </td>
              </tr>

   </table>
   </f:verbatim>
</h:form>
