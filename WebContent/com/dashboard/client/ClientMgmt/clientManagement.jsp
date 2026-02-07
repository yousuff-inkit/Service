<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Client Management</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
  <style type="text/css"> 
  .txtalign{
  text-align:right;
  }
	  .branch {
		color: black;
		background-color: #ECF8E0;
		width: 100%;
		font-family: Tahoma;
		font-size: 12px;
	}  
      .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 15px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    }
    .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: center;
        vertical-align: middle;
    }
    .card-container .card-body .card-detail-container{
        width: 68%;
        vertical-align: middle;
    }
    .card-container .card-body>div{
        display: inline-block;
    }
    .card-container .card-body .card-detail-container>div{
        display: inline-block;
        width:24%;
        text-align:center;
    }
    .card-container .card-body .card-detail-container>div:not(:last-child){
    	border-right: 1px solid #efefef;
    } 
   @media (min-width: 900px) {  
  .modal-xl {
    width: 100%;  
   max-width:1200px;  
  }
}
    .textpanel{
        color: blue;    
  		overflow:auto; 
  		width:550px;         
  }  
  .textpanel1{
        color: #00008B;    
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;  
    }
    .custompanel1{  
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
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
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
    	margin-bottom:5px;
    }
    .actionpanel{
        padding-right: 5px; 
    }
    .otherpanel{
        padding-right: 5px; 
    }
    .primarypanel{
        padding-right: 5px; 
    }
    .padtop{
        padding-top: 5px; 
    }
    .class-pad5{
     padding-top: 5px; 
    }
  </style>  
</head>       
<body>               
<form id="frmScheduleReport" action="saveScheduleReport" method="post" autocomplete="off" class="form-inline">         
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
       <div class="primarypanel custompanel1">      
  			  <button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
          	  <button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
       <div class="actionpanel custompanel1">      
	          <button type="button" class="btn btn-default" id="btncreditlimit" data-toggle="tooltip" title="Credit limit Update" data-placement="bottom"><i class="fa fa-pencil-square  "  aria-hidden="true"></i></button>        
	          <button type="button" class="btn btn-default" id="btnsalman" data-toggle="tooltip" title="Salesman Update" data-placement="bottom"><i class="fa fa-user"  aria-hidden="true"></i></button>        
        </div>              
        <div class="textpanel custompanel">     
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>                            
        </div>   
      </div>
    </div>
    <div class="row">               
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
        <div id="clientListDiv"><jsp:include page="clientListGrid.jsp"></jsp:include></div>          
      </div>
    </div>    

    
       <div id="modalcreditupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-md">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Credit Period Update<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row rowgap">  
	  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
			        					  <label>Credit period</label> 
		 	                  </div>   
		 	                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
			        					 <input  type="text" id="creditmin" name="creditmin"   class="form-control input-sm txtalign" placeholder="min"  value='<s:property value="creditmin"/>' onkeypress="javascript:return isNumberKey(event);" />
		 	                  </div>    
		 	                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">  
			        					 &nbsp;-&nbsp;
		 	                  </div>  
		 	                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">    
			        					   <input type="text" id="creditmax" placeholder="max"  class="form-control input-sm txtalign" name="creditmax"  value='<s:property value="creditmax"/>' onkeypress="javascript:return isNumberKey(event);"/>
		 	                  </div> 
	 	                </div>   
	 	                <div class="row rowgap">  
  					         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
		        					  <label >Credit limit</label> 
		        			 </div>   
		        					  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
									  <input   type="text" id="txtcreditlimit" name="txtcreditlimit" class="form-control input-sm txtalign"  value='<s:property value="txtcreditlimit"/>'/>
	 	                  </div>   
	 	                    </div>  
		         </div> 
          		<div class="modal-footer"> 
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnstatussave" onclick="funUpdate(1)">Save Changes</button>  
            		
          		</div>
        </div>
      </div>
     </div> 
     
     <div id="modalsalesmanupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-md">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Salesman update<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row rowgap">  
	  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">  
			        					  <label>Salesman</label> 
		 	                  </div>   
		 	                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        					    <select class="form-control select2" name="cmbsalesman" id="cmbsalesman" style="width:100%;"></select> 
		 	                  </div>    
	 	                </div>   
		         </div> 
          		<div class="modal-footer"> 
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnstatussave" onclick="funUpdate(2)">Save Changes</button>  
            		
          		</div>
        </div>
      </div>
     </div> 
     
     
      <input type="hidden" name="cldocno" id="cldocno" style="height:20px;width:70%;" value='<s:property value="cldocno"/>' >   
	  <input type="hidden" name="salid" id="salid" style="height:20px;width:70%;" value='<s:property value="salid"/>' >  
	 <input type="hidden" name="brhid" id="brhid" style="height:20px;width:70%;" value='<s:property value="brhid"/>' > 
     <input type="hidden" name="lblname" id="lblname" style="height:20px;width:70%;" value='<s:property value="lblname"/>' >     
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
$(document).ready(function () {
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $('#Salesagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'SalesMan Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	  $('#Salesagentinfowindow').jqxWindow('close');
	  getSalesman();
    $('#btnsalman').dblclick(function(){
		  $('#Salesagentinfowindow').jqxWindow('open');
	      salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow'));
		  });
    
    $('#btnsubmit').on('click',function(){
    	 funreload(event);
    	 $("#textpanel").text('');
    	 document.getElementById("lblname").value="";
    });
    $('#btnexcel').on('click',function(){
    	funExportBtn();
    });
    $('#btncreditlimit').on('click',function(){
    	 var cldocno=$('#cldocno').val();
	    	if(cldocno=="" || cldocno=="0"){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val();
    	$("#modalcreditupdate").modal('toggle'); 
    });
    $('#btnsalman').on('click',function(){
    	 var cldocno=$('#cldocno').val();
	    	if(cldocno=="" || cldocno=="0"){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	document.getElementById("lblotherdetails2").innerHTML=$("#lblname").val();
    	$("#modalsalesmanupdate").modal('toggle'); 
    });
});

function funreload(event){
$("#clientListDiv").load("clientListGrid.jsp?check=1");
}	

function funExportBtn() {
	$("#clientListDiv").excelexportjs({
				containerid: "clientListDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "jqxClientGrid", 
				columns: getColumns("jqxClientGrid") ,   
				worksheetName:"Client Management"  
				});
	} 
function funUpdate(val){
	var creditmin = $('#creditmin').val();
	var creditmax =  $('#creditmax').val();
	var creditlimit = $('#txtcreditlimit').val();
	var salid = $('#cmbsalesman').val();
	var brhid = $('#brhid').val();
	var cldocno = $('#cldocno').val();
	if(parseInt(val)==1){
		if(creditmin==''){
			Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Please Enter Credit Min.'   
			});
			 return 0;
		 }
		if(creditmax==''){
			Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Please Enter Credit Max'   
			});
			 return 0;
		 }
		 if(creditlimit==''){
			 Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please Enter Credit limit'   
				});
			 return 0;
		 }
	}	
	if(parseInt(val)==2){
		 if(salid==''){
			 Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a Sales Man'   
				});
			 return 0;
		 }
	}
	   
	 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		saveGridData(creditmin,creditmax,creditlimit,salid,val,brhid,cldocno);	
	     	}
	});
}

