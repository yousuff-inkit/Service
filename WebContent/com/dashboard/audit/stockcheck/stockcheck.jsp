<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Purchase Order Follow-up</title>
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
<body>
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
      			<form class="form-inline">
        			<div class="primarypanel custompanel" style="display: flex; align-items: center;">
        				<div class="form-group col-auto" style="display: flex; align-items: center;">
        					<input type="checkbox" id="chkdate" style="margin:0;">
        					&nbsp;&nbsp;&nbsp;
            				<label class="form-group">Date:</label>
            				<div id='fromdate' name='fromdate'></div>
          				</div>
          				<div class="form-group col-auto">
          					&nbsp;&nbsp;&nbsp;
            				<label class="form-group">Branch:</label>
            				<div class="form-group">
              						<select id="cmbbranch" name="cmbbranch"></select>
            				</div>
          				</div>
        			</div>
        		<div class="primarypanel custompanel">
          			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          			<button type="button" class="btn btn-default" id="btncorrectall" data-toggle="tooltip" title="Correct" data-placement="bottom"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
        		</div>
        <!-- <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btncalculate">
            <i class="fa fa-calculator" aria-hidden="true" data-toggle="tooltip" title="Calculate" data-placement="bottom"></i>
          </button>
          
          <button type="button" class="btn btn-default" id="btndeltrigger">
            <i class="fa fa-th-list" aria-hidden="true" data-toggle="tooltip" title="Create Delivery Note" data-placement="bottom"></i>
          </button>
        
          <button type="button" class="btn btn-default" id="btninvtrigger" disabled="disabled">
            <i class="fa fa-plus-square" aria-hidden="true" data-toggle="tooltip" title="Create Credit Invoice" data-placement="bottom"></i>
          </button>
        </div> -->
       
      </form>
    </div>
  </div>
</div>
<div class="row">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    	<div id="mainDiv" Style="margin-left:15px;"><jsp:include page="stockcheckgrid.jsp"></jsp:include></div>
	</div>
</div>
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#chkdate').trigger('click');
	$("#fromdate").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});
	var currentDate = new Date();
	$("#fromdate").jqxDateTimeInput('setMaxDate', currentDate);
	getInitData();
	$('#cmbbranch').select2();
	
	$("#chkdate").change(function () {
        if (this.checked) {
            // If checkbox is checked, enable the jqxDateTimeInput
            $("#fromdate").jqxDateTimeInput({ disabled: false });
        } else {
            // If checkbox is not checked, disable the jqxDateTimeInput
            $("#fromdate").jqxDateTimeInput({ disabled: true });
        }
    });
	
	
	$("#btnsubmit").click(function(){
		$('.load-wrapp').show();
    	submit();    	
    });
	
	$("#btncorrectall").click(function(){
		 Swal.fire({
		      title: 'Update Entries',
		      text: 'Are you sure you want to update the Entries?',
		      icon: 'warning',
		      showCancelButton: true,
		      confirmButtonText: 'Update',
		      cancelButtonText: 'Cancel'
		    }).then((result) => {
		      if (result.isConfirmed) {
		        // If the user confirms the update action
		        // Call the function to update the file
		        $('.load-wrapp').show();
		  		setData(); 
		      }
		    });
    });
	
});

function setData(){
	var gridData = new Array();
	var rows = $('#jqxDashBoardMaster').jqxGrid('getrows');
	for (var i = 0; i < rows.length; i++) {
	  if(rows[i].transtype!=""||rows[i].transno!=""||rows[i].tr_no!="") {
		  gridData.push(rows[i]);
	  }
	}
	updateData(gridData);
}

function submit(){
	 	var date;
	    if($("#chkdate").is(':checked')){
	    	date=$('#fromdate').val()
	    }
	    $("#mainDiv").load("stockcheckgrid.jsp?date="+date+"&chk=1"); 
}

function getInitData() {
    $.get('getInitData.jsp', function(data) {
        data = JSON.parse(data.trim());
        var htmldata = '';
        $.each(data.branchdata, function(index, value) {
            htmldata += '<option value="' + value.docno + '">' + value.refname + '</option>';
        });
        $('#cmbbranch').html($.parseHTML(htmldata));
        $('#cmbbranch').select2({
            placeholder: "Select Branch",
            allowClear: true
        });
        $('#cmbbranch').val('1').trigger('change');
        $('.load-wrapp').hide();
    });
}

function updateData(gridData){
	const jsobj={"data":gridData};
	const myarray = JSON.stringify(jsobj);
	var date;
    if($("#chkdate").is(':checked')){
    	date=$('#fromdate').val()
    }
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
	{
		var items=x.responseText;
		if(items>=1){
			$('.load-wrapp').hide();
			Swal.fire({
			      title: 'Successful',
			      text: 'The entries have been successfully updated.',
			      icon: 'success',
			      confirmButtonText: 'Ok'  
			}).then((result) => {
				  if (result.isConfirmed) {
			        // Trigger the button click
			        $("#btnsubmit").click();
				  }
			});
		} else {
			 Swal.fire({
			        title: 'Failed to Update entries',
			        text: 'An error occurred while updating the entries. Please try again later.',
			        icon: 'error'
			      });
		}
	}   
	}
	x.open("POST","updatedata.jsp?",true);
	x.send(myarray);
}
</script>	
</body>
</html>