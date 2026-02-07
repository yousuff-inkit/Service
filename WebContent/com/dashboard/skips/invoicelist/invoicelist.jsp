<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Invoice List</title>             
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
  			<input type="radio"  id="radiosum"  data-toggle="tooltip" name="rdo" title="Summary" onclick="radioClick();" value="radiosum" checked="checked" >Summary  
          	<input type="radio"  id="radiodet" data-toggle="tooltip" name="rdo" title="Detail" onclick="radioClick();" value="radiodet">Detail
        </div>  
		 	   
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel"  data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btnverify" data-toggle="tooltip" title="Verify" data-placement="bottom"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btninvoiceprint" onclick="funPrint();" data-toggle="tooltip" title="Invoice Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btnattachs" onclick="funAttachs(event)" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
         </div>       
        <div class="textpanel custompanel" >  
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>    
        </div>
        </form>
      </div>
    </div>
     
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="summarydiv"><jsp:include page="summarygrid.jsp"></jsp:include></div>          
      </div>
    </div> 
    <div><table><tr></tr></table></div>
    <div></div>  
      
     <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="DetailGrid.jsp"></jsp:include></div>
      </div>
    </div> 
	<div id="modalverify" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Verify<span></span></h4><label for="otherdetails1" id="lblotherdetails1"></label> 
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
    						<label class="control-label col-sm-2" for="route">Remarks :</label>  
    						<div class="col-sm-10 input-container">  
      							  <input type='text' id='verifyremarks' name='verifyremarks' style="width:99%"/>  
    						</div>
  						</div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnverifysave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
  
 
    <input type="hidden" name="hidid" id="hidid">    
    <input type="hidden" name="hiddocno" id="hiddocno">    
    <input type="hidden" name="hidbrhid" id="hidbrhid">  
    <input type="hidden" name="hiddtype" id="hiddtype">
    <input type="hidden" name="hidvocno" id="hidvocno"> 
    <input type="hidden" name="printdocno" id="printdocno">           
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
	  $("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
		  $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
			$('#todate').on('change', function (event) {
				   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				   if(fromdates<todates){
					   Swal.fire({  
		        			icon: 'warning',
							title: 'Warning',
							text: 'To Date Less Than From Date'
						});
				        return false;  
				  }   
			 });
        var hidid=1;
        $('#btnverify').click(function(){   
        	var docno=$("#hiddocno").val();
        	if(docno=="" || docno=="0"){  
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document!!!'  
				});
        		return false;
        	}
        	$("#verifyremarks").val('');
        	$("#modalverify").modal('toggle');         
        }); 
        $('#btnverifysave').click(function(){      
        	funUpdate();  
          });
        $('#btnsubmit').click(function(){    
            //  clearfields(); 
                loads(); 
                $('.textpanel p').text("");   
                document.getElementById("lblotherdetails1").innerHTML="";
                document.getElementById("hiddocno").value="";
                document.getElementById("hidbrhid").value="";  
          }); 
         $('#btnexcel').click(function(){  
      	  var rad= document.getElementById("hidid").value; 
			if (rad==1 || rad=="")
				{
				
				$("#summarydiv").excelexportjs({
					containerid: "summarydiv", 
					datatype: 'json', 
					dataset: null, 
					gridId: "jqxsummarygrid", 
					columns: getColumns("jqxsummarygrid") ,   
					worksheetName:"Invoice List Summary"
					});				
			
	        }
           else
        	{
        	   //alert("detail")
        	   $("#detailDiv").excelexportjs({
					containerid: "detailDiv", 
					datatype: 'json', 
					dataset: null, 
					gridId: "jqxdetailgrid", 
					columns: getColumns("jqxdetailgrid") ,   
					worksheetName:"Invoice List Detailed Report"
					});	
        
        	}
        	}); 
        	
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#jqxclientconfirmGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
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
	   			  $("#btnverify").hide();
	   			  $("#verifyremarks").val('');
		 }
		 else if(document.getElementById("radiosum").checked){
			 	  document.getElementById("hidid").value=1;
			 	  $("#summarydiv").prop("hidden", false);
	 			  $("#detailDiv").prop("hidden", true);
	 			  $("#summarydiv").jqxGrid('clear');
	 			  $("#detailDiv").jqxGrid('clear');
	 			  $("#summarydiv").jqxGrid("addrow", null, {});
	 		 	  $("#detailDiv").jqxGrid("addrow", null, {});
	 		 	  $("#btnverify").show(); 
	 		 	  $("#verifyremarks").val('');  
		 }
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
    	// add the filters.
    	$("#jqxclientconfirmGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxclientconfirmGrid").jqxGrid('applyfilters');    
 	}
   
    function loads(){   
	    var fromdate= $("#fromdate").val();
	    var todate= $("#todate").val();

	    var rad= document.getElementById("hidid").value; 

		 $("#overlay, #PleaseWait").show();
	   if (rad==1|| rad=="")
		  {
		    $('#summarydiv').load('summarygrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');
		  }
	  else 
		  {
		    $('#detailDiv').load('DetailGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&id=1');  

		  }
    } 
    function funPrint() {   
    	if(document.getElementById("radiosum").checked){
    		 $('#jqxsummarygrid').jqxGrid('clearfilters', true);    
 			var selectedrows=$('#jqxsummarygrid').jqxGrid('selectedrowindexes');
 			if(selectedrows.length==0){
 				$.messager.alert('Warning','Please select valid invoice');
 				return false;
 			}
 			document.getElementById("printdocno").value="";
 			var brhid="";
 			for(var i=0;i<selectedrows.length;i++){
 				if(i==0){
 					document.getElementById("printdocno").value+=$('#jqxsummarygrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
 					brhid=$('#jqxsummarygrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');  
 				}
 				else{
 					document.getElementById("printdocno").value+=":"+$('#jqxsummarygrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
 				}
 			}
 	      	     var url=document.URL;  
 	      	     var reurl=url.split("com/");   
 	      	     var win= window.open(reurl[0]+"printmultipageInvoice?docno="+document.getElementById("printdocno").value+"&branch="+brhid+"&header=2","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
 	      		 win.focus();  
    	}else{
    		 $('#jqxdetailgrid').jqxGrid('clearfilters', true);    
 			var selectedrows=$('#jqxdetailgrid').jqxGrid('selectedrowindexes');
 			if(selectedrows.length==0){
 				$.messager.alert('Warning','Please select valid invoice');
 				return false;
 			}
 			document.getElementById("printdocno").value="";
 			var brhid="";
 			for(var i=0;i<selectedrows.length;i++){
 				if(i==0){
 					document.getElementById("printdocno").value+=$('#jqxdetailgrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
 					brhid=$('#jqxsummarygrid').jqxGrid('getcellvalue',selectedrows[i],'brhid'); 
 				}
 				else{
 					document.getElementById("printdocno").value+=":"+$('#jqxdetailgrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
 				}
 			}
 	      	     var url=document.URL;  
 	      	     var reurl=url.split("com/");     
 	      	     var win= window.open(reurl[0]+"printmultipageInvoice?docno="+document.getElementById("printdocno").value+"&branch="+brhid+"&header=2","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
 	      		 win.focus();  
    	}
	  	 
	    } 
    function funUpdate(){     
			 var verifyremarks = $('#verifyremarks').val();  
		     var docno= $('#hiddocno').val(); 
			 if(verifyremarks==''){
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Please enter remarks'    
						});
		  		      return false;
			 } 
			 Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) {
						funverify(docno,verifyremarks);       
					}else{
					}
			});  
	  }  
       function funverify(docno,verifyremarks){   
    		var x=new XMLHttpRequest();
    		x.onreadystatechange=function(){
    		if (x.readyState==4 && x.status==200){  
    				var items=x.responseText;
    					 if(parseInt(items)>0){        	  
    								 swal.fire({  
    										icon: 'success',
    										title: 'Success',
    										text: 'Successfully Updated'    
    									});
    								 $("#modalverify").modal('toggle');
    								 loads(); 
    						}else{
    								 swal.fire({  
    									    icon: 'warning',
    										title: 'Warning',
    										text: 'Not Updated'     
    									});
    						} 
    				}
    		 }
    	    x.open("GET","saveData.jsp?docno="+docno+"&verifyremarks="+encodeURIComponent(verifyremarks),true);        
    	    x.send();     
       }
       function funAttachs(event){                         
			var brchid=$("#hidbrhid").val();        
	   		var docno=$("#hidvocno").val();     
	   		var url=document.URL;
			var reurl=url.split("com/");
	 		if(docno!="" && docno!="0"){                
	   			var frmdet=$("#hiddtype").val();     
	   			var fname="Invoice";
	   		    var  myWindow= window.open(reurl[0]+"com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
	   		}else{   
				swal({
					icon: 'warning',
					title: 'Warning',
					text: 'Select a Document....!'                                     
				});
				return;
			    }               
		   }
  </script>
  </div>
</body>
</html>
