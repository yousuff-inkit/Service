<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Warehouse Management</title>         
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>     
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">     
  <style type="text/css">   
     
  .btn-group>.btn:first-child:not(:last-child):not(.dropdown-toggle) {     
    border-radius: 30px !important;       
} 
  .btn:focus,.btn:active {
   outline: none !important;
   box-shadow: none;
   }
   .modalStyle {      
    background-color:#33b5e5; `
    padding: 10px; 
   }
   .borderStyle{  
    margin-bottom: 0;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    border: none;
    line-height: 1.42857143;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
   box-shadow: 1px 2px 7px 3px #d4cece;                          
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }   
  .iconStyle{
	color: #000000 !important;  
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;   
  }
  .btnStyle{  
  	display: inline-block;   
    margin-bottom: 0;
    font-weight: 400;
    margin-right:5px;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    background-image: none;
    border: none;
    padding: 3px 8px;  
    font-size: 14px;
    line-height: 1.42857143;
    border-radius: 30px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);                     
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
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
      margin-top: 0px; 
      padding-top: 10px;
      padding-bottom: 0px;
      border-radius: 8px;
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      /* background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%); */
      background-color:#FEFE56;   
      color: black;
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
    #border1 {
	  border-radius: 25px;
	  padding: 8px;
	  -moz-box-shadow:    inset 0 0 3px #000000;
      -webkit-box-shadow: inset 0 0 3px #000000;
      box-shadow:         inset 0 0 3px #000000;   
}
  </style>
