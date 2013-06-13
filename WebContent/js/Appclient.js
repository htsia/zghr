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
 *  ����ҳ���ϵĴ���
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

    //��ʼajax����
    //����XMLHttpRequest����
    if (window.ActiveXObject)
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    else if (window.XMLHttpRequest)
        xmlHttp = new XMLHttpRequest();

    if (xmlHttp == null) {
        alert("�������֧��ajax")
        return;
    }

    xmlHttp.onreadystatechange = codeInterpretCallback;
    xmlHttp.open("GET", "/pages/ajax/Interpret.jsp?" + reqStr, true);
    xmlHttp.send(null);
}
function codeInterpretCallback() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
            //�����ص�����
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
 *���뷭��:��������ɴ���ֵ
 *����onsubmit����
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
 *��ʾֻ��ѡ��һ��
 */
function selectOnlyOne(field) {
    size = field.length;
    var flag = 0;
    id = null;
    if (size != null) {  // ���
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
        if (field.checked){   // ����
            id = field.value;
            return id;
         }
         else {
             alert("û���κ�ѡ��");
             return null;
         }
    }
    if (flag==0){
        alert("û���κ�ѡ��");
        return null;
    }
    else if (flag > 1) {
        alert("ֻ��ѡ��һ����");
        return null;
        //ѡ�����ʱ����null
    } else
        return id;
}

/**
 * У��checkBox��radio�Ƿ�ѡ��
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

// �õ���һ��ѡ�е���Ŀ  ����ֵΪ�ַ���
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

//  �õ�����ѡ��ֵ ����ֵΪ�ַ���
//  filter Ϊ�����Ŀʱ�ķָ�������,
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
 * ��Ӧȫѡ�¼���
 * all:ȫѡ�¼�checkbox����
 * chk:��Ҫȫѡcheckbox����
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
 * �ύ���������
 * targObj:parent���ڵ�iframe������
 * height:��С�߶�
 */
