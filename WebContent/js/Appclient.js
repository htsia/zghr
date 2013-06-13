function Ltrim(str){
    return str.replace(/(^\s*)/g, "");
}
function Rtrim(str){
    return str.replace(/(\s*$)/g, "");
}

function judgeBrowser(){
    var ua = navigator.userAgent.toLowerCase();
    var version="";
    if (window.ActiveXObject){
        version=ua.match(/msie ([\d.]+)/)[1]
        return "IE-"+version;
    }
    else if (ua.indexOf("firefox")>=0) {
        version=ua.match(/firefox\/([\d.]+)/)[1]
        return "FIREFOX-"+version;
    }

    return "";
}
function   Unicode2Str(str){
    var   re=/&#[\da-fA-F]{1,5};/ig;
    var   arr=str.match(re);
    if(arr==null) return str;
    var   size=arr.length;
    var   arr2=new   Array(size);
    for(var   i=0;i <arr.length;i++){
        arr2[i]=String.fromCharCode(arr[i].replace(/[&#;]/g, " "));
    }
    for(var   i=0;i <arr.length;i++){
        str=str.replace(arr[i],arr2[i]);
    }
    return   str;    
}

/*
 *  翻译页面上的代码
 *
 */
function interpret(srcForm) {
    if (srcForm == null)   return;
    codeFields = new Array();
    var reqStr = "";
    for (i = 0; i < srcForm.elements.length; i++) {
        obj = srcForm.elements[i];
        if (obj.dict == "yes") {
            if (obj.dict_num != null && obj.value != null) {
                id = "";
                if (obj.id == null || obj.id == undefined || obj.id=='')
                    id = obj.name;
                else
                    id = obj.id;
                reqStr += "&" + id + "=" + obj.dict_num + "|" + obj.value;
            }
        }
    }

    if (reqStr == "" || reqStr == null)
        return;

    reqStr = reqStr.substr(1);

    //开始ajax请求
    //创建XMLHttpRequest对象
    if (window.ActiveXObject)
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    else if (window.XMLHttpRequest)
        xmlHttp = new XMLHttpRequest();

    if (xmlHttp == null) {
        alert("浏览器不支持ajax")
        return;
    }

    xmlHttp.onreadystatechange = codeInterpretCallback;
    xmlHttp.open("GET", "/pages/ajax/Interpret.jsp?" + reqStr, true);
    xmlHttp.send(null);
}
function codeInterpretCallback() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
            //处理返回的数据
            var results = xmlHttp.responseXML;

            var codes = results.getElementsByTagName("interpretitem");

            for (i = 0; i < codes.length; i++) {
                code = codes[i];
                if (code.getElementsByTagName("formfield")[0].firstChild != null)
                    fieldName = code.getElementsByTagName("formfield")[0].firstChild.nodeValue;
                else
                    fieldName = "";
                if (code.getElementsByTagName("codename")[0].firstChild != null)
                    codename = code.getElementsByTagName("codename")[0].firstChild.nodeValue;
                else
                    codename = "";
                if (code.getElementsByTagName("codeitemid")[0].firstChild != null)
                    codeid = code.getElementsByTagName("codeitemid")[0].firstChild.nodeValue;
                else
                    codeid = "";

                document.getElementById(fieldName).code = codeid;
                document.getElementById(fieldName).value = codename;
            }
        }
    }
}

/**
 *代码翻译:描述符译成代码值
 *用在onsubmit处。
 */
function pageCodeExchange(form) {
    //debugger;
    for (var num = 0; num < form.length; num++) {
        var obj = form.elements[num];
        obj=$(obj);
        if (obj.val() != "" && obj.attr("code") != "" && obj.attr("dict") == "yes") {
            obj.val(obj.attr("code"));
        }
    }
    return true;
}

/**
 *提示只能选择一个
 */
function selectOnlyOne(field) {
    size = field.length;
    var flag = 0;
    id = null;
    if (size != null) {  // 多个
        for (i = 0; i < size; i++) {
            if (field[i].checked == true) {
                flag = flag + 1;
                if (flag == 1)
                    id = field[i].value;
                if (flag > 1)
                    break;
            }
        }
    }
    else{
        if (field.checked){   // 单人
            id = field.value;
            return id;
         }
         else {
             alert("没有任何选择！");
             return null;
         }
    }
    if (flag==0){
        alert("没有任何选择！");
        return null;
    }
    else if (flag > 1) {
        alert("只能选择一个！");
        return null;
        //选择出错时返回null
    } else
        return id;
}

/**
 * 校验checkBox、radio是否选择
 * chk: object
 */
function checkMutilSelect(chk) {
    //debugger;
    if (chk == null) {
        return false;
    }
    var size = chk.length;
    if (size == null) {
        if (chk.checked) {
            return true;
        } else {
            return false;
        }
    } else {
        for (var i = 0; i < size; i++) {
            if (chk[i].checked) {
                return true;
            }
        }
    }
    return false;
}

// 得到第一个选中的项目  返回值为字符串
function getFirstSelectValue(chk){
    if (chk == null) {
        return "";
    }
    var size = chk.length;
    if (size == null) {
        if (chk.checked) {
            return chk.value;
        } else {
            return "";
        }
    } else {
        for (var i = 0; i < size; i++) {
            if (chk[i].checked) {
                return chk[i].value;
            }
        }
    }
    return "";
}

//  得到所有选中值 返回值为字符串
//  filter 为多个项目时的分隔符，如,
function getAllSelectValue(chk,filter){
    var str="";
    if (chk == null) {
        return "";
    }
    var size = chk.length;
    if (size == null) {
        if (chk.checked) {
            return chk.value;
        } else {
            return "";
        }
    } else {
        for (var i = 0; i < size; i++) {
            if (chk[i].nodeName!="INPUT") continue;
            if (chk[i].checked) {
                if (str==""){
                    str=chk[i].value;
                }
                else{
                    str+=filter+chk[i].value;
                }
            }
        }
    }
    return str;
}

/**
 * 相应全选事件。
 * all:全选事件checkbox对象
 * chk:需要全选checkbox对象
 */
function selectAll(all, chk) {
    if (chk == null) {
        return false;
    }
    var size = chk.length;
    if (size == null) {
        if (!chk.disabled)
            chk.checked = all.checked;
        ;
    } else {
        for (var i = 0; i < size; i++) {
            if (!chk[i].disabled)
                chk[i].checked = all.checked;
        }
    }
    return true;
}

/**
 * 提交并处理代码
 * targObj:parent窗口的iframe的名字
 * height:最小高度
 */
function forsubmit(form1, flag) {
    if (checkAll(form1, flag)) {
        pageCodeExchange(form1);
        return true;
    } else {
        return false;
    }
}

 // 弹出日历管理对话筐
