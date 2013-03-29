/*
 *  ��װ������
 *
 */

//ɾ���ո�����checkValidate����
function KillSpace(x) {
    while ((x.length > 0) && (x.charAt(0) == ' '))
        x = x.substring(1, x.length);
    while ((x.length > 0) && (x.charAt(x.length - 1) == ' '))
        x = x.substring(0, x.length - 1);
    return x;
}

//�ж��Ƿ���������checkValidate����
function isNature(inputVal) {
    if ("+" == inputVal.substring(0, 1))
        inputVal = inputVal.substring(1, inputVal.length);

    if (isNaN(inputVal))
        return false;

    var i = parseInt(inputVal);
    if (i.toString().length != inputVal.length)
        return false;

    return true;
}

function count_char(str) {
    var len = 0;
    for (var i = 0; i < str.length; i++) {
        var ech = escape(str.charAt(i));
        if (ech.length > 4) {
            //// �޸���������֣�len + 1 ��ʾ2���ַ�����һ�������֣�len + 5 ��ʾ6���ַ�����һ��������
            len = len + 1;
        }
        len++;
    }
    return len;
}

function LengthCheck(text, size) {
    var len = text.length;
    if (len > size) {
        return true;
    }
    return false;
}

/**
 * �����û�ָ���Ķ����Ƿ�Ϸ�
 *  element        �û���ҪУ��Ķ���
 *  discript       ���������
 *  type           ���������:
 *                       i  ����
 *                       f  ����
 *                       s  �ַ�
 *  length         �������󳤶�
 *  type           �ܷ�Ϊ�գ�
 *                       1  ����Ϊ��
 *                       0  ����Ϊ��
 *  maxs           ���ֵ
 *  mins           ��Сֵ
 *  mins           ��Сֵ
 *  digit          С������汣����λ��
 * ����              ȫ�������Ϸ�����true�����򷵻�false
 */
function checkValidate(element, discript, type, length, nullflag, maxs, mins, digit){
    if (element == "") {
        window.alert("�������ó���,������ؼ�!");
        return(0);
    }
    if (discript == ""){
        window.alert("�������ó���,������ؼ�����!");
        return(0);
    }

    if (nullflag == 0){
        if (element.value == ""){
            window.alert(discript + "����Ϊ��ֵ!");
            element.focus();
            return(0);
        }
    }

    if (type != ""){
        switch (type)  {
            case "i":
                if (element.value.indexOf("****") == -1) {
                    if (element.value.length != 0 && isNature(element.value) != true)
                    {
                        window.alert(discript + "����������!");
                        element.focus();
                        return(0);
                    }
                    break;
                } else {
                    break;
                }
            case "f":
                var fvalue = element.value.replace(/\,/g, "");
                if (fvalue.indexOf("****") == -1) {
                    if (fvalue.length != 0 && element.value.indexOf(",") != -1) {
                        window.alert(discript + "����������!");
                        element.focus();
                        return(0);
                    }
                    if (fvalue.length != 0 && isNaN(fvalue) == true)
                    {
                        window.alert(discript + "����������!");
                        element.focus();
                        return(0);
                    } else if (fvalue.length != 0 && isNaN(fvalue) == false) {
                        if (digit != null && digit != "") {
                            var s = fvalue;
                            if (s.indexOf(".") != -1) {
                                s = s.substr(s.indexOf(".") + 1);
                                if (s.length > digit) {
                                    window.alert(discript + "��С������汣��λ�����ԣ�ӦΪ" + digit + "λ!");
                                    element.focus();
                                    return(0);
                                }
                            }
                        }
                    }
                    break;
                } else {
                    break;
                }
            case "s":
                break;
            case "d":
                if (element.value.indexOf("****") == -1) {
                    if (element.value.length != 0 && dateCheck(element.value) == false)
                    {
                        window.alert(discript + "��������Ч����!");
                        element.focus();
                        return(0);
                    } else {
                        if (element.value.length == 8) {
                            var idate = element.value;
                            element.value = idate.substring(0, 4) + "-" + idate.substring(4, 6) + "-" + idate.substring(6, 8);
                        }
                    }
                    break;
                } else {
                    break;
                }
            case "d6":
                if (element.value.indexOf("****") == -1) {
                    if (element.value.length != 0 && dateCheck(element.value + "-01") == false)
                    {
                        window.alert(discript + "��������Ч����!");
                        element.focus();
                        return(0);
                    } else {
                        if (element.value.length == 6) {
                            var idate = element.value;
                            element.value = idate.substring(0, 4) + "-" + idate.substring(4, 6);
                        }
                    }
                    break;
                } else {
                    break;
                }
        }
    }

    if (length != "" && type != "d" && type!="IGM") {
        if (LengthCheck(element.value, length)) {
            window.alert(discript + "�ĳ��ȱ���С�ڵ���" + length + "!");
            element.focus();
            return(0);
        }
    }
    if (element.value != "") {
        if (maxs != "" && mins != "")
        {

            if (element.value < mins || element.value > maxs)
            {
                window.alert(discript + "ȡֵ����С��" + maxs + ",����" + mins + "!");
                element.focus();
                return(0);
            }
        }
        else
        {
            if (maxs != "")
            {
                if (element.value > maxs)
                {
                    window.alert(discript + "ȡֵ����С��" + maxs + "!");
                    element.focus();
                    return(0);
                }
            }
            if (mins != "")
            {
                if (element.value < mins)
                {
                    window.alert(discript + "ȡֵ�������" + mins + "!");
                    element.focus();
                    return(0);
                }
            }
        }
    }
    return(1);
}

