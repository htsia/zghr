//����˵��  ���ڵ�,��Թ�ϵ,�ڵ�����,�ڵ���,�ڵ���2,����,ͼƬ����,exeCategory,exeArg,�Ƿ�ѡ��,�Ƿ���ʾcheckbox�ؼ�
//exeCategory ����ʹ��"JS"���� exeArgΪ�ڵ㵥����ִ�в��� �� alert(1);

//tree=new newtree(images,16,dt)
//root=tree.root
//i1=tree.addChkNode(toNode,"relation","text","key","key2","alt","ico","exeCategory","exeArg",checked,showCheckbox,checkboxName,checkboxId);
//���÷���	i1=tree.addChkNode(s1,"last","����","A001001","a001","Set=A001|codeSet=102","item","JS","alert(1)",true,true,checkboxName,checkboxId);

function tree_check(){
	if(typeof(newtree)!="function"){
		alert("run tree_check() fail, please load newtree firt!")
		return
	}
	//add(toNode,relation,text,key,ico,exeCategory,exeArg)
	var colChkNode=[]
	newtree.prototype.colChkNode=colChkNode
	newtree.prototype.addChkNode=function(toNode,relation,text,key,key2,alt,ico,exeCategory,exeArg,checked,enabled,checkboxName,checkboxId,chkTreeId,chkOnclick){
		var newNode=this.add(toNode,"last",text,key,key2,alt,ico,exeCategory,exeArg)
		if(enabled){
			var chkBox=document.createElement('<input type="Checkbox" name=' + checkboxName + ' value=' + checkboxId + ' treeId='+chkTreeId+'>')
			var tree=this
			newNode.label.insertAdjacentElement("beforeBegin",chkBox)
			newNode.isCheck=true
			if(typeof(checked)=="boolean")chkBox.checked=checked;
			newNode.oncheck=new Function("return true;")
			chkBox.onpropertychange=function(){if(newNode.oncheck() && tree.oncheck!=null)tree.oncheck(newNode)}
			colChkNode[colChkNode.length]=newNode
			newNode.checkBox=chkBox
		}
		return newNode

	}
	newtree.prototype.oncheck=new Function("return true;")
}
tree_check()