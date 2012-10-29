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
    rt = window.prompt("�������ѯ����", document.all('qryName').value);
    if (rt == "" || rt == null)
        return false;
    document.all("qryName").value = rt;
    //��֤����
	}
    return flag;
}
//�ύʱjs�Ĵ���
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
                alert("�������ѯ����");
                return false;
            }
            if ((itemId.dict == "1" || itemId.dict == "2" || itemId.dict == "9") && isNaN(valuec.value)) {
                alert("����������");
                valuec.focus();
                return false;
            }
            cdate = valuec.value;

            if(itemId.dict == "5" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                if(dateCheck(cdate)== false ){
                    alert("��������ȷ����");
                    valuec.focus();
                    return false;
                }
            }
            if(itemId.dict == "15" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                if(dateCheck(valuec.value + "-01")== false){
                    alert("��������ȷ����");
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
                    alert("�������ѯ����");
                    return false;
                }

                if ((itemId.dict == "1" || itemId.dict == "2" || itemId.dict == "9") && isNaN(valuec.value)) {
                    alert("����������");
                    valuec.focus();
                    return false;
                }
                 cdate = valuec.value;
                if(itemId.dict == "5" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                    if(dateCheck(valuec.value)== false){
                        alert("��������ȷ����");
                        valuec.focus();
                        return false;
                    }
                }
                if(itemId.dict == "15" && cdate.charAt(0) != '[' && cdate.charAt(cdate.length-1) != ']'){
                    if(dateCheck(valuec.value + "-01")== false){
                        alert("��������ȷ����");
                        valuec.focus();
                        return false;
                    }
                }
            }
        }
    }
    return true;
}
//��������ɾ�����Ŀ���js
var focusField ;
var oldBgColor;
var oldColor;
//�ȶ���tr td��class��ʽ
trClass = "td_top";
tdClass = "F08";


function selField() {
    src = window.event.srcElement;
    if (src == focusField)
        return;

    oldBgColor = src.style.backgroundColor;
    oldColor = src.style.color;
    //���������ѡ��
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

//���ָ����˫��ʱ���ñ����� ,�����������ò����з���.������з���
function addCondition(itemId, itemName, itemType, codeSetId) {
    if (focusField == null) {
        insertConditionRow(itemId, itemName, itemType, codeSetId);
    } else {
        modifyCondition(itemId, itemName, itemType, codeSetId);
    }
}

//ɾ��ĳһ����������Ҫ����rebuildGroup��������span
function deleteCondition(src) {
    //ɾ����Ҫ���µ��� ���
    PLList.deleteRow(src.rowIndex);
    rebuildGroup();
    focusField = null;
}

//��������a1 a2 a3 ���ϲ���span
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
        if (src.innerText == '��')
            src.innerText = '��';
        else
            src.innerText = '��';
    } else {
        tmp = prompt("����������", src.innerText)
        if (tmp == null)
            tmp = "";
        //����ȫ������
        while (tmp != tmp.replace("��", "(")) {
            tmp = tmp.replace("��", "(");
        }
        while (tmp != tmp.replace("��", ")")) {
            tmp = tmp.replace("��", ")");
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

//����ѡ�����Ŀ �޸�һ������,�������� 2 3 4 ��Ԫ��
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
    //�ж� �Ƿ�Ҫ��ѡ��ť
    if (",5,6,7,8,11,12,15,23,".indexOf(","+itemType+",") != -1) {
        c4.innerHTML += "<input type='button' value='' onclick='doPop(this)' class='button_select'>"
    }
    operatorChange(op);
}

//����ѡ�����Ŀ����һ������
function insertConditionRow(itemId, itemName, itemType, codeSetId, operator, hidden1, value1, hidden2, value2) {
    //debugger;
    if (operator == null) operator = "";
    if (hidden1 == null) hidden1 = "";
    if (value1 == null) value1 = "";
    if (hidden2 == null) hidden2 = "";
    if (value2 == null) value2 = "";
    //������
    dt = new Date();

    newRow = PLList.insertRow();
    newRow.id = "ROWID_" + dt.getTime();
    newRow.className = trClass;
    newRow.pos = newRow.rowIndex;
    conditionId = getConditionId();

    //���뵥Ԫ��
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
    //�ж� �Ƿ�Ҫ��ѡ��ť
    if (",5,6,7,8,11,12,13,15,23,".indexOf(","+itemType+",") != -1) {
        c4.innerHTML += "<input type='button' value='' onclick='doPop(this)' class='button_select'>"
    }

    c5 = newRow.insertCell();
    c5.id = "ACTION_" + conditionId;
    c5.className = tdClass;
    c5.innerHTML = "<a onclick='deleteCondition(" + newRow.id + ")'>ɾ��</a>&nbsp;&nbsp;"
    c5.innerHTML += "<a onclick='moveUp(" + newRow.id + ")'>����</a>&nbsp;&nbsp;"
    c5.innerHTML += "<a onclick='moveDown(" + newRow.id + ")'>����</a>&nbsp;&nbsp;"

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
                                "onmouseout='spanOut(this)' style='width:10px;' id='groupSpan' spanType='logic'>��</span> "
        //��� ������֮ǰ
    }

    groupField.innerHTML += "<span	 onclick='groupChange(this);' " +
                            "onmouseover='spanOver(this)' " +
                            "onmouseout='spanOut(this)' style='width:10px;' id='groupSpan' spanType='left_bracket' >&nbsp;</span> " //ǰ����span

    groupField.innerHTML += "<span style='width:20px;'>" + conditionId + "&nbsp;</span>";

    groupField.innerHTML += "<span	 onclick='groupChange(this);' " +
                            "onmouseover='spanOver(this)' " +
                            "onmouseout='spanOut(this)' style='width:10px;' id='groupSpan' spanType='right_bracket'>&nbsp;</span> " //������span
}
//ȡ�����ı�� ��A1 A2
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
// ѡ���������ڵ�
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

    if ("5" == item_type) {//����
        PopUpCalendarDialog(valuec);
    } else if ("6" == item_type) {//����
        if (mutilSelFlag)
            PopUpMutilCodeDlgNoSubmit(codec, valuec, dict_num,'');
        else
            PopUpCodeDlgTwoControl(codec, valuec, dict_num);
    } else if ("7" == item_type) {//����
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

// ѡ����һ����Ŀ
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
    if ("10" == dataType || "14" == dataType) {//lob����
        operatorHTML = "<select name='operId' onchange='operatorChange(this)'>" +
                       "<option value='isnull'>	Ϊ��	</option>" +
                       "<option value='notisnull'>	��Ϊ��	</option>";
        return operatorHTML;
    }
    operatorHTML = "<select name='operId' onchange='operatorChange(this)'>" +
                   "<option value='equal'>		���� 	</option>" +
                   "<option value='notequal'>		������ 	</option>" +
                   "<option value='morethan'>		����	</option>" +
                   "<option value='lessthan'>		С��	</option>" +
                   "<option value='moreequal'>	���ڵ���	</option>" +
                   "<option value='lessequal'>	С�ڵ���	</option>" +
                   "<option value='in'>	���б���	</option>" +
                   "<option value='notin'>	�����б���	</option>" +
                   "<option value='like'>	ƥ��	</option>" +
                   "<option value='notlike'>	��ƥ��	</option>" +
                   "<option value='exist'>	����	</option>" +
                   "<option value='notexist'>	������	</option>" +
                   "<option value='isnull'>	Ϊ��	</option>" +
                   "<option value='notisnull'>	��Ϊ��	</option>";
    return operatorHTML;
}
var node = null;
