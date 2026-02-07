<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Contract LPO Followup</title>             
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
  			<input type="radio"  id="radioexp"  data-toggle="tooltip" name="rdo" title="Expired" onclick="radioClick();" value="radioexp"/>Expired   
          	<input type="radio"  id="radioall" data-toggle="tooltip" name="rdo" title="All" onclick="radioClick();" value="radioall"/>All
        </div>  
		 	   
        <div class="primarypanel custompanel1">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>   
         <div class="otherpanel custompanel1">      
          <button type="button" class="btn btn-default" id="btnfollowup" ><i class="fa fa-exchange" aria-hidden="true" data-toggle="tooltip" title="Followup" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnextend"><i class="fa fa-pencil" aria-hidden="true" data-toggle="tooltip"  title="Extend" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
        
        </div>  
        <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>    
        </div>
      </div>
    </div>
     
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="contractdiv"><jsp:include page="clientConfirmGrid.jsp"></jsp:include></div>          
      </div>
    </div> 
    <div><table><tr></tr></table></div>
    <div></div>  
      
     <div class="row" style="padding-top: 5px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
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
    
    	<div id="modalextend" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Extend<span></span></h4>
          		</div>
          		<div class="modal-body">
            		<div class="form-horizontal">
            			<div class="form-group">
						     <label class="control-label col-sm-3" for="uptodate">Up to Date</label></td>
						      <div class="col-sm-9 input-container">
						     <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
						     </div>
						     </div>
  						
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnupdate">Save Changes</button>
            		
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
  <input type="hidden" name="hidcontrno" id="hidcontrno">  
    <input type="hidden" name="hidcontdet" id="hidcontdet">  
  <input type="hidden" name="hidcdate" id="hidcdate">    
  <input type="hidden" name="hidclient" id="hidclient">  
  <input type="hidden" name="hidrowno" id="hidrowno"> 
  <input type="hidden" name="hidcomments" id="hidcomments">  
  <input type="hidden" name="hidtype" id="hidtype">  
  <input type="hidden" name="hidcldocno" id="hidcldocno">  
  <input type="hidden" name="hidwastetype" id="hidwastetype">  
  <input type="hidden" name="hidskipsize" id="hidskipsize">  
  <input type="hidden" name="hidnos" id="hidnos">  
  <input type="hidden" name="hidmail1" id="hidmail1">  
  <input type="hidden" name="hidpono" id="hidpono">  
  <input type="hidden" name="hidqty" id="hidqty">  
  <input type="hidden" name="hidamount" id="hidamount">  
  <input type="hidden" name="hidvalidupto" id="hidvalidupto">  
  <input type="hidden" name="hiddescription" id="hiddescription">  
  <input type="hidden" name="hidpath" id="hidpath">  
  <input type="hidden" name="hidenddt" id="hidenddt">
  <input type="hidden" name="hidstartdt" id="hidstartdt">  
  <input type="hidden" name="hiddate" id="hiddate">  
    <input type="hidden" name="hidid" id="hidid">    
    
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
    	$("#uptodate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy"});  
   	  $("#amcfollowupGrid").jqxGrid('clear');     
   	
    	var date = new Date();
    	var uptodate = new Date();
    	 $('#btnattachs').click(function(){   
    	      	funAttachs();      
    	      });
        $('#btnsubmit').click(function(){    
        	clearfields();      
            loads(); 
        });  
        $('#btnflwupsave').click(function(){  
        	  followup();  
	      }); 
	   
        $('#btnupdate').click(function(){  
      	  update();  
	      }); 
        
        $('#btnfollowup').click(function(){  
        	var contrno=$('#hidcontrno').val();  
         	if(contrno==""){

         		Swal.fire({
         			icon: 'warning',
 					title: 'Warning',
 					text: 'Please select a document'
 				});
         		return false;
         	}  
        	$('#modalfollowup').modal('show');  
	      });
        
        $('#btnextend').click(function(){  
        	var contrno=$('#hidcontrno').val();  
         	if(contrno==""){

         		Swal.fire({
         			icon: 'warning',
 					title: 'Warning',
 					text: 'Please select a document'
 				});
         		return false;
         	}  
        	$('#modalextend').modal('show');  
	      });
        
      
       
        $('#btnexcel').click(function(){  
        	$("#contractdiv").excelexportjs({ 
        		containerid: "contractdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxclientconfirmGrid",   
        		columns: getColumns("jqxclientconfirmGrid") ,   
        		worksheetName:"Contract LPO Followup"  
         		});
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
    	$('.textpanel p').text(''); 
    	document.getElementById("hidcontrno").value="";   
    }
    
    function radioClick(){
    	 if(document.getElementById("radioexp").checked){
    	  	document.getElementById("hidid").value=1;   

	 }
	 else{
		 
 	  	document.getElementById("hidid").value=0;   

	 }
    }
    
	function funAttachs(){    
		var brchid=1; 
   		var docno=document.getElementById("hidcontrno").value;  

   		if(docno==""){

     		Swal.fire({
     			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
     		return false;
     	} 
   		
   		var url=document.URL;
		var reurl=url.split("com/");

 		if(docno!="" && docno!="0"){  
   			var frmdet="AMC"; 
   			var fname="Service Contract";
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
	    $("#overlay, #PleaseWait").show();
	  var exp= document.getElementById("hidid").value;   
	    $('#contractdiv').load('clientConfirmGrid.jsp?exp='+exp+'&id=1');                
    } 
	  
       function followup(){  
			var contdet = $('#hidcontdet').val();   
			var remarks = $('#txtremarks').val().replace(/\n/g, '');
			var date = $('#date').val();
			var contrno = $('#hidcontrno').val();  
			
			 
			
			 
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
						saveFollowup(contrno,contdet,remarks,date); 
					}
			});
		}
		    
		function saveFollowup(contrno,contdet,remarks,date){
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
						$("#detailDiv").load("detailGrid.jsp?contrno="+contrno);   
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
			
		x.open("GET","saveFlwp.jsp?contrno="+contrno+"&contdet="+contdet+"&remarks="+remarks+"&date="+date,true)
		x.send();
		}
		
		
		function update(){  
			var uptodate = $('#uptodate').val();
			var contrno = $('#hidcontrno').val();  
			var contdet = $('#hidcontdet').val();   
			
			
			 
			
			 
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
						saveUpdate(contrno,contdet,uptodate); 
					}
			});
		}
		    
		function saveUpdate(contrno,contdet,uptodate){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
					var items=x.responseText;
					if(parseInt(items)=="1") {	
						$('#uptodate').val(new Date());
						$('.load-wrapp').hide();
						Swal.fire({
							icon: 'success',
							title: 'Success',  
							text: ' Successfully Updated'
						});
						
						$('#btnsubmit').trigger('click');
						$("#detailDiv").load("detailGrid.jsp?contrno="+contrno);   
						$('#modalextend').modal('hide');     
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
			
		x.open("GET","saveUpdate.jsp?contrno="+contrno+"&contdet="+contdet+"&uptodate="+uptodate,true)
		x.send();
		}
		
		
  </script>
  </div>
  </form>   
</body>
</html>