</head>       
<body onload="getBin();">                        
  <div class="container-fluid">    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
         <div class="primarypanel custompanel" style="margin-left:5px;">
	          <div id="border1">    
		           <input type="radio" id="rdiofloor" name="loadtype" onchange="funchangeloadtype();"/>&nbsp;<label for="floor" class="branch">Floor</label>
		           &nbsp;&nbsp;&nbsp;<input type="radio" id="rdioproduct" name="loadtype" onchange="funchangeloadtype();"/>&nbsp;<label for="product" class="branch">Product</label>  
	           </div>  
         </div>
         <div class="primarypanel custompanel" style="margin-left:5px;">    
             <div id="border1">
                <button type="button" class="btn btn-default btnStyle" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
	          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
            </div>                               
	  	 </div> 
       <div class="otherpanel custompanel"  style="margin-left:5px;">    
           <div id="border1">    
               <button type="button" class="btn btn-default btnStyle" id="btnstoringslip" data-toggle="tooltip" title="Storing Slip" data-placement="bottom"><i class="fa fa-database " aria-hidden="true"></i></button> 
               <button type="button" class="btn btn-default btnStyle" id="btnpickingslip" data-toggle="tooltip" title="Picking Slip" data-placement="bottom"><i class="fa fa-file-text " aria-hidden="true"></i></button>       
               <button type="button" class="btn btn-default btnStyle" id="btntransferslip" data-toggle="tooltip" title="Transfer Slip" data-placement="bottom"><i class="fa fa-share-square " aria-hidden="true"></i></button>             
	         <!--   <button type="button" class="btn btn-default btnStyle" id="btncomment" data-toggle="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button> -->
           </div>
        </div>             
        <div class="textpanel custompanel" style="margin-left:5px;padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;top:25px;position:absolute;">          
			<p  style="font-size:0.9em;float:left;" id="selectedrow">&nbsp;</p>&nbsp;&nbsp;&nbsp;&nbsp;   
        </div>  
      </div>
    </div>     
    <br/>  
    <div class="row" id="floortype">        
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
        <div id="whmfloordiv" class="borderStyle"><jsp:include page="whmFloorGrid.jsp"></jsp:include></div>               
      </div>                                  
    </div>
     <div class="row" id="producttype">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
        <div id="whmproductdiv" class="borderStyle"><jsp:include page="whmProductGrid.jsp"></jsp:include></div>               
      </div>                                  
    </div>
    <!-- Comments Modal-->     
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Comments</h4>
          </div>
          <div class="modal-body">
            <div class="comments-outer-container container-fluid">
              <div class="comments-container">                
              </div>
              <div class="create-msg-container">
                <!-- <div class="container-fluid"> -->
                  <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
                      <div class="input-group">
                        <input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                        <div class="input-group-btn">
                          <button type="button" id="btncommentsend" class="btn btn-default">
                            <i class="fa fa-paper-plane"></i>
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                <!-- </div> -->
              </div>
            </div>
          </div>  
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
        </div>
      </div>
    </div>  
       <!-- Comments Modal--> 
                
    <!-- storing slip modal-->              
    <div id="modalstoringslip" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Storing Slip</h4>                
             <p id="lblname" style="text-align:center;"></p>             
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">
               <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
			        <div id="storingdiv" class="borderStyle"><jsp:include page="storingGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div>   
              <div class="row rowgap">   
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-10">       
	                <div class="form-group">
						<label>Product</label>           
						<input type="text" id="txtproduct1" title="" readonly class="form-control input-sm"/>            
					</div>       
				 </div>     
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">                    
	                <div class="form-group">  
						<label>Qty</label>        
						<input type="text" id="txtqty1" class="form-control input-sm">                      
					</div>       
				 </div>
              </div>
              <div class="row rowgap">  
		             <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">          
			                <div class="form-group">
								<label>Bin</label>           
								<select class="form-control input-sm" id="cmbbin" name="cmbbin" style="width:200px;" value='<s:property value="cmbbin"/>'>
		  							<option></option>   
								</select>           
							</div>         
					</div>
	            </div>       
            </div>   
            </div>  
            <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">             
						<button type="button" class="btn btn-default btnStyle" id="btnupdateStoringslip" title="Save" data-toggle="tooltip" data-placement="bottom" onclick="funstockslip();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div>   
      <!-- picking slip modal-->              
    <div id="modalpickingslip" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
             <h4 class="modal-title" style="text-align:center">Picking Slip</h4>                     
             <p id="lblname" style="text-align:center;"></p>             
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">
               <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
			        <div id="pickingdiv" class="borderStyle"><jsp:include page="pickingGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div> 
			     <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">           
			        <div id="pickingsubdiv" class="borderStyle"><jsp:include page="pickingSubGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div>   
            </div>   
            </div>  
            <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">             
						<button type="button" class="btn btn-default btnStyle" id="btnupdatePickingslip" title="Save" data-toggle="tooltip" data-placement="bottom" onclick="funpickslip();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div> 
         <!-- transfer slip modal-->              
    <div id="modaltransferslip" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Transfer Slip</h4>                
             <p id="lblname" style="text-align:center;"></p>             
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">
               <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
			        <div id="transferdiv" class="borderStyle"><jsp:include page="transferGrid.jsp"></jsp:include></div>                 
			      </div>                                  
			    </div>   
			  <div class="row rowgap">   
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">       
	                <div class="form-group">
						<label>Current Bin</label>           
						<input type="text" id="txtbin"  title="" readonly class="form-control input-sm"/>          
					</div>       
				 </div>
                <div class="row rowgap">   
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-7">         
	                <div class="form-group">
						<label>Product</label>           
						<input type="text" id="txtproduct3"  title="" readonly class="form-control input-sm"/>          
					</div>       
				 </div>     
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">                    
	                <div class="form-group">  
						<label>Qty</label>        
						<input type="text" id="txtqty3" class="form-control input-sm">                    
					</div>       
				 </div>      
              </div> 
              <div class="row rowgap">
		             <div class="col-xs-12 col-sm-6 col-md-4 col-lg-6">          
			                <div class="form-group">
								<label>New Bin</label>               
								<select class="form-control input-sm" id="cmbbin3" name="cmbbin3"  style="width: 50%" value='<s:property value="cmbbin3"/>'>    
		  							<option></option>   
								</select>           
							</div>         
					</div>
	            </div>      
            </div>   
            </div>  
            <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">             
						<button type="button" class="btn btn-default btnStyle" id="btnupdateTransferslip" title="Save" data-toggle="tooltip" data-placement="bottom" onclick="funtransferslip();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div>             
    </div> 
    <!-- Bin content details modal-->              
    <div id="modalbindetails" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <!-- <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center" id="bindetails"></h4>                     
             <p id="lblname" style="text-align:center;"></p>             
          </div> -->                               
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">
              <div class="row rowgap">        
			      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">          
			        <div id="bindiv" class="borderStyle"><jsp:include page="bindetailsGrid.jsp"></jsp:include></div>                   
			      </div>                                  
			  </div> 
            </div>   
            </div>  
            <!-- <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">             
						<button type="button" class="btn btn-default btnStyle" id="btnupdateStoringslip" title="Save" data-toggle="tooltip" data-placement="bottom" onclick="funstockslip();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div> -->
          </div>  
        </div>    
      </div> .
   </div> .  
  <input type="hidden" name="hidcomments" id="hidcomments">     
  <input type="hidden" name="hidpsrno" id="hidpsrno">    
  <input type="hidden" name="hidprodoc" id="hidprodoc">   
  <input type="hidden" name="hidrdocno" id="hidrdocno">  
  <input type="hidden" name="hidrdtype" id="hidrdtype">  
  <input type="hidden" name="hidrbrhid" id="hidrbrhid">  
  <input type="hidden" name="hidbalqty" id="hidbalqty">  
  <input type="hidden" name="hidoldbin" id="hidoldbin">           
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>         
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){        
    	 $('[data-toggle="tooltip"]').tooltip();      
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    	 //$("#date").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"}); 
    	 //$("#podate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"}); 
         document.getElementById("rdiofloor").checked=true;
         $("#producttype").hide();
    	 $("#cmbbin").select2({
		    placeholder: "Select a Bin",
		    allowClear: true
		});
    	 $("#cmbbin2").select2({
 		    placeholder: "Select a Bin",
 		    allowClear: true
 		});
    	 $("#cmbbin3").select2({
  		    placeholder: "Select a Bin",
  		    allowClear: true 
  		});
    	 $('#txtproduct1').keyup(function(){
           	$('#txtproduct1').attr('title',$('#txtproduct1').val());  
         })
          $('#txtproduct2').keyup(function(){
           	$('#txtproduct2').attr('title',$('#txtproduct2').val());  
         })
    	 $('#btnstoringslip').click(function() { 
    		 $('#storingdiv').load("storingGrid.jsp?id="+1);   
             $('#modalstoringslip').modal('toggle');       
         });
    	 $('#btnpickingslip').click(function() {   
    		 $('#pickingdiv').load("pickingGrid.jsp?id="+1);   
             $('#modalpickingslip').modal('toggle');         
         });
    	 $('#btntransferslip').click(function() { 
    		 $('#transferdiv').load("transferGrid.jsp?id="+1);   
             $('#modaltransferslip').modal('toggle');          
         });  
        
        $('#btnsubmit').click(function(){
        	$("#overlay, #PleaseWait").show();
        	funload();
            $('.textpanel p').text("");
        });          
        $('#btncomment').click(function(){    
	        var actdocno=$('#hiddocno').val();
	    	if(actdocno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	      	getComments(); 
	      	$('#modalcomments').modal('toggle');          
        }); 
        $('#btnaccountstmt').click(function(){       
	        var docno=$('#hidrntldocno').val();
	    	if(docno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	    	getstmtprint(docno);                  
        }); 
        $('#btnexcel').click(function(){ 
        	if(document.getElementById("rdiofloor").checked){  
        		$("#whmfloordiv").excelexportjs({
     				containerid: "whmfloordiv",          
     				datatype: 'json',
     				dataset: null,
     				gridId: "jqxwhmFloorGrid",
     				columns: getColumns("jqxwhmFloorGrid") ,      
     				worksheetName:"Warehouse Management"        
     			});
        	}else{
        		$("#whmproductdiv").excelexportjs({   
     				containerid: "whmproductdiv",          
     				datatype: 'json',
     				dataset: null,
     				gridId: "jqxwhmProductGrid",
     				columns: getColumns("jqxwhmProductGrid") ,         
     				worksheetName:"Warehouse Management"          
     			});
        	}
        });
        $('#btncommentsend').click(function(){
        	 var actdocno=$('#hiddocno').val();
        	var txtcomment=$('#txtcomment').val();  
        	if(actdocno==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	saveComment();
        });
        
       $('.warningpanel div button').click(function(){
        	var gridrows=$('#jqxRentalGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');  
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{    
        		$('#jqxRentalGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}   
        });  
    });
   function funRoundAmt(value,id){
	  var res=parseFloat(value).toFixed("2");                    
	  var res1=(res=='NaN'?"0":res);
	  document.getElementById(id).value=res1;  
	 }
   function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){   
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	//var filtercondition = 'contains';
	    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
	
	    	filtergroup.addfilter(filter_or_operator, filter1);
	    	//filtergroup.addfilter(filter_or_operator, filter2);
	    	// add the filters.
	    	$("#jqxRentalGrid").jqxGrid('addfilter', datafield, filtergroup);
	    	// apply the filters.
	    	$("#jqxRentalGrid").jqxGrid('applyfilters');
    	
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var docno=$('#hiddocno').val();
    	var srno=$('#hidsrno').val();
    	$('#hidcomments').val($('#txtcomment').val());
   	    if (($(hidcomments).val()).includes('$')) { $(hidcomments).val($(hidcomments).val().replace(/$/g, ''));};if (($(hidcomments).val()).includes('%')) { $(hidcomments).val($(hidcomments).val().replace(/%/g, ''));};
   	    if (($(hidcomments).val()).includes('^')) { $(hidcomments).val($(hidcomments).val().replace(/^/g, ''));};if (($(hidcomments).val()).includes('`')) { $(hidcomments).val($(hidcomments).val().replace(/`/g, ''));};
   	    if (($(hidcomments).val()).includes('~')) { $(hidcomments).val($(hidcomments).val().replace(/~/g, ''));};if ($(hidcomments).val().indexOf('\'')  >= 0 ) { $(hidcomments).val($(hidcomments).val().replace(/'/g, ''));};
   	    if (($(hidcomments).val()).includes(',')) { $(hidcomments).val($(hidcomments).val().replace(/,/g, ''));}
   	    if ($(hidcomments).val().indexOf('"') >= 0) { $(hidcomments).val($(hidcomments).val().replace(/["']/g, ''));};
   	    if (($(hidcomments).val()).match(/\\/g)) { $(hidcomments).val($(hidcomments).val().replace(/\\/g, ''));}; 
    
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				$('#txtcomment').val('');
				getComments(); 		
			}
			else
			{
			}   
		}
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&docno="+docno+"&srno="+srno,true);  
		x.send();
    }
    function getComments(){
    	var docno=$('#hiddocno').val();
    	var srno=$('#hidsrno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split(",");
				var str='';
				if(items!=''){ 
				for(var i=0;i<items.length;i++){
					str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
				}
				$('.comments-container').html($.parseHTML(str));		
				}else{}	
			}   
			else
			{
			}
		}
		x.open("GET","getComments.jsp?docno="+docno+"&srno="+srno,true);         
		x.send();      
    }
    
   function funload(){
	   if(document.getElementById("rdiofloor").checked){
		   $('#whmfloordiv').load("whmFloorGrid.jsp?id="+1); 
	   }else{
		   $('#whmproductdiv').load("whmProductGrid.jsp?id="+1);    
	   }
   }
   function getBin(){     
		 var x=new XMLHttpRequest();
		 x.onreadystatechange=function(){  
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');
					brchIdItems = items[0].split(",");  
					brchItems = items[1].split(",");
					var optionsbrch = '<option value="">--Select--</option>';
					for (var i = 0; i < brchItems.length; i++) {
						optionsbrch += '<option value="' + brchIdItems[i] + '">'
								+ brchItems[i] + '</option>';    
					}
					$("select#cmbbin").html(optionsbrch); 
					$("select#cmbbin2").html(optionsbrch); 
					$("select#cmbbin3").html(optionsbrch);   
				} 
			else    
			{       
			}                
		}
		x.open("GET","getBin.jsp",true);                     
		x.send();  
	 }
   function funstockslip(){                 
			    var qty=$('#txtqty1').val();      
				var psrno=$('#hidpsrno').val();               
				var prodoc=$('#hidprodoc').val();   
				var binid=$('#cmbbin').val();    
				var rdocno=$('#hidrdocno').val();       
				var rdtype=$('#hidrdtype').val();   
				var rbrhid=$('#hidrbrhid').val();   
				var balqty=$('#hidbalqty').val();   
				if(prodoc==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select a product '    
					});
					 return 0;
				 } 
				if(parseInt(qty)>parseInt(balqty)){     
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be less than or equals to '+balqty    
					});
					 return 0;
				 } 
				if(parseInt(qty)<=0){     
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be greater than 0'   
					});
					 return 0;
				 } 
				if(binid==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select a bin '    
					});
					 return 0;
				 }
			   $.messager.confirm('Message', 'Do you want to save changes?', function(r){             
					     	if(r==false)   
					     	  {
					     		return false; 
					     	  }  
					     	else {
					     		$("#overlay, #PleaseWait").show();    
					     		stockslip(psrno,prodoc,qty,binid,rdocno,rdtype,rbrhid);                           
					     	}        
					 });              
			}
	     function stockslip(psrno,prodoc,qty,binid,rdocno,rdtype,rbrhid){                  
	          var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){     
		      		var items=x.responseText.trim();          
		      		if(parseInt(items)>0){    
						swal({   
								type: 'success',
								title: 'Message',
								text: ' Successfully Saved '                          
							});    
						 $("#overlay, #PleaseWait").hide(); 
						 $('#txtqty1').val('');
						 $('#txtproduct1').val('');  
						 $('#storingdiv').load("storingGrid.jsp?id="+1);   
						 //$('#modalstoringslip').modal('toggle');           
						}else{ 
							swal({
								type: 'error',
								title: 'Error',    
								text: 'Not Saved'                                                
							}); 
						$("#overlay, #PleaseWait").hide();                           
						} 
		      	 }
		      }     
		      x.open("GET","stockslipSave.jsp?psrno="+psrno+'&prodoc='+prodoc+'&qty='+qty+'&binid='+binid+'&rdocno='+rdocno+'&rdtype='+rdtype+'&rbrhid='+rbrhid,true);                                                                                                 
		      x.send();      
	     }   
	   
	     function funpickslip(){                 
				var psrno=$('#hidpsrno').val();               
				var prodoc=$('#hidprodoc').val();   
				var rdocno=$('#hidrdocno').val();       
				var rdtype=$('#hidrdtype').val();   
				var rbrhid=$('#hidrbrhid').val();   
				var balqty=$('#hidbalqty').val();     
				if(prodoc==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select a product '    
					});
					 return 0;
				 } 
				/* if(parseInt(qty)>parseInt(balqty)){     
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be less than or equals to '+balqty    
					});
					 return 0;
				 } 
				if(parseInt(qty)<=0){     
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be greater than 0'   
					});
					 return 0;
				 }  */ 
				var val=0;
				var valqty=0.0;
				var gridarray=new Array();
				var rows=$('#jqxpickingSubGrid').jqxGrid('getrows');
				for(var i=0;i<rows.length;i++){
				    var chk=$('#jqxpickingSubGrid').jqxGrid('getcellvalue',i,'bin');
				    var chk2=$('#jqxpickingSubGrid').jqxGrid('getcellvalue',i,'qty'); 
				    var chk3=$('#jqxpickingSubGrid').jqxGrid('getcellvalue',i,'binqty');   
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						if(typeof(chk2) != "undefined" && typeof(chk2) != "NaN" && chk2 != "" && chk2 != "0"){  
							 gridarray.push(rows[i].binid+":: "+rows[i].qty); 
							 if(parseInt(chk2)>parseInt(chk3)){   
								 val=1;
							 }
							 valqty=valqty+parseFloat(chk2);    
						} 	
					}
				} 
				if(valqty>parseFloat(balqty)){       
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be less than or equals to '+balqty    
					});
					 return 0;
				 }
				if(val==1){       
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be less than or equals to bin qty'      
					});
					 return 0;
				 }
			   $.messager.confirm('Message', 'Do you want to save changes?', function(r){             
					     	if(r==false)   
					     	  {
					     		return false; 
					     	  }  
					     	else {
					     		$("#overlay, #PleaseWait").show();    
					     		pickslip(psrno,prodoc,rdocno,rdtype,rbrhid,gridarray);                           
					     	}        
					 });              
			}
	     function pickslip(psrno,prodoc,rdocno,rdtype,rbrhid,gridarray){                     
	          var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){     
		      		var items=x.responseText.trim();          
		      		if(parseInt(items)>0){    
						swal({   
								type: 'success',
								title: 'Message',
								text: ' Successfully Saved '                          
							});    
						 $("#overlay, #PleaseWait").hide(); 
						 $('#pickingdiv').load("pickingGrid.jsp?id="+1); 
						 $('#jqxpickingSubGrid').jqxGrid('clear'); 
						 //$('#modalstoringslip').modal('toggle');           
						}else{ 
							swal({
								type: 'error',
								title: 'Error',    
								text: 'Not Saved'                                                
							}); 
						$("#overlay, #PleaseWait").hide();                            
						} 
		      	 }
		      }     
		      x.open("GET","pickslipSave.jsp?psrno="+psrno+'&prodoc='+prodoc+'&gridarray='+encodeURIComponent(gridarray)+'&rdocno='+rdocno+'&rdtype='+rdtype+'&rbrhid='+rbrhid,true);                                                                                                 
		      x.send();        
	     } 
	     
	     function funtransferslip(){                 
			    var qty=$('#txtqty3').val();         
				var psrno=$('#hidpsrno').val();               
				var prodoc=$('#hidprodoc').val();   
				var binid=$('#cmbbin3').val();    
				var rdocno=$('#hidrdocno').val();       
				var rdtype=$('#hidrdtype').val();   
				var rbrhid=$('#hidrbrhid').val();   
				var balqty=$('#hidbalqty').val();   
				var oldbinid=$('#hidoldbin').val();    
				if(prodoc==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select a product '    
					});
					 return 0;
				 } 
				if(parseInt(qty)>parseInt(balqty)){     
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be less than or equals to '+balqty    
					});
					 return 0;
				 }
				if(parseInt(qty)<=0){     
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Qty should be greater than 0'   
					});
					 return 0;
				 } 
				if(binid==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select a bin '    
					});
					 return 0;
				 }
			   $.messager.confirm('Message', 'Do you want to save changes?', function(r){             
					     	if(r==false)   
					     	  {
					     		return false; 
					     	  }  
					     	else {
					     		$("#overlay, #PleaseWait").show();    
					     		transferslip(psrno,prodoc,qty,binid,rdocno,rdtype,rbrhid,oldbinid);                             
					     	}        
					 });              
			}
	     function transferslip(psrno,prodoc,qty,binid,rdocno,rdtype,rbrhid,oldbinid){                        
	          var x=new XMLHttpRequest();
		      x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){     
		      		var items=x.responseText.trim();          
		      		if(parseInt(items)>0){    
						swal({   
								type: 'success',
								title: 'Message',
								text: ' Successfully Saved '                          
							});    
						 $("#overlay, #PleaseWait").hide(); 
						 $('#txtqty3').val('');
						 $('#txtproduct3').val('');    
						 $('#transferdiv').load("transferGrid.jsp?id="+1);        
						 //$('#modalstoringslip').modal('toggle');           
						}else{ 
							swal({
								type: 'error',
								title: 'Error',    
								text: 'Not Saved'                                                
							}); 
						$("#overlay, #PleaseWait").hide();                              
						} 
		      	 }
		      }     
		      x.open("GET","transferslipSave.jsp?psrno="+psrno+'&prodoc='+prodoc+'&qty='+qty+'&newbinid='+binid+'&rdocno='+rdocno+'&rdtype='+rdtype+'&rbrhid='+rbrhid+'&oldbinid='+oldbinid,true);                                                                                                 
		      x.send();        
	     }
	     function funchangeloadtype(){
	    	 if(document.getElementById("rdiofloor").checked){   
	    		  $("#producttype").hide();
	    		  $("#floortype").show(); 
	    	 }else{
	    		  $("#floortype").hide(); 
	    		  $("#producttype").show();  
	    	 }
	     }
	     function getBindetails(bindata){
	    	 var binid=bindata.split('##');
	    	 $('#bindiv').load("bindetailsGrid.jsp?binid="+encodeURIComponent(binid[0])+"&id="+1);          
			 $('#modalbindetails').modal('toggle');         
	     }  
  </script>
</body>
</html>