function checkValidate2(element, discript, type, length, nullflag, maxs, mins) {
    if (element == "") {
        window.alert("�������ó���,������ؼ�!");
        return(0);
    }
    if (discript == "") {
        window.alert("�������ó���,������ؼ�����!");
        return(0);
    }

    if (nullflag == 0) {
        if (element.value == "")
        {
            window.alert(discript + "����Ϊ��ֵ!");
            // element.focus();
            forfocus(element);
            return(0);
        }
    }

    if (type != "") {
        switch (type) {
            case "i":{
                if (element.value.indexOf("****") == -1) {
                    if (element.value.length != 0 && isNature(element.value) != true) {
                        window.alert(discript + "����������!");
                        // element.focus();
                        forfocus(element);
                        return(0);
                    }
                }
                break;
            }

            case "f":{
                if (element.value.indexOf("****") == -1) {
                    if (element.value.length != 0 && isNaN(element.value) == true) {
                        window.alert(discript + "����������!");
                        // element.focus();
                        forfocus(element);
                        return(0);
                    }
                }
                break;
            }
            case "s":{
                break;
            }
            case "d":{
                if (element.value.indexOf("****") == -1) {
                    if (element.value.length != 0 && dateCheck(element.value) == false) {
                        window.alert(discript + "��������Ч����!");
                        // element.focus();
                        forfocus(element);
                        return(0);
                    } else {
                        if (element.value.length == 8) {
                            var idate = element.value;
                            element.value = idate.substring(0, 4) + "-" + idate.substring(4, 6) + "-" + idate.substring(6, 8);
                        }
                    }
                }
                break;
            }
        }
    }

    if (length != "" && type != "d") {
        //if (element.value.length>length)
        if (LengthCheck(element.value, length)) {
            window.alert(discript + "�ĳ��ȱ���С�ڵ���" + length + "!");
            // element.focus();
            forfocus(element);
            return(0);
        }
    }

    if (maxs != "" && mins != "") {
        if (element.value < mins || element.value > maxs) {
            window.alert(discript + "ȡֵ����С��" + maxs + ",����" + mins + "!");
            //element.focus();
            forfocus(element);
            return(0);
        }
    } else {
        if (maxs != "") {
            if (element.value > maxs) {
                window.alert(discript + "ȡֵ����С��" + maxs + "!");
                //element.focus();
                forfocus(element);
                return(0);
            }
        }
        if (mins != "") {
            if (element.value < mins) {
                window.alert(discript + "ȡֵ�������" + mins + "!");
                //element.focus();
                forfocus(element);
                return(0);
            }
        }
    }
    return(1);
}


