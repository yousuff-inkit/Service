<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Revision Request Approval </title>           
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
  		width:700px;  
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
<body>   
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">   
            <div class="todatepanel custompanel1">
	      <table>
		      <tr> 
			       <td align="right"><label class="branch" style="font-size: 13px">&nbsp;Status&nbsp;&nbsp;</label></td>       
		          <td align="left"> <select name="cmbstatus" id="cmbstatus" style="width:100%;" onChange="loads();" class="form-control input-sm">  
							<option value="0">Not Approved</option><option value="1">Approved</option><option value="2">Rejected</option><option value="">All</option></select>  
							</td>   
		      </tr>                                            
		 </table>          
       </div>                       
        <div class="primarypanel custompanel1"> 
        
      	<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btncontractview"><i class="fa fa-scribd" aria-hidden="true" data-toggle="tooltip"  title="View Contract" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnapprove"><i class="fa fa-check-circle " aria-hidden="true" data-toggle="tooltip" title="Approve" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btnreject"><i class="fa fa-pencil-square-o" aria-hidden="true" title="Reject" data-placement="bottom"></i></button>
        </div> 
        <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>    
        </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>          
      </div>
    </div>       
    <div id="modalapprove" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>    
            		<h4 class="modal-title">Approve<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">  
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
		        				<div class="form-group">
		        					<label for="Date">Date:</label>     
		        					<div id="aprdate" style="border: 1px solid black" style="width:69%;"></div>         
	                     	    </div>  
		                   </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">    
		        				<div class="form-group">
		        					<label for="Reason">Reason:</label>     
		        					<input type="text" id="txtapprovereason" name="txtapprovereason" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnapprovesave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
    <div id="modalreject" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>    
            		<h4 class="modal-title">Reject<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>    
          		</div>
          		<div class="modal-body">
  					<div class="row">  
  					       <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">     
		        				<div class="form-group">
		        					<label for="Date">Date:</label>           
		        					<div id="rjtdate" style="border: 1px solid black" style="width:69%;"></div>         
	                     	    </div>  
		                   </div>
		                  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-9">       
		        				<div class="form-group">
		        					<label for="Reason">Reason:</label>     
		        					<input type="text" id="txtrejectreason" name="txtrejectreason" class="form-control input-sm">   
	                     	    </div>  
		                   </div>  
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnrejectsave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
    </div>
 </div>
  <input type="hidden" name="hidcontrno" id="hidcontrno">  
  <input type="hidden" name="hidbrhid" id="hidbrhid">  
  <input type="hidden" name="hidstatus" id="hidstatus"> 
  <input type="hidden" name="hiddocno" id="hiddocno">    
  <input type="hidden" name="hidcomments" id="hidcomments">  
    <input type="hidden" name="lblname" id="lblname">  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){  
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
        $("#aprdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
        $("#rjtdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});           
        
        $('[data-toggle="tooltip"]').tooltip();     
        
        $('#btnsubmit').click(function(){    
        	clearfields();      
            loads(); 
            $('.textpanel p').text("");  
        }); 
        $('#btncontractview').click(function(){    
	         var contrno=$('#hidcontrno').val();    
	         if(contrno=="" || contrno=="0"){  
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document!'      
					});
	        		return false;
	         }
	         viewContract();                  
		}); 
        $('#btnapprove').click(function(){    
        	var docno=$('#hiddocno').val();    
	         if(docno=="" || docno=="0"){  
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document!'      
					});
	        		return false;
	         }
	     	document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val();
	         $("#modalapprove").modal('toggle');     
        }); 
        $('#btnapprovesave').click(function(){    
	    	 approve("modalapprove"); 
        });
        $('#btnreject').click(function(){    
        	var docno=$('#hiddocno').val();    
	         if(docno=="" || docno=="0"){  
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document!'      
					});
	        		return false;
	         }
	     	document.getElementById("lblotherdetails2").innerHTML=$("#lblname").val();
	         $("#modalreject").modal('toggle');      
        }); 
        $('#btnrejectsave').click(function(){      
        	reject("modalreject");    
        }); 
        $('#btnexcel').click(function(){  
        	$("#contractdiv").excelexportjs({ 
        		containerid: "contractdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxContractGrid",   
        		columns: getColumns("jqxContractGrid") ,   
        		worksheetName:"Revision Request Approval"  
         		});
        });
       /*  $('#btncommentsend').click(function(){
        	var enqno=$('#hidrowno').val();
        	var txtcomment=$('#txtcomment').val();
        	if(enqno==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	saveComment();
        });
         */
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#jqxContractGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("hidcontrno").value=""; 
    	document.getElementById("hiddocno").value="";   

    }
    
 
	function approve(modalid){  
		var status = $('#hidstatus').val();
		var docno = $('#hiddocno').val(); 
		var brhid = $('#hidbrhid').val(); 
		var reason = $('#txtapprovereason').val();
		var aprdate = $('#aprdate').val();    
		if(reason==""){  
    		Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Please enter a reason'        
			});
    		return false;
    	}else if(status==1){   
    		Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Already Approved'   
			});
    		return false;
    	}else{
			status=1;
		 Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to Approve?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
		}).then((result) => {
				if (result.isConfirmed) {
					$('.load-wrapp').show();
					approval(docno, status, brhid, reason, modalid, aprdate); 
				}
		});
		}
	}
	    
	function approval(docno, status, brhid, reason, modalid, aprdate){         
        var stat=$('#cmbstatus').val();
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
				var items=x.responseText;
				if(parseInt(items)=="1") {	
					$('.load-wrapp').hide();
					Swal.fire({
						icon: 'success',
						title: 'Success',  
						text: ' Successfully Updated'
					});
					$("#jqxContractGrid").jqxGrid('clear');
					$("#txtapprovereason").val('');   
					$("#txtrejectreason").val('');     
					$("#"+modalid).modal('toggle');   
				    $('#contractdiv').load('contractGrid.jsp?status='+stat+'&id=1');         
				} else {
					$('.load-wrapp').hide();
					Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Not Updated'
					});
					return false;
				}
				}  
		}
	x.open("GET","approve.jsp?docno="+docno+"&status="+status+"&brhid="+brhid+"&reason="+encodeURIComponent(reason)+"&aprdate="+aprdate,true)   
	x.send();  
	}
	
	function reject(modalid){  
		var status = $('#hidstatus').val();
		var docno = $('#hiddocno').val(); 
		var brhid= $('#hidbrhid').val(); 
		var reason = $('#txtrejectreason').val();
		var rjtdate = $('#rjtdate').val();           
		if(reason==""){  
    		Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Please enter a reason'     
			});
    		return false;
    	}else if(status==1){
    		Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Already Approved'   
			});
    		return false;
    	}
		else if(status==2){
    		Swal.fire({
    			icon: 'warning',
				title: 'Warning',
				text: 'Already Rejected'   
			});
    		return false;
    	}
		else{
			status=2;
		 Swal.fire({
				title: 'Are you sure?',
				text: "Do you want to Reject?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
		}).then((result) => {
				if (result.isConfirmed) {
					$('.load-wrapp').show();
					approval(docno,status,brhid,reason,modalid,rjtdate); 
				}
		});
		}
	}
	
    function loads(){ 
    	
        var status=$('#cmbstatus').val();
	    $("#overlay, #PleaseWait").show();
		 $("#jqxContractGrid").jqxGrid('clear');  

	    $('#contractdiv').load('contractGrid.jsp?status='+status+'&id=1');         
    }  
    function viewContract(){                           
		var contracttrno=document.getElementById("hidcontrno").value;         
		var brch=document.getElementById("hidbrhid").value; 
		
		var path1="com/skips/servicecontract/servicecontract.jsp";        
		var name="Service Contract";
		var url=document.URL;  
		var reurl=url.split("com/");

		window.parent.formName.value="Service Contract";            
		window.parent.formCode.value="AMC";
		window.parent.branchid.value=brch;             
		var detName="Service Contract";  
		var mode="view";  
		  
		var path= path1+"?modes="+mode+"&brhid="+brch+"&contrno="+contracttrno;              
		top.addTab( detName,reurl[0]+""+path);
	}
  </script>
  </div>
  </form>   
</body>
</html>