function PopUpCalendarDialog(obj) {
    var ctrlobj
    if (obj.tagName == null)
        ctrlobj = document.getElementById(obj);
    else
        ctrlobj = obj;
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/common/CalendarDlg.jsp?date=" + ctrlobj.value, "", "dialogWidth:250px; dialogHeight:170px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        ctrlobj.value = retval;
    } else {
    }
}
function PopUpCalendarDlg_OnlyMonth(obj) {   // 只选到月份
    var ctrlobj
    if (obj.tagName == null)
        ctrlobj = document.getElementById(obj);
    else
        ctrlobj = obj;
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;

    strDate = ctrlobj.value;
    if(strDate != ''){
        strDate += "-01";
    }
    retval = window.showModalDialog("/pages/common/CalendarDlg.jsp?date=" + strDate, "", "dialogWidth:170px; dialogHeight:190px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.substring(0, retval.length - 3)
        ctrlobj.value = retval;
    } else {
    }
}
function PopUpCalendar_OnlyMonth(obj) {   // 只显示年月下拉框
    var ctrlobj
    if (obj.tagName == null)
        ctrlobj = document.getElementById(obj);
    else
        ctrlobj = obj;
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;

    strDate = ctrlobj.value;
    retval = window.showModalDialog("/pages/common/CalendarMonthOnly.jsp?date=" + strDate, "", "dialogWidth:170px; dialogHeight:100px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
	if(retval != null){
		ctrlobj.value = retval;
	}	
}
function PopUpCalendarDlg_OnlyYear(obj) {   // 只选到年份
    var ctrlobj
    if (obj.tagName == null)
        ctrlobj = document.getElementById(obj);
    else
        ctrlobj = obj;
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;

    strDate = ctrlobj.value;
    if(strDate != ''){
        strDate += "-01";
    }
    retval = window.showModalDialog("/pages/common/CalendarDlg.jsp?date=" + strDate, "", "dialogWidth:170px; dialogHeight:190px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.substring(0, retval.length - 6)
        ctrlobj.value = retval;
    } else {
    }
}

/**
 * 弹出新窗口
 *
 */
function windowOpen(theURL, winName, features, width, hight, scrollbars, top, left, resizable) {
    var parameter = features + " top=" + top + ",left=" + left + ",width=" + width + ",height=" + hight;
    //+"location=no";
    if (scrollbars == "no") {
        parameter += ",scrollbars=no";
    } else {
        parameter += ",scrollbars=yes";
    }
    if (resizable == "no") {
        parameter += ",resizable=no";
    } else {
        parameter += ",resizable=yes";
    }
    var w=window.open(theURL, winName, parameter);
	w.focus();
}

//---------------选择代码--------------------------------------------------------------------------------------
//    rootCodeId,代码的根节点，用逗号隔开 "12,13";
//    flag 是否选则叶 flag=0,只允许选择叶，flag=1,允许选择枝 ,不传或者=2，根据数据库里的属性判断要选择枝还是叶
function PopUpCodeDlgOneControl(obj, rootCodeId, flag) {
    var ctrlobj = document.getElementById(obj);
    ctrlobj=$(ctrlobj);
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    if (rootCodeId == null)
        rootCodeId = "";
    if (flag == null || flag == "")
        flag = "2";
    var arg = "dict_num=" + ctrlobj.attr("dict_num");
    arg += "&curCode=" + ctrlobj.attr("code");
    arg += "&value=" + ctrlobj.val();
    arg += "&rootId=" + rootCodeId;
    arg += "&flag=" + flag;
    retval = window.showModalDialog("/pages/common/SelCode.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        ctrlobj.val(rs[1]);
        ctrlobj.attr("code", rs[0]);
    }
}
//  codec 代码
//  valuec 描述
function PopUpCodeDlgTwoControl(codec, valuec, dict_num, rootCodeId) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    if (rootCodeId == null)
        rootCodeId = "";
    var arg = "dict_num=" + dict_num;
    arg += "&curCode=" + codec.value;
    arg += "&value=" + valuec.value;
    arg += "&rootId=" + rootCodeId;
    retval = window.showModalDialog("/pages/common/SelCode.jsp?" + arg, "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpCodeDlgTwoControlSelectAll(codec, valuec, dict_num, rootCodeId) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    if (rootCodeId == null)
        rootCodeId = "";
    var arg = "dict_num=" + dict_num;
    arg += "&curCode=" + codec.value;
    arg += "&value=" + valuec.value;
    arg += "&rootId=" + rootCodeId;
    arg+="&flag=1"
    retval = window.showModalDialog("/pages/common/SelCode.jsp?" + arg, "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}


/*****************************************************************************************
 *    选择机构
 *       obj 对应显示控件
 *       useRightFlag 权限方式 0-不使用 1-使用查询权限过滤,2-使用维护权限过滤；
 *       rootOrgId根节点的机构编号，可以用“，”分隔
 */
function PopUpOrgDlg(obj, useRightFlag, rootOrgId, onlyOrg) {
    var ctrlobj = document.getElementById(obj);
    ctrlobj=$(ctrlobj);
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    if (useRightFlag == null)
        useRightFlag = 0;
    if (rootOrgId == null)
        rootOrgId = "";
    var arg = "dict_num=" + ctrlobj.attr("dict_num");
    arg += "&curCode=" + ctrlobj.attr("code");
    arg += "&value=" + ctrlobj.val();
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg += "&onlyOrg=" + onlyOrg;

    retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        ctrlobj.val(rs[1]);
        ctrlobj.attr("code", rs[0]);
    }
}
function PopUpOrgDlg_1(obj, useRightFlag, rootOrgId, onlyOrg) {
	var ctrlobj = document.getElementById(obj);
	ctrlobj=$(ctrlobj);
	showx = event.screenX - event.offsetX - 150;
	showy = event.screenY - event.offsetY + 18;
	if (useRightFlag == null)
		useRightFlag = 0;
	if (rootOrgId == null)
		rootOrgId = "";
	var arg = "dict_num=" + ctrlobj.attr("dict_num");
	arg += "&curCode=" + ctrlobj.attr("code");
	arg += "&value=" + ctrlobj.val();
	arg += "&rightFlag=" + useRightFlag;
	arg += "&rootId=" + rootOrgId;
	arg += "&onlyOrg=" + onlyOrg;
	
	retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
	return retval;
}

function PopUpOrgOnlyDlg(obj, useRightFlag, rootOrgId) { //   仅仅显示机构 useRightFlag 0-不使用 1-使用查询权限过滤,2-使用维护权限过滤；rootOrgId根节点的机构编号，可以用“，”分隔
    var ctrlobj = document.getElementById(obj);
    ctrlobj=$(ctrlobj);
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    if (useRightFlag == null)
        useRightFlag = 0;
    if (rootOrgId == null)
        rootOrgId = "";
    var arg = "dict_num=" + ctrlobj.attr("dict_num");
    arg += "&curCode=" + ctrlobj.attr("code");
    arg += "&value=" + ctrlobj.val();
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg+="&onlyOrg=1";
    retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        ctrlobj.val(rs[1]);
        ctrlobj.attr("code", rs[0]);
    }
}

function PopUpOrgDlgShowGroup(obj, useRightFlag, rootOrgId, onlyOrg) {    // 显示班组
    var ctrlobj = document.getElementById(obj);
    ctrlobj=$(ctrlobj);
    showx = event.screenX - event.offsetX - 150;
    // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    if (useRightFlag == null)
        useRightFlag = 0;
    if (rootOrgId == null)
        rootOrgId = "";
    var arg = "dict_num=" + ctrlobj.attr("dict_num");
    arg += "&curCode=" + ctrlobj.attr("code");
    arg += "&value=" + ctrlobj.val();
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg += "&onlyOrg=" + onlyOrg;
    arg+="&showGroup=1";

    retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        ctrlobj.val(rs[1]);
        ctrlobj.attr("code", rs[0]);
    }
}


