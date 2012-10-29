var spanValue;
var actStatus;
function iclick() {
    var count = show.all.length;
    var oChild;
    for (i = 0; i < count; i++) {
        oChild = show.children(i);
        if (oChild!=null){
            oChild.style.color = "black";
            oChild.style.fontWeight = "normal";
        }
    }
    event.srcElement.style.color = "red";
    event.srcElement.style.fontWeight = "bold";
    spanValue = event.srcElement;
}
function removeSpan() {
    if (spanValue == null) {
        alert("请选择指标项再进行操作！");
        return;
    } else {
        name = spanValue.id.substring(5, spanValue.id.length);
        show.removeChild(spanValue);
        document.all('exp').removeChild(document.all["exp_" + name]);
        spanValue = null;
    }
}
function setActStatus(status) {
    if (spanValue == null) {
        alert("请选择指标项再进行操作！");
        return;
    }
    //设置操作状态
    actStatus = status;
    //debugger;
    if (status=="replace"){
       document.all("form1:status").innerText="编辑状态:替换";
    }
    else if (status=="insert"){
       document.all("form1:status").innerText="编辑状态:插入";
    }
    else{
       document.all("form1:status").innerText="编辑状态:添加";
    }
}
function clearText() {
    if (confirm("你真的要清除吗？")) {
        document.all('exp').innerHTML = "";
        show.innerHTML = "";
        spanValue = null;
        actStatus = "";
        spanValue = document.all('show');
    }
}
function spanOperation(value, name) {
    if (actStatus == 'insert') {    //执行插入操作
        var randomName = Math.random();
        expSpan = "<span id='show_" + randomName + "' onclick=iclick()>" + name + "</span>";
        spanValue.insertAdjacentHTML("BeforeBegin", expSpan);

        showSpan = "<span id='exp_" + randomName + "'>" + value + "</span>";
        spanname = spanValue.id.substring(5, spanValue.id.length);
        document.all["exp_" + spanname].insertAdjacentHTML("BeforeBegin", showSpan);

        spanValue.removeAttribute("style");
        spanValue = null;
        actStatus = "";
        return;
    } else if (actStatus == 'replace') { //执行替换操作
        spanValue.innerText = name;
        spanname = spanValue.id.substring(5, spanValue.id.length);
        document.all["exp_" + spanname].innerText = value;
        spanValue.removeAttribute("style");
        spanValue = null;
        actStatus = "";
        return;
    } else {
        //在show中添加span元素
        randomName = Math.random();
        showSpan = "<span id='show_" + randomName + "' onclick=iclick()>" + name + "</span>"
        expSpan = "<span id='exp_" + randomName + "'>" + value + "</span>"
        show.insertAdjacentHTML('BeforeEnd', showSpan);
        document.all('exp').insertAdjacentHTML('BeforeEnd', expSpan);
        actStatus = "";
    }
}

function selectCodeOperation() {
    var codeObj = document.forms(0).condValue;
    codeObj.dict_num = document.forms(0).infoItem.codeSet;
    if (codeObj.code == null
        || codeObj.value == null
        || codeObj.code == ""
        || codeObj.value == "") return false;
    spanOperation(codeObj.code, codeObj.value);
}
function selectCodeOperation2() {
    var codeObj = document.forms(0).condValue2;
    codeObj.dict_num = document.forms(0).infoItem2.codeSet;
    if (codeObj.code == null
        || codeObj.value == null
        || codeObj.code == ""
        || codeObj.value == "") return false;
    spanOperation(codeObj.code, codeObj.value);
}

function selectRsFieldOperation(itemName) {
    var obj = document.forms(0).all(itemName);
    if (obj.value == "")return;

    value = "_" + obj.code.substr(0, 4) + "." + obj.code;
    name = rsTableName + "." + obj.value;
    spanOperation(value, name);
}

// 选择指标项
function selectInfoItem() {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/wage/base/FormulaInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        form1.infoItem.value = rs[1];
        form1.infoItem.code = "_" + rs[0];
        form1.infoItem.datatype = rs[2];
        form1.infoItem.codeSet = rs[3];
        form1.condValue.value = "";
        form1.condValue.dict_num = rs[3];
    }
}
function selectInfoItem2() {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;

    retval = window.showModalDialog("/pages/wage/base/FormulaInfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        form1.infoItem2.value = rs[1];
        form1.infoItem2.code = "_" + rs[0];
        form1.infoItem2.datatype = rs[2];
        form1.infoItem2.codeSet = rs[3];
        form1.condValue2.value = "";
        form1.condValue2.dict_num = rs[3];
    }
}

function selectConst(){
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    url="/pages/wage/base/ConstItem.jsp?setId="+document.all('form1:setId').value;
    //alert(url);
    retval = window.showModalDialog(url, "", "dialogWidth:215px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    if (retval != null) {
        rs = retval.split("|");
        form1.wageConst.value = rs[1];
        form1.wageConst.code =  rs[0];
    }
}
function forSelCode() {
    var obj = document.forms(0).condValue;
    if (obj.dict_num != null && obj.dict_num != "" && form1.infoItem.datatype == 6) {
        PopUpCodeDlgOneControl(obj.name);
    }
    else if (form1.infoItem.datatype == 23){
        PopUpWageDeptDlgByPerson(obj.name,useID);
        obj.value="'"+obj.value+"'";
        obj.code=obj.value;
    }
    else {
        return false;
    }
}
function forSelCode2() {
    var obj = document.forms(0).condValue2;
    if (obj.dict_num != null && obj.dict_num != "" && form1.infoItem2.datatype == 6) {
        PopUpCodeDlgOneControl(obj.name);
    } else {
        return false;
    }
}
function checkSubmit(form1) {
    flag = true;
    var name = form1.all("form1:name").value;
    var rsField = form1.all("form1:rsField").value;
    if (name == "" || name == null) {
        alert("公式名称不能为空！");
        flag = false;
    }
    if (!form1.all('form1:usualFlag')[1].checked && !form1.all('form1:usualFlag')[2].checked) {
        alert("必须指定是否通用公式！");
        flag = false;
    }
    if (form1.all('form1:usualFlag')[2].checked) {
        var setId = form1.all('form1:setId').value;
        if (setId == null || setId == '') {
            alert("所属账套不能为空！");
            flag = false;
        }
    } else {
        form1.all('form1:setId').value = "";
    }
    //return false;
    if (rsField == "" || rsField == null) {
        alert("公式结果指标项不能为空！");
        flag = false;
    }
    if (flag) {
        form1.all("form1:htmlDesc").value = document.all('exp').innerHTML;
        form1.all("form1:express").value = document.all('exp').innerText;
        form1.all("form1:chnDesc").value = show.innerHTML;
        form1.all('form1:rsField').value = form1.all('form1:rsField').code;
        return true;
    } else {
        return false;
    }
}
function forcostchange() {
    var oldvalue = form1.all('form1:costId').value;
    PopUpCodeDlgOneControl('form1:costId', '', '0');
    if (form1.all('form1:costId').value != oldvalue) {
        form1.all('form1:costId').value = form1.all('form1:costId').code;
        return true;
    }
    return false;
}

function forUsualChange() {
    var control = form1.all('form1:usualFlag');
    if (control[1].checked) {//standard
        form1.all('form1:setId').disabled = true;
    } else {
        form1.all('form1:setId').disabled = false;
    }
}
