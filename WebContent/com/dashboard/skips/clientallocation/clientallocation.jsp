<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Client Allocation</title>
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
<body >
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
        <div class="primarypanel custompanel">
            			<div class="form-group col-auto">
    						<select class="cmbload" name="cmbload" style="width: 100%" id="cmbload" onchange="loadGrid();">
  							<option value="1">All</option>
  							<option value="2">Allocated</option>
  							<option value="3">Not Allocated</option> 
						</select>
  						</div>
			    </div>		  
              <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>
         <div class="otherpanel custompanel">
          <button type="button" class="btn btn-default" id="btnassign"><i class="fa fa-pencil-square" aria-hidden="true" data-toggle="tooltip"  title="Allocate" data-placement="bottom"></i></button>
        </div> 
       <!--  <div class="textpanel custompanel">      
			<p class="h4">&nbsp;</p>
        </div>  -->
        </form>
			     
		 </div> 
  
      </div>
      
      <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="cldiv"><jsp:include page="clientGrid.jsp"></jsp:include></div>
      </div>
    </div>
   
   </div>
    
    
    <div id="modalassign" class="modal fade" role="dialog">
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>
            		<h4 class="modal-title">Allocation<span></span></h4>    
          		</div>
          		<div class="modal-body">
  				  <div class="row"> 
  				           <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">      
		        				<div class="form-group">
		        					<label for="Helper">Telesales:</label>     
		        					<input type="text" id="txttelesales" name="txttelesales" class="form-control input-sm" placeholder="press F3 to search" style="width:95%;height:10%" readonly  onKeyDown="getTelesales();">   
		        					<input type="hidden" id="hidtelesalesid" name="hidtelesalesid">                
	                     	    </div>  
		                   </div>
            		</div>
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<button type="button" class="btn btn-default btn-primary" id="btnassignsave">Save Changes</button>  
            		
          		</div>
        </div>
      </div>
    </div>

    <div id="telesalessearchWindow">
   <div ></div>
   </div>
   <input type="hidden" id="cldocnos" name="cldocnos">  
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
        $('.load-wrapp').hide();  
        $('.cmbload').select2({dropdownAutoWidth : true});  
 	    $('#telesalessearchWindow').jqxWindow({ width: '40%', height: '50%',  maxHeight: '80%' ,maxWidth: '85%' , title: 'Telesales Search' ,position: { x: 500, y: 120 }, keyboardCloseKey: 27});
	    $('#telesalessearchWindow').jqxWindow('close');
 	    $('#btnsubmit').click(function(){
			$('.load-wrapp').show(); 
			loadGrid();
		});
 	   $('#txttelesales').dblclick(function(){    
	    	$('#telesalessearchWindow').jqxWindow('open');
	    	telesalesinfoSearchContent('searchTelesales.jsp?', $('#telesalessearchWindow'));     
	       });
		$('#btnexcel').click(function(){ 
	    		 $("#cldiv").excelexportjs({
	 				containerid: "cldiv",
	 				datatype: 'json',
	 				dataset: null,
	 				gridId: "jqxClientGrid",
	 				columns: getColumns("jqxClientGrid"),
	 				worksheetName: "Client Allocation"  
	 			});
		});
		$('#btnassign').click(function(){  
			getCldocnos();
        });
		$('#btnassignsave').click(function(){
			funallocate();  
        });
	}); 
	function getTelesales(event){  
		 var x= event.keyCode;
   	 if(x==114){
   		 $('#telesalessearchWindow').jqxWindow('open');
   		 telesalesinfoSearchContent('searchTelesales.jsp?', $('#telesalessearchWindow'));     
   	}
   	 else{
   		 
   	 }
	}
	function telesalesinfoSearchContent(url) {  
  	 //alert(url);
  		 $.get(url).done(function (data) {
  			 
  		$('#telesalessearchWindow').jqxWindow('open');
  		$('#telesalessearchWindow').jqxWindow('setContent', data);  
  
  	}); 
  	}
    function loadGrid(){
    	$('.load-wrapp').show(); 
    	var type=$("#cmbload").val();  
    	$('#cldiv').load('clientGrid.jsp?type='+type+'&id=1');     
    }
	function getCldocnos(){
		$('#jqxClientGrid').jqxGrid('clearfilters', true);    
		var selectedrows=$('#jqxClientGrid').jqxGrid('selectedrowindexes');  
		if(selectedrows.length==0){
			  Swal.fire({  
      			    icon: 'warning',
					title: 'Warning',
					text: 'Please select documents'
				});
			return false;
		}
		document.getElementById("cldocnos").value="";
		for(var i=0;i<selectedrows.length;i++){
			if(i==0){
				document.getElementById("cldocnos").value+=$('#jqxClientGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
			else{
				document.getElementById("cldocnos").value+=":"+$('#jqxClientGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			}
		}
		$("#modalassign").modal('toggle');  
	}
	function funallocate(){
		var telesales=$('#hidtelesalesid').val();  
		var cldocnos=$('#cldocnos').val();
		if(telesales=="" || telesales=="0"){  
			  Swal.fire({  
    			    icon: 'warning',
					title: 'Warning',
					text: 'Please select telesales'
				});
			return false;
		}
		Swal.fire({
			title: 'Are you sure?',
			text: "Do you want to allocate?",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: 'Yes'
		}).then((result) => {
				if (result.isConfirmed) {
					$('.load-wrapp').show(); 
					saveData(telesales,cldocnos);  
				}
		});
	}
	function saveData(telesales,cldocnos){  
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 	var items= x.responseText;
			 	if(parseInt(items)>0){
			 		 Swal.fire({  
		    			    icon: 'success',
							title: 'Success',
							text: 'Successfully Allocated'
						});
			 	}
			 	else{
			 		 Swal.fire({  
		    			    icon: 'error',
							title: 'Error',  
							text: 'Not Allocated'  
						});
			 	}
			 	$('.load-wrapp').hide(); 
			 	loadGrid();
			 	$("#modalassign").modal('toggle');    
	    }
		}
	     x.open("GET","saveData.jsp?cldocnos="+encodeURIComponent(cldocnos)+"&telesalesid="+telesales,true);     
	    x.send(); 
	}
</script>
</body>
</html>
