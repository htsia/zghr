var tableFixCol=-1;
var listControl;
var FixID;
var FixColID;
//控制列表页面头部随着用户下拉滚动条而滚动
function setFix() {
    //window.clearInterval(FixID);
    if (document.getElementById('datatable') == null) return false;
    var itop = parseInt(document.getElementById('datatable').scrollTop - 2);
    var obj = document.all("locked");
    if (null != obj) {
        if (null == obj.length) {
            obj.style.top = itop;
        } else {
            for (i = 0; i < obj.length; i++)
                obj[i].style.top = itop;
        }
    }
}
function setFixCol(){
    try{
        //window.clearInterval(FixColID);
        if (document.getElementById('datatable') == null) return false;
        var ileft = parseInt(document.getElementById('datatable').scrollLeft - 2);
        for(i=0;i<listControl.rows.length;i++){
           for(j=0;j<=tableFixCol;j++)
              listControl.rows.item(i).cells(j).style.left=ileft;
        }
        if (paget!=null && paget!=undefined)   paget.rows.item(0).cells(0).style.left=ileft;
    }catch(err){}
}

function setFixColTitle(fixcol){
    try{
        for(i=0;i<list.rows.length;i++){
           list.rows.item(i).title="";
           for(j=0;j<=fixcol;j++)
            list.rows.item(i).title +=list.rows.item(i).cells(j).innerText+" ";
        }
    }catch(err){}
}
// 分页
function forpage(page) {
    var obj = document.forms(0);
    if (rowNum != obj.rowNum.value) {
        page = 1;
    }
    if (isNaN(obj.rowNum.value)) {
        alert("请输入数字");
        obj.rowNum.value=rowNum;
        obj.pageNum.value = page;
        return false;
    } else if (obj.rowNum.value <= 0) {
        alert("每页行数必须大于0！");
        return false;
    }
    obj.pageFlag.value = "1";
    obj.pageNum.value = page;
    if (document.all('processbar')!=null && document.all('processbar')!=undefined){  // 显示进度
        x = document.body.clientWidth / 2 - 150;
        y = document.body.clientHeight / 2;
        document.all('processbar').style.top = y;
        document.all('processbar').style.left = x;
        document.all('processbar').style.display = "";
    }
    obj.submit();
    return true;
}
function forpage2(page) {
    var obj = document.forms(0);
    if (rowNum2 != obj.rowNum.value) {
        page = 1;
    }
    if (isNaN(obj.rowNum.value)) {
        alert("请输入数字");
        return false;
    } else if (obj.rowNum.value <= 0) {
        alert("每页行数必须大于0！");
        return false;
    }
    obj.pageFlag.value = "1";
    obj.pageNum2.value = page;
    obj.submit();
    return true;
}

function forSort(){
    return true;
}
