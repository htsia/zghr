<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.ucc.IPersonUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript" language="javascript" src="/js/ScanIDCard.js"></script>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    //XMLHttpRequest状态改变时要执行的函数
    function handleStateChange() {
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
                //解析从xml文件得到的结果,动态画树
                parseResults();
            }
        }
    }

    //解析从xml文件得到的结果
    function parseResults() {
        var results = xmlHttp.responseXML;
        var orgs = null;
        var trees = results.getElementsByTagName("message");
        for (var i = 0; i < trees.length; i++) {
            orgs = trees[i];
            info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
        }
    }
    //创建XMLHttpRequest对象
    function createXMLHttpRequest() {
        if (window.ActiveXObject) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        } else if (window.XMLHttpRequest) {
            xmlHttp = new XMLHttpRequest();
        }
    }
    
function selectTypeFun(){
   PopUpCodeDlgOneControl('form1:A016010','0200110001');
}
function forCheck() {
    var queryString = createQueryString("A001",document.forms(0));
    createXMLHttpRequest();
    xmlHttp.open("POST", "/pages/ajax/Check.jsp", false);
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
    xmlHttp.send(queryString);

    if (info != null && info != "" && info != "no") {
        alert(info);
        return false;
    }
    return true;
}

function forSave() {
    if (forCheck()) {
        return forsubmit(document.forms(0));
    }
    return false;
}

function selAddTime() {
    <%
       InfoItemBO addTime=SysCacheTool.findInfoItem("A016","A016020");
       if (InfoItemBO.DATA_TYPE_DATE6.equals(addTime.getItemDataType())){
    %>
        PopUpCalendarDlg_OnlyMonth('form1:A016020')
    <%
       }
       else{
     %>
         PopUpCalendarDialog("form1:A016020");
    <%
     }
    %>
}

</script>

<h:form id="form1">
<h:inputHidden  id="type" value="#{emp_personAddBB.type}"></h:inputHidden>
<f:verbatim>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif"> 
    	  <%=LanguageSupport.getResource("XTGL-0900","系统管理")%> -> 
    	  <%=LanguageSupport.getResource("XTGL-1034","增加新员工")
    	   %>       
        </td>
        <td class="td_title">
             <font color=red  >
             <%
                if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)){
            		 out.println(LanguageSupport.getResource("XTGL-1035","注意：新增人员需审批后才生效"));
                } 
                if ("1".equals(Constants.AUTO_OPEN_USER)){
                	out.println(LanguageSupport.getResource("XTGL-1036","自动开通用户"));
                } 
                if ("1".equals(Constants.DEFAULT_SH_NAME_FIELD)){
                	out.println(LanguageSupport.getResource("XTGL-1037","默认登陆名:员工编号"));
                } 
                else if ("2".equals(Constants.DEFAULT_SH_NAME_FIELD)){
                	out.println(LanguageSupport.getResource("XTGL-1038","默认登陆名:身份证号"));
                } 
                else
                	out.println(LanguageSupport.getResource("XTGL-1039","默认登陆名:姓名简拼"));

                if ("1".equals(Constants.DEFAULT_SH_PASSWORD_TYPE))
                	out.println(LanguageSupport.getResource("XTGL-1040","默认密码:")+Constants.DEFAULT_SH_PASSWORD+"</font>");
                else 
                	out.println(LanguageSupport.getResource("XTGL-1041","默认密码:身份证后4位"));

            %>
             </font>
        </td>
        <td class="td_title">
</f:verbatim>
           <h:commandButton value="扫描二代证" type="button" styleClass="button01" rendered="#{sys_commonInfoBB.enableScanCard2}" onclick="doScan();"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
<br>


<table width=95% align=center border=0 cellpadding=0 cellspacing=0 >
<tr nowrap>
    <td align="right" title="<%=Constants.EMP_PERSON_CODE_DES%>">
      <strong><%=LanguageSupport.getResource("XTGL-1042", "员工编号") %></strong>
</f:verbatim>
        <h:inputText styleClass="input" id="A001735" value="#{emp_personAddBB.personvo.personCode}" alt="员工编号|1|s|50||"/>
