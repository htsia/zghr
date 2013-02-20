function  doselfQuery(){
    document.all("form1:WageDept").value="-1";
    return doAdvanceQuery('A','ORG','011','Y','','','N','152','N');
}

function CreateBankFile(){
    if (document.all("form1:bankSet").value=="" || document.all("form1:bankSet").value=="-1"){
        alert("请选择银行格式!");
        return false;
    }
    var url="/wage/payoff/CreateBankFile.jsf?setId="+document.all("form1:setId").value+"&dateId="+document.all("form1:dateId").value+"&bankId="+document.all("form1:bankSet").value;
    window.open(url, "_blank", "top="+(screen.height/2-80)+",height=160, left="+(screen.width/2-150)+",width=300,toolbar=no,scrollbars=no,menubar=no");
    return false;
}

function forViewPerson(form, id, type){
    window.showModalDialog("/wage/payoff/wagePersonquery.jsf?pID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
}

function KeyDown(){
   if(event.keyCode == 13){
       event.keyCode=0;
    }
}
function doViewCard(){
    var ID=getFirstSelectValue(form1.chk);
    //debugger;
    if (ID!=null && ID!=""){
       window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value+"&ID="+ID, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
    }else{
       window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    return false;
}
function doClearZero() {
    var setName = form1.all("form1:setName").value;
    var unitId = form1.all("form1:unitId").value;
    var setId = form1.all("form1:setId").value;
    var arg = "act=selectSetInput&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
    var reval = window.showModalDialog("/wage/set/SetInputClear.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    if (reval != null) {
        return true;
    } else {
        return false;
    }
}
function doQueryManyPerson(){
    var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
    if (reval != null && reval !="") {
        document.all('form1:ManyPerson').value = reval;
        return true;
    } else {
        return false;
    }
}
function doShowItem() {
    var arg = "setId=" + form1.all("form1:setId").value;
    var reval = window.showModalDialog("/wage/payoff/ComputeShowItemEdit.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
    if (reval != null) {
        form1.all('form1:str').value = reval;
        return true;
    } else {
        return false;
    }
}
function doSetConst(){
    var url="/wage/set/SetConst.jsf?setId="+form1.all("form1:setId").value+"&setName="+form1.all("form1:setName").value;
    //alert(url);
    window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
function doExport() {
   window.open('/wage/payoff/SetSelectToExport.jsf');
}

function OpenRpt(){
    if (document.all("form1:ReportID").value=="-1"){
        alert("请先选择表格样式！");
        return false;
    }
    var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter=TRY_"+document.all("form1:setId").value
             +"&Title=TRY_"+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
    window.open(url);
    return false;
}
function OpenRptByControl(){
    if (document.all("form1:ReportID").value=="-1"){
        alert("请先选择表格样式！");
        return false;
    }
    var url="/pages/report/ClientReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter=TRY_"+document.all("form1:setId").value
             +"&Title=TRY_"+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
    window.open(url);
    return false;
}
function OpenRptByDept(){
    count = form1.chk.length;
    var str = "";
    if (count != null) {
        var num = 0;
        for (i = 0; i < count; i++)
            if (form1.chk[i].checked) {
                str += form1.chk[i].value.replace("#","~") + ",";
                num++;
            }
        if (num > allCount) {
            alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
            return false;
        }
    } else
        str = form1.chk.value.replace("#","~");

    var url="/report/DeptReportShow.jsf?unitId="+document.all("form1:unitId").value+"&setId=TRY_"+document.all("form1:setId").value
             +"&setName="+form1.all("form1:setName").value+"&pids="+str;
    window.showModalDialog( url, null, "dialogWidth:400px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;// 返回true 以便涮新界面 从而得到部门权限session
}
function doReinforce(){
    var url="/wage/set/ReinForce.jsf?setid="+form1.all("form1:setId").value+"&unitid="+form1.all("form1:unitId").value;
    var reval = window.showModalDialog( url, null, "dialogWidth:800px; dialogHeight:550px;center:center;resizable:yes;status:no;scroll:yes;");
    //alert(reval);
    if (reval != null && reval != "") {
        document.all("form1:addPerson").value=reval;
        return true;
    } else {
        return false;
    }
}
function  doBatch(){
    var setName = form1.all("form1:setName").value;
    var unitId = form1.all("form1:unitId").value;
    var setId = form1.all("form1:setId").value;
    var arg="unitId="+unitId+"&setId="+setId+"&setName="+setName;
    window.showModalDialog("/wage/payoff/batchUpdate.jsf?isTry=true&" + arg, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}

// 模板录入
function doTemplateInput(){
    var setName = form1.all("form1:setName").value;
    var unitId = form1.all("form1:unitId").value;
    var setId = form1.all("form1:setId").value;
    var unitName=form1.all("form1:unitName").value;
    var dateId=form1.all("form1:dateId").value;
    var arg="isTry=true&dateId="+dateId+"&unitId="+unitId+"&setId="+setId+"&setName="+setName+"&unitName="+unitName;
    var reval = window.showModalDialog("/wage/set/InputEdit.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
    if (reval != null) {
        return true;
    } else {
        return false;
    }
}

// 按标准表计算
function doSetStandard(){
    if (checkMutilSelect(form1.chk)) {
        count = form1.chk.length;
        var str = "";
        if (count != null) {
            var num = 0;
            for (i = 0; i < count; i++)
                if (form1.chk[i].checked) {
                    str += form1.chk[i].value.replace("#","~") + ",";
                    num++;
                }
            if (num > allCount) {
                alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                return false;
            }
        } else
            str = form1.chk.value.replace("#","~");
        var setName = form1.all("form1:setName").value;
        var unitId = form1.all("form1:unitId").value;
        var setId = form1.all("form1:setId").value;
        var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str;
        var reval = window.showModalDialog("/wage/set/SetStardard.jsf?isTry=true&" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    } else {
        alert("请选择人员");
        return false;
    }
}
function doSelectInput() {
    if (checkMutilSelect(form1.chk)) {
        count = form1.chk.length;
        var str = "";
        if (count != null) {
            var num = 0;
            for (i = 0; i < count; i++)
                if (form1.chk[i].checked) {
                    str += form1.chk[i].value.replace("#","~") + ",";
                    num++;
                }
            if (num > allCount) {
                alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                return false;
            }
        } else
            str = form1.chk.value.replace("#","~");
        var setName = form1.all("form1:setName").value;
        var unitId = form1.all("form1:unitId").value;
        var setId = form1.all("form1:setId").value;
        var arg = "isTry=true&act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str;
        var reval = window.showModalDialog("/wage/set/SetInputSelect.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        if (reval != null) {
            return true;
        } else {
            return false;
        }
    } else {
        alert("请选择人员");
        return false;
    }
}
function doBaseInfoInput() {
    if (checkMutilSelect(form1.chk)) {
        //debugger;
        count = form1.chk.length;
        var str = "";
        if (count != null) {
            var num = 0;
            for (i = 0; i < count; i++)
                if (form1.chk[i].checked) {
                    str += form1.chk[i].value.replace("#","~") + ",";
                    num++;
                }
            if (num > allCount) {
                alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                return false;
            }
        } else
            str = form1.chk.value;
        var setName = form1.all("form1:setName").value;
        var unitName = form1.all("form1:unitName").value;
        var unitId = form1.all("form1:unitId").value;
        var setId = form1.all("form1:setId").value;
        var arg = "setName=" + setName + "&unitId=" + unitId + "&unitName="+unitName+"&setId=" + setId + "&str=" + str;
        var reval = window.showModalDialog("/wage/set/BaseInputSelect.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        if (reval != null) {
            return true;
        } else {
            return false;
        }
    } else {
        alert("请选择人员");
        return false;
    }
}

function doDelete(){
    if (checkMutilSelect(form1.chk)) {
        count = form1.chk.length;
        var str = "";
        if (count != null) {
            var num = 0;
            for (i = 0; i < count; i++)
                if (form1.chk[i].checked) {
                    str += form1.chk[i].value + ",";
                    num++;
                }
            if (num > allCount) {
                alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                return false;
            }
        } else
            str = form1.chk.value;
        //alert(str);
        document.all("form1:deletePerson").value=str;
        return true;
    } else {
        alert("请选择人员");
        return false;
    }
}
// 录入部门信息
function doDeptInput(){
    var url="/wage/set/SetDeptInput.jsf?isTry=true&setId="+form1.all("form1:setId").value+"&unitId=" + form1.all("form1:unitId").value+"&setName="+form1.all("form1:setName").value+"&dateId="+form1.all("form1:dateId").value;
    //alert(url);
    window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
    return false;
}
function doOrderInput() {
    if (checkMutilSelect(form1.chk)) {
        count = form1.chk.length;
        var str = "";
        if (count != null) {
            var num = 0;
            for (i = 0; i < count; i++)
                if (form1.chk[i].checked) {
                    str += form1.chk[i].value + ",";
                    num++;
                }
            if (num > allCount) {
                alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                return false;
            }
        } else
            str = form1.chk.value;
        var reval = window.showModalDialog("/wage/set/OrderInput.jsf?setId="+form1.all("form1:setId").value+"&PerStr=" + str, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        if (reval != null) {
            return true;
        } else {
            return false;
        }
    } else {
        alert("请选择人员");
        return false;
    }
}
function doOrderCalc(){
    if (form1.all("form1:groupLevel").value!="DEPT_NAME"){
        alert("必须选择最细层次的部门!");
        return false;
    }
    if (form1.all("form1:WageDept").value=="-1" || form1.all("form1:WageDept").value=="-2"){
        alert("请选择部门");
        return false;
    }
    return true;
}
function doUploadFile() {
    var setName = form1.all("form1:setName").value;
    var unitId = form1.all("form1:unitId").value;
    var setId = form1.all("form1:setId").value;
    var arg = "isTry=true&act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
    var reval = window.showModalDialog("/wage/set/SetInputUpload.jsf?" + arg, null, "dialogWidth:1200px; dialogHeight:700px;center:center;resizable:yes;status:no;scroll:yes;");
    if (reval != null) {
        return true;
    } else {
        return false;
    }
}
function doCheckSelect() {
    if (checkMutilSelect(form1.chk)) {
        showProcessBar();
        return true;
    } else {
        alert("请选择人员");
        return false;
    }
}
function refreshList() {
     showProcessBar();
    return true;
}
function showSum(){
    var url="/wage/payoff/ShowSumInfo.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
    window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40');
    return false;
}
function showdiff(){
    var url="/wage/payoff/ShowDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
    window.open(url,'','toolbar=0,height=500,width='+screen.width*0.9+',top=40,left='+screen.width*0.05);
    return false;
}
function showProcessBar() {
   x = document.body.clientWidth / 2 - 150;
   y = document.body.clientHeight / 2;
   document.all('processbar').style.top = y;
   document.all('processbar').style.left = x;
   document.all('processbar').style.display = "";
}
function doSelectManyDept(){
    window.showModalDialog("/wage/payoff/WageManyDept.jsf?SetId=" + form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
function     doaddManyDept(){
    if (checkMutilSelect(form1.chk)) {
        count = form1.chk.length;
        var str = "";
        if (count != null) {
            var num = 0;
            for (i = 0; i < count; i++)
                if (form1.chk[i].checked) {
                    str += form1.chk[i].value + ",";
                    num++;
                }
            if (num > allCount) {
                alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                return false;
            }
        } else
            str = form1.chk.value;
        var reval = window.showModalDialog("/wage/payoff/BatchAddWageManyDept.jsf?SetId=" + form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value+"&PerStr=" + str, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
        if (reval != null) {
            return true;
        } else {
            return false;
        }
    } else {
        alert("请选择人员");
        return false;
    }
}
function beginGroup(){
    if (document.all("form1:sortList").value=="-1") {
        alert("没有选择汇总信息项");
    }
    else{
       window.showModalDialog("/wage/payoff/ShowGroup.jsf?isTry=true&SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
    }
    return false;
}
