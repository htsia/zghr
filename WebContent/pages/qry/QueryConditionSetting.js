function showProcessBar() {
    x = document.body.clientWidth / 2 - 150;
    y = document.body.clientHeight / 2;
    document.all('processbar').style.top = y;
    document.all('processbar').style.left = x;
    document.all('processbar').style.display = "";
}
function forQuery(obj){
    flag = toSubmit(obj);
    if(flag)
        showProcessBar()
    return flag;
}
function forSave() {
	flag = toSubmit();
	if(flag){
    rt = window.prompt("请输入查询名称", document.all('qryName').value);
    if (rt == "" || rt == null)
        return false;
    document.all("qryName").value = rt;
    //验证输入
	}
    return flag;
}
//提交时js的处理
function toSubmit(src) {
    document.all("group").value = groupField.innerText;
    document.all("groupShow").value = groupField.innerHTML;
    return check();
}
function check() {
    valuec = null;
    oper = null;
    itemId = null;
    if (document.all("itemId") != null) {
        if (document.all("itemId").length == undefined) {
            valuec = document.all("operValue");
            oper = document.all("operId");
            itemId = document.all("itemId");
            if(oper.value == "isnull" || oper.value == "notisnull"){
                return true;
            }
            if ((valuec.value == "" || valuec.value == null) && (oper.value != "isnull" || oper.value != "notisnull")) {
                alert("请输入查询条件");
                return false;
            }
            if ((itemId.dict == "1" || itemId.dict == "2" || itemId.dict == "9") && isNaN(valuec.value)) {
                alert("请输入数字");
                valuec.focus();
                return false;
            }
            cdate = valuec.value;

            if(itemId.dict == "5" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                if(dateCheck(cdate)== false ){
                    alert("请输入正确日期");
                    valuec.focus();
                    return false;
                }
            }
            if(itemId.dict == "15" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                if(dateCheck(valuec.value + "-01")== false){
                    alert("请输入正确日期");
                    valuec.focus();
                    return false;
                }
            }
        } else {
            for (pos = 0; pos < document.all("itemId").length; pos++) {
                valuec = document.all("operValue")[pos];
                oper = document.all("operId")[pos];
                itemId = document.all("itemId")[pos];
                if(oper.value == "isnull" || oper.value == "notisnull"){
                    continue;
                }
                if ((valuec.value == "" || valuec.value == null) && (oper.value != "isnull" || oper.value != "notisnull")) {
                    alert("请输入查询条件");
                    return false;
                }

                if ((itemId.dict == "1" || itemId.dict == "2" || itemId.dict == "9") && isNaN(valuec.value)) {
                    alert("请输入数字");
                    valuec.focus();
                    return false;
                }
                 cdate = valuec.value;
                if(itemId.dict == "5" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                    if(dateCheck(valuec.value)== false){
                        alert("请输入正确日期");
                        valuec.focus();
                        return false;
                    }
                }
                if(itemId.dict == "15" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                    if(dateCheck(valuec.value + "-01")== false){
                        alert("请输入正确日期");
                        valuec.focus();
                        return false;
                    }
                }
            }
        }
    }
    return true;
}
//下面是增删条件的控制js
var focusField ;
var oldBgColor;
var oldColor;
//先定义tr td的class格式
trClass = "td_top";
tdClass = "F08";


function selField() {
    src = window.event.srcElement;
    if (src == focusField)
        return;

    oldBgColor = src.style.backgroundColor;
    oldColor = src.style.color;
    //清除其他行选择
    for (rowPos = 2; rowPos < PLList.rows.length; rowPos++) {
        PLList.rows(rowPos).cells(1).style.backgroundColor = oldBgColor;
        PLList.rows(rowPos).cells(1).style.color = oldColor;
    }
    focusField = null;

    src.style.backgroundColor = "blue";
    src.style.color = "white";
    focusField = src;
}
function unSelField() {
    src = window.event.srcElement;
    src.style.backgroundColor = oldBgColor;
    src.style.color = oldColor;
    focusField = null;

}

