<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	String contextPath=request.getContextPath();
 %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Presales Management</title>
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
				           <label class="form-group" for="cmbpriority">Branch:</label>
    						<div class="form-group">
      							<select id="cmbbranch" name="cmbbranch" ></select>
    						</div>  
    						</div>
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
			               <div class="form-group col-auto">
				           <label class="form-group" for="cmbpriority">Load:</label> 
    						<div class="form-group">
      							<select id="cmbdecload" name="cmbdecload">
      							<option value="1">All</option><option value="2">ENQ Declined</option><option value="3">QOT Declined</option><option value="4">Other</option>
      							</select>
    						</div>  
    						</div>
			                </div>		  
					  <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        	<button type="button" class="btn btn-default" id="btnattachs" data-toggle="tooltip" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
            <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>       
       </div>  
        <div class="textpanel custompanel">
			<p class="h4">&nbsp;</p>
        </div> 
				</form>
			</div> 
		</div>	     
      </div>
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="partsplangriddiv"><jsp:include page="declinedpresalesgrid.jsp"></jsp:include></div>
      </div>
    </div>
	  <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="detailDiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
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
      <input type="hidden" name="hidcomments" id="hidcomments"> 
   <input type="hidden" id="enqdocno" name="enqdocno" value='<s:property value="enqdocno"/>'>
   <input type="hidden" id="brhid1" name="brhid1" value='<s:property value="brhid1"/>'>
   <input type="hidden" id="reftrno" name="reftrno"  value='<s:property value="reftrno"/>'>
   <div id="partssearchwindow">
   		<div><img id="loadingImage" src="../../../../icons/31load.gif" style="position: absolute;vertical-align:middle;text-align:center;margin-right:50%;margin-left:60%;margin-top:25%;" /></div>
	</div>
	<div id="areainfowindow">
   <div ></div>
</div>
<div id="sourcesearchwndow">
   <div ></div>
</div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	setTimeout(funload, 1000);  
        $('[data-toggle="tooltip"]').tooltip();
		$("#fromdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));   
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		$('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   if(fromdates<todates){
				   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			       return false;
			  }     
		 });
		$('#cmbdecload').select2({
				placeholder:"Select Load Type",
				allowClear:true
			});
		getInitData()
		$('#btnsubmit').click(function(){
			funload()
		});
		$('#cmbdecload').change(function(){ 
			funload()
		});
		$('#btnexcel').click(function(){
			$("#partsplangriddiv").excelexportjs({
				containerid: "partsplangriddiv",
				datatype: 'json',
				dataset: null,
				gridId: "enqlistgrid",
				columns: getColumns("enqlistgrid"),
				worksheetName: "Presales Report"
			});
		});
 
		 $('#btnattachs').click(function(){ 
				var jobcarddocno=$('#reftrno').val();
				if(jobcarddocno==""){
	        		Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	        	}
	        	attach();      
	        });
		 $('#btncomment').click(function(){    
		        var enqno=$('#reftrno').val();
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
		 $('#btncommentsend').click(function(){
	        	var enqno=$('#reftrno').val(); 
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
	        
	});
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var enqno=$('#reftrno').val();  
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
    	var enqno=$('#reftrno').val();
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
    function funload(){
    	 var decid=$('#cmbdecload').val();
    	 var brhid=$('#cmbbranch').val();
		 var fromdate= $("#fromdate").val();
		 var todate= $("#todate").val();
		 var areaid=$("#areaid").val();
		 var salesmanid=$("#cmbsalesman").val();
		 $('.load-wrapp').show();
		 $('#partsplangriddiv').load('declinedpresalesgrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&decchk='+decid);
    }
     
    function attach(){
				var fcode="ENQ";
				var fname="Presales Report";
				var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+fcode+"&docno="+document.getElementById("enqdocno").value+"&brchid="+document.getElementById("brhid1").value+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				myWindow.focus();
	} 
    function getInitData(){
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data.trim());
			var htmldata='';
			htmldata='<option value="0">All</option>';  
			$.each(data.branchdata,function(index,value){
  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
  			});
  			$('#cmbbranch').html($.parseHTML(htmldata));
  			$('#cmbbranch').select2({
  				placeholder:"Select Branch",
  				allowClear:true
  			});
  			$('.load-wrapp').hide();   
		});
	}
</script>
</body>
</html>