//�ж��Ƿ�����,��dateCheck����
function ifIsInt(sVal) {
    try {
        eval(sVal);
        return true;
    } catch(errorObject) {
        return false;
    }
}

//ȡ�������ַ���ASCII��,��dateCheck����
function getvalue(string) {
    var count;
    var numchar;
    var numvalue;
    var value;
    value = 0;
    for (count = 0; count < string.length; count++) {
        numchar = string.charAt(count);
        numvalue = numchar - '0';
        value = value * 10 + numvalue;
    }
    return value;
}


function mod(var1, var2) {
    return (var1 % var2);
}

//����ַ��Ƿ�Ϸ�,��dateCheck����
function checkvalue(string) {
    var count;
    var numchar;
    var numvalue;
    for (count = 0; count < string.length; count++) {
        numchar = string.charAt(count);
        numvalue = numchar - '0';
        if (!(numvalue >= 0 && numvalue <= 9))
            return false;
    }
    return true;
}

//���������Ƿ�Ϸ�,��dateCheck����
function CheckDate(year, month, day) {
    var iyear;
    var imonth;
    var iday;
    if (year.length != 4 || month.length != 2 || day.length != 2)
        return false;
    if (!checkvalue(year) || !checkvalue(month) || !checkvalue(day))
        return false;
    iyear = getvalue(year);
    imonth = getvalue(month);
    iday = getvalue(day);
    if (imonth < 1 || imonth > 12) return false;
    switch (imonth)
            {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            if (iday > 31) return false;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            if (iday > 30) return false;
            break;
        default:
            if (mod(iyear, 4) == 0 && (mod(iyear, 100) != 0 || mod(iyear, 400) == 0)) {//�ж��Ƿ�����
                if (iday > 29) return false;
            } else {
                if (iday > 28) return false;
            }
    }
    return true;
}


/**���ô˺���У�����ڡ�
 *  s         ��������string s,��2001-01-01
 * ����         �����������û�а����Ƿ��ַ����Լ������ںϷ����򷵻�true�����򷵻�false
 */
function dateCheck(s) {
    try {
        if (s.length == 10) {
            if (s.length != 10 || s.charAt(4) != '-' || s.charAt(7) != '-')
                return false;
            if (!ifIsInt(s.substring(0, 4)) || !ifIsInt(s.substring(5, 7)) || !ifIsInt(s.substring(8, 10)) || eval(s.substring(0, 4)) < 1 || eval(s.substring(5, 7)) < 1 || eval(s.substring(8, 10)) < 1)
                return false;
            if (CheckDate(s.substring(0, 4), s.substring(5, 7), s.substring(8, 10)) == false)
                return false;
            return true;
        }
        if (s.length == 8)
            return CheckDate(s.substring(0, 4), s.substring(4, 6), s.substring(6, 8));

        return false;
    } catch(e) {
        alert(e);
        return false;
    }
}

var e_tag;
//��ǰ���ڷֲ��Tagֵ

//��ʼ�����ֲ�Tagֵ
function parseTag(p_tag) {
    e_tag = p_tag;
}

//�õ���һ���ֲ����ֵ
function getNextValue() {
    if (e_tag == null || e_tag == "")
        return null;
    var p = e_tag.indexOf("|");
    if (p == -1)
        p = e_tag.length;
    var r = e_tag.substring(0, p);
    e_tag = e_tag.substring(p + 1, e_tag.length);
    return r;
}

