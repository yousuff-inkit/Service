<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Contract Renewal Followup</title>             
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
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
		  <div class="primarypanel custompanel1">
		      <table>
			      <tr>              
			      <td align="right" ><label class="branch" style="font-size: 13px">Up To &nbsp;&nbsp;</label></td>   
			      <td align="left"><div id='todate' name='todate'></div></td></tr>                              
			 </table>   
        </div>	   
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>   
         <div class="otherpanel custompanel1">     
         <button type="button" class="btn btn-default" id="btnstatusupdate" data-toggle="tooltip"  title="Status Update" data-placement="bottom"><i class="fa fa-file-text "  aria-hidden="true"></i></button>      
          <button type="button" class="btn btn-default" id="btnfollowup" ><i class="fa fa-exchange" aria-hidden="true" data-toggle="tooltip" title="Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnmail" ><i class="fa fa-envelope" aria-hidden="true" data-toggle="tooltip" title="Send Document to Client" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncontractcreate" ><i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Service Contract Creation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
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
     <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
      </div>
    </div> 
     <div id="modalstatusupdate" class="modal fade" role="dialog">  
    	<div class="modal-dialog modal-sm">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Status Update<span></span></h4>  <label for="otherdetails11" id="lblotherdetails11"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row">  
  					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
		        				<div class="form-group">
		        					<label for="cmbstatus">Status:</label>     
		        					<select class="form-control select2" name="cmbstatus" id="cmbstatus" style="width:100%;">
		        					<option value="1">Draft Send</option><option value="2">Client Approved</option><option value="3">Invoiced</option></select>   
	                     	    </div>     
		                   </div> 
		               </div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnstatussave">Save Changes</button>
            		
          		</div>
        </div>
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
						     <label class="control-label col-sm-3" for="date">Date</label></td>
						      <div class="col-sm-9 input-container">
						     <div id="date" name="date" value='<s:property value="date"/>'></div>
						     </div>
						     </div>
						     <div class="form-group">
						     <label class="control-label col-sm-3" for="date">Remarks</label>
						<div class="col-sm-9 input-container">
						<textarea maxlength="540" id="txtremarks" style="height:65px;width:98%;font: 10px Tahoma;resize:none"  name="txtremarks" ></textarea>
  						</div>
  						</div>  
  						</div>
            		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnflwupsave">Save Changes</button>  
          		</div>
          		</div>
        </div>
      </div>
    <!-- Comments Modal-->
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Comments</h4>
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
  <input type="hidden" name="hidtrno" id="hidtrno">  
  <input type="hidden" name="hiddocno" id="hiddocno">    
  <input type="hidden" name="hidbrhid" id="hidbrhid">  
  <input type="hidden" name="hidrowno" id="hidrowno"> 
  <input type="hidden" name="hidcomments" id="hidcomments">  
  <input type="hidden" name="hidclient" id="hidclient">  
  <input type="hidden" name="hidcldocno" id="hidcldocno">  
  <input type="hidden" name="hidaddress" id="hidaddress">  
  <input type="hidden" name="hidpertel" id="hidpertel">  
  <input type="hidden" name="hidper_mob" id="hidper_mob">  
  <input type="hidden" name="hidmail1" id="hidmail1">  
  <input type="hidden" name="hidsalname" id="hidsalname">  
  <input type="hidden" name="hidsalid" id="hidsalid">  
  <input type="hidden" name="hidgrpname" id="hidgrpname">  
  <input type="hidden" name="hiddesc" id="hiddesc">  
  <input type="hidden" name="hidbilling" id="hidbilling">  
  <input type="hidden" name="hidtype" id="hidtype">  
  <input type="hidden" name="hidpayterms" id="hidpayterms"> 
  <input type="hidden" name="hidenddt" id="hidenddt">
  <input type="hidden" name="hidstartdt" id="hidstartdt">  
  <input type="hidden" name="hiddate" id="hiddate">    
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
    	$("#date").jqxDateTimeInput({ width: '115px', height: '22px', formatString:"dd.MM.yyyy"});
    	$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var date = new Date();
		$('#todate').val(date.addDays(60));     
        $('#btnsubmit').click(function(){    
        	clearfields();      
            loads(); 
        });  
        $('#btnflwupsave').click(function(){  
        	  followup();  
	      }); 
        $('#btnstatussave').click(function(){       
	    	funUpdateStatus();     
        });
	    $('#btncontractcreate').click(function(){  
	        	var enqdocno=$('#hidrowno').val(); 
	         	if(enqdocno==""){
	         		Swal.fire({
	         			icon: 'warning',
	 					title: 'Warning',
	 					text: 'Please select a document'
	 				});
	         		return false;
	         	}  
	         	funCreateAMC();   
		 });
	    $('#btnstatusupdate').click(function(){          
	    	//clearfields();      
        	var enqno=$('#hidrowno').val();  
	        if(enqno==""){
	    		Swal.fire({
					icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}   
	    	// document.getElementById("lblotherdetails11").innerHTML=$("#lblname").val();
	    	$("#modalstatusupdate").modal('toggle');                         
        });
        $('#btnfollowup').click(function(){  
        	var enqdocno=$('#hidrowno').val();  
         	if(enqdocno==""){
         		Swal.fire({
         			icon: 'warning',
 					title: 'Warning',
 					text: 'Please select a document'
 				});
         		return false;
         	}  
        	$('#modalfollowup').modal('show');  
	      });
        $('#btnmail').click(function(){  
        	var enqdocno=$('#hidrowno').val();  
         	if(enqdocno==""){
         		Swal.fire({
         			icon: 'warning',
 					title: 'Warning',
 					text: 'Please select a document'
 				});
         		return false;
         	}  
         	funemail(); 
	      });
        $('#btncomment').click(function(){    
	        var enqno=$('#hidrowno').val();
	    	if(enqno==""){
	    		Swal.fire({
	    			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	 getComments(); 
        }); 
        $('#btnexcel').click(function(){  
        	$("#contractdiv").excelexportjs({ 
        		containerid: "contractdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxContractGrid",   
        		columns: getColumns("jqxContractGrid") ,   
        		worksheetName:"Contract Review"  
         		});
        });
        $('#btncommentsend').click(function(){
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
    Date.prototype.addDays = function(days) {
        var date = new Date(this.valueOf());
        date.setDate(date.getDate() + days);
        return date;
    }  
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("hidrowno").value="";   
    }
    function funUpdateStatus(){
    	var brhid= $("#hidbrhid").val();
		var statusid= $('#cmbstatus').val();       
		processid="Status Update";             
		if(statusid==''){
			 swal.fire({  
				 icon: 'warning',
					title: 'Warning',
					text: 'Please select a status!!!'       
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
					funstatussave(processid,statusid,brhid);            
				}else{
				}
		});
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
    	$("#jqxContractGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxContractGrid").jqxGrid('applyfilters');    
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#hidrowno').val();
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&reftrno="+enqno,true);
		x.send();
    }
    function getComments(){  
    	var enqno=$('#hidrowno').val();
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
		x.open("GET","getComments.jsp?reftrno="+enqno,true);    
		x.send();
    }
   
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var todate= $("#todate").val();
	    $('#contractdiv').load('contractGrid.jsp?id='+1+'&todate='+todate);                
    } 
	 function funemail(){    
			 Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to send E-mail?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						funSendMail();  	
					}
			});
		}
       function funSendMail(){   
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim().split("####");
					var email="";
					var cldocno="";
					var msg="";      
					var client="";
					var subject="Contract Renewal Notice";  
					//console.log(items[0]+"="+items[1]+"="+items[2]);  
					if(items!=""){
						 msg=items[0];
					     email=items[1];
					     cldocno=items[2];
					     //client=items[3];    
					}
					var brchid="<%= session.getAttribute("BRANCHID").toString() %>";    
					var userid="<%= session.getAttribute("USERID").toString() %>";     
			   		var contrctno=document.getElementById("hiddocno").value; 
			   		var frmdet="AMC";    
			   		var dtype="CRF";        
			   		var fname="Contract Renewal Follow Up";     
			   		//console.log(msg+"="+email+"="+cldocno);
			   		window.open("<%=contextPath%>/com/emailnew/Email.jsp?formcode="+dtype+"&docno="+contrctno+"&brchid="+brchid+"&frmname="+fname+"&recipient="+email+"&cldocno="+cldocno+"&client="+client+"&userid="+userid+"&dtype="+frmdet+"&subject="+encodeURIComponent(subject)+"&msg="+encodeURIComponent(msg),"E-Mail","menubar=0,resizable=1,width=900,height=950"); 
				}
			}      
			x.open("GET","sendMail.jsp?vocno="+$('#hiddocno').val()+"&brhid="+$('#hidbrhid').val(),true);     
			x.send();         
			}  
       function followup(){  
			var date =  $('#date').val();
			var branchid = $('#hidbrhid').val();   
			var remarks = $('#txtremarks').val().replace(/\n/g, '');
			var trno = $('#hidtrno').val();
			var rowno = $('#hidrowno').val();  
			var rdtype = "AMC";    
			 
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
						saveFollowup(date,branchid,trno,rdtype,remarks,rowno); 
					}
			});
		}
		    
		function saveFollowup(date,branchid,trno,rdtype,remarks,rowno){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
					var items=x.responseText;
					if(parseInt(items)=="1") {	
						$('#date').val(new Date());
						$('#txtremarks').val('');
						$('.load-wrapp').hide();
						Swal.fire({
							icon: 'success',
							title: 'Success',  
							text: ' Successfully Updated'
						});
						
						$('#btnsubmit').trigger('click');
						$("#detailDiv").load("detailGrid.jsp?rowno="+rowno);   
						$('#modalfollowup').modal('hide');   
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
			
		x.open("GET","saveFlwp.jsp?date="+date+"&branchid="+branchid+"&trno="+trno+"&rdtype="+rdtype+"&remarks="+remarks+"&rowno="+rowno,true)
		x.send();
		}
		function funCreateAMC(){      
			var client=document.getElementById("hidclient").value;
			var cldocno=document.getElementById("hidcldocno").value;
			var address=document.getElementById("hidaddress").value;
			var pertel=document.getElementById("hidpertel").value;
			var per_mob=document.getElementById("hidper_mob").value;
			var mail1=document.getElementById("hidmail1").value;
			var salname=document.getElementById("hidsalname").value;
			var salid=document.getElementById("hidsalid").value;
			var brch=document.getElementById("hidbrhid").value;  
			var grpname=document.getElementById("hidgrpname").value; 
			var description=document.getElementById("hiddesc").value; 
			var billingmethod=document.getElementById("hidbilling").value;
			var type=document.getElementById("hidtype").value; 
			var payterms=document.getElementById("hidpayterms").value; 
			var startdt=document.getElementById("hidstartdt").value;  
			var enddt=document.getElementById("hidenddt").value;  
			var date=document.getElementById("hiddate").value; 
			var contrno=document.getElementById("hidtrno").value;  
			var reftype="DIR";
			
			var path1="com/skips/servicecontract/servicecontract.jsp";    
			var name="Service Contract";
			var url=document.URL;  
			var reurl=url.split("/com/");

			window.parent.formName.value="Service Contract";  
			window.parent.formCode.value="AMC";   
			window.parent.branchid.value=brch;
			var detName="Service Contract";
			var mode="A";    
			   
			var path= path1+"?mod="+mode+"&brhid="+brch+"&billingmethod="+billingmethod+"&client="+encodeURIComponent(client)+"&cldocno="+cldocno+"&date="+date+"&contrno="+contrno  
					  +"&address="+encodeURIComponent(address)+"&telno="+pertel+"&mob="+per_mob+"&startdt="+startdt+"&enddt="+enddt  
					  +"&mail="+encodeURIComponent(mail1)+"&salesman="+encodeURIComponent(salname)
					  +"&reftype="+reftype+"&salid="+salid+"&payterms="+payterms+"&type="+type+"&description="+encodeURIComponent(description)+"&grpname="+encodeURIComponent(grpname);           
			 
		    top.addTab( detName,reurl[0]+"/"+path);   
		}
		function funstatussave(processid,statusid,brhid){  
			var trno = $('#hidtrno').val();
			var rowno = $('#hidrowno').val();
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){  
					var items=x.responseText;
						 if(parseInt(items)=="1"){  	  
							    loads(); 
									 swal.fire({  
											icon: 'success',
											title: 'Success',
											text: 'Successfully Updated'  
										});
									 $("#modalstatusupdate").modal('toggle');    
							}else{
									 swal.fire({  
										    icon: 'warning',
											title: 'Warning',
											text: 'Not Updated'  
										});
							} 
					}
			}  
			x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&brhid="+brhid+"&statusid="+statusid+"&rowno="+$("#hidrowno").val()+"&contrno="+$("#hidtrno").val(),true);
			x.send();        
		}
  </script>
  </div>
  </form>   
</body>
</html>