//左边指标树双击时调用本方法 ,根据条件调用插入行方法.或更新行方法
function addCondition(itemId, itemName, itemType, codeSetId) {
    if (focusField == null) {
        insertConditionRow(itemId, itemName, itemType, codeSetId);
    } else {
        modifyCondition(itemId, itemName, itemType, codeSetId);
    }
}

//删除某一行条件，需要调用rebuildGroup重新生成span
function deleteCondition(src) {
    //删除需要重新调整 编号
    PLList.deleteRow(src.rowIndex);
    rebuildGroup();
    focusField = null;
}

//重新生成a1 a2 a3 和上部的span
function rebuildGroup() {
    groupField.innerHTML = "";

    for (rowPos = 2; rowPos < PLList.rows.length; rowPos++) {
        conditionId = "A" + (rowPos - 1);

        PLList.rows(rowPos).cells(0).innerText = conditionId;
        PLList.rows(rowPos).cells(0).innerHTML += "<input type='hidden' value='" + conditionId + "' name='groupId'>";

        //redraw span
        drawGroup(conditionId);
    }
}


function groupChange(src) {
    if (src.spanType == 'logic') {
        if (src.innerText == '与')
            src.innerText = '或';
        else
            src.innerText = '与';
    } else {
        tmp = prompt("请输入括号", src.innerText)
        if (tmp == null)
            tmp = "";
        //过滤全角括号
        while (tmp != tmp.replace("（", "(")) {
            tmp = tmp.replace("（", "(");
        }
        while (tmp != tmp.replace("）", ")")) {
            tmp = tmp.replace("）", ")");
        }
        if (src.spanType == "left_bracket") {
            while (tmp != tmp.replace(")", "")) {
                tmp = " " + tmp.replace(")", "");
            }
        }
        if (src.spanType == "right_bracket") {
            while (tmp != tmp.replace("(", "")) {
                tmp = tmp.replace("(", "");
            }
        }
        src.innerText = tmp;
    }
}
function spanOver(src) {
    oldBgColor = src.style.backgroundColor;
    oldColor = src.style.color;

    for (spanPos = 0; spanPos < groupSpan.length; spanPos++) {
        groupSpan[spanPos].style.backgroundColor = oldBgColor;
        groupSpan[spanPos].style.color = oldColor;
    }

    src.style.backgroundColor = "blue";
    src.style.color = "white";
}
function spanOut(src) {
    for (spanPos = 0; spanPos < groupSpan.length; spanPos++) {
        groupSpan[spanPos].style.backgroundColor = oldBgColor;
        groupSpan[spanPos].style.color = oldColor;
    }
}

//根据选择的项目 修改一行条件,包括重置 2 3 4 单元格
function modifyCondition(itemId, itemName, itemType, codeSetId) {
    modifyRow = focusField.parentElement;
    //
    operator = "";
    value1 = "";
    hidden1 = "";
    c2 = modifyRow.cells(1);
    c2.innerText = itemName;

    c2.innerHTML += "<input type='hidden' value='" + itemId + "' name='itemId' dict='" + itemType + "' dict_num='" + codeSetId + "' >";
    c2.innerHTML += "<input type='hidden' value='" + itemName + "' name='itemName'>";
    c2.ondblclick = selField;
    c2.onclick = unSelField;


    c3 = modifyRow.cells(2);
    c3.id = "OPER_" + conditionId;
    c3.classname = tdClass;
    c3.align = "center";
    c3.innerHTML = createOperator(itemType);
    var op ;
    if (newRow.rowIndex <= 2)
        op = document.all('operId');
    else
        op = document.all('operId')[newRow.rowIndex - 2];

    c4 = modifyRow.cells(3);
    c4.id = "VALUE_" + conditionId;
    c4.className = tdClass;
    if (",5,6,7,8,11,12,15,23".indexOf(","+itemType+",") != -1) {
       c4.innerHTML = "<input readonly type='text' value='" + value1 + "' name='operValue' style='width:170'>";
    }
    else{
       c4.innerHTML = "<input type='text' value='" + value1 + "' name='operValue' style='width:170'>";
    }
    c4.innerHTML += "<input type='hidden' value='" + hidden1 + "' name='operHidden'>";
    //判断 是否要加选择按钮
    if (",5,6,7,8,11,12,15,23,".indexOf(","+itemType+",") != -1) {
        c4.innerHTML += "<input type='button' value='' onclick='doPop(this)' class='button_select'>"
    }
    operatorChange(op);
}

