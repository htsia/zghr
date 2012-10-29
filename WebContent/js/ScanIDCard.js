var countPhoto;
var countID;
var photoSrc="";
var IDSrc="";

function doScan(){
    var ret=window.showModalDialog("/pages/common/ScanIDCard.jsp", null, "dialogWidth:100px; dialogHeight:100px;center:center;resizable:yes;status:no;scroll:yes;");
    if (ret!=""){
       var s=ret.split(",");
       document.all("form1:A001001").value=s[0].trim();
       document.all("form1:A001007").value=s[1].trim();
       if (s[1].trim()=="男"){
            document.all("form1:A001007").code="01001";
       }
       else{
            document.all("form1:A001007").code="01002";
       }
       if (document.all("form1:A001021")!=null && document.all("form1:A001021")!=undefined){
           document.all("form1:A001021").value=s[2].trim();
           switch(s[2].trim()){
               case "汉族":document.all("form1:A001021").code="011501"; break;
               case "蒙古族":document.all("form1:A001021").code="011502"; break;
               case "回族":document.all("form1:A001021").code="011503"; break;
               case "藏族":document.all("form1:A001021").code="011504"; break;
               case "维吾尔族":document.all("form1:A001021").code="011505"; break;
               case "苗族":document.all("form1:A001021").code="011506"; break;
               case "彝族":document.all("form1:A001021").code="011507"; break;
               case "壮族":document.all("form1:A001021").code="011508"; break;
               case "布依族":document.all("form1:A001021").code="011509"; break;
               case "朝鲜族":document.all("form1:A001021").code="011510"; break;
               case "满族":document.all("form1:A001021").code="011511"; break;
               case "侗族":document.all("form1:A001021").code="011512"; break;
               case "瑶族":document.all("form1:A001021").code="011513"; break;
               case "白族":document.all("form1:A001021").code="011514"; break;
               case "土家族":document.all("form1:A001021").code="011515"; break;
               case "哈尼族":document.all("form1:A001021").code="011516"; break;
               case "哈萨克族":document.all("form1:A001021").code="011517"; break;
               case "傣族":document.all("form1:A001021").code="011518"; break;
               case "黎族":document.all("form1:A001021").code="011519"; break;
               case "傈僳族":document.all("form1:A001021").code="011520"; break;
               case "佤族":document.all("form1:A001021").code="011521"; break;
               case "畲族":document.all("form1:A001021").code="011522"; break;
               case "高山族":document.all("form1:A001021").code="011523"; break;
               case "拉祜族":document.all("form1:A001021").code="011524"; break;
               case "水族":document.all("form1:A001021").code="011525"; break;
               case "东乡族":document.all("form1:A001021").code="011526"; break;
               case "纳西族":document.all("form1:A001021").code="011527"; break;
               case "景颇族":document.all("form1:A001021").code="011528"; break;
               case "柯尔克孜族":document.all("form1:A001021").code="011529"; break;
               case "土族":document.all("form1:A001021").code="011530"; break;
               case "达斡尔族":document.all("form1:A001021").code="011531"; break;
               case "仫佬族":document.all("form1:A001021").code="011532"; break;
               case "羌族":document.all("form1:A001021").code="011533"; break;
               case "布朗族":document.all("form1:A001021").code="011534"; break;
               case "撒拉族":document.all("form1:A001021").code="011535"; break;
               case "毛难族":document.all("form1:A001021").code="011536"; break;
               case "仡佬族":document.all("form1:A001021").code="011537"; break;
               case "锡伯族":document.all("form1:A001021").code="011538"; break;
               case "阿昌族":document.all("form1:A001021").code="011539"; break;
               case "普米族":document.all("form1:A001021").code="011540"; break;
               case "塔吉克族":document.all("form1:A001021").code="011541"; break;
               case "怒族":document.all("form1:A001021").code="011542"; break;
               case "乌孜别克族":document.all("form1:A001021").code="011543"; break;
               case "俄罗斯族":document.all("form1:A001021").code="011544"; break;
               case "鄂温克族":document.all("form1:A001021").code="011545"; break;
               case "德昂族":document.all("form1:A001021").code="011546"; break;
               case "保安族":document.all("form1:A001021").code="011547"; break;
               case "裕固族":document.all("form1:A001021").code="011548"; break;
               case "京族":document.all("form1:A001021").code="011549"; break;
               case "塔塔尔族":document.all("form1:A001021").code="011550"; break;
               case "独龙族":document.all("form1:A001021").code="011551"; break;
               case "鄂伦春族":document.all("form1:A001021").code="011552"; break;
               case "赫哲族":document.all("form1:A001021").code="011553"; break;
               case "门巴族":document.all("form1:A001021").code="011554"; break;
               case "珞巴族":document.all("form1:A001021").code="011555"; break;
               case "基诺族":document.all("form1:A001021").code="011556"; break;
           }
       }
       var temp=s[3].trim();
       document.all("form1:A001011").value=temp.substring(0,4)+"-"+temp.substring(4,6)+"-"+temp.substring(6,8);
       document.all("form1:A001077").value=s[4].trim();

       if (s.length>=9){
           photoSrc=s[9];
           setLoadPhoto();
           if (document.all('form1:photoFile')!=null && document.all('form1:photoFile')!=undefined){
               document.all('form1:photoFile').value=photoSrc;
           }
       }
       if (s.length>=10){
           IDSrc=s[10];
           setLoadIDPhoto();
           if (document.all('form1:idFile')!=null && document.all('form1:idFile')!=undefined){
               document.all('form1:idFile').value=IDSrc;
           }
       }
    }
}

function setLoadPhoto(){
    countPhoto=window.setInterval("refreshPhoto()",1500);
}
function refreshPhoto(){
    window.clearInterval(countPhoto);
    document.all.seryFilterDiv.style.display = "";
    document.all.showZP.src = photoSrc;
}

function setLoadIDPhoto(){
    countID=window.setInterval("refreshIDPhoto()",1500);
}
function refreshIDPhoto(){
    window.clearInterval(countID);
    document.all.seryFilterDiv2.style.display = "";
    document.all.showSFZ.src = IDSrc;
}
