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
       if (s[1].trim()=="��"){
            document.all("form1:A001007").code="01001";
       }
       else{
            document.all("form1:A001007").code="01002";
       }
       if (document.all("form1:A001021")!=null && document.all("form1:A001021")!=undefined){
           document.all("form1:A001021").value=s[2].trim();
           switch(s[2].trim()){
               case "����":document.all("form1:A001021").code="011501"; break;
               case "�ɹ���":document.all("form1:A001021").code="011502"; break;
               case "����":document.all("form1:A001021").code="011503"; break;
               case "����":document.all("form1:A001021").code="011504"; break;
               case "ά�����":document.all("form1:A001021").code="011505"; break;
               case "����":document.all("form1:A001021").code="011506"; break;
               case "����":document.all("form1:A001021").code="011507"; break;
               case "׳��":document.all("form1:A001021").code="011508"; break;
               case "������":document.all("form1:A001021").code="011509"; break;
               case "������":document.all("form1:A001021").code="011510"; break;
               case "����":document.all("form1:A001021").code="011511"; break;
               case "����":document.all("form1:A001021").code="011512"; break;
               case "����":document.all("form1:A001021").code="011513"; break;
               case "����":document.all("form1:A001021").code="011514"; break;
               case "������":document.all("form1:A001021").code="011515"; break;
               case "������":document.all("form1:A001021").code="011516"; break;
               case "��������":document.all("form1:A001021").code="011517"; break;
               case "����":document.all("form1:A001021").code="011518"; break;
               case "����":document.all("form1:A001021").code="011519"; break;
               case "������":document.all("form1:A001021").code="011520"; break;
               case "����":document.all("form1:A001021").code="011521"; break;
               case "���":document.all("form1:A001021").code="011522"; break;
               case "��ɽ��":document.all("form1:A001021").code="011523"; break;
               case "������":document.all("form1:A001021").code="011524"; break;
               case "ˮ��":document.all("form1:A001021").code="011525"; break;
               case "������":document.all("form1:A001021").code="011526"; break;
               case "������":document.all("form1:A001021").code="011527"; break;
               case "������":document.all("form1:A001021").code="011528"; break;
               case "�¶�������":document.all("form1:A001021").code="011529"; break;
               case "����":document.all("form1:A001021").code="011530"; break;
               case "���Ӷ���":document.all("form1:A001021").code="011531"; break;
               case "������":document.all("form1:A001021").code="011532"; break;
               case "Ǽ��":document.all("form1:A001021").code="011533"; break;
               case "������":document.all("form1:A001021").code="011534"; break;
               case "������":document.all("form1:A001021").code="011535"; break;
               case "ë����":document.all("form1:A001021").code="011536"; break;
               case "������":document.all("form1:A001021").code="011537"; break;
               case "������":document.all("form1:A001021").code="011538"; break;
               case "������":document.all("form1:A001021").code="011539"; break;
               case "������":document.all("form1:A001021").code="011540"; break;
               case "��������":document.all("form1:A001021").code="011541"; break;
               case "ŭ��":document.all("form1:A001021").code="011542"; break;
               case "���α����":document.all("form1:A001021").code="011543"; break;
               case "����˹��":document.all("form1:A001021").code="011544"; break;
               case "���¿���":document.all("form1:A001021").code="011545"; break;
               case "�°���":document.all("form1:A001021").code="011546"; break;
               case "������":document.all("form1:A001021").code="011547"; break;
               case "ԣ����":document.all("form1:A001021").code="011548"; break;
               case "����":document.all("form1:A001021").code="011549"; break;
               case "��������":document.all("form1:A001021").code="011550"; break;
               case "������":document.all("form1:A001021").code="011551"; break;
               case "���״���":document.all("form1:A001021").code="011552"; break;
               case "������":document.all("form1:A001021").code="011553"; break;
               case "�Ű���":document.all("form1:A001021").code="011554"; break;
               case "�����":document.all("form1:A001021").code="011555"; break;
               case "��ŵ��":document.all("form1:A001021").code="011556"; break;
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