//根据选择的项目插入一行条件
function insertConditionRow(itemId, itemName, itemType, codeSetId, operator, hidden1, value1, hidden2, value2) {
    //debugger;
    if (operator == null) operator = "";
    if (hidden1 == null) hidden1 = "";
    if (value1 == null) value1 = "";
    if (hidden2 == null) hidden2 = "";
    if (value2 == null) value2 = "";
    //插入行
    dt = new Date();

    newRow = PLList.insertRow();
    newRow.id = "ROWID_" + dt.getTime();
    newRow.className = trClass;
    newRow.pos = newRow.rowIndex;
    conditionId = getConditionId();

    //插入单元格
    c1 = newRow.insertCell();
    c1.id = "GROUP_" + conditionId;
    c1.className = tdClass;
    c1.align = "center";
    c1.innerText = conditionId;
    c1.innerHTML += "<input type='hidden' value='" + conditionId + "' name='groupId'>";

    c2 = newRow.insertCell();
    c2.id = "ITEM_" + conditionId;
    c2.className = tdClass;
    c2.align = "center";
    c2.innerText = itemName;
    c2.innerHTML += "<input type='hidden' value='" + itemId + "' name='itemId' dict='" + itemType + "' dict_num='" + codeSetId + "' >";
    c2.innerHTML += "<input type='hidden' value='" + itemName + "' name='itemName'>";
    c2.ondblclick = selField;
    c2.onclick = unSelField;

    c3 = newRow.insertCell();
    c3.id = "OPER_" + conditionId;
    c3.classname = tdClass;
    c3.align = "center";
    c3.innerHTML = createOperator(itemType);
    var op ;
    if (newRow.rowIndex <= 2)
        op = document.all('operId');
    else
        op = document.all('operId')[newRow.rowIndex - 2];
    if (operator != null && "" != operator)
        op.value = operator;


    c4 = newRow.insertCell();
    c4.id = "VALUE_" + conditionId;
    c4.className = tdClass;
    if (",5,6,7,8,11,12,13,15,23".indexOf(","+itemType+",") != -1){
       c4.innerHTML = "<input readonly type='text' value='" + value1 + "' name='operValue' style='width:170'>";
    }
    else{
       c4.innerHTML = "<input type='text' value='" + value1 + "' name='operValue' style='width:170'>";
    }
    c4.innerHTML += "<input type='hidden' value='" + hidden1 + "' name='operHidden'>";
    //判断 是否要加选择按钮
    if (",5,6,7,8,11,12,13,15,23,".indexOf(","+itemType+",") != -1) {
        c4.innerHTML += "<input type='button' value='' onclick='doPop(this)' class='button_select'>"
    }

    c5 = newRow.insertCell();
    c5.id = "ACTION_" + conditionId;
    c5.className = tdClass;
    c5.innerHTML = "<a onclick='deleteCondition(" + newRow.id + ")'>删除</a>&nbsp;&nbsp;"
    c5.innerHTML += "<a onclick='moveUp(" + newRow.id + ")'>上移</a>&nbsp;&nbsp;"
    c5.innerHTML += "<a onclick='moveDown(" + newRow.id + ")'>下移</a>&nbsp;&nbsp;"

    drawGroup(conditionId)

    operatorChange(op, true);
    try {
        op.focus();
    } catch(e) {
    }
}

