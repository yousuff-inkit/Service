<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<style type="text/css">
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 
		 $('#userDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Users Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#userDetailsWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     
	     /* $('#txtusername').dblclick(function(){
			  userDetailsSearchContent('userDetailsSearch.jsp');
		 });
		  */
	     document.getElementById("rdmenu").checked=true;
	   //  $('#btnupdate').attr("disabled",true);
	    
	});

	function userDetailsSearchContent(url) {
	    $('#userDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#userDetailsWindow').jqxWindow('setContent', data);
		$('#userDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getUserDetails(event){
        var x= event.keyCode;
        if(x==114){
        	userDetailsSearchContent('userDetailsSearch.jsp');
        }
        else{}
        }
	
	function funreload(event){
		 $('#hiddocno').val('');    
		// $('#btnupdate').attr("disabled",true);
		 $("#overlay, #PleaseWait").show();
		 if(document.getElementById("rdmenu").checked==true){
		 	$("#menuDiv").load("menuGrid.jsp?rpttype=1&check=1");
		 	$('#printpath2').show();
		 } else {
			 	$("#menuDiv").load("menuGrid.jsp?rpttype=2&check=1");
			 	 $('#printpath2').hide();
		 }
	}
	
	
	function funUpdate(event){
		var docno = $('#hiddocno').val();
		var gate = $('#hidgate').val();

		var path = $('#txtpath').val();
		path=encodeURIComponent(path);
	//	 var fsize = $('#file')[0].files[0];
	//	 alert(gate);
		var printpath = $('#txtprintpath').val();
		var printpath2 = $('#txtprintpath2').val();
		printpath=encodeURIComponent(printpath);
		printpath2=encodeURIComponent(printpath2);

		var rpttype="0";
		if(document.getElementById("rdmenu").checked==true){
			rpttype="1";
		}
		var chk=0;
		if(gate=='')
			{
			chk=1;
			}
		else
			{
			if(document.getElementById("rdmenu").checked==true){
				gate=gate.toUpperCase();
			//	alert(gate);
				if(!(gate=="E" || gate=="N")){
					 $.messager.alert('Message','Enter  Value (E/N).','warning');
					 return 0;
				}
			}
			else
				{
				if(!(gate=="0" || gate=="1")){
					 $.messager.alert('Message','Enter  Value (0/1).','warning');
					 return 0;
				}
				}
			
			}
		
		 if(docno==''){
			 $.messager.alert('Message','Select a Document.','warning');
			 return 0;
		}
		  
		    $.messager.confirm('Message', 'Do you want to Update ?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(docno,path,printpath,printpath2,rpttype,gate,chk);	
		     	}
		 });
	}
	
	
	
	function saveGridData(docno,path,printpath,printpath2,rpttype,gate,chk) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(items==1)
					{
				$.messager.alert('Message', '  Updated Successfully ', function(r){
			  });
					}
				else
					{
					$.messager.alert('Message', ' Not Updated  ', function(r){
					  });	
					}
			  funClearInfo();
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&path="+path+"&printpath="+printpath+"&printpath2="+printpath2+"&rpttype="+rpttype+"&gate="+gate+"&chk="+chk,true);
	x.send();
	}

	
	function funExportBtn(){
		if(document.getElementById("rdmenu").checked==true){
		 $("#menuDiv").excelexportjs({    
				containerid: "menuDiv",    
				datatype: 'json', 
				dataset: null, 
				gridId: "menuGridID", 
				columns: getColumns("menuGridID") ,     
				worksheetName: "Menu"
			});
		}
		else{
		 $("#menuDiv").excelexportjs({    
				containerid: "menuDiv",    
				datatype: 'json', 
				dataset: null, 
				gridId: "menuGridID", 
				columns: getColumns("menuGridID") ,     
				worksheetName: "BI"
			});
		}
		 
	}
	
	function  funClearInfo() {
		    $('#txtpath').val('');
			$('#txtprintpath').val('');
			$('#txtprintpath2').val(''); 
			$('#hiddocno').val(''); 
			$('#hidgate').val(''); 

			//$('#btnupdate').attr("disabled",true);
			document.getElementById("rdmenu").checked=true;
			document.getElementById("rdbi").checked=false;
			$("#menuGridID").jqxGrid('clear');
			
			if (document.getElementById("txtpath").value == "") {
		        $('#txtpath').attr('placeholder', 'Choose Path'); 
		    }
			if (document.getElementById("txtprintpath").value == "") {
		        $('#txtprintpath').attr('placeholder', 'Choose Print Path'); 
		    }if (document.getElementById("txtprintpath2").value == "") {
		        $('#txtprintpath2').attr('placeholder', 'Choose Print Path 2'); 
		    }
	}
	
	function funClearRadioInfo() {
		
		if(document.getElementById("rdmenu").checked==true){
			  $('#txtpath').val('');
				$('#txtprintpath').val('');
				$('#txtprintpath2').val(''); 
				$('#hiddocno').val(''); 
				//	$('#btnupdate').attr("disabled",true);
			document.getElementById("rdmenu").checked=true;
			document.getElementById("rdbi").checked=false;
			//$("#menuGridID").jqxGrid('clear');
			
			
		} else if(document.getElementById("rdbi").checked==true){
			  $('#txtpath').val('');
				$('#txtprintpath').val('');
				$('#txtprintpath2').val(''); 
				$('#hiddocno').val(''); 
				//	$('#btnupdate').attr("disabled",true);
			document.getElementById("rdmenu").checked=false;
			document.getElementById("rdbi").checked=true;
		//	$("#biGridID").jqxGrid('clear');
			
			
		}
		if (document.getElementById("txtpath").value == "") {
	        $('#txtpath').attr('placeholder', 'Choose Path'); 
	    }
		if (document.getElementById("txtprintpath").value == "") {
	        $('#txtprintpath').attr('placeholder', 'Choose Print Path'); 
	    }if (document.getElementById("txtprintpath2").value == "") {
	        $('#txtprintpath2').attr('placeholder', 'Choose Print Path 2'); 
	    }
	}

	function loading(){
		//alert(this.value);
		document.getElementById("iscapture").value=0;
		var path=document.getElementById("file").value;
		 var fsize = $('#file')[0].files[0].size;
		//    var tmppath = URL.createObjectURL(event.target.files[0]);

		// alert(tmppath);
		 var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
		
		 if((extn=='jpg')||(extn=='png')||(extn=='jpeg')||(extn=='gif')||(extn=='bmp')||(extn=='JPG')||(extn=='PNG')||(extn=='JPEG')||(extn=='GIF')||(extn=='BMP'))
	       {
			 
			 if(fsize>1048576)
				 {
				 document.getElementById("errormsg").innerText="Please Wait......";
				 }
			 
			 
			 
	       }
	      
		
		
	}
	
	 <%--  function getBranch() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
					var optionsbranch = '<option value="">--Select--</option>';
					for (var i = 0; i < branchItems.length; i++) {
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
					}
					$("select#cmbbranch").html(optionsbranch);
					if ($('#hidcmbbranch').val() != null) {
						$('#cmbbranch').val($('#hidcmbbranch').val());
					}
				} else {
				}
			}
			x.open("GET", <%=contextPath+"/"%>+"com/operations/commtransactions/getBranch.jsp", true);
			x.send();
		} --%>
	
