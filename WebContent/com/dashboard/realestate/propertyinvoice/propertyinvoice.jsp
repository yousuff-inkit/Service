<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Property Invoice</title>         
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
<body>                        
  <div class="container-fluid">    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
         <div class="primarypanel custompanel" style="margin-left:5px;">  
             <div id="border1">
                <button type="button" class="btn btn-default btnStyle" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
	          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
            </div>                               
	  	 </div> 
        <div class="otherpanel custompanel"  style="margin-left:5px;">    
           <div id="border1">  
               <button type="button" class="btn btn-default btnStyle" id="btninvoice" data-toggle="tooltip" title="Invoice" data-placement="bottom"><i class="fa fa-file-text " aria-hidden="true"></i></button>       
	           <button type="button" class="btn btn-default btnStyle" id="btnaccountstmt"  data-toggle="tooltip" title="Account Statement" data-placement="bottom"><i class="fa fa-print" aria-hidden="true"></i></button>
	           <button type="button" class="btn btn-default btnStyle" id="btncomment" data-toggle="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
           </div>
        </div>           
        <div class="textpanel custompanel" style="margin-left:5px;padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;top:25px;position:absolute;">        
			<p  style="font-size:0.9em;float:left;" id="selectedrow">&nbsp;</p>&nbsp;&nbsp;&nbsp;&nbsp;   
        </div>  
      </div>
    </div>     
    <br/>  
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="rntldiv" class="borderStyle"><jsp:include page="rentalGrid.jsp"></jsp:include></div>               
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
                
    <!-- Invoice modal-->            
    <div id="modalinvoice" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-lg">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Invoice</h4>              
             <p id="lblname" style="text-align:center;"></p>             
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid">   
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">            
	                <div class="form-group">
						<label>Date</label>
						<div id="date" ></div>          
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
	                <div class="form-group">
						<label>PO No</label>           
						<input type="text" id="txtpono" class="form-control input-sm"/>       
					</div>       
				 </div>     
				  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">            
	                <div class="form-group">
						<label>PO Date</label>
						<div id="podate" ></div>         
					</div>       
				 </div> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">                  
	                <div class="form-group">
						<label>Total</label>        
						<input type="text" id="txttotal" class="form-control input-sm text-right" readonly onblur="funRoundAmt(value,id);">                
					</div>       
				 </div>      
              </div>       
              <div class="row rowgap"> 
				 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">       
	                <div class="form-group">
						<label>Remarks</label>                    
						<input id="txtremarks" class="form-control input-sm">        
					</div>       
				 </div>  
              </div>           
            	</div>   
            </div>  
            <div class="modal-footer"> 
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnupdate" title="Create" data-placement="bottom" onclick="funinvoice();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div> 
            </div>
          </div>  
        </div>    
      </div>               
 </div> .
  <input type="hidden" name="hidlblname" id="hidlblname">     
  <input type="hidden" name="hidcomments" id="hidcomments">        
  <input type="hidden" name="hiddocno" id="hiddocno"> 
  <input type="hidden" name="hidcldocno" id="hidcldocno">                                
  <input type="hidden" name="hidrntldocno" id="hidrntldocno"> 
  <input type="hidden" name="hidsrno" id="hidsrno">  
  <input type="hidden" name="hidvocno" id="hidvocno">  
  <input type="hidden" name="hidrowno" id="hidrowno">    
  <input type="hidden" name="hidbrhid" id="hidbrhid"> 
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>         
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){        
    	 $('[data-toggle="tooltip"]').tooltip();      
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    	 $("#date").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"}); 
    	 $("#podate").jqxDateTimeInput({ width: '109px', height: '25px',formatString:"dd.MM.yyyy"}); 
         $('#btninvoice').click(function() {            
        	  var docno = $('#hiddocno').val();
                if (docno == "") {    
                swal({
                    type: 'warning',
                    title: 'Warning',
                    text: 'Please select a document'   
                });
                return false;
               }  
             $('#txtremarks').val("");          
			 $('#date').val(new Date());   
			 $('#podate').val(new Date());       
			 $('#txtpono').val("");               
             document.getElementById("lblname").innerHTML=$("#hidlblname").val();             
             $('#modalinvoice').modal('toggle');       
         });
        
        $('#btnsubmit').click(function(){
        	$("#overlay, #PleaseWait").show();
        	funload();
            $('.textpanel p').text("");
            $('#hiddocno').val('');  
            $('#hidcldocno').val(''); 
            $('#hidbrhid').val('');  
            $('#hidvocno').val('');     
            $('#hidlblname').val(''); 
            $('#hidsrno').val(''); 
            $('#txttotal').val("");
            $('#hidrowno').val("");
            $('#hidrntldocno').val("");    
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
        	 $("#rntldiv").excelexportjs({
 				containerid: "rntldiv",        
 				datatype: 'json',
 				dataset: null,
 				gridId: "jqxRentalGrid",
 				columns: getColumns("jqxRentalGrid") ,   
 				worksheetName:"Property Invoice"      
 			});   
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
       $('#rntldiv').load("rentalGrid.jsp?id="+1);                                            
   }
   function funinvoice(){                 
			    var remarks=$('#txtremarks').val();      
			    var date=$('#date').jqxDateTimeInput('val');   
			    var podate=$('#podate').jqxDateTimeInput('val');
				var pono=$('#txtpono').val();               
				var total=$('#txttotal').val();
				var docno=$('#hidrntldocno').val();          
				if(docno==""){  
					swal({
						type: 'warning',   
						title: 'Warning',       
						text: ' Please select a document '
					});
					 return 0;
				 } 
			   $.messager.confirm('Message', 'Do you want to create invoice?', function(r){           
					     	if(r==false)   
					     	  {
					     		return false; 
					     	  }  
					     	else {
					     		$("#overlay, #PleaseWait").show();    
					     		saveData(docno,date,podate,pono,total,remarks);                           
					     	}        
					 });              
			}
	     function saveData(docno,date,podate,pono,total,remarks){           
	          var x=new XMLHttpRequest();
	          var rowno=$('#hidrowno').val(); 
	          var vocno=$('#hidvocno').val(); 
	          var brhid=$('#hidbrhid').val();   
	          var cldocno=$('#hidcldocno').val();  
	          console.log(cldocno);
		      x.onreadystatechange=function(){
		      if (x.readyState==4 && x.status==200){     
		      		var items=x.responseText.trim().split('###');          
		      		if(parseInt(items[0])>0){  
						swal({   
								type: 'success',
								title: 'Message',
								text: 'SRS - '+items[1]+' Successfully generated'                          
							});    
						 $("#overlay, #PleaseWait").hide();    
						 funload();    
						 $('#modalinvoice').modal('toggle');         
						}else{ 
							swal({
								type: 'error',
								title: 'Error',    
								text: 'Not generated'                                                
							}); 
						$("#overlay, #PleaseWait").hide();                    
						} 
		      	 }
		      }     
		      x.open("GET","saveData.jsp?docno="+docno+'&rowno='+rowno+'&pono='+pono+'&podate='+podate+'&brhid='+brhid+'&date='+date+'&vocno='+vocno+'&amount='+total+'&remarks='+encodeURIComponent(remarks)+'&cldocno='+cldocno,true);                                                                                               
		      x.send();      
	     }   
	   
	  function getstmtprint(docno){
		    var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split('####');     
			    if(parseInt(items[2])>0){
				    var acno=items[2];    
				    var type="AR";   
					var brnach="a";    
					var url=document.URL;     
			        var reurl=url.split("realestate");     
			        var netamt=0.00;   
			        var fdate=items[0];    
		            var tdate=items[1];     
			        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();          
				}else{      
					swal({
						type: 'warning',           
						title: 'Warning',    
						text: 'Account Satatement is not created'              
					    });          
				}
			}                 
			}   
			x.open("GET","getAcno.jsp?docno="+docno,true);                                                                     
			x.send();   
	    }
  </script>
</body>
</html>