function drawGroup(conditionId) {
    if (groupField.innerHTML != "") {
        groupField.innerHTML += "<span	 onclick='groupChange(this);' " +
                                "onmouseover='spanOver(this)' " +
                                "onmouseout='spanOut(this)' style='width:10px;' id='groupSpan' spanType='logic'>与</span> "
        //与或 在括号之前
    }

    groupField.innerHTML += "<span	 onclick='groupChange(this);' " +
                            "onmouseover='spanOver(this)' " +
                            "onmouseout='spanOut(this)' style='width:10px;' id='groupSpan' spanType='left_bracket' >&nbsp;</span> " //前括号span

    groupField.innerHTML += "<span style='width:20px;'>" + conditionId + "&nbsp;</span>";

    groupField.innerHTML += "<span	 onclick='groupChange(this);' " +
                            "onmouseover='spanOver(this)' " +
                            "onmouseout='spanOut(this)' style='width:10px;' id='groupSpan' spanType='right_bracket'>&nbsp;</span> " //后括号span
}
//取条件的编号 即A1 A2
function getConditionId() {
    return "A" + (PLList.rows.length - 2);
}

function moveUp(src) {
    if (src.rowIndex == 2)
        return;
    tmpHtml = PLList.rows(src.rowIndex - 1).cells(1).innerHTML;
    PLList.rows(src.rowIndex - 1).cells(1).innerHTML = src.cells(1).innerHTML;
    src.cells(1).innerHTML = tmpHtml;

    tmpHtml = PLList.rows(src.rowIndex - 1).cells(2).innerHTML;
    PLList.rows(src.rowIndex - 1).cells(2).innerHTML = src.cells(2).innerHTML;
    src.cells(2).innerHTML = tmpHtml;

    tmpHtml = PLList.rows(src.rowIndex - 1).cells(3).innerHTML;
    PLList.rows(src.rowIndex - 1).cells(3).innerHTML = src.cells(3).innerHTML;
    src.cells(3).innerHTML = tmpHtml;

}

function moveDown(src) {
    if (src.rowIndex == PLList.rows.length - 1)
        return;

    tmpHtml = PLList.rows(src.rowIndex + 1).cells(1).innerHTML;
    PLList.rows(src.rowIndex + 1).cells(1).innerHTML = src.cells(1).innerHTML;
    src.cells(1).innerHTML = tmpHtml;

    tmpHtml = PLList.rows(src.rowIndex + 1).cells(2).innerHTML;
    PLList.rows(src.rowIndex + 1).cells(2).innerHTML = src.cells(2).innerHTML;
    src.cells(2).innerHTML = tmpHtml;

    tmpHtml = PLList.rows(src.rowIndex + 1).cells(3).innerHTML;
    PLList.rows(src.rowIndex + 1).cells(3).innerHTML = src.cells(3).innerHTML;
    src.cells(3).innerHTML = tmpHtml;

}
// 选择代码或日期等
function doPop(src) {
    pos = src.parentElement.parentElement.rowIndex - 2;

    dict_num = "";
    item_type = "";
    codec = null;
    valuec = null;
    itemc = null;
    oper = null;
    if (document.all("itemId").length == undefined) {
        codec = document.all("operHidden");
        valuec = document.all("operValue");
        itemc = document.all("itemId");
        oper = document.all("operId");
        dict_num = itemc.dict_num;
        item_type = itemc.dict;
    } else {
        dict_num = document.all("itemId")[pos].dict_num;
        item_type = document.all("itemId")[pos].dict;
        codec = document.all("operHidden")[pos];
        valuec = document.all("operValue")[pos];
        itemc = document.all("itemId")[pos];
        oper = document.all("operId")[pos];
    }
    var mutilSelFlag = false;

    if (oper.value == 'in' || oper.value == 'notin')
        mutilSelFlag = true;

    if ("5" == item_type) {//日期
        PopUpCalendarDialog(valuec);
    } else if ("6" == item_type) {//代码
        if (mutilSelFlag)
            PopUpMutilCodeDlgNoSubmit(codec, valuec, dict_num,'');
        else
            PopUpCodeDlgTwoControl(codec, valuec, dict_num);
    } else if ("7" == item_type) {//机构
        if (mutilSelFlag)
            PopUpMutilOrgTwoControl(codec, valuec,'1');
        else
            fPopUpOrgDlg2(codec, valuec,'1');
    } else if ("8" == item_type) {//person
        if (mutilSelFlag)
            fPopUpMutiPerDlg(codec, valuec);
        else
            fPopUpPerDlg(codec, valuec);
    } else if ("11" == item_type) {//post
        if (mutilSelFlag)
            fPopUpMutiPostDlg(codec, valuec);
        else
            fPopUpPostDlg(codec, valuec);
    } else if ("12" == item_type) {//party
        if (mutilSelFlag)
            fPopUpMutilParty2(codec, valuec,'1');
        else
            fPopUpPartyDlg2(codec, valuec,'1');
    }else if("13" == item_type){//wage
        if (mutilSelFlag)
            fPopUpMutiWageUnitDlg2(codec, valuec,true);
        else
            fPopUpWageUnitDlg2(codec, valuec,'1');
    }else if("15" == item_type){
        PopUpCalendarDlg_OnlyMonth(valuec);
    }else if("23" == item_type){
        PopUpWageDeptDlgByPerson(codec.name,'<%User user = (User) (session.getAttribute(Constants.USER_INFO));out.print(user.getUserId());%>');
        valuec.value=codec.value;
    }
}