<f:verbatim>
    </td>
    <%
        try{
            IPersonUCC uu = (IPersonUCC) SysContext.getBean("emp_personUCC");
            User user = (User) session.getAttribute(Constants.USER_INFO);
            out.print("<script type=\"text/javascript\">");
            out.print("     document.all('form1:A001735').value=\""+uu.getNextPersonCode(user.getOrgId())+"\"");
            out.print("</script>");
        }
        catch(Exception e){

        }
    %>
</tr>
</table>
    
    <table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr nowrap>
    <td class="td_form01 td_form_required" width="120">
  <%=LanguageSupport.getResource("MSG-0010", "姓名") %>
     </td>
    <td class="td_form02">
</f:verbatim>
        <h:inputText styleClass="input" id="A001001" value="#{emp_personAddBB.personvo.name}" alt="姓名|0|s|50||"/>
<f:verbatim>
    </td>

    <td class="td_form01 td_form_required">
     <%=LanguageSupport.getResource("XTGL-1043", "身份证号") %>
    </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001077"  size="22"
                     value="#{emp_personAddBB.personvo.idNum}"
                     alt="身份证号|0|s|50||"/>
<f:verbatim>
    </td>
</tr>
    <tr nowrap>
        <td class="td_form01 "> <%=LanguageSupport.getResource("MSG-0013", "出生日期")%></td>
        <td class=td_form02>
    </f:verbatim>
            <h:inputText styleClass="input" id="A001011" value="#{emp_personAddBB.personvo.birth}"
                         readonly="true" alt="出生日期|1|d|50||"/>
    <f:verbatim>
             <%if ("1".equals(Constants.AUTO_CACL_BIRTH)){%>
                从身份证号得到
             <%}else{%>
                <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
             <%}%>
        </td>
        <td  class="td_form01 "><%=LanguageSupport.getResource("MSG-0012", "性别")%></td>
        <td class=td_form02 >
    </f:verbatim>
            <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                         readonly="true" value="#{emp_personAddBB.personvo.sex}"
                         alt="性别|1|s|50||"/>
    <f:verbatim>
            <%if ("1".equals(Constants.AUTO_CACL_BIRTH)){%>
              从身份证号得到
            <%}else{%>
               <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
             <%}%>
        </td>

    </tr>
    
<tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("RYGL-2057", "民族")%></td>
        <td class=td_form02>
    </f:verbatim>
            <h:inputText styleClass="input" id="A001021" code="" dict="yes" dict_num="0115"
                         readonly="true" value="#{emp_personAddBB.personvo.folk}"
                         alt="民族|1|s|50||"/>
    <f:verbatim>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001021')">
        </td>
        <td width="120"><%= LanguageSupport.getResource("RYGL-2330", "员工照片")%> </td>
        <td>
            <iframe name=uploadPhoto frameBorder=0 width=280 height=98% scrolling=no
                    src='/common/UploadPhoto.jsf?imageItemId=A001780'></iframe>
            <div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;left:800px;top:55px;display:none;" onMouseDown="catchFilter()" onMouseUp="releaseFilter()">
                <img id=showZP src="" width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> alt="照片">
            </div>
            <div id=seryFilterDiv2 onMouseDown="catchFilter2()" onMouseUp="releaseFilter2()"
                 style="cursor:move;position:absolute;z-index:0;left:650px;top:<%=Constants.PHOTOHEIGHT%>px;display:none;">
                <img id=showSFZ  width=<%=Constants.IDWIDTH%> height=<%=Constants.IDHEIGHT%> alt="身份证">
            </div>

            <%out.print(Constants.EMP_PHOTO_DESCRIPTION);%>
        </td>
</tr>

    <tr>  
    <td class="td_form01 td_form_required">
       <%=LanguageSupport.getResource("XTGL-1044", "员工类别") %>
    </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                     readonly="true" value="#{emp_personAddBB.personvo.personType}"
                     alt="员工类别|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
    </td>
 </tr>

<tr nowrap>
    <td class="td_form01 td_form_required">
           <%=LanguageSupport.getResource("XTGL-1045", "所在部门") %>
         </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{emp_personAddBB.personvo.deptId}"
                     alt="所在部门|0|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A001705',2)">
       </td>
    <td class=td_form01>
         <%=LanguageSupport.getResource("XTGL-1046", "所在岗位") %>
        </td>
    <td class=td_form02>
</f:verbatim>
        <h:inputText styleClass="input" id="A001715" code="" dict="yes" dict_num="PO"
                     readonly="true" value="#{emp_personAddBB.personvo.postId}"
                     alt="岗位|1|s|50||"/>
