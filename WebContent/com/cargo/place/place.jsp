 
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

<% String contextPath=request.getContextPath(); %>

<script type="text/javascript">
	$(document).ready(function () {    
	    $("#PlaceDate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
        });
       function funSearchLoad(){
		changeContent('placeSearch.jsp', $('#window')); 
	 } 
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	function funReadOnly() {
		$('#frmPlace input').attr('readonly', true);
		$('#frmPlace textarea').attr('disabled', true );
		$('#frmPlace select').attr('disabled', true );
		$('#PlaceDate').jqxDateTimeInput({
			readonly : true
		});
		setValues();
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmPlace input').attr('readonly', false);
		$('#frmPlace textarea').attr('disabled', false );
		$('#frmPlace select').attr('disabled', false );
		$('#PlaceDate').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		
	}
/* 	function show_image(src, width, height, alt,position,norepeat) {
	    var img = document.createElement("img");
	    img.src = src;
	    img.width = width;
	    img.height = height;
	    img.alt = alt;
	    img.position=position;
	    img.repeat=norepeat;

	    // This next line will just add it to the <body> tag
	    document.body.appendChild(img);
	} */
	function setValues() {
		getCountry();
		/* if($('#hidPortDate').val()){
			$("#PortDate").jqxDateTimeInput('val', $('#hidPortDate').val());
		} */
		//alert("no of times");
		
		
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	}
	
	 
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("code").focus();
	     }
	     function getCountry(){
	  	   var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				items = items.split('***');
	  				var locItems = items[0].split(",");
	  				var locIdItems = items[1].split(",");
	  				var optionsloc = '<option value="">--Select--</option>';
	  				for (var i = 0; i < locItems.length; i++) {
	  					optionsloc += '<option value="' + locIdItems[i] + '">'
	  							+ locItems[i] + '</option>';
	  				}
	  				$("select#cmbcountry").html(optionsloc);
	  				
	  				if ($('#hidcmbcountry').val() != null && $('#hidcmbcountry').val()!="") {
	  					$('#cmbcountry').val($('#hidcmbcountry').val());
	  				}
	  			} else {
	  			}
	  		}
	  		x.open("GET", "getCountry.jsp", true);
	  		x.send();
	     }
</script>  
 
</head>
<body onLoad="funReadOnly();setValues();" >
<form id="frmPlace" action="savePlace" method="get" autocomplete="off">
<script>
			 window.parent.formName.value="PLACE";
			window.parent.formCode.value="PLC"; 
	</script>
	<%-- <jsp:include page="../../../../header.jsp" /> --%>
	<jsp:include page="../../../header.jsp" />
	<br/> 
	<table width="100%" >
	<tr><td>
	<fieldset><legend>Place Details</legend>
	<table width="100%" >
		<tr><td colspan=2 width="6%" align="right">Date</td>
			<td width="31%"  align="left"><div id="PlaceDate" name="PlaceDate"></div>
		  	</td>
			<td width="46%" align="right">Doc No.</td>
			<td width="17%">
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true"  tabindex="-1">
			</td>
		</tr>
		
		</table>
		<table width="100%" >
		<tr>
		<td width="6%" align="right">Code</td>
			<td width="20%"><input type="text" name="code" id="code" style="width: 70%;"  value='<s:property value="code"/>' ></td>
		<td align="right">Name</td>
			<td width="20%"><input type="text" name="name" id="name" style="width: 100%;"  value='<s:property value="name"/>' ></td>
		<td align="right">Country</td>
        <td width="20%" align="left"><select name="cmbcountry" id="cmbcountry"  value='<s:property value="cmbcountry"/>' style="width:100%;">
          <option value="">--Select--</option>
        </select></td>
        <input type="hidden" name="hidcmbcountry" id="hidcmbcountry" value='<s:property value="hidcmbcountry"/>'>
		</tr>
		
		</table>
		</fieldset>
		</td></tr></table>
	
	
	
    	<table width="100%">
      <tr>
        <td width="3%">&nbsp;</td>
        <td width="42%">
        <input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<input type="hidden" id="deleted" name="deleted"  value='<s:property value="deleted"/>'/>
</td>
        <td width="55%">&nbsp;</td>
      </tr>
    </table>
	</form>

<br/>

</body>
</html>