function fPopUpOrgDlg2(codec, valuec, useRightFlag, rootOrgId) {  //选择机构  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    if (codec != "[object]")
        codec = document.getElementById(codec);
    if (valuec != "[object]")
        valuec = document.getElementById(valuec);

    if (useRightFlag == null)
        useRightFlag = 0;
    if (rootOrgId == null)
        rootOrgId = "";
    var arg = "dict_num=OU";
    arg += "&curCode=" + codec.value;
    arg += "&value=" + valuec.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
//选择机构  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
function PopUpOrgOnlyDlgTwoControl(codec, valuec, useRightFlag, rootOrgId) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    if (codec != "[object]")
        codec = document.getElementById(codec);
    if (valuec != "[object]")
        valuec = document.getElementById(valuec);

    if (useRightFlag == null)
        useRightFlag = 0;
    if (rootOrgId == null)
        rootOrgId = "";
    var arg = "dict_num=OU";
    arg += "&curCode=" + codec.value;
    arg += "&value=" + valuec.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg+="&onlyOrg=1";
    retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function fPopUpWageUnitDlg(obj, checkRight) { //选择薪资机构检查权限 checkRight =true 不检查权限 checkright＝false
    var ctrlobj = document.getElementById(obj);
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    if (checkRight == null || checkRight == "") {
        checkRight = false;
    }
    var arg = "dict_num=" + ctrlobj.dict_num;
    arg += "&curCode=" + ctrlobj.code;
    arg += "&value=" + ctrlobj.value;
    arg += "&checkRight=" + checkRight;
    retval = window.showModalDialog("/pages/common/SelWageUnit.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        ctrlobj.value = rs[1];
        ctrlobj.code = rs[0];
    }
}

function fPopUpWageUnitDlg2(codec,valuec, checkRight) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
     if (codec != "[object]")
        codec = document.getElementById(codec);
    if (valuec != "[object]")
        valuec = document.getElementById(valuec);

    if (checkRight == null || checkRight == "") {
        checkRight = false;
    }
    var arg = "dict_num=OU";
    arg += "&curCode=" + codec.value;
    arg += "&value=" + valuec.value;
    arg += "&checkRight=" + checkRight;
    retval = window.showModalDialog("/pages/common/SelWageUnit.jsp?" + arg, "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
        return true;
    }
    return false;
}