function forsubmit(form1, flag) {
    if (checkAll(form1, flag)) {
        pageCodeExchange(form1);
        return true;
    } else {
        return false;
    }
}

 // ������������Ի���
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
function PopUpCalendarDlg_OnlyMonth(obj) {   // ֻѡ���·�
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
function PopUpCalendar_OnlyMonth(obj) {   // ֻ��ʾ����������
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
function PopUpCalendarDlg_OnlyYear(obj) {   // ֻѡ�����
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
 * �����´���
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

//---------------ѡ�����--------------------------------------------------------------------------------------
//    rootCodeId,����ĸ��ڵ㣬�ö��Ÿ��� "12,13";
//    flag �Ƿ�ѡ��Ҷ flag=0,ֻ����ѡ��Ҷ��flag=1,����ѡ��֦ ,��������=2���������ݿ���������ж�Ҫѡ��֦����Ҷ
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
//  codec ����
//  valuec ����
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
 *    ѡ�����
 *       obj ��Ӧ��ʾ�ؼ�
 *       useRightFlag Ȩ�޷�ʽ 0-��ʹ�� 1-ʹ�ò�ѯȨ�޹���,2-ʹ��ά��Ȩ�޹��ˣ�
 *       rootOrgId���ڵ�Ļ�����ţ������á������ָ�
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

function PopUpOrgOnlyDlg(obj, useRightFlag, rootOrgId) { //   ������ʾ���� useRightFlag 0-��ʹ�� 1-ʹ�ò�ѯȨ�޹���,2-ʹ��ά��Ȩ�޹��ˣ�rootOrgId���ڵ�Ļ�����ţ������á������ָ�
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

function PopUpOrgDlgShowGroup(obj, useRightFlag, rootOrgId, onlyOrg) {    // ��ʾ����
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


function fPopUpOrgDlg2(codec, valuec, useRightFlag, rootOrgId) {  //ѡ�����  useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ�����ţ������á������ָ�
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
//ѡ�����  useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ�����ţ������á������ָ�
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

function fPopUpWageUnitDlg(obj, checkRight) { //ѡ��н�ʻ������Ȩ�� checkRight =true �����Ȩ�� checkright��false
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

//���Ȩ�� checkRight =true �����Ȩ�� checkright��false
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
// ѡ��н����
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

// ѡ��н�ʲ���
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

//ѡ����֯  useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ�����ţ������á������ָ�
//partyType 0��ȫ�� 1|null|''������֯ 2���ѳ�������֯ 3��ֻ��ʾ���еĵ�ί
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
//ѡ����֯  useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ�����ţ������á������ָ�
//partyType 0��ȫ�� 1|null|''������֯ 2���ѳ�������֯ 3��ֻ��ʾ���еĵ�ί
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

//���� ��ҳ�����ʾ������
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
//useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ������
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

//useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ������
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
//useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ������
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

//----------------------------------  ѡ���ѡ����   -------------------------------
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
// ����ؼ� �����ؼ� ����/ָ��  ������
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

// ��ʾ��ѡ����
//   codeField  ������
//   nameField  ������
//   dict_num   ���뼯
//   cur_code   ��ǰѡ��ֵ
//    ���ѡ�񷵻�true ���򷵻�false
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

//ѡ����֯  useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ�����ţ������á������ָ�
//partyType 0��ȫ�� 1|null|''������֯ 2���ѳ�������֯ 3��ֻ��ʾ���еĵ�ί
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

//ѡ����֯  useRightFlag 0-��ʹ�� 1-ʹ��Ȩ�޹��ˣ� rootOrgId���ڵ�Ļ�����ţ������á������ָ�
//partyType 0��ȫ�� 1|null|''������֯ 2���ѳ�������֯ 3��ֻ��ʾ���еĵ�ί
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
 *  ѡ�񵥸���Ա
 *      objname1 �����ֶ�ID
 *      objname1 ID�ֶ�ID
 *      superId Ҫѡ�������orguid 
 *      rightFlag ����Ȩ��ģʽ 0 �����   1 ����  2 ��ѯ
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
// ѡ����Ա
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

// ѡ����Ա ��Ҫ������Ȩ�޼���
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

//��ѡ����Ա
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

//ѡ����Ա�󣬰���Ա��ŷŵ���̨��httpsession��
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

// ������ģʽ����
// rootId
// rightFlag
function fPopUpBackPerTreeDlg(rootId) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    window.showModalDialog("/common/SelBackTreePerson.jsf?rootId=" + rootId+"&rightFlag=2", "", "dialogWidth:800px; dialogHeight:700px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
}

//��ѡ����Ա(ͨ������֯��ѯ)
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
*     ѡ���λ
*        obj1 ����ؼ�ID
*        obj2 �����ؼ�ID
*        superId Ҫ���λ�Ļ�������
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
*     ��Ա������Ϣά��ѡ���λ
*        obj1 ����ؼ�ID
*        obj2 �����ؼ�ID
*        superId Ҫ���λ�Ļ�������
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
//��ѡ���λ obj1���λid,obj2���λ����,obj3�����ڻ�������
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
 * �߼���ѯ
 * setType      A|B|C|D (��Ա|����|��λ|����֯)
 * unitType     ORG|PARTY (�û�������|�õ���֯����)
 * mask       111 ��λ���ֱַ��Ӧ ������Χ����.��ѯ��������.��ʾ������� 0��ʾ����ʾ 1��ʾ
 * hideSaveButton   Y|null (����ʾ���水ť|��ʾ���水ť)
 * addedCondition        ���ӵ�sql�������� A001.A001005 = '00900' and A002.A002004 > '00900'
 * queryFlag    Y|null|N (��ѯ|��ѯ|����ѯ)
 * qryId        Ĭ�ϲ�ѯid ��Ϊ�� �� ''
 * pageFlag     ��ѯ�Ƿ��ҳ Y|N (��ҳ|����ҳ)
 * checkScale   1|null ���������|�����
 * operFlag       1|null|2 ʹ�ò�ѯ��ΧȨ��|ʹ�ò�ѯ��ΧȨ��|ʹ��ά����ΧȨ��
 */
function doAdvanceQuery(setType, unitType, mask, hideSaveButton, sessionKey, addedCondition, queryFlag, qryId, pageFlag,checkScale,operFlag) {
    if (mask.length != 3) {
        alert("mask��������ȷ");
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
    //�Ƿ��ѯ
    arg += "&dialog=" + mask;
    arg += "&unitType=" + unitType;
    arg += "&sessionKey=" + sessionKey;
    arg += "&hideSave=" + hideSaveButton;
    arg += "&addedCondition=" + addedCondition;
    arg += "&qryId=" + qryId;
    arg += "&pageFlag=" + pageFlag;
    arg += "&checkScale=" + checkScale;
    arg += "&operFlag=" + operFlag;

    var width=screen.width-20;// ����Ӧ���
    retval = window.showModalDialog("/qry/" + url + "?" + arg, "", "dialogWidth:"+width+"px; dialogHeight:550px; center:yes; status:1;");
    if (retval)
        return true;
    else
        return false;
}

/**
 * ��������ѯ��
 *
 */
function checkBatchDo(selected_ids){
    var form = document.forms[0];
    var field = form(selected_ids);
    if (checkMutilSelect(field)) {
        return true;
    } else {
        alert("��ѡ���������");
        return false;
    }
}
/**
 * ��������ѯ��
 *
 */
function checkBatchDelete(selected_ids){
    var form = document.forms[0];
    var field = form(selected_ids);
    if (checkMutilSelect(field)) {
        if (confirm('ȷ��Ҫɾ����')) {
            return true;
        } else {
            return false;
        }
    } else {
        alert("��ѡ��ɾ���");
        return false;
    }
}
/**
 * �س���ת����һ������
 *
 */
function gotoNextPage(arg) {
    if (event.keyCode == 13) {//�س�
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
                  if (changeTr[i].type.toLowerCase()=="text"){  // ¼���
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
            alert("��Ǹ!û���ҵ�");
            return false;
        }
    }
    return false;
}

function enterKeyDown(btnName){
    if (event.keyCode == 13) {  //�س�
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



// ������ѵ
function showRealPlay(title,url){
    window.open('/pages/common/showCource.jsp?Title='+title+'&URL='+url, "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
}
// ������ѵ
function showMediaPlay(title,url){
    window.open('/pages/common/showMedia.jsp?Title='+title+'&URL='+url, "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
}
// ������ѵ
function showFlvPlay(title,url){
    window.open('/pages/common/showFlv.jsp?Title='+title+'&URL='+url, "_blank", "top=50,height=600,left="+(screen.width-900)/2+",width=900,toolbar=no,scrollbars="+scroll+",menubar=no");
}

// ��ʾ��ѵ�̲�
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

// ���ڽ�����
function doShowContruct(){
    window.showModalDialog("/pages/common/showContructing.jsp", null, "dialogWidth:460px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
}
// ���߿���
function doTest(id){
    window.showModalDialog("/eLearn/doTest.jsf?testID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}

// ���ߵ���
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

// ��ʾ����
function doShowBulletin(ID){
    window.open('/self/QueryOneBulletin.jsf?subOneId='+ID, "_blank", "top="+screen.height*0.1+",height="+screen.height*0.8+", left="+screen.width*0.125+",width="+screen.width*0.75+",toolbar=no,scrollbars=yes,menubar=no");
}
// �޸Ĺ���
function doEditBulletin(ID){
    if (ID!=null && ID!=""){
        window.showModalDialog('/system/BulletinEdit.jsf?idforEdit='+ID, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    else{
        window.showModalDialog('/system/BulletinEdit.jsf', null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    return true;
}

// ��ʾѧϰ����
function doShowElearnBulletin(ID){
    window.showModalDialog('/eLearn/QueryOneBulletin.jsf?subOneId='+ID, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
}

// ��ʾ����
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

// ��ʾ��ͬ
function doShowCont(ID){
  window.open('/pages/cont/Download.jsp?attachmentId='+ID, "_blank", "height="+screen.height+", width="+screen.width+",toolbar=no,scrollbars="+scroll+",menubar=no");
  return false;
}

// ��ʾ��Ա�ǼǱ�
function doShowPersonTable(reportID,PersonID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ID="+PersonID;
    window.open(url);
}
// ��ʾ�����ǼǱ�
function doShowOrgTable(reportID,orgID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ORGUID="+orgID;
    window.open(url);
}

// ��ʾ��Ա������
function doShowPersonRoster(reportID,unitID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ORGUID="+unitID;
    window.open(url);
}
function doShowOrgRoster(reportID,unitID){
    var url="/pages/report/ServerReportShow.jsp?RptCode="+reportID+"&ORGUID="+unitID;
    window.open(url);
}

// ��ʾ��Ա����
function forViewPersonWage(id){
    window.showModalDialog("/wage/payoff/wagePersonquery.jsf?pID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
}
// ���Ա������
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

// ��ʾ��Ա��Ϣ
// type=1 ֻ��
function showPersonCard(id) {
    windowOpen("/pages/employee/info/showPersonCard.jsp?PersonID=" +id, "aa", "", "1000", "600", "no","10","1","yes");
}

function forViewPersonDetail(id) {
    windowOpen("/employee/info/PersonEditInfo.jsf?pk=" +id+"&type=1", "aa", "", "1000", "600", "no","10","1","yes");
}
// �޸���Ա��Ϣ
function forModifyPersonDetail(id) {
    windowOpen("/employee/info/PersonEditInfo.jsf?pk=" +id+"&type=0", "aa", "", "1000", "600", "no","10","1","yes");
}
function forModifyPartyPersonDetail(id) {
   windowOpen("/employee/info/PersonEditInfo.jsf?pk=" +id+"&type=0&partyFlag=1", "aa", "", "1000", "600", "no","10","1","yes");
}
function forModifyPersonApply(id) {
    windowOpen("/self/info/PersonEditInfo.jsf?pk=" +id, "aa", "", "1000", "600", "no","10","1","yes");
}
// ����ѧϰ
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
 * �����Ű�����
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
 *  id    ͼƬֵ
 *  field ��Ӧ�ֶ�
 *  pk    ����
 **/
function EditPhotoField(imgID,field,pk) {
    window.showModalDialog("/common/editPhotoField.jsf?imgID="+imgID+"&field="+field+"&pk="+pk, "", "dialogWidth:600px; dialogHeight:500px; status:0;resizable:yes;center:yes;scrollbars:yes;maximize:yes;");
    if (document.forms[0]!=null){  // ǿ��ˢ��
        document.forms[0].submit();
    }
}

function viewPhotoField(imgID,field,pk) {
    window.showModalDialog("/common/editPhotoField.jsf?ReadOnly=true&imgID="+imgID+"&field="+field+"&pk="+pk, "", "dialogWidth:600px; dialogHeight:500px; status:0;resizable:yes;center:yes;scrollbars:yes");
    if (document.forms[0]!=null){  // ǿ��ˢ��
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
//---------- ��ݿ� ---------------
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