function checkOne(id,flag) {
    var discript = "";
    var v_type = "s";
    var length = "";
    var nullflag = "1";
    var maxs = "";
    var mins = "";
    var digit = "";

    var e=document.all(id);
    if (e.alt == null || e.alt == "" ||e.value=="**********") // **********��Ȩ��
        return true;
    parseTag(e.alt);
    if ((v = getNextValue()) != null) {
        discript = v;
    }
    if ((v = getNextValue()) != null) {
        nullflag = v;
    }
    if ((v = getNextValue()) != null) {
        v_type = v;
    }
    if ((v = getNextValue()) != null) {
        length = v;
    }
    if ((v = getNextValue()) != null) {
        mins = eval(v);
    }
    if ((v = getNextValue()) != null) {
        maxs = eval(v);
    }
    if ((v = getNextValue()) != null) {
        digit = eval(v);
    }
    if (flag != null){
        if (checkValidate2(e, discript, v_type, length, nullflag, maxs, mins,digit) == "0")
            return false;
    } else{
        if (checkValidate(e, discript, v_type, length, nullflag, maxs, mins,digit) == "0")
            return false;
    }
   return true;
}
/*
*   ������пؼ�����ֵ�ĺϷ���
*       alt �������� ��ʽ: ����|����Ϊ��|����|����|��Сֵ|���ֵ|digit|
*/
function checkAll(p_frm, flag) {
    var eCount = p_frm.elements.length;
    var v = "";

    var discript = "";
    var v_type = "s";
    var length = "";
    var nullflag = "1";
    var maxs = "";
    var mins = "";
    var digit = "";
    for (var i = 0; i < eCount; i++) {
        discript = "";
        v_type = "s";
        length = "";
        nullflag = "1";
        maxs = "";
        mins = "";
        digit = "";

        var e = p_frm.elements[i];
        if (e.alt == null || e.alt == "" ||e.value=="**********") // **********��Ȩ��
            continue;
        parseTag(e.alt);
        if ((v = getNextValue()) != null) {
            discript = v;
        }
        if ((v = getNextValue()) != null) {
            nullflag = v;
        }
        if ((v = getNextValue()) != null) {
            v_type = v;
        }
        if ((v = getNextValue()) != null) {
            length = v;
        }
        if ((v = getNextValue()) != null) {
            mins = eval(v);
        }
        if ((v = getNextValue()) != null) {
            maxs = eval(v);
        }
        if ((v = getNextValue()) != null) {
            digit = eval(v);
        }
        if (flag != null){
            if (checkValidate2(e, discript, v_type, length, nullflag, maxs, mins,digit) == "0")
                return false;
        } else{
            if (checkValidate(e, discript, v_type, length, nullflag, maxs, mins,digit) == "0")
                return false;
        }
    }
    return true;
}

var e_tag_eee;
//��ʼ�����ֲ�Tagֵ
function parseTag_eee(p_tag) {
    e_tag_eee = p_tag;
}

//�õ���һ���ֲ����ֵ
function getNextValue_eee() {
    if (e_tag_eee == null || e_tag_eee == "")
        return null;
    var p = e_tag_eee.indexOf("|");
    if (p == -1)
        p = e_tag_eee.length;
    var r = e_tag_eee.substring(0, p);
    //e_tag=e_tag.substring(p+1,e_tag.length);
    return r;
}

function isnull(p_frm, i, j) {
    var discript = "";
    var e = p_frm.elements[i];
    parseTag_eee(e.alt);
    discript = getNextValue_eee();
    //alert(p_frm.elements[i].value);
    //alert(p_frm.elements[j].value);
    if (p_frm.elements[i].value > p_frm.elements[j].value)
    {
        alert(discript + "���ܴ��ڽ���ʱ�䣡��");
        return false;
    }
    else
    {
        return true;
    }
}
function isnullint(p_frm, i, j) {
    var discript = "";
    var e = p_frm.elements[i];
    parseTag_eee(e.alt);
    discript = getNextValue_eee();
    if (parseInt(p_frm.elements[i].value) > parseInt(p_frm.elements[j].value))
    {
        alert(discript + "���ܴ������ޣ���");
        p_frm.elements[i].select();
        return false;
    }
    else
    {
        return true;
    }
}

//����ajaxУ�������
function createQueryString(setId,form) {
    var queryString = "";
    var name = "";
    var svalue = "";
    for (var i = 0; i < form.length; i++) {
        obj = form.elements[i];
        var para=obj.name.split(":");
        if (para.length>1){
            name = para[1];
        }
        else{
            name = para[0];
        }
        if (obj.dict == "yes") {
            svalue = obj.code;
        } else {
            svalue = obj.value;
        }
        queryString += name + "=" + svalue + "&";
    }

    queryString += "setId=" + setId;
    return queryString;
}


