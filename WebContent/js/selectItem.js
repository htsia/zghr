/*
 *  ��װ��item�Ĳ���
 */

function doClear(obj){
    if (obj.options != null) {
        var length = obj.options.length;
        for (i = length - 1; i >= 0; i--) {
            obj.remove(i);
        }
    }
}
/**
 * ����ָ�꼯�任ָ����
 */
function forSelectSet(dest, ori) {
    var setId=ori.value;
    if (setId == '' || setId == null) {
        var size = dest.options.length;
        for (i = size - 1; i >= 0; i--) {
            dest.remove(i);
        }
    } else {
        loadInfoItem(dest, setId);
    }
}
/**
 *���ÿ�ѡ��ָ����
 */
function loadInfoItem(obj, setId) {
    //���ԭ��InfoItem OPtion
    doClear(obj);
    var itemlist = itemHash.get(setId);
    if (itemlist != null) {
        var length = itemlist.size();
        var key = itemlist.keys();
        if (length != 0) {
            var op = document.createElement("option");
            op.value = "";
            op.text = "";
            obj.add(op);
        }
        for (i = 0; i < length; i++) {
            var op = document.createElement("option");
            op.value = itemlist.get(key[i]).itemId;
            op.text = itemlist.get(key[i]).name;
            obj.add(op);
        }
    }
}

/*
 *  ������Ŀ ��Ҫ����Ƿ�����
 */
function addOptionItem(obj, val, text) {
    var count = obj.options.length;
    var flag = true;
    for (j = 0; j < count; j++) {
        if (obj.options[j].value == val) {
//            alert(text + " ��Ŀ�Ѿ�ѡ��");
            flag = false;
            break;
        }
    }
    if (val != null && text != null && flag == true) {
        var op = document.createElement("option");
        op.value = val;
        op.text = text;
        obj.add(op);
    }
    return true;
}
/*
 *  ������Ŀ ����Ҫ����Ƿ�����
 */
function addOptionItemNoCheck(obj, val, text) {
    if (val != null && text != null) {
        var op = document.createElement("option");
        op.value = val;
        op.text = text;
        obj.add(op);
    }
    return true;
}

function forAddItem(dest, ori) {
    var itemId;
    var itemName;
    var count = ori.options.length;
    for (i = 0; i < count; i++) {
        if (ori.options[i].selected == true) {
            itemId = ori.options[i].value;
            itemName = ori.options[i].text;
            addOptionItem(dest, itemId, itemName);
            ori.options[i].selected=false;
        }
    }
    return true;
}

function forAddItemBydw(dest, ori) {
    var itemId;
    var itemName;
    var count = ori.options.length;
    for (i = 0; i < count; i++) {
        if (ori.options[i].selected == true) {
	        if (ori.options[i].value == "N"){
	            itemId = "N"+dest.options.length;
	            itemName = ori.options[i].text;
	            addOptionItemBydw(dest, itemId, itemName);
	        }else{
	            itemId = ori.options[i].value;
	            itemName = ori.options[i].text;
	            addOptionItemBydw(dest, itemId, itemName);
	        }
        }
    }
    return true;
}

function addOptionItemBydw(obj, val, text) {
    if (val != null && text != null) {
        var op = document.createElement("option");
        op.value = val;
        op.text = text;
        obj.add(op);
    }
    return true;
}


/**
 *����
 */
function removeItem(obj) {
    var count = obj.options.length;
    for (i = count - 1; i >= 0; i--) {
        if (obj.options[i].selected) {
            obj.remove(i);
        }
    }
}
/**
 *����
 */
function forUpItem(obj) {
    var count = obj.options.length;
    for (i = 0; i < count; i++) {
        if (obj.options[i].selected) {
            if (i == 0) {
                continue;
            }
            var op1 = document.createElement("Option");
            op1.value = obj.options[i].value;
            op1.text = obj.options[i].text;
            obj.add(op1, i - 1);
            obj.remove(i + 1);
            obj.options[i - 1].selected = true;
        }
    }
    return;
}
/**
 *����
 */
function forDownItem(obj) {
    var count = obj.options.length;
    for (i = 0; i < count; i++) {
        if (obj.options[i].selected) {
            if (i == count - 1) {
                continue;
            }
            var op1 = document.createElement("Option");
            op1.value = obj.options[i].value;
            op1.text = obj.options[i].text;
            obj.add(op1, i + 2);
            obj.remove(i);
            obj.options[i + 1].selected = true;
            break;
        }
    }
    return;
}
// ��ȫ��ѡ������Ϊtrue
function selectTotal(obj) {
    for (i = 0; i < obj.options.length; i++) {
        obj.options[i].selected = true;
    }
}