</script>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2" align="center"><input type="radio" id="rdmenu" name="rdo" onchange="funreload();" value="rdmenu"><label for="rdmenu" class="branch">Menu</label>&nbsp;&nbsp;&nbsp;&nbsp;
	    <input type="radio" id="rdbi" name="rdo" onchange="funreload();" value="rdbi"><label for="rdbi" class="branch">BI</label></td></tr>
	<tr>
	 	      <td colspan="2"><input type="file" id="file" name="file" onChange="return loading();" /></td>  
	</tr>
	
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td width="23%" ><label class="branch">Path</label></td>
	<td align="left"><input type="text" id="txtpath" name="txtpath" style="width:100%;height:20px;" placeholder="Choose Path"  value='<s:property value="txtpath"/>'/>
	</td>
<!-- 	      <td align="left" width="10%" ><input type="file" id="file" name="file" onChange="return loading();" /></td>  
 -->	
	</tr> 
	 <tr><td ><label class="branch">Print Path</label></td>
	<td align="left"><input type="text" id="txtprintpath" name="txtprintpath" style="width:100%;height:20px;" placeholder="Choose Print Path" value='<s:property value="txtprintpath"/>'/>
	</td>
<!-- 	 <td align="left" width="10%" ><input type="file" id="file1" name="file1" onChange="return loading1();" /></td>  
 -->	
	
	</tr> 
	 <tr id="printpath2"><td ><label class="branch">Print Path2</label></td>
	<td  align="left"><input type="text" id="txtprintpath2" name="txtprintpath2" style="width:100%;height:20px;" placeholder="Choose Print Path2" value='<s:property value="txtprintpath2"/>'/>
</td>
<!-- 	      <td align="left" width="10%" ><input type="file" id="file2" name="file2" onChange="return loading2();" /></td>  
 -->

</tr> 
	<tr><td colspan="2" align="center"><button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button>&nbsp;&nbsp;&nbsp;&nbsp;
	<tr><td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2"><input type="hidden" name="hiddocno" id="hiddocno" style="height:20px;width:70%;" value='<s:property value="hiddocno"/>'></td></tr> 
    <tr><td colspan="2"><input type="hidden" name="hidgate" id="hidgate" style="height:20px;width:70%;" value='<s:property value="hidgate"/>'></td></tr> 
		<tr><td colspan="2">&nbsp;</td></tr>
	
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="menuDiv"><jsp:include page="menuGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>

<div id="userDetailsWindow">
<div></div>
</div>
</div> 
</body>
</html>