function fPopUpLeadUnitDlg2(codec,valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
     if (codec != "[object]")
        codec = document.getElementById(codec);
    if (valuec != "[object]")
        valuec = document.getElementById(valuec);
    var arg = "dict_num=OU";
    arg += "&curCode=" + codec.value;
    arg += "&value=" + valuec.value;
    retval = window.showModalDialog("/pages/common/SelLeadUnit.jsp?" + arg, "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

//检查权限 checkRight =true 不检查权限 checkright＝false
function fPopUpMutiWageUnitDlg2(codec,valuec, checkRight) {
   // var ctrlobj = document.getElementById(obj);
    showx = event.screenX - event.offsetX - 150;
    // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
     if (codec != "[object]")
        codec = document.getElementById(codec);
    if (valuec != "[object]")
        valuec = document.getElementById(valuec);

    if (checkRight == null || checkRight == "") {
        checkRight = false;
    }
    var arg = "dict_num=OU";
    arg += "&curCode=" + codec.value;
    arg += "&value=" + valuec.value;
    arg += "&checkRight=" + checkRight;
    retval = window.showModalDialog("/pages/common/SelMutiWageUnit.jsp?" + arg, "", "dialogWidth:215px; dialogHeight:230px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
// 选择薪资项
function PopUpWageItemDlg(obj) {
    if (obj != "[object]")
        obj = document.getElementById(obj);

    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/common/SelWageItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        obj.value = rs[1];
        obj.code = rs[0];
    }
}

// 选择薪资部门
function PopUpWageDeptDlg(obj,setID) {
    if (obj != "[object]")
        obj = document.getElementById(obj);

    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/common/SelWageDept.jsp?setID="+setID, "", "dialogWidth:215px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        obj.value = retval;
    }
}
function PopUpWageDeptDlgByPerson(obj,personID) {
    if (obj != "[object]")
        obj = document.getElementById(obj);

    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    var url="/pages/common/SelWageDeptByPerson.jsp?personID="+personID;
    //alert(url);
    retval = window.showModalDialog(url, "", "dialogWidth:215px; dialogHeight:230px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        obj.value = retval;
    }
}
function PopUpWageDeptDlgByOrg(obj,OrgID) {
    if (obj != "[object]")
        obj = document.getElementById(obj);

    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/common/SelWageDeptByOrg.jsp?OrgID="+OrgID, "", "dialogWidth:215px; dialogHeight:230px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        obj.value = retval;
    }
}

//选择党组织  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
//partyType 0：全部 1|null|''：党组织 2：已撤销党组织 3：只显示现有的党委
function fPopUpPartyDlg(obj, useRightFlag, rootOrgId, partyType) {
    var ctrlobj = document.getElementById(obj);
    showx = event.screenX - event.offsetX - 150;
    // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    if (useRightFlag == null)
        useRightFlag = 0;
    if (rootOrgId == null)
        rootOrgId = "";
    if (partyType == "undefined" || partyType == null)
        partyType = "";

    var arg = "dict_num=" + ctrlobj.dict_num;
    arg += "&curCode=" + ctrlobj.code;
    arg += "&value=" + ctrlobj.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg += "&paType=" + partyType;
    retval = window.showModalDialog("/pages/common/SelParty.jsp?" + arg, "", "dialogWidth:215px; dialogHeight:230px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        ctrlobj.value = rs[1];
        ctrlobj.code = rs[0];
    }
}
//选择党组织  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
//partyType 0：全部 1|null|''：党组织 2：已撤销党组织 3：只显示现有的党委
function fPopUpPartyDlg2(codec, valuec, useRightFlag, rootOrgId, partyType) {
    showx = event.screenX - event.offsetX - 150;
    // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    if (codec != "[object]")
        codec = document.getElementById(codec);
    if (valuec != "[object]")
        valuec = document.getElementById(valuec);
    if (partyType == "undefined" || partyType == null)
        partyType = "";

    if (useRightFlag == null)
        useRightFlag = 0;
    if (rootOrgId == null)
        rootOrgId = "";

    var arg = "dict_num=PA";
    arg += "&curCode=" + codec.code;
    arg += "&value=" + valuec.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg += "&paType=" + partyType;
    retval = window.showModalDialog("/pages/common/SelParty.jsp?" + arg, "", "dialogWidth:215px; dialogHeight:230px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

//控制 树页面的显示、隐藏
function ctrlbar() {
    if (document.getElementById("showTree").style.display == "") {
        document.getElementById("showTree").style.display = "none"
        document.getElementById("ctrlBnt").src = '/images/button_2.gif';
    } else {
        document.getElementById("showTree").style.display = ""
        document.getElementById("ctrlBnt").src = '/images/button_1.gif';
    }
}
function functrlbar() {
    if (document.getElementById("showfunTree").style.display == "") {
        document.getElementById("showfunTree").style.display = "none"
        document.getElementById("functrlbar").src = '/images/button_2.gif';
    } else {
        document.getElementById("showfunTree").style.display = ""
        document.getElementById("functrlbar").src = '/images/button_1.gif';
    }
}
//useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号
function PopUpMutilOrgOneControl(obj, useRightFlag, rootOrgId) {
    if (obj == null)
        return;
    if (obj != "[object]")
        obj = document.getElementById(obj);
    showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    var arg = "dict_num=OU";
    arg += "&curCode=" + obj.code;
    arg += "&value=" + obj.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;

    retval = window.showModalDialog("/pages/common/SelMutilOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        obj.code = retval[0];
        obj.value = retval[1];
    }
}

//useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号
function PopUpMutilOrgTwoControl(codeField, nameField, useRightFlag, rootOrgId) {
    if (codeField == null || nameField == null)
        return false;
    if (codeField != "[object]")
        codeField = document.getElementById(codeField);
    if (nameField != "[object]")
        nameField = document.getElementById(nameField);
    showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    var arg = "dict_num=OU";
    arg += "&curCode=" + codeField.value;
    arg += "&value=" + nameField.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;

    retval = window.showModalDialog("/pages/common/SelMutilOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
        return true;
    }
    else
        return false;
}
//useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号
function PopUpMutilOrgTwoControlQuery(codeField, nameField, useRightFlag, rootOrgId) {
	if (codeField == null || nameField == null)
		return false;
	if (codeField != "[object]")
		codeField = document.getElementById(codeField);
	if (nameField != "[object]")
		nameField = document.getElementById(nameField);
	showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
	showy = event.screenY - event.offsetY + 18;
	// + deltaY;
	var arg = "dict_num=OU";
	arg += "&curCode=" + codeField.value;
	arg += "&value=" + nameField.value;
	arg += "&rightFlag=" + useRightFlag;
	arg += "&rootId=" + rootOrgId;
	
	retval = window.showModalDialog("/pages/common/SelMutilOrgQuery.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
	if(retval=="-1"){
		codeField.value = "";
		nameField.value = "";
	}else if (retval != null) {
		retval = retval.split("|");
		codeField.value = retval[0];
		nameField.value = retval[1];
		return true;
	}else{
		return false;
	}
}
function PopUpMutilOnlyOrgTwoControl(codeField, nameField, useRightFlag, rootOrgId) {
    if (codeField == null || nameField == null)
        return false;
    if (codeField != "[object]")
        codeField = document.getElementById(codeField);
    if (nameField != "[object]")
        nameField = document.getElementById(nameField);
    showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
    showy = event.screenY - event.offsetY + 18;

    var arg = "dict_num=OU";
    arg += "&curCode=" + codeField.value;
    arg += "&value=" + nameField.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;

    retval = window.showModalDialog("/pages/common/SelMutilOnlyOrg.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
        return true;
    }
    else
        return false;
}

//----------------------------------  选择多选代码   -------------------------------
function PopUpMutilCodeDlg(obj) {
    if (obj == null)
        return;
    if (obj != "[object]")
        obj = document.getElementById(obj);
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;
    var arg = "dict_num=" + ctrlobj.dict_num;
    arg += "&curCode=" + ctrlobj.code;
    arg += "&value=" + ctrlobj.value;
    retval = window.showModalDialog("/pages/common/SelMutilCode.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        obj.code = retval[0];
        obj.value = retval[1];
    }
}
// 代码控件 描述控件 代码/指标  根代码
function PopUpMutilCodeDlgNoSubmit(codeField, nameField, dict_num,root_code) {
    if (codeField == null || nameField == null)
        return;
    var setId = dict_num;
    var url;
    if (codeField != "[object]")
        codeField = document.getElementById(codeField);
    if (nameField != "[object]")
        nameField = document.getElementById(nameField);
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;
    url="/pages/common/SelMutilCode.jsp?dict_num=" + setId + "&curCode=" + codeField.value + "&value=" + nameField.value+"&rootCode="+root_code;
    retval = window.showModalDialog(url, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
    }
    return false;
}

// 显示多选代码
//   codeField  代码域
//   nameField  描述域
//   dict_num   代码集
//   cur_code   当前选择值
//    如果选择返回true 否则返回false
function PopUpMutilCodeDlgForSubmit(codeField, nameField, dict_num,root_code) {
    if (codeField == null || nameField == null)
        return;
    var setId = dict_num;
    if (codeField != "[object]")
        codeField = document.getElementById(codeField);
    if (nameField != "[object]")
        nameField = document.getElementById(nameField);
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;
    //alert(cur_code);
    retval = window.showModalDialog("/pages/common/SelMutilCode.jsp?dict_num=" + setId + "&curCode=" + codeField.value + "&value=" + nameField.value+"&rootCode="+root_code, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
        if(retval[0] == "" && retval[1] == ""){
            return false;
        }else{
             return true;
       }
    }else{
        return false;
    }
}

function PopUpMutilCodeDlgNoLayerForSubmit(codeField, nameField, dict_num,root_code) {
    if (codeField == null || nameField == null)
        return;
    var setId = dict_num;
    if (codeField != "[object]")
        codeField = document.getElementById(codeField);
    if (nameField != "[object]")
        nameField = document.getElementById(nameField);
    showx = event.screenX - event.offsetX - 160;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/common/SelMutilCodeNolayer.jsp?dict_num=" + setId + "&curCode=" + codeField.value + "&value=" + nameField.value+"&rootCode="+root_code, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
        if(retval[0] == "" && retval[1] == ""){
            return false;
        }else{
             return true;
        }
    }else{
        return false;
    }
}

//选择党组织  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
//partyType 0：全部 1|null|''：党组织 2：已撤销党组织 3：只显示现有的党委
function fPopUpMutilParty(obj, useRightFlag, rootOrgId, partyType) {
    if (obj == null)
        return;
    if (obj != "[object]")
        obj = document.getElementById(obj);
    if (partyType == "undefined" || partyType == null)
        partyType = "";
    showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    var arg = "dict_num=PA";
    arg += "&curCode=" + obj.code;
    arg += "&value=" + obj.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg += "&paType=" + partyType;
    retval = window.showModalDialog("/pages/common/SelMutilParty.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        obj.code = retval[0];
        obj.value = retval[1];
    }
}

//选择党组织  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
//partyType 0：全部 1|null|''：党组织 2：已撤销党组织 3：只显示现有的党委
function fPopUpMutilParty2(codeField, nameField, useRightFlag, rootOrgId, partyType) {
    if (codeField == null || nameField == null)
        return;
    if (codeField != "[object]")
        codeField = document.getElementById(codeField);
    if (nameField != "[object]")
        nameField = document.getElementById(nameField);
    if (partyType == "undefined" || partyType == null)
        partyType = "";
    showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    var arg = "dict_num=PA";
    arg += "&curCode=" + codeField.value;
    arg += "&value=" + nameField.value;
    arg += "&rightFlag=" + useRightFlag;
    arg += "&rootId=" + rootOrgId;
    arg += "&paType=" + partyType;
    retval = window.showModalDialog("/pages/common/SelMutilParty.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
    }
}

/**
 *  选择单个人员
 *      objname1 名字字段ID
 *      objname1 ID字段ID
 *      superId 要选择机构的orguid 
 *      rightFlag 机构权限模式 0 不检查   1 操作  2 查询
 */
function fPopUpPerDlgFilter(objname1, objname2, filter) {
    var obj1 = document.getElementById(objname1);
    var obj2 = document.getElementById(objname2);
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/common/SelPerson.jsf?superId=&rightFlag=0&Filter="+filter, "", "dialogWidth:700px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj2 != null) {
            obj1.value = rs[1];
            obj2.value = rs[0];
        } else {
            obj1.value = rs[1];
            obj1.code = rs[0];
        }
        return true;
    } else {
        return false;
    }

}
function fPopUpPerDlg(objname1, objname2, superId,rightFlag) {
    var obj1 = document.getElementById(objname1);
    var obj2=null;
    if (objname2!=null && objname2!=undefined){
       obj2= document.getElementById(objname2);
    }
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    if (superId == null) {
        superId = "";
    }
    if(rightFlag == null){
        rightFlag = "1";
    }

    retval = window.showModalDialog("/common/SelPerson.jsf?superId=" + superId+"&rightFlag="+rightFlag, "", "dialogWidth:600px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj2 != null) {
            obj1.value = rs[1];
            obj2.value = rs[0];
        } else {
            obj1.value = rs[1];
            obj1.code = rs[0];
        }
        return true;
    } else {
        return false;
    }
}
// 选择人员
function fPopUpPerEMailDlg(objname1, objname2,objname3,objname4) {
    var obj1 = document.getElementById(objname1);
    var obj2 = document.getElementById(objname2);
    var obj3 = document.getElementById(objname3);
    var obj4 = document.getElementById(objname4);
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/common/SelPersonMail.jsf", "", "dialogWidth:720px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj1 != null) {
            obj1.value = rs[0];
        }
        if (obj2 != null && rs.length>1) {
            obj2.value = rs[1];
        }
        if (obj3 != null && rs.length>2) {
            obj3.value = rs[2];
        }
        if (obj4 != null && rs.length>3) {
            obj4.value = rs[3];
        }

        return true;
    } else {
        return false;
    }
}

