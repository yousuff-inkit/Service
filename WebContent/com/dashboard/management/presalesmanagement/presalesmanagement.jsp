<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Pre Sales Management</title>     
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

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
  }    
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
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
  </style>
</head> 
<body>
  <div class="container-fluid">      
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
      <div class="primarypanel custompanel">
                <label for="pending enquiry">Type</label>   
        </div>
        <div class="primarypanel custompanel">
               <select class="cmbtype form-control input-sm" id="cmbtype" name="cmbtype" onchange="funchange()" style="width:140px;">
  					<option value="enq">Pending Enquiry</option><option value="quot">Pending Quotation</option>   
				</select>
        </div>          
        <div class="primarypanel custompanel">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnenquiryfollowup" data-toggle="tooltip" title="Followup" data-placement="bottom"><i class="fa fa-th-list " aria-hidden="true"></i></button>
        </div> 
        <div class="textpanel custompanel" >
			<label for="divid" id="selecteddiv" style="font-size:75%;padding-top:9px;padding-left:6px;"></label>  
        </div>
        <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>  
        </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="presalesdiv"><jsp:include page="pendingenquiryGrid.jsp"></jsp:include></div>     
      </div>
    </div>  
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="prequotdiv"><jsp:include page="pendingquotationGrid.jsp"></jsp:include></div>     
      </div>
    </div> 
      <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="flwupdiv"><jsp:include page="followupGrid.jsp"></jsp:include></div>         
      </div>
    </div>   
	<div id="modalfollowup" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-xxxl">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Follow-Up<span></span></h4>      
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
						 <div class="form-group">
							 <label class="control-label col-sm-3" for="cmbenqprocess">Process</label>  
							 <div class="col-sm-9 input-container">  
							 <select name="cmbprocess" id="cmbprocess" style="width:52%;" class="form-control input-sm">  
							 <option value="1">Follow-Up</option><option value="2">Drop</option></select>    
							 </div>  
						 </div>  
						 <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Date</label>   
						      <div class="col-sm-9 input-container">
						     <div id="enqflwupdate"></div>
						     </div>
						  </div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="Remarks">Remarks</label>      
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="flwupremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="flwupremarks"  class="form-control input-sm"></textarea>
  						</div>
  						</div>  
  						</div>  
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnenqflwpsave">Save Changes</button>    
          		</div>
          		</div>
        </div>
      </div>	    
  <input type="hidden" id="enqdocno" name="enqdocno" >
    <input type="hidden" id="enqbrhid" name="enqbrhid" >
      <input type="hidden" id="qotdocno" name="qotdocno" >
        <input type="hidden" id="qotbrhid" name="qotbrhid" >   
  
  
  </div>
           
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip(); 
        funchange()
        $("#enqflwupdate").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
        $('#btnsubmit').click(function(){    
            loads(); 
        });  
        $('#btnexcel').click(function(){    
        	funExportBtn(); 
        });
        $('#btnenqflwpsave').click(function(){    
            funSave();   
        });
    });    
        function funExportBtn(){
        	var type=$("#cmbtype").val();
   		  	if (type=="enq") {
   			 	$("#presalesdiv").excelexportjs({
	        		containerid: "presalesdiv",       
	        		datatype: 'json', 
	        		dataset: null, 
	        		gridId: "jqxEnquiryGrid", 
	        		columns: getColumns("jqxEnquiryGrid") , 
	        		worksheetName:"Presales Management"
   				 });
   		    } else if (type=="quot") {
   				$("#prequotdiv").excelexportjs({
   					 containerid: "prequotdiv",
   					 datatype: 'json',
   					 dataset: null,
   					 gridId: "jqxquotationGrid",
   					 columns: getColumns("jqxquotationGrid") ,
   					 worksheetName:"Pending Quotation"
   				 });  
   			}else{}
   		
   	 }
        
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var type=$("#cmbtype").val();
    	if(type=="enq"){
	    	 $('#presalesdiv').load('pendingenquiryGrid.jsp?id=1');          
    	}else if(type=="quot"){
    		 $('#prequotdiv').load('pendingquotationGrid.jsp?id=1'); 
    	}
    }   
    
    function  funchange(){
    	var type=$("#cmbtype").val();
    	if(type=="enq"){
    		$("#prequotdiv").hide();
     		$("#presalesdiv").show();
    	}else if(type=="quot"){
    		$("#presalesdiv").hide();
     		$("#prequotdiv").show();
    	}
    	$('.textpanel p').text('');
    }
	
    $('#btnenquiryfollowup').click(function(){   
    	var type=$("#cmbtype").val();
		if(type=="enq"){
			    var enqdocno=$('#enqdocno').val();  
		    	if(enqdocno==""){
		    		Swal.fire({
		    			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
		    		return false;
			    }  
		       $('#modalfollowup').modal('show');         
		}else if(type=="quot"){
			var qotdocno=$('#qotdocno').val();  
	    	if(qotdocno==""){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
	    		return false;
		    }  
	       $('#modalfollowup').modal('show');    
		}else{}      
    });
	function funSave(){
		var brhid=0, docno=0;
		var dtype = ""; 
		var type=$("#cmbtype").val();
    	if(type=="enq"){
    		  brhid = $('#enqbrhid').val();      
    		  docno = $('#enqdocno').val(); 
    		  dtype = "ENQ"; 
    	}else if(type=="quot"){
    		  brhid = $('#qotbrhid').val();         
   		      docno = $('#qotdocno').val();  
   		      dtype = "QOT"; 
    	}else{}
    	
		var date =  $('#enqflwupdate').val();
		var remarks = $('#flwupremarks').val();
		var enqprocess = $('#cmbprocess').val(); 
		if(remarks==''){
			
			 swal.fire({
				    icon: 'warning',
					title: 'Warning',
					text: 'Please Enter Remarks.'
				});
  		      return false;
		 }
		 
		 Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to save changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
		}).then((result) => {
				if (result.isConfirmed) {
					$('.load-wrapp').show();
					saveEnqflwp(date,docno,dtype,remarks,brhid,enqprocess);       
				}
		});
	}
    function saveEnqflwp(date,docno,rdtype,remarks,brhid,enqprocess){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText.trim();
				//alert(items+"=")
					 if(parseInt(items)>0){  	  
								 swal.fire({  
									    icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $('#enqflwupdate').val(new Date()); 
								 $('#flwupremarks').val(''); 
								 $('#modalfollowup').modal('hide');  
                                 $("#flwupdiv").load("followupGrid.jsp?docno="+docno+"&reftype="+rdtype)  
								 
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'    
									});
						} 
				}
		}  
	x.open("GET","saveData.jsp?enqprocess="+enqprocess+"&date="+date+"&rdtype="+rdtype+"&docno="+docno+"&brhid="+brhid+"&remarks="+encodeURIComponent(remarks),true);       
	x.send();
	}
  </script>
</body>
</html>
