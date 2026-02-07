<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Tipping Details</title>             
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
  <style type="text/css"> 
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
  		width:260px;  
  		/* height:50px;       */           
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
    	margin-bottom:6px;
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
    .modal-title{
        font-weight: bold;
        color:#3c52fa;
    }
  </style>
</head>       
<body >   
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
		 <form  class="form-inline">      
		   <div class="primarypanel custompanel1">
	                      
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">From:</label>
    						<div class="form-group mb-2">
      							<div id='fromdate' name='fromdate'></div>
    						</div> </div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="cmbpriority">To:</label>
    						<div class="form-group mb-2">
      							<div id='todate' name='todate'></div>      
			               </div> 	</div>
			                </div>		  
		                
		
		 <div class="primarypanel custompanel1">   
  			<input type="radio"  id="radiosum"  data-toggle="tooltip" name="rdo" title="Summary" onclick="radioClick();" value="radiosum" checked=true>Summary  
          	<input type="radio"  id="radiodet" data-toggle="tooltip" name="rdo" title="Detail" onclick="radioClick();" value="radiodet">Detail
        </div>  
		 	   
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btndnoupdate"  data-toggle="tooltip" title="DNO Update" data-placement="bottom"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>    
            <button type="button" class="btn btn-default" id="btndetailsupdate"  data-toggle="tooltip" title="Tipping Details Update" data-placement="bottom"><i class="fa fa-pencil-square" aria-hidden="true"></i></button>    
        </div>   
        <div class="warningpanel custompanel1">                     
	         <div class="btn-group" role="group">
	            <button type="button" class="btn btn-default" id="btninvoicedcount" data-toggle="tooltip"  title="Invoiced" data-placement="bottom"><i class="fa fa-file-text-o " aria-hidden="true"></i></button>
	            <span class="badge badge-notify badge-invoiced"></span>                                            
	          </div>  
	          <div class="btn-group" role="group">
	            <button type="button" class="btn btn-default" id="btnnotinvoicedcount" data-toggle="tooltip"  title="Not Invoiced" data-placement="bottom"><i class="fa fa-file-o " aria-hidden="true"></i></button>
	            <span class="badge badge-notify badge-notinvoiced"></span>                                            
	          </div>      
        </div>
        <div class="textpanel custompanel" >  
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>      
        </div>
        </form>
      </div>
    </div>
     
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="summarydiv"><jsp:include page="tippingsummarygrid.jsp"></jsp:include></div>          
      </div>
    </div> 
    <div><table><tr></tr></table></div>
    <div></div>  
      
     <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="tippingDetailGrid.jsp"></jsp:include></div>
      </div>
    </div> 
     <div id="modaldnoupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">DNO Update<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>       
          		</div>
          		<div class="modal-body">
  					<div class="row">  
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="dno">DNO:</label>     
		        					<input type="text" id="txtdno" name="txtdno" class="form-control input-sm">       
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btndnosave" onclick="funupdate()">Save Changes</button>      
            		
          		</div>
        </div>
      </div>
    </div>
       <div id="modaldetailsupdate" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Tipping Details Update<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>       
          		</div>
          		<div class="modal-body">
  					<div class="row">  
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="dno Date">DNO Date:</label>      
		        					<div id='dodate'></div>      
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
		        				<div class="form-group">
		        					<label for="Contract no">Contract No:</label>         
		        					<div id="Contract" onkeydown="return (event.keyCode!=13);"><jsp:include page="contractnoSearch.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="hidcontrno" name="hidcontrno">               
	                     	    </div>  
		                   </div>  
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">  
		        				<div class="form-group">
		        					<label for="Waste Type">Waste Type:</label>            
		        					<div id="wastetype" onkeydown="return (event.keyCode!=13);"><jsp:include page="wastetypeSearch.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="wasteid" name="wasteid">               
	                     	    </div>  
		                   </div>
		             </div> 
		             <div class="row">         
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">    
		        				<div class="form-group">
		        					<label for="Skip Size">Skip Size:</label>            
		        					<div id="skipsize" onkeydown="return (event.keyCode!=13);"><jsp:include page="skipsizeSearch.jsp"></jsp:include></div>     
	                     	        <input type="hidden" id="skipsizeid" name="skipsizeid">             
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Qty">Qty:</label>       
		        					<input type="text" id="txtqty" name="txtqty" class="form-control input-sm" style="height:27px" placeHolder="Enter Qty" onkeypress="return isNumberKey(event)">         
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="dno">DNO:</label>        
		        					<input type="text" id="txttipdno" name="txttipdno" class="form-control input-sm" style="height:27px" placeHolder="Enter DNO">         
	                     	    </div>  
		                   </div>  
            		</div>
            		 <div class="row">         
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Weight">Weight:</label>       
		        					<input type="text" id="txtweight" name="txtweight" class="form-control input-sm" style="height:27px" placeHolder="Enter Weight" onkeypress="return isNumberKey(event)">         
	                     	    </div>  
		                   </div>  
		                   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">   
		        				<div class="form-group">
		        					<label for="Price">Price:</label>        
		        					<input type="text" id="txtprice" name="txtprice" class="form-control input-sm" style="height:27px;text-align:right" placeHolder="Enter Price" onkeypress="return isNumberKey(event)" onblur="funRoundAmt(this.value,this.id);">            
	                     	    </div>    
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>      
          			<button type="button" class="btn btn-default btn-primary" id="btntipdetsave" onclick="funtippingupdate()">Save Changes</button>      
            		
          		</div>
        </div>
      </div>
    </div>  
 
    <input type="hidden" name="hidid" id="hidid">    
    <input type="hidden" name="hidtipdetsrno" id="hidtipdetsrno">     
    <input type="hidden" name="lblname" id="lblname">  
    <input type="hidden" name="hidinvno" id="hidinvno">
    <input type="hidden" name="hiddno" id="hiddno">            
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
		$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();     
	    $("#detailDiv").prop("hidden", true);
	    document.getElementById("hidid").value=1;
	    $("#btndnoupdate").hide(); 
	    $("#btndetailsupdate").hide(); 
	    $("#dodate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});  
	    $("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		$('#todate').on('change', function (event) {
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
				   if(fromdates>todates){    
					   Swal.fire({  
		        			icon: 'warning',
							title: 'Warning',
							text: 'To Date Less Than From Date'
						});
				        return false;  
				  }   
			 });
		getCountData();
        $('#btnsubmit').click(function(){    
        //  clearfields(); 
            loads(); 
            getCountData();
        });  
        $('#btninvoicedcount').click(function(){    
        	var fromdate= $("#fromdate").val();
     	    var todate= $("#todate").val();
     	     
     	    $("#overlay, #PleaseWait").show();
     	    if(document.getElementById("radiodet").checked){
     	         $('#detailDiv').load('tippingDetailGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=2');  
     	    }else{
     		     $('#summarydiv').load('tippingsummarygrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=2');   
     	    }  
        }); 
        $('#btnnotinvoicedcount').click(function(){    
        	var fromdate= $("#fromdate").val();
     	    var todate= $("#todate").val();
     	     
     	    $("#overlay, #PleaseWait").show();
     	    if(document.getElementById("radiodet").checked){
     	         $('#detailDiv').load('tippingDetailGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=3');  
     	    }else{
     		     $('#summarydiv').load('tippingsummarygrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=3');   
     	    }       
        });    
	    $('#btndnoupdate').click(function(){              
        	var tipdetsrno=$('#hidtipdetsrno').val();  
	    	if(tipdetsrno=="" || tipdetsrno=="0"){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}  
	    	document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val();        
	    	$("#modaldnoupdate").modal('toggle');                      
        });
	    $('#btndetailsupdate').click(function(){              
        	var tipdetsrno=$('#hidtipdetsrno').val(); 
        	var invno=$('#hidinvno').val();  
	    	if(tipdetsrno=="" || tipdetsrno=="0"){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	} 
	    	if(parseInt(invno)>0){  
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'You cannot change tipping details of invoiced contracts!!!'         
				});
	    		return false;
	    	} 
	    	document.getElementById("lblotherdetails2").innerHTML=$("#lblname").val();        
	    	$("#modaldetailsupdate").modal('toggle');                          
        });
     
        $('#btnexcel').click(function(){  
      	  var rad= document.getElementById("hidid").value; 
      	  if(rad==""){
        		rad=1;
          }
		  if (rad==0){
				$("#detailDiv").excelexportjs({ 
	        		containerid: "detailDiv",       
	        		datatype: 'json', 
	        		dataset: null, 
	        		gridId: "jqxdetailgrid",   
	        		columns: getColumns("jqxdetailgrid") ,   
	        		worksheetName:"Tipping Detailed Report"  
	         	 });
	     } else {
	        	$("#summarydiv").excelexportjs({ 
	        		containerid: "summarydiv",       
	        		datatype: 'json', 
	        		dataset: null, 
	        		gridId: "jqxsummarygrid",   
	        		columns: getColumns("jqxsummarygrid") ,   
	        		worksheetName:"Tipping Details  Summary"  
	         	 });
        	}
        	});
    });
      
    Date.prototype.addDays = function(days) {
        var date = new Date(this.valueOf());
        date.setDate(date.getDate() + days);
        return date;
    }
    
    Date.prototype.addDays = function(days) {
        var uptodate = new Uptodate(this.valueOf());
        uptodate.setUptodate(uptodate.getUptodate() + days);
        return uptodate;
    }
    
    function clearfields(){
    	document.getElementById("hidid").value=""; 
    	$("#summarydiv").jqxGrid('clear');
		$("#detailDiv").jqxGrid('clear');
    }
    
    function radioClick(){
    	 if(document.getElementById("radiodet").checked){
    		document.getElementById("hidid").value=0;  
    		  $("#summarydiv").prop("hidden", true);
   			  $("#detailDiv").prop("hidden", false);
   			  $("#summarydiv").jqxGrid('clear');
   			  $("#detailDiv").jqxGrid('clear');
   			  $("#summarydiv").jqxGrid("addrow", null, {});
   			  $("#detailDiv").jqxGrid("addrow", null, {});
   			  $("#btndnoupdate").show();
   			  $("#btndetailsupdate").show(); 
	 }else{
 		 	 document.getElementById("hidid").value=1;
		 	 $("#summarydiv").prop("hidden", false);
 			 $("#detailDiv").prop("hidden", true);
 			 $("#summarydiv").jqxGrid('clear');
 			 $("#detailDiv").jqxGrid('clear');
 			 $("#summarydiv").jqxGrid("addrow", null, {});
 			 $("#detailDiv").jqxGrid("addrow", null, {});
 			 $("#btndnoupdate").hide();
 			 $("#btndetailsupdate").hide();
	 }
     getCountData();
    }
    
    function addGridFilters(filtervalue,datafield){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	var filtercondition = 'equal';
    	var filter1 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	 if(document.getElementById("radiodet").checked){
    		    // add the filters.
    	    	$("#jqxdetailgrid").jqxGrid('addfilter', datafield, filtergroup);
    	    	// apply the filters.
    	    	$("#jqxdetailgrid").jqxGrid('applyfilters');  
    	 }else{
    		    // add the filters.
    	    	$("#jqxsummarygrid").jqxGrid('addfilter', datafield, filtergroup);
    	    	// apply the filters.
    	    	$("#jqxsummarygrid").jqxGrid('applyfilters');    
    	 }
 	}
   
    function loads(){   
	   var fromdate= $("#fromdate").val();
	   var todate= $("#todate").val();
	     
	   $("#overlay, #PleaseWait").show();  
	   if(document.getElementById("radiodet").checked){
		   $('#detailDiv').load('tippingDetailGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');  
	   }else{
		   $('#summarydiv').load('tippingsummarygrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1'); 
	   }
    } 
    function funupdate(){  
		        var tipdetsrno = $("#hidtipdetsrno").val(); 
		        var dno = $("#txtdno").val();
				if(dno==""){  	  
					swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please enter new dno'        
					});
					return false;
				} 
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
					var items=x.responseText.trim();   
					if(parseInt(items)>0){
						swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'DO No already exists. Please use a different number.'        
						});  
				 		$("#txtdno").focus();
				 		return false; 
				 	}
				 	else{
						Swal.fire({
								title: 'Are you sure?',
								text: "Do you want to update?",  
								icon: 'warning',
								showCancelButton: true,
								confirmButtonColor: '#3085d6',
								cancelButtonColor: '#d33',
								confirmButtonText: 'Yes'
							}).then((result) => {  
									if (result.isConfirmed) { 
										 $("#overlay, #PleaseWait").show(); 
										 saveDNO(tipdetsrno,dno);          
									}else{
									} 
							});	   
				 	}
			    }
		   }
		x.open("GET","validateDNO.jsp?dno="+encodeURIComponent(dno)+"&srno="+tipdetsrno,true);                  
		x.send();  
	}
	function saveDNO(tipdetsrno,dno){    
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
				if(parseInt(items)>0){ 
					 $("#overlay, #PleaseWait").hide();
					 loads();
					 $("#txtdno").val(''); 
					 $("#modaldnoupdate").modal('toggle');    
					 swal.fire({  
							icon: 'success',
							title: 'Success',
							text: 'Successfully Updated'  
						});
				}else{
					 $("#overlay, #PleaseWait").hide();
					 $("#modaldnoupdate").modal('toggle');    
					swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Not Updated'        
					});		  
				} 
			}  
		}
	x.open("GET","saveDNO.jsp?tipdetsrno="+tipdetsrno+"&dno="+encodeURIComponent(dno),true);                      
	x.send();     
	}  
    function funtippingupdate(){  
    	var contractno = $('#jqxcontractno').val(); 
    	var contrno = document.getElementById("hidcontrno").value; 
    	var dodate =  $('#dodate').val();
    	var wasteid = $('#wasteid').val();     
    	var wastetype = $('#jqxwastetype').val(); 
    	var skipsizeid = $('#skipsizeid').val();   
    	var skipesize = $('#jqxskipesize').val();
    	var qty = $('#txtqty').val(); 
    	var dno = $('#txttipdno').val();  
    	var tipdetsrno = $('#hidtipdetsrno').val();
    	var weight = $('#txtweight').val(); 
    	var price = $('#txtprice').val();   
    	if(dno==''){    
    		swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please enter DNO.'             
			});	
    		    return false;  
    	 }
    	if(contractno==''){  
    		swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please enter contract no.'           
			});	
    		    return false;  
    	 }
    	if(wastetype==''){  
    		swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please enter waste type.'        
			});	
    		    return false;  
    	 }
    	if(skipesize==''){
    		swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please enter skip size.'        
			});	
    		    return false;    
    	 }
    	if(qty=='' || qty=='0'){ 
    		swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please enter qty.'        
			});	
    		    return false;  
    	 }
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function(){
    	if (x.readyState==4 && x.status==200)
    		{
    		var items=x.responseText.trim().split('####');   
    		if(parseInt(items[0])>0){  
    			swal.fire({  
    			    icon: 'warning',
    				title: 'Warning',
    				text: 'You cannot change tipping details of invoiced contracts!!!'          
    			});	  
    	 		 return false;   
    	 	}else if(parseInt(items[1])>0){  
    	 		swal.fire({  
    			    icon: 'warning',
    				title: 'Warning',
    				text: 'DO No already exists. Please use a different number.'        
    			});	  
    	 		 return false;
    	 	}else{
    	 		Swal.fire({
    				title: 'Are you sure?',
    				text: "Do you want to update?",
    				icon: 'warning',
    				showCancelButton: true,
    				confirmButtonColor: '#3085d6',
    				cancelButtonColor: '#d33',
    				confirmButtonText: 'Yes'
    			}).then((result) => {
    					if (result.isConfirmed) {
    						$("#overlay, #PleaseWait").show();   
    						saveTippingDetails(contrno, dodate, wasteid, wastetype, skipsizeid, skipesize, qty, tipdetsrno, dno, weight, price); 
    					}
    			});  
    	 	}
    	  }
    	}
      x.open("GET","validateTipping.jsp?srno="+tipdetsrno+"&dno="+encodeURIComponent(dno),true);                 
      x.send();
    }  
    function saveTippingDetails(contrno, dodate, wasteid, wastetype, skipsizeid, skipesize, qty, tipdetsrno, dno, weight, price){                
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function(){
    	if (x.readyState==4 && x.status==200){  
    			var items=x.responseText;
    				 if(parseInt(items)>0){ 
	    					 $("#overlay, #PleaseWait").hide();
	    					 $("#modaldetailsupdate").modal('toggle');
	    					 loads();  
	    					 swal.fire({  
	    		    			    icon: 'success',
	    		    				title: 'Success',
	    		    				text: 'Successfully Updated'          
	    		    			});	
    					}else{
    						$("#overlay, #PleaseWait").hide();
    						$("#modaldetailsupdate").modal('toggle');  
    						swal.fire({  
    		    			    icon: 'error',
    		    				title: 'Error',
    		    				text: 'Not Updated'             
    		    			});	
    					} 
    			}  
    	}  
    x.open("GET","saveData.jsp?wastetype="+encodeURIComponent(wastetype)+"&tipdetsrno="+tipdetsrno+"&contrno="+contrno+"&dodate="+dodate+"&wasteid="+wasteid+"&skipesizeid="+skipsizeid+"&qty="+qty+"&skipesize="+encodeURIComponent(skipesize)+"&dno="+encodeURIComponent(dno)+"&weight="+weight+"&price="+price,true);             
    x.send(); 
    }
    function isNumberKey(evt){
	    var charCode = (evt.which) ? evt.which : event.keyCode
	    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
	        return false;
	    return true;
	}
    function funRoundAmt(value,id){
        var res=parseFloat(value).toFixed(window.parent.amtdec.value);
        var res1=(res=='NaN'?"0":res);
        document.getElementById(id).value=res1;  
       }
    function getCountData(){  
    	var fromdate= $("#fromdate").val();
    	var todate= $("#todate").val();
    	var type=0;
    	if(document.getElementById("radiodet").checked){
    		type=1;
    	}else{
    		type=0;
    	}
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {
				var items=x.responseText.trim().split('####');  
				$('.badge-invoiced').text(items[0]);
				$('.badge-notinvoiced').text(items[1]);
			} else {
			}  
		}  
		x.open("GET","getCountData.jsp?todate="+todate+"&fromdate="+fromdate+"&type="+type,true);         
		x.send();
    }
  </script>
  </div>
</body>
</html>
