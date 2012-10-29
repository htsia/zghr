function importLicFile(){
    retval = window.showModalDialog("/system/ImportLicFile.jsf", "", "dialogWidth:350px; dialogHeight:190px; center:center; status:0;");
}
function importTokenFile(){
    retval = window.showModalDialog("/system/ImportTokenFile.jsf", "", "dialogWidth:350px; dialogHeight:190px; center:center; status:0;");
}
//选择机构  useRightFlag 0-不使用 1-使用权限过滤； rootOrgId根节点的机构编号，可以用“，”分隔
function PopUpOrgDlg() {
    var arg = "dict_num=OU";
    arg += "&curCode=";
    arg += "&value=";
    arg += "&rightFlag=1";
    arg += "&rootId=";
    //debugger;
    showx = event.screenX - event.offsetX - 250;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/common/SelOrg.jsp?" + arg, "", "dialogWidth:315px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //  debugger;
    if (retval != null) {
        rs = retval.split(",");
        document.forms[0]["formUserManager:selOrgId"].value = rs[0];
        document.forms[0]["formUserManager:queryType"].value ="org";
        return true;
    }
    return false;
}

function queryByUserName(){
    var personName = document.forms[0]["formUserManager:condiValue"].value;
    if(personName==null || personName==""){
        alert('请输入查询条件');
        return false;
    }
    return true;
}
function domodiLevel(){
    var chitem = document.forms(0).selectItem;
    if(chitem==null) return;
    var chklen = 0;
    var perid="";

    if(chitem.length==null){
        perid=chitem.value;
    }else{
        for (i = 0; i < chitem.length; i++) {
            if (chitem[i].checked){
                if (perid==""){
                    perid = chitem[i].value;
                }
                else{
                    perid += ","+chitem[i].value;
                }
            }
        }
    }
    if (perid=="") {
        alert('请先选泽用户！');
        return false;
    }
    showx = event.screenX - event.offsetX - 250;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/user/UserInfoSelfLevEdit.jsf?userId=" + perid, "", "dialogWidth:315px; dialogHeight:160px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0");
    return false;
}

function deployCard(){
    var chitem = document.forms(0).selectItem;
    if(chitem==null) return;
    var chklen = 0;
    var perid;

    if(chitem.length==null){
        perid=chitem.value;
    }else{
        for (i = 0; i < chitem.length; i++) {
            if (chitem[i].checked)
            {
                perid = chitem[i].value;
                chklen++;
            }
        }
        if (chklen > 1) {
            alert('请选择单个用户！');
            return false;
        }
    }
    if (perid==null) {
        alert('请先选泽用户！');
        return false;
    }
    showx = event.screenX - event.offsetX-100;
    showy = event.screenY - event.offsetY + 5;
    retval = window.showModalDialog("/user/UserInfoCardI.jsf?userId=" + perid, "", "dialogWidth:350px; dialogHeight:260px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0");
    return true;
}

function deployOTPCard(){
    var chitem = document.forms(0).selectItem;
    if(chitem==null) return;
    var chklen = 0;
    var perid;

    if(chitem.length==null){
        perid=chitem.value;
    }else{
        for (i = 0; i < chitem.length; i++) {
            if (chitem[i].checked)
            {
                perid = chitem[i].value;
                chklen++;
            }
        }
        if (chklen > 1) {
            alert('请选择单个用户！');
            return false;
        }
    }
    if (perid==null) {
        alert('请先选泽用户！');
        return false;
    }
    showx = event.screenX - event.offsetX - 250;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/user/UserOTPCard.jsf?userId=" + perid, "", "dialogWidth:350px; dialogHeight:260px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0");
    return true;
}

function editLoginName(){
    var chitem = document.forms(0).selectItem;
    if(chitem==null) return;
    var chklen = 0;
    var perid;

    if(chitem.length==null){
        perid=chitem.value;
    }else{
        for (i = 0; i < chitem.length; i++) {
            if (chitem[i].checked)
            {
                perid = chitem[i].value;
                chklen++;
            }
        }
        if (chklen > 1) {
            alert('请选择单个用户！');
            return false;
        }
    }
    if (perid==null) {
        alert('请先选泽用户！');
        return false;
    }
    showx = event.screenX - event.offsetX - 250;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/user/UserLoginNameEdit.jsf?userId=" + perid, "", "dialogWidth:315px; dialogHeight:160px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0");
   // debugger;
    return retval;
}
function editUserInfo() {
    var chitem = document.forms(0).selectItem;
    if(chitem==null) return;
    var chklen = 0;
    var perid;

    if(chitem.length==null){
        perid=chitem.value;
    }else{
        for (i = 0; i < chitem.length; i++) {
            if (chitem[i].checked)
            {
                perid = chitem[i].value;
                chklen++;
            }
        }
        if (chklen > 1) {
            alert('请选择单个用户！');
            return false;
        }
    }
    if (perid==null) {
        alert('请先选泽用户！');
        return false;
    }
    showx = event.screenX - event.offsetX - 250;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/user/UserInfoEdit.jsf?userId=" + perid, "", "dialogWidth:315px; dialogHeight:260px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0");
   // debugger;
    return retval;
}
function editUserPassword() {
    var chitem = document.forms(0).selectItem;
    if(chitem==null) return;
    var chklen = 0;
    var perid;

    if(chitem.length==null){
        perid=chitem.value;
    }else{
        for (i = 0; i < chitem.length; i++) {
            if (chitem[i].checked)
            {
                perid = chitem[i].value;
                chklen++;
            }
        }
        if (chklen > 1) {
            alert('请选择单个用户！');
            return false;
        }
    }
    if (perid==null) {
        alert('请先选泽用户！');
        return false;
    }
    showx = event.screenX - event.offsetX - 250;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/user/UserPassEdit.jsf?userId=" + perid, "", "dialogWidth:315px; dialogHeight:260px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0");
   // debugger;
    return true;
}
