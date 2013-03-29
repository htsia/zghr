/*
 *  封装检查操作
 *
 */

//删除空格处理，供checkValidate调用
function KillSpace(x) {
    while ((x.length > 0) && (x.charAt(0) == ' '))
        x = x.substring(1, x.length);
    while ((x.length > 0) && (x.charAt(x.length - 1) == ' '))
        x = x.substring(0, x.length - 1);
    return x;
}

//判断是否整数，供checkValidate调用
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
            //// 修改下面的数字，len + 1 表示2个字符代表一个中文字，len + 5 表示6个字符代表一个中文字
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
 * 检验用户指定的对象是否合法
 *  element        用户需要校验的对象
 *  discript       对象的描述
 *  type           对象的类型:
 *                       i  整数
 *                       f  浮点
 *                       s  字符
 *  length         对象的最大长度
 *  type           能否为空：
 *                       1  可以为空
 *                       0  不能为空
 *  maxs           最大值
 *  mins           最小值
 *  mins           最小值
 *  digit          小数点后面保留的位数
 * 返回              全部条件合法返回true；否则返回false
 */
function checkValidate(element, discript, type, length, nullflag, maxs, mins, digit){
    if (element == "") {
        window.alert("函数调用出错,请输入控件!");
        return(0);
    }
    if (discript == ""){
        window.alert("函数调用出错,请输入控件描述!");
        return(0);
    }

    if (nullflag == 0){
        if (element.value == ""){
            window.alert(discript + "不能为空值!");
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
                        window.alert(discript + "请输入整数!");
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
                        window.alert(discript + "请输入数字!");
                        element.focus();
                        return(0);
                    }
                    if (fvalue.length != 0 && isNaN(fvalue) == true)
                    {
                        window.alert(discript + "请输入数字!");
                        element.focus();
                        return(0);
                    } else if (fvalue.length != 0 && isNaN(fvalue) == false) {
                        if (digit != null && digit != "") {
                            var s = fvalue;
                            if (s.indexOf(".") != -1) {
                                s = s.substr(s.indexOf(".") + 1);
                                if (s.length > digit) {
                                    window.alert(discript + "的小数点后面保留位数不对，应为" + digit + "位!");
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
                        window.alert(discript + "请输入有效日期!");
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
                        window.alert(discript + "请输入有效日期!");
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
            window.alert(discript + "的长度必须小于等于" + length + "!");
            element.focus();
            return(0);
        }
    }
    if (element.value != "") {
        if (maxs != "" && mins != "")
        {

            if (element.value < mins || element.value > maxs)
            {
                window.alert(discript + "取值必须小于" + maxs + ",大于" + mins + "!");
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
                    window.alert(discript + "取值必须小于" + maxs + "!");
                    element.focus();
                    return(0);
                }
            }
            if (mins != "")
            {
                if (element.value < mins)
                {
                    window.alert(discript + "取值必须大于" + mins + "!");
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
        window.alert("函数调用出错,请输入控件!");
        return(0);
    }
    if (discript == "") {
        window.alert("函数调用出错,请输入控件描述!");
        return(0);
    }

    if (nullflag == 0) {
        if (element.value == "")
        {
            window.alert(discript + "不能为空值!");
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
                        window.alert(discript + "请输入整数!");
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
                        window.alert(discript + "请输入数字!");
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
                        window.alert(discript + "请输入有效日期!");
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
            window.alert(discript + "的长度必须小于等于" + length + "!");
            // element.focus();
            forfocus(element);
            return(0);
        }
    }

    if (maxs != "" && mins != "") {
        if (element.value < mins || element.value > maxs) {
            window.alert(discript + "取值必须小于" + maxs + ",大于" + mins + "!");
            //element.focus();
            forfocus(element);
            return(0);
        }
    } else {
        if (maxs != "") {
            if (element.value > maxs) {
                window.alert(discript + "取值必须小于" + maxs + "!");
                //element.focus();
                forfocus(element);
                return(0);
            }
        }
        if (mins != "") {
            if (element.value < mins) {
                window.alert(discript + "取值必须大于" + mins + "!");
                //element.focus();
                forfocus(element);
                return(0);
            }
        }
    }
    return(1);
}


//判断是否整数,供dateCheck调用
function ifIsInt(sVal) {
    try {
        eval(sVal);
        return true;
    } catch(errorObject) {
        return false;
    }
}

//取得输入字符的ASCII码,供dateCheck调用
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

//检查字符是否合法,供dateCheck调用
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

//检验日期是否合法,供dateCheck调用
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
            if (mod(iyear, 4) == 0 && (mod(iyear, 100) != 0 || mod(iyear, 400) == 0)) {//判断是否润年
                if (iday > 29) return false;
            } else {
                if (iday > 28) return false;
            }
    }
    return true;
}


/**调用此函数校验日期。
 *  s         输入日期string s,如2001-01-01
 * 返回         若输入的日期没有包含非法字符，以及该日期合法，则返回true；否则返回false
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
//当前正在分拆得Tag值

//开始解析分拆Tag值
function parseTag(p_tag) {
    e_tag = p_tag;
}

//得到下一个分拆处理的值
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
    if (e.alt == null || e.alt == "" ||e.value=="**********") // **********无权限
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
*   检测所有控件输入值的合法性
*       alt 用来控制 格式: 描述|可以为空|类型|长度|最小值|最大值|digit|
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
        if (e.alt == null || e.alt == "" ||e.value=="**********") // **********无权限
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
//开始解析分拆Tag值
function parseTag_eee(p_tag) {
    e_tag_eee = p_tag;
}

//得到下一个分拆处理的值
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
        alert(discript + "不能大于结束时间！！");
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
        alert(discript + "不能大于上限！！");
        p_frm.elements[i].select();
        return false;
    }
    else
    {
        return true;
    }
}

//创建ajax校验参数串
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


