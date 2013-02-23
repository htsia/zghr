<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <c:verbatim><base target="_self"></c:verbatim>
    <script type="text/javascript">
        function AddAttech() {
            if (document.all('form1:excelFile').value==""){
                alert("请选择文件");
                return false;
            }
            
            x = document.body.clientWidth / 2 - 150;
			y = document.body.clientHeight / 2;
			document.all('processbar').style.top = y;
			document.all('processbar').style.left = x;
			document.all('processbar').style.display = "";
            return true;
         }
         function doCheck(){
            if (document.all('form1:title').value==""){
                alert("请录入标题!");
                return false;
            }
            if (document.all('form1:startDate').value==""){
                alert("请选择生效时间!");
                return false;
            }
            if (document.all('form1:endDate').value==""){
                alert("请选择结束时间!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{train_courceeditbb}"/>
<h:form id="form1" enctype="multipart/form-data">
        <h:inputHidden id="pageInit" value="#{train_courceeditbb.initFile}"/>
<c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td class="td_form01">类别</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputHidden value="#{train_courceeditbb.filebo.typeID}" />
                    <h:inputText readonly="true" value="#{train_courceeditbb.filebo.typeName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
            <td class="td_form01">显示单位范围</td>
            <td class="td_form02" >
 </c:verbatim>
                <h:panelGroup>
                    <h:selectOneMenu id="orgID" value="#{train_courceeditbb.filebo.orgID}">
                        <c:selectItems value="#{train_courceeditbb.orgList}"></c:selectItems>
                    </h:selectOneMenu>
                </h:panelGroup>
<c:verbatim>
            </td>

            <tr>
                <td class="td_form01">标题</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="title" value="#{train_courceeditbb.filebo.title}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">顺序</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="itemOrder" value="#{train_courceeditbb.filebo.itemOrder}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">生效时间</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText id="startDate" readonly="true" value="#{train_courceeditbb.filebo.startDate}"></h:inputText>
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:startDate')"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01"><img src="/images/common/new.gif" >标示结束时间</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="newEndDate" value="#{train_courceeditbb.filebo.newEndDate}"></h:inputText>
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:newEndDate')"/>
<c:verbatim>
                </td>
           </tr>
            <tr>
                <td class="td_form01">结束时间</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="endDate" value="#{train_courceeditbb.filebo.endDate}"></h:inputText>
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:endDate')"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">课件文件</td>
                <td class="td_form02" align="left">
</c:verbatim>
                    <h:inputText  style="width:300px" readonly="true" value="#{train_courceeditbb.filebo.fileName}"></h:inputText>
                    <c:verbatim><br></c:verbatim>
                    <x:inputFileUpload id="excelFile"   styleClass="input" value="#{train_courceeditbb.excelFile}"  storage="file" size="25" />
                    <h:commandButton   styleClass="button02" value="上传" onclick="return AddAttech();" action="#{train_courceeditbb.uploadFile}"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                 <td class="td_form01">是否公共</td>
                 <td class="td_form02">
</c:verbatim>
                     <h:selectOneMenu value="#{train_courceeditbb.filebo.publicFlag}">
                         <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                         <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                     </h:selectOneMenu>
<c:verbatim>
                 </td>
            </tr>
            <tr>
                 <td class="td_form01">是否置顶</td>
                 <td class="td_form02">
</c:verbatim>
                     <h:selectOneMenu value="#{train_courceeditbb.filebo.top}">
                         <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
                         <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
                     </h:selectOneMenu>
<c:verbatim>
                 </td>
            </tr>
        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="发布" onclick="return doCheck();" action="#{train_courceeditbb.SaveFile}" styleClass="button01" />
                <h:commandButton value="返回"  type="button" onclick="window.close()" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>