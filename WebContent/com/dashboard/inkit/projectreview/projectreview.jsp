<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Project Review</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.datepanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-bottom: 10px;
      padding-right: 10px;
      padding-left: 10px;
    }
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	
/* 	.modal-dialog,
.modal-content {
    /* 80% of window height */
    height: 80%;
}

.modal-body {
    /* 100% = dialog height, 120px = header + footer */
    max-height: calc(100% - 120px);
    overflow-y: scroll;
}		 */
  </style>
</head>
<body onload="getBranch()">
 <!--  -->
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="primarypanel custompanel">
        
       <table>
        
        <tr>
      <td><label class="branch">From</label></td> <td><div id="fromdate" name="fromdate" style="width:140px;"></div></td>
  		
      <td><label class="branch">To</label></td> <td><div id="todate" name="todate" style="width:140px;"></div></td>
      
      
    <td><label class="branch">Branch</label><select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' style="width:140px;"></select></td>
       
     <td><label class="branch">Type</label><select id="ctype" name="ctype" value='<s:property value="ctype"/>' style="width:140px;">
  					 <option value="" >ALL</option><option value="AMS">AMS</option><option value="SJOB">SJOB</option><option value="STC">Staffing</option>
     </select></td>
   <td> <label class="branch">Client</label><input id="txtclientname" name="txtclientname" onkeydown="getClientAccount(event);" readonly="readonly" placeholder="Press F3 to Search" style="width:140px;">

	 <input type="hidden" id="txtclientaccountdocno" name="txtclientaccountdocno"/></td>
	 
	 </tr>
	 
	 </table>
         
	 
	 </div> 
	 
	  
	  <div class="primarypanel custompanel">
	 	<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
          </div>
          
         </div>  
      </div>
     </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="loadgriddata"><jsp:include page="gridDetails.jsp"></jsp:include></div>
      </div>
    </div>
	   
   <div id="accountDetailsWindow">
	<div></div>
	</div>
	
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){

	     $('#txtclientname').dblclick(function(){
	    	 
			  accountsSearchContent('clientAccountDetailsSearch.jsp');
		 });
	     
	     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 
		  
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));  
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	    $('#btnexcel').click(function(){
			$("#loadgriddata").excelexportjs({
				containerid: "loadgriddata", 
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxloaddataGrid", 
				columns: getColumns("jqxloaddataGrid") ,   
				worksheetName:"Project Review"
				});
	});


	
	$('#btnsubmit').click(function(){
	
	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	   }
	  
	 	 
	  
	 var barchval = document.getElementById("cmbbranch").value;
	 var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val();
	 var rds=$('#ctype').val();
	 var clientid=$('#txtclientaccountdocno').val();
	
	 
		$('.load-wrapp').show();
$("#loadgriddata").load("gridDetails.jsp?barchval="+barchval+"&froms="+fromdate+"&tos="+todate+"&rds="+rds+"&clientid="+clientid);
	
	  
	 });
	 
	   
	  
});



function getBranch() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText;
			items = items.split('####');
			var brnch = items[0].split(",");
			var brnchId = items[1].split(",");
			var optionsbrand = '<option value="">--Select--</option>';
			for (var i = 0; i < brnch.length; i++) {
				optionsbrand += '<option value="' + brnch[i].trim() + '">'
						+ brnchId[i].trim() + '</option>';
				
			}
//alert("optionsbrand==="+optionsbrand)
			$("select#cmbbranch").html(optionsbrand);
		} else {
		}
	}
	x.open("GET", "getBranch.jsp", true);
	x.send();
}


function getClientAccount(event){
	var rds=$('#ctype').val();
	if(rds=='ALL'){
		
	}
   var x= event.keyCode;
   if(x==114){
 	  accountsSearchContent('clientAccountDetailsSearch.jsp');
   }
   else{}
   }
function accountsSearchContent(url) {
	
$('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}



		function  funClearData(){
			 $('#txtclientname').val('');
			 $('#txtclientaccountdocno').val('');
			 $('#acno').val('');
			 $('#trno').val('');
			 $('#jqxloaddataGrid').jqxGrid('clear');
			 $('#txtclientname').val('Press F3 To Search');
			
			
		}	
	
	
</script>
</body>
</html>
