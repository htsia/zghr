function setLoadPhoto(){
    countPhoto=window.setInterval("refreshPhoto()",1500);
}
function refreshPhoto(){
    window.clearInterval(countPhoto);
    if (photoID=="A001780"){
        document.all.seryFilterDiv.style.display = "";
        document.all.showZP.src = photoSrc;
    }
    else if (photoID=="A001786"){
        document.all.seryFilterDiv2.style.display = "";
        document.all.showSFZ.src = photoSrc;
    }
    else if (photoID=="B001082"){
        document.all.seryFilterDiv.style.display = "";
        document.all.showZP.src = photoSrc;
    }
    else{
        document.all.seryFilterDiv3.style.display = "";
        document.all("imgText").value="图片上传成功,保存后生效！";
    }
}

function selPost(idf, org) {
    obj = document.all(org);
    if (obj.value == null || obj.value == "") {
        alert("在选岗位时，部门不能为空");
        return;
    }
    var arg = parent.CSApp;
    fPopUpPostDlgByOrg(idf, obj.code, arg);
}
function selPostNo(idf) {
    var arg = parent.CSApp;
    fPopUpPostDlg(idf, arg);
}
document.all.seryFilterDiv.style.left = document.body.scrollWidth - 120;
document.all.seryFilterDiv2.style.left = document.body.scrollWidth - 120;
document.all.seryFilterDiv3.style.left = document.body.scrollWidth - 120;

var bIsCatchSery = false;
var dragClickX = 0;
var dragClickY = 0;

var bIsCatchSery2 = false;
var dragClickX2 = 0;
var dragClickY2 = 0;

var bIsCatchSery3 = false;
var dragClickX3 = 0;
var dragClickY3 = 0;

function myload_setFilter() {
    seryFilterDiv.style.top = document.body.scrollTop + 100;
    seryFilterDiv.style.left = document.body.scrollLeft + 100;
}
function catchFilter(e) {
    if (movePhoto=="0") return ;
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
function catchFilter3(e) {
    if (movePhoto=="0") return ;
    bIsCatchSery3 = true;
    var x = event.x + document.body.scrollLeft;
    var y = event.y + document.body.scrollTop;
    dragClickX3 = x - seryFilterDiv3.style.pixelLeft;
    dragClickY3 = y - seryFilterDiv3.style.pixelTop;
    seryFilterDiv3.setCapture();
    document.onmousemove = moveFilter3;
}

function releaseFilter(e) {
    if (movePhoto=="0") return ;
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
function releaseFilter3(e) {
    if (movePhoto=="0") return ;
    bIsCatchSery3 = false;
    seryFilterDiv3.releaseCapture();
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
function moveFilter3(e) {
    if (bIsCatchSery3) {
        seryFilterDiv3.style.left = event.x + document.body.scrollLeft - dragClickX;
        seryFilterDiv3.style.top = event.y + document.body.scrollTop - dragClickY;
    }
}