// 选择人员 需要看自助权限级别
function fPopUpPerDlgInSelf(objname1, objname2,filter) {
    var obj1 = document.getElementById(objname1);
    var obj2 = document.getElementById(objname2);
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    var url="/common/SelPersonInSelf.jsf";
    if (filter!=null && filter!=""){
        url+="?filter="+filter;
    }
    retval = window.showModalDialog(url, "", "dialogWidth:720px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj2 != null) {
            obj1.value = rs[1];
            obj2.value = rs[0];
        } else {
            obj1.value = rs[1];
            obj1.code = rs[0];
        }
        return true;
    } else {
        return false;
    }
}

//多选择人员
function fPopUpMutiPerDlg(obj1, obj2, superId,rightFlag) {
    var obj11 = document.getElementById(obj1);
    var obj21 = document.getElementById(obj2);
    showx = event.screenX - event.offsetX - 150;
    // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;
    if (superId == null) {
        superId = "";
    }
    if(rightFlag == null){
        rightFlag = "1";
    }
    retval = window.showModalDialog("/common/SelMutiPerson.jsf?superId=" + superId+"&rightFlag="+rightFlag, "", "dialogWidth:600px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("||");
        if (obj2 != null) {
            obj11.value = rs[1];
            obj21.value = rs[0];

        } else {
            obj11.value = rs[1];
            obj11.code = rs[0];
        }
        return true;
    } else {
        return false;
    }
}

//选择人员后，把人员编号放到后台的httpsession里
function fPopUpBackPerDlg(sid,rightFlag) {
    var id = sid;
    //sessionId
    if(rightFlag == null){
        rightFlag = "1";
    }
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/common/SelBackPerson.jsf?sid=" + id+"&rightFlag="+rightFlag, "", "dialogWidth:600px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
}

// 按树的模式加人
// rootId
// rightFlag
function fPopUpBackPerTreeDlg(rootId) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    window.showModalDialog("/common/SelBackTreePerson.jsf?rootId=" + rootId+"&rightFlag=2", "", "dialogWidth:800px; dialogHeight:700px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
}

//单选择人员(通过党组织查询)
function fPopUpPerByPartyDlg(obj1, obj2) {
    var obj11 = document.getElementById(obj1);
    var obj21 = document.getElementById(obj2);
    showx = event.screenX - event.offsetX - 150;
    // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;


    retval = window.showModalDialog("/ccp/PartySelPerson.jsf", "", "dialogWidth:900px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj2 != null) {
            obj11.value = rs[1];
            obj21.value = rs[0];

        } else {
            obj11.value = rs[1];
            obj11.code = rs[0];
        }
        return true;
    } else {
        return false;
    }
}

/*
*     选择岗位
*        obj1 代码控件ID
*        obj2 描述控件ID
*        superId 要查岗位的机构代码
*/
function fPopUpPostDlg(obj1, obj2, superId) {
    if (obj1 == null)
        return;
    if (obj1 != "[object]")
        obj11 = document.getElementById(obj1);
    else
        obj11 = obj1;
    if (obj2 != "[object]" && obj2 != null)
        obj21 = document.getElementById(obj2);
    else if (obj2 != null) {
        obj21 = obj2
    }
    if (superId == null) {
        superId = "";
    }

    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/common/SelPost.jsf?superId=" + superId, "", "dialogWidth:700px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj2 != null) {
            obj11.value = rs[0];
            obj21.value = rs[1];
        } else {
            obj11.value = rs[1];
            obj11.code = rs[0];
        }
        return true;
    } else {
        return false;
    }
}
/*
*     人员基本信息维护选择岗位
*        obj1 代码控件ID
*        obj2 描述控件ID
*        superId 要查岗位的机构代码
*/
function fPopUpPostDlgRy(obj1, obj2, superId) {
    if (obj1 == null)
        return;
    if (obj1 != "[object]")
        obj11 = document.getElementById(obj1);
    else
        obj11 = obj1;
    if (obj2 != "[object]" && obj2 != null)
        obj21 = document.getElementById(obj2);
    else if (obj2 != null) {
        obj21 = obj2
    }
    if (superId == null) {
        superId = "";
    }

    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/common/SelRyPost.jsf?fk=" + fk, "", "dialogWidth:700px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj2 != null) {
            obj11.value = rs[0];
            obj21.value = rs[1];
        } else {
            obj11.value = rs[1];
            obj11.code = rs[0];
        }
        return true;
    } else {
        return false;
    }
}