function saveGridData(creditmin,creditmax,creditlimit,salid,val,brhid,cldocno){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200){
    			
			var items=x.responseText;
			if(parseInt(items)>0){
				Swal.fire({
	    			icon: 'success',
					title: 'Message',
					text: 'Record Successfully Updated'   
				});
				funreload(event);
			}else{
				Swal.fire({
	    			icon: 'error',
					title: 'Error',
					text: 'Not Updated'   
				});
			}
		     $('#creditmin').val('');
			 $('#creditmax').val('');
			 $('#txtcreditlimit').val('');
			  $('#cmbsalesman').val('').trigger('change');
			}
	}
x.open("GET","saveData.jsp?creditmin="+creditmin+"&creditmax="+creditmax+"&creditlimit="+creditlimit+"&salid="+salid+"&val="+val+"&brhid="+brhid+"&cldocno="+cldocno);    
x.send();
}	  

function getsalesAgent(event){
   	 var x= event.keyCode;
   	 if(x==114){
   	  $('#Salesagentinfowindow').jqxWindow('open');
   
     
    salesagentSearchContent('SearchSalesman.jsp?', $('#Salesagentinfowindow')); }
   	 else{
   		 }
   	 }

function salesagentSearchContent(url) {
            //alert(url);
              $.get(url).done(function (data) {
     //alert(data);
	           $('#Salesagentinfowindow').jqxWindow('setContent', data);

    	}); 
}
function isNumberKey(evt){
   var charCode = (evt.which) ? evt.which : event.keyCode
   if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
       return false;
   return true;
}   
function getSalesman() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option  value="' + srno[i].trim() +'">'
				+ process[i] + '</option>';
				
			}
			$('#cmbsalesman').html($.parseHTML(optionsbranch));
  			$('#cmbsalesman').select2({
  				placeholder:"Please select a Salesman",    
  				allowClear:true 
  			});
		} else {}
	}
	x.open("GET","getSalesman.jsp", true);  
	x.send();
}
</script> 
  </div>
  <div id="Salesagentinfowindow">
<div ></div>
 </div>
 </form>   
</body>
</html>