<f:verbatim>
        <input type="button" class="button_select" onclick="fPopUpPostDlg('form1:A001715')"></td>
    </tr>
    <tr nowrap>
        <td class="td_form01 td_form_required" width="120">
                 <%=LanguageSupport.getResource("XTGL-1047", "增员类别") %>
        </td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                         readonly="true" value="#{emp_personAddBB.personchangevo.changeType}"
                         alt="增员类别|0|s|50||"/>
            <h:commandButton type="button" styleClass="button_select"  id="selectType" />
<f:verbatim>

        </td>
        <td class="td_form01 td_form_required" width="120"><%=addTime.getItemName()%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="A016020" value="#{emp_personAddBB.personchangevo.changeDate}"  readonly="true" alt="增员时间|0|d6|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="selAddTime();"/>
<f:verbatim>
    <script type="text/javascript">
        document.all('form1:A016020').alt = "<%=addTime.getItemName()%>|1|<%=InfoItemBO.getHtmlDataType(addTime.getItemDataType())%>|50||";
    </script>

        </td>
    </tr>

</table>
<br>
</f:verbatim>

<f:verbatim>
<br>
<table width=95% border=0 align=center cellpadding=0 cellspacing=0>
    <tr>
        <td align="right">
</f:verbatim>
            <h:inputHidden id="photoFile" value="#{emp_personAddBB.photoFile}"></h:inputHidden>
            <h:inputHidden id="idFile" value="#{emp_personAddBB.idFile}"></h:inputHidden>
            <h:commandButton value="增加" onclick="javascript:return forSave()" styleClass="button01"
                             action="#{emp_personAddBB.createUser}"/>&nbsp;&nbsp;
            <h:commandButton value="取消" styleClass="button01"
                             action="#{emp_personAddBB.cancelPerson}"></h:commandButton>
<f:verbatim>
        </td>
    </tr>
</table>
</f:verbatim>
</h:form>

<script type="text/javascript">
    var movePhoto="1";
    interpret(document.forms(0));
    document.all('form1:selectType').onclick=selectTypeFun;

    document.all.seryFilterDiv.style.left = document.body.scrollWidth - 120;
    document.all.seryFilterDiv2.style.left = document.body.scrollWidth - 120;

    var bIsCatchSery = false;
    var dragClickX = 0;
    var dragClickY = 0;
    var bIsCatchSery2 = false;
    var dragClickX2 = 0;
    var dragClickY2 = 0;

    function myload_setFilter() {
        seryFilterDiv.style.top = document.body.scrollTop + 100;
        seryFilterDiv.style.left = document.body.scrollLeft + 100;
    }
    function catchFilter(e) {
        bIsCatchSery = true;
        var x = event.x + document.body.scrollLeft;
        var y = event.y + document.body.scrollTop;
        dragClickX = x - seryFilterDiv.style.pixelLeft;
        dragClickY = y - seryFilterDiv.style.pixelTop;
        seryFilterDiv.setCapture();
        document.onmousemove = moveFilter;
    }
    function catchFilter2(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery2 = true;
        var x = event.x + document.body.scrollLeft;
        var y = event.y + document.body.scrollTop;
        dragClickX2 = x - seryFilterDiv2.style.pixelLeft;
        dragClickY2 = y - seryFilterDiv2.style.pixelTop;
        seryFilterDiv2.setCapture();
        document.onmousemove = moveFilter2;
    }

    function releaseFilter(e) {
        bIsCatchSery = false;
        seryFilterDiv.releaseCapture();
        document.onmousemove = null;
    }
    function releaseFilter2(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery2 = false;
        seryFilterDiv2.releaseCapture();
        document.onmousemove = null;
    }
            
    function moveFilter(e) {
        if (bIsCatchSery) {
            seryFilterDiv.style.left = event.x + document.body.scrollLeft - dragClickX;
            seryFilterDiv.style.top = event.y + document.body.scrollTop - dragClickY;
        }
    }
    function moveFilter2(e) {
        if (bIsCatchSery2) {
            seryFilterDiv2.style.left = event.x + document.body.scrollLeft - dragClickX;
            seryFilterDiv2.style.top = event.y + document.body.scrollTop - dragClickY;
        }
    }

</script>