function PopUpPostDlgByDept(obj1, obj2, superId) {
    if (obj1 == null)
        return;
    if (obj1 != "[object]")
        obj11 = document.getElementById(obj1);
    else
        obj11 = obj1;
    if (obj2 != "[object]" && obj2 != null)
        obj21 = document.getElementById(obj2);
    else if (obj2 != null) {
        obj21 = obj2
    }
    if (superId == null) {
        superId = "";
    }

    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    obj11=$(obj11);
    obj21=$(obj21);
    
    retval = window.showModalDialog("/common/SelPostByDept.jsf?superId=" + superId, "", "dialogWidth:700px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split(",");
        if (obj2 != null) {
            obj11.val(rs[0]);
            obj21.val(rs[1]);
        } else {
            obj11.val(rs[1]);
            obj11.attr("code", rs[0]);
        }
        return true;
    } else {
        return false;
    }
}
function PopUpPostDlgByDept_1(superId) {	
	showx = event.screenX - event.offsetX - 150;
	showy = event.screenY - event.offsetY + 18;

	retval = window.showModalDialog("/common/SelPostByDept.jsf?superId=" + superId, "", "dialogWidth:700px; dialogHeight:500px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
	return retval;
}
//多选择岗位 obj1存岗位id,obj2存岗位名称,obj3存所在机构名称
function fPopUpMutiPostDlg(obj1, obj2, obj3) {
    if (obj1 == null || obj2 == null) {
        return;
    }
    if (obj1 != "[object]")
        obj1 = document.getElementById(obj1);
    if (obj2 != "[object]")
        obj2 = document.getElementById(obj2);
    if (obj3 != "[object]")
        obj3 = document.getElementById(obj3);
    showx = event.screenX - event.offsetX - 150;
    // + deltaX;
    showy = event.screenY - event.offsetY + 18;
    // + deltaY;


    retval = window.showModalDialog("/pages/post/SelMutiPost.jsf", "", "dialogWidth:600px; dialogHeight:300px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("||");
        if (obj3 != null) {
            obj1.value = rs[0];
            obj2.value = rs[1];
            obj3.value = rs[2];

        } else {
            obj1.value = rs[0];
            obj2.value = rs[1];
        }
        return true;
    } else {
        return false;
    }
}

/**
 * 高级查询
 * setType      A|B|C|D (人员|机构|岗位|党组织)
 * unitType     ORG|PARTY (用机构查人|用党组织查人)
 * mask       111 三位数字分别对应 机构范围定义.查询条件定义.显示项定义三个 0表示不显示 1显示
 * hideSaveButton   Y|null (不显示保存按钮|显示保存按钮)
 * addedCondition        附加的sql条件，如 A001.A001005 = '00900' and A002.A002004 > '00900'
 * queryFlag    Y|null|N (查询|查询|不查询)
 * qryId        默认查询id 如为空 则传 ''
 * pageFlag     查询是否分页 Y|N (分页|不分页)
 * checkScale   1|null 检测行条件|不检测
 * operFlag       1|null|2 使用查询范围权限|使用查询范围权限|使用维护范围权限
 */
function doAdvanceQuery(setType, unitType, mask, hideSaveButton, sessionKey, addedCondition, queryFlag, qryId, pageFlag,checkScale,operFlag) {
    if (mask.length != 3) {
        alert("mask参数不正确");
        return false;
    }
    if ("N" != queryFlag)
        queryFlag = "Y";
    if (hideSaveButton != 'Y')
        hideSaveButton = "";
    pos = mask.indexOf("1");
    url = "QueryOrgSetting.jsf";
    if (pos == 1)
        url = "QueryConditionSetting.jsf";
    else if (pos == 2)
        url = "QueryItemSetting.jsf";
    if (qryId == undefined || qryId == null)
        qryId = "";
    if (pageFlag == undefined || pageFlag == null)
        pageFlag = "Y";
    if(checkScale == undefined || checkScale== null)
        checkScale = "0";
    arg = "resetFlag=Y";
    arg += "&pop=Y";
    arg += "&qsType=Q";
    arg += "&classId=DIALOG";
    arg += "&setType=" + setType;
    arg += "&queryFlag=" + queryFlag;
    //是否查询
    arg += "&dialog=" + mask;
    arg += "&unitType=" + unitType;
    arg += "&sessionKey=" + sessionKey;
    arg += "&hideSave=" + hideSaveButton;
    arg += "&addedCondition=" + addedCondition;
    arg += "&qryId=" + qryId;
    arg += "&pageFlag=" + pageFlag;
    arg += "&checkScale=" + checkScale;
    arg += "&operFlag=" + operFlag;

    var width=screen.width-20;// 自适应宽度
    retval = window.showModalDialog("/qry/" + url + "?" + arg, "", "dialogWidth:"+width+"px; dialogHeight:550px; center:yes; status:1;");
    if (retval)
        return true;
    else
        return false;
}

/**
 * 批量操作询问
 *
 */
function checkBatchDo(selected_ids){
    var form = document.forms[0];
    var field = form(selected_ids);
    if (checkMutilSelect(field)) {
        return true;
    } else {
        alert("请选择操作对象！");
        return false;
    }
}
/**
 * 批量操作询问
 *
 */
function checkBatchDelete(selected_ids){
    var form = document.forms[0];
    var field = form(selected_ids);
    if (checkMutilSelect(field)) {
        if (confirm('确定要删除吗？')) {
            return true;
        } else {
            return false;
        }
    } else {
        alert("请选择删除项！");
        return false;
    }
}
/**
 * 回车跳转到下一个对象
 *
 */
function gotoNextPage(arg) {
    if (event.keyCode == 13) {//回车
        forpage(arg);
    } else {
        return;
    }

}

function linkOver(src) {
    src.style.color = "#FF6600";
    src.style.cursor = "hand";
    src.style.textDecoration = "underline";
}

function linkOut(src) {
    src.style.color = "#294673";
    src.style.cursor = "auto";
    src.style.textDecoration = "none";
}

function tdlinkOver(src) {
    var obj = src.parentElement.cells;
    if (obj != null) {
        for (i = 0; i < obj.length; i++) {
            obj[i].style.backgroundColor = "#BCD5EE";
        }
    }
    src.style.cursor = "hand";
    src.style.textDecoration = "none";
}

function tdlinkOut(src) {
    var obj = src.parentElement.cells;
    if (obj != null) {
        for (i = 0; i < obj.length; i++) {
            obj[i].style.backgroundColor = "#FFFFFF";
        }
    }
    src.style.cursor = "auto";
    src.style.textDecoration = "none";
}

function inputEnter(src) {
    trlinkOver(src.parentNode.parentNode);
}
function inputExit(src) {
    trlinkOut(src.parentNode.parentNode);
}

function trlinkOver(src) {
    var obj = src.cells;
    if (obj != null) {
        for (i = 0; i < obj.length; i++) {
            obj[i].style.backgroundColor = "#BCD5EE";
        }
    }
    src.style.cursor = "hand";
    src.style.textDecoration = "none";
}

function trlinkOut(src) {
    var obj = src.cells;
    if (obj != null) {
        for (i = 0; i < obj.length; i++) {
            obj[i].style.backgroundColor = "#FFFFFF";
        }
    }
    src.style.cursor = "auto";
    src.style.textDecoration = "none";
}

function setDataTableOver(id){
    if (document.getElementById(id)==null) return;
    var changeTr=document.getElementById(id).getElementsByTagName("tr");
    for(i=1;i<changeTr.length;i++){
          changeTr[i].onmouseover=function(){
                                               trlinkOver(this);
                                             };
          changeTr[i].onmouseout=function(){
	                                            trlinkOut(this);
                                             };
    }
}
function setTableInputOver(id){
    if (document.getElementById(id)!=null && document.getElementById(id)!=undefined){
        var changeTr=document.getElementById(id).getElementsByTagName("input");
        if (changeTr!=null &&changeTr!=undefined){
            for(var i=0;i<changeTr.length;i++){
                  if (changeTr[i].type.toLowerCase()=="text"){  // 录入框
                  changeTr[i].onfocusin=function(){
                                                       inputEnter(this);
                                                  };
                  changeTr[i].onfocusout=function(){
                                                       inputExit(this);
                                                 };
                  }
            }
        }
    }
}
String.prototype.trim = function(){
    return this.replace(/(^[\s]*)|([\s]*$)/g, "");
}
String.prototype.lTrim = function(){
    return this.replace(/(^[\s]*)/g, "");
}
String.prototype.rTrim = function(){
    return this.replace(/([\s]*$)/g, "");
}

var win = window;
var n = 0;
function forSearch(str) {
    var txt, i, found;
    if (str == "")
        return false;
    txt = win.document.body.createTextRange();

    for (i = 0; i <= n && (found = txt.findText(str)) != false; i++) {
        txt.moveStart("character", 1);
        txt.moveEnd("textedit");
    }
    if (found) {
        txt.moveStart("character", -1);
        txt.findText(str);
        txt.select();
        txt.scrollIntoView();
        n++;

    } else {
        if (n > 0) {
            n = 0;
            forSearch(str);
        } else {
            alert("抱歉!没有找到");
            return false;
        }
    }
    return false;
}

function enterKeyDown(btnName){
    if (event.keyCode == 13) {  //回车
        document.getElementById(btnName).click();
        event.keyCode=null;
    }
    return false;
}

function PopUpRuleTypeTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/common/SelRuleType.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpelearnDirTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eLearn/SeleLearnDir.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null && retval!="") {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpeLearnCourseTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/eLearn/selectCourse.jsf?CourseID="+codec.value, "", "dialogWidth:500px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpeLearnCourseDlg(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eLearn/selectCourseDlg.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}


function PopUpCWTypeTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/common/SelCWType.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpItemKeyTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eva/SelItemKey.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpItemKeySetTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eva/SelItemKeySet.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpItemSetTwoControl(id,codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eva/SelItemSet.jsp?templateID="+id, "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpEvaTemplateTwoControl(codec, valuec,orguid) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eva/SelTemplate.jsp?OrgID="+orguid, "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpGradeTypeTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eva/SelGrade.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpPaperTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eLearn/SelPaperLib.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpPaperLibTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eLearn/SelPaperLibDir.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpQuestionLibTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eLearn/SelQuestionLibDir.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
function PopUpTemplateSetTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/eva/SelTemplateDir.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpLawTypeTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/common/SelLawType.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}



// 在线培训
function showRealPlay(title,url){
    window.open('/pages/common/showCource.jsp?Title='+title+'&URL='+url, "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
}
// 在线培训
function showMediaPlay(title,url){
    window.open('/pages/common/showMedia.jsp?Title='+title+'&URL='+url, "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
}
// 在线培训
function showFlvPlay(title,url){
    window.open('/pages/common/showFlv.jsp?Title='+title+'&URL='+url, "_blank", "top=50,height=600,left="+(screen.width-900)/2+",width=900,toolbar=no,scrollbars="+scroll+",menubar=no");
}

// 显示培训教材
function doShowCource(action,title,url){
    if (action=="2"){
        window.open(url, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=true,menubar=no");
    }
    else{
        if (url.toLowerCase().indexOf(".flv")>0 || url.toLowerCase().indexOf(".mp4")>0){
           showFlvPlay(title,url);
        }
        else if (url.toLowerCase().indexOf(".wmv")>0){
           showMediaPlay(title,url);
        }
        else{
           showRealPlay(title,url);
        }
    }
}

// 正在建设中
function doShowContruct(){
    window.showModalDialog("/pages/common/showContructing.jsp", null, "dialogWidth:460px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
}
// 在线考试
function doTest(id){
    window.showModalDialog("/eLearn/doTest.jsf?testID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}

// 在线调查
function doSurvey(paperID){
    if (paperID!=null && paperID!=""){
        window.open('/common/DoSurvey.jsf?paperID='+paperID, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=auto,menubar=no");
    }
}
function showSurveyResult(paperID){
    window.open('/system/survey/PaperResult.jsf?paperID='+paperID, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=auto,menubar=no");
}
function showSurvey(paperID){
    window.open('/common/ShowSurvey.jsf?paperID='+paperID, "_blank", "top="+screen.height*0.05+",height="+screen.height*0.9+", left="+screen.width*0.05+",width="+screen.width*0.9+",toolbar=no,scrollbars=auto,menubar=no");
}
function showSurveyInword(paperID){
    window.open('/common/ShowSurveyInWord.jsf?paperID='+paperID, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=auto,menubar=no");
}

// 显示公告
function doShowBulletin(ID){
    window.open('/self/QueryOneBulletin.jsf?subOneId='+ID, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=yes,menubar=no");
}
// 修改公告
function doEditBulletin(ID){
    if (ID!=null && ID!=""){
        window.showModalDialog('/system/BulletinEdit.jsf?idforEdit='+ID, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    else{
        window.showModalDialog('/system/BulletinEdit.jsf', null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    return true;
}

// 显示学习公告
function doShowElearnBulletin(ID){
    window.showModalDialog('/eLearn/QueryOneBulletin.jsf?subOneId='+ID, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
}

// 显示新闻
function doShowNews(ID){
    window.showModalDialog('/self/QueryOneNews.jsf?subOneId='+ID, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
}


function doShowRule(ruleid){
    window.showModalDialog("/rule/ShowRule.jsf?RuleID="+ruleid, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
function doShowLaw(lawid){
    window.showModalDialog("/rule/ShowLaw.jsf?LawID="+lawid, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}

function doExport(){
    window.open("/pages/common/ExportToExcel.jsp");
}
function doExport2(){
    window.open("/pages/common/ExportToExcel2.jsp");
}

function exportToExcel(ID){
   window.open('/pages/common/ExportToExcel.jsp?sessionKey='+ID, "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
}


function ExportShowTable(){
   window.open("/pages/common/ExportShowTable.jsp", "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
}

// 显示合同
function doShowCont(ID){
  window.open('/pages/cont/Download.jsp?attachmentId='+ID, "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
  return false;
}

// 显示人员登记表
function doShowPersonTable(reportID,PersonID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ID="+PersonID;
    window.open(url);
}
// 显示机构登记表
function doShowOrgTable(reportID,orgID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ORGUID="+orgID;
    window.open(url);
}

// 显示人员花名册
function doShowPersonRoster(reportID,unitID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ORGUID="+unitID;
    window.open(url);
}
function doShowOrgRoster(reportID,unitID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ORGUID="+unitID;
    window.open(url);
}

// 显示人员工资
function forViewPersonWage(id){
    window.showModalDialog("/wage/payoff/wagePersonquery.jsf?pID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
}
// 浏览员工档案
function forViewPersonDoc(id) {
    windowOpen("/doc/PersonIndex.jsf?flag=2&fk="+id+"&typeId=2001010000,2001010100&setId=A001", "aa", "", "1000", "600", "auto","10","1","yes");
}
function forViewOrgDoc(id) {
    windowOpen("/doc/OrgIndex.jsf?fk="+id, "aa", "", "1000", "600", "auto","10","1","yes");
}
function forViewPost(id) {
    windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=1","aa","","900","600","no","10","100","yes");
}
function forViewPostInSelf(id) {
    windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=1&flag=1","aa","","900","600","no","10","100","yes");
}

// 显示人员信息
// type=1 只读
function showPersonCard(id) {
    windowOpen("/pages/employee/info/showPersonCard.jsp?PersonID=" +id, "aa", "", "1000", "600", "no","10","1","yes");
}

function forViewPersonDetail(id) {
    windowOpen("/employee/info/PersonEditInfo.jsf?pk=" +id+"&type=1", "aa", "", "1000", "600", "no","10","1","yes");
}
// 修改人员信息
function forModifyPersonDetail(id) {
    windowOpen("/employee/info/PersonEditInfo.jsf?pk=" +id+"&type=0", "aa", "", "1000", "600", "no","10","1","yes");
}
function forModifyPartyPersonDetail(id) {
   windowOpen("/employee/info/PersonEditInfo.jsf?pk=" +id+"&type=0&partyFlag=1", "aa", "", "1000", "600", "no","10","1","yes");
}
function forModifyPersonApply(id) {
    windowOpen("/self/info/PersonEditInfo.jsf?pk=" +id, "aa", "", "1000", "600", "no","10","1","yes");
}
// 在线学习
function doLearn(){
    window.showModalDialog("/eLearn/eLearnIndex.jsf", null, "dialogWidth:"+screen.width+"px; dialogHeight:"+screen.height+"px;center:center;resizable:yes;status:no;scroll:no;");
    return false;
}



function showWorkDefine(typeID){
    window.showModalDialog("/system/workFlowList.jsf?TypeID="+typeID, null, "dialogWidth:"+screen.width*0.94+"px; dialogHeight:"+screen.height*0.86+"px;center:center;resizable:yes;status:no;scroll:no;");
    return false;
}
function showWorkFlowLog(processID){
    window.showModalDialog("/system/showWorkFlowLog.jsf?ProcessID="+processID, null, "dialogWidth:"+screen.width*0.94+"px; dialogHeight:"+screen.height*0.86+"px;center:center;resizable:yes;status:no;scroll:no;");
    return false;
}

function showWorkFlowLogByLinkID(linkID){
    window.showModalDialog("/system/showWorkFlowLog.jsf?linkID="+linkID, null, "dialogWidth:"+screen.width*0.94+"px; dialogHeight:"+screen.height*0.86+"px;center:center;resizable:yes;status:no;scroll:no;");
    return false;
}
/**
 * 考勤排班设置
 * @param codec
 * @param valuec
 * @return
 */
function PopUpMoni(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/attence/SelGroupMgr.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function sendMessage(ReceiveID,Msg){
    var ret=window.showModalDialog("/system/SendMessage.jsf?RecID="+ReceiveID+"&Msg="+Msg, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
    if (ret=="ok"){
      return true;
    }
    else{
        return false;
    }
}
function sysSendMail(attFileMode){
    window.showModalDialog("/system/SendMail.jsf?attFileMode="+attFileMode, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
function showCalendar(){
    window.open("/attence/showCalenda.jsf", null, "dialogWidth:550px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
function PopUpRptList(codeField, nameField, useRightFlag, rootId) {
    if (codeField == null || nameField == null)
        return false;
    if (codeField != "[object]")
        codeField = document.getElementById(codeField);
    if (nameField != "[object]")
        nameField = document.getElementById(nameField);
    showx = event.screenX - event.offsetX - 160//+ 25; // + deltaX;
    showy = event.screenY - event.offsetY + 18;

    var arg="rootId=" + rootId;

    retval = window.showModalDialog("/pages/report/ShowReportPowerAdd.jsp?" + arg, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;");
    if (retval != null) {
        retval = retval.split("|");
        codeField.value = retval[0];
        nameField.value = retval[1];
        return true;
    }
    else
        return false;
}

function PopUpRule(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/attence/SelAnnualMgr.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpRuleItem(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/attence/SelAttExecludeRule.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpItemRptGroupDirTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/report/RptGroupDirCodeSet.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function selectInfoItem(setType,name,id) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/common/SelInfoItem.jsp?setType="+setType, "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        name.value=rs[0];
        id.value=rs[1];
    }
}

function showAllFile(){
    showx = (screen.width-200)/2;
    showy = (screen.height-120)/2;
    window.open("/pages/common/showFile.jsp", "_blank", "top="+showy+",left="+showx+",height=120, width=200,toolbar=no,scrollbars=no,menubar=no,resizable=yes");
}

function colEdit() {
    window.showModalDialog("/pages/common/colEdit.jsp", "", "dialogWidth:500px; dialogHeight:"+screen.height*0.85+"px; status:0;resizable:no;center:yes;scrollbars:yes");
}
/**
 *  id    图片值
 *  field 对应字段
 *  pk    主键
 **/
function EditPhotoField(imgID,field,pk) {
    window.showModalDialog("/common/editPhotoField.jsf?imgID="+imgID+"&field="+field+"&pk="+pk, "", "dialogWidth:600px; dialogHeight:500px; status:0;resizable:yes;center:yes;scrollbars:yes;maximize:yes;");
    if (document.forms[0]!=null){  // 强制刷新
        document.forms[0].submit();
    }
}

function viewPhotoField(imgID,field,pk) {
    window.showModalDialog("/common/editPhotoField.jsf?ReadOnly=true&imgID="+imgID+"&field="+field+"&pk="+pk, "", "dialogWidth:600px; dialogHeight:500px; status:0;resizable:yes;center:yes;scrollbars:yes");
    if (document.forms[0]!=null){  // 强制刷新
        document.forms[0].submit();
    }
}

function PopUpLainStockTwoControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/common/LainStockCode.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function PopUpRptDefineListsss(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/report/RptDefineCodeSet.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function selectItemFlag(controlName){
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
	 retval = window.showModalDialog("/pages/common/itemSetConfigAddFlagChar.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
	 controlName.value=retval;
}
//---------- 身份卡 ---------------
function installDrv(){
    try{
         document.getElementById('cardIApi').GetLibVersion();
    }
    catch(err){
        window.status=err.message;
        return false;
    }
    return true;
}
function startInstall(){
    retval = window.showModalDialog("/pages/system/CardI/installDrv.html", "", "dialogWidth:350px; dialogHeight:190px; center:center; status:0;");
}
function PopUpItemRptSetControl(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/report/RptGroupCodeList.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

function viewTax(){
    window.showModalDialog("/wage/set/taxCountMethod.jsf?setId=" + document.getElementById("form1:setId").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
function viewYearTax(){
    window.showModalDialog("/wage/set/taxYearCountMethod.jsf?setId=" + document.getElementById("form1:setId").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
function viewStandard(sid){
    window.showModalDialog("/wage/base/StandardEditValueDlg.jsf?StandardID=" + sid, null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
function viewFormula(fid){
    window.showModalDialog("/wage/base/FormulaView.jsf?formulaid=" + fid, null, "dialogWidth:800px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
function disPlayProcessBar() {
   x = document.body.clientWidth / 2 - 150;
   y = document.body.clientHeight / 2;
   document.getElementById('processbar').style.top = y;
   document.getElementById('processbar').style.left = x;
   document.getElementById('processbar').style.display = "";
   return true;
}
function showExcelFile(){
    window.open('/pages/common/ShowExcel.jsp');
}