// 选择了一个项目
function doSel(srcNode) {
    alt = srcNode.alt;
    alt = alt.substr(1, alt.length - 2);
    alta = alt.split("|");
    addCondition(srcNode.getKey(), srcNode.label.innerText, alta[0], alta[1]);
}

function operatorChange(src, saveData) {
    pos = src.parentElement.parentElement.rowIndex - 2;
    codec = null;
    valuec = null;

    if (document.all("itemId").length == undefined) {
        codec = document.all("operHidden");
        valuec = document.all("operValue");
    } else {
        codec = document.all("operHidden")[pos];
        valuec = document.all("operValue")[pos];
    }
    if (saveData == null) {
        codec.value = "";
        valuec.value = "";
    }
    if (src.value == "isnull" || src.value == 'notisnull') {
        valuec.readOnly = true;
        valuec.style.backgroundColor = "#CCCCCC";
        valuec.value = " ";
    } else {
        valuec.readOnly = false;
        valuec.style.backgroundColor = "";
    }
}
function createOperator(dataType) {
    var operatorHTML = "";
    if ("10" == dataType || "14" == dataType) {//lob类型
        operatorHTML = "<select name='operId' onchange='operatorChange(this)'>" +
                       "<option value='isnull'>	为空	</option>" +
                       "<option value='notisnull'>	不为空	</option>";
        return operatorHTML;
    }
    operatorHTML = "<select name='operId' onchange='operatorChange(this)'>" +
                   "<option value='equal'>		等于 	</option>" +
                   "<option value='notequal'>		不等于 	</option>" +
                   "<option value='morethan'>		大于	</option>" +
                   "<option value='lessthan'>		小于	</option>" +
                   "<option value='moreequal'>	大于等于	</option>" +
                   "<option value='lessequal'>	小于等于	</option>" +
                   "<option value='in'>	在列表中	</option>" +
                   "<option value='notin'>	不在列表中	</option>" +
                   "<option value='like'>	匹配	</option>" +
                   "<option value='notlike'>	不匹配	</option>" +
                   "<option value='exist'>	存在	</option>" +
                   "<option value='notexist'>	不存在	</option>" +
                   "<option value='isnull'>	为空	</option>" +
                   "<option value='notisnull'>	不为空	</option>";
    return operatorHTML;
}
var node = null;
