<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Client Review</title>           
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
         <div class="primarypanel custompanel1"> 
      	    <button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>                 
        <div class="primarypanel custompanel1"> 
         <button type="button" class="btn btn-default " id="btntenantaccounts" data-tooltip="tooltip" title=" Account Statement" data-placement="bottom"><i class="fa fa-address-card" aria-hidden="true"></i></button>
         <button type="button" class="btn btn-default" id="btntenantacprint"  data-toggle="tooltip" title="Account Statement Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
         <button type="button" class="btn btn-default" id="btncontractview"><i class="fa fa-scribd" aria-hidden="true" data-toggle="tooltip"  title="Contract History" data-placement="bottom"></i></button>
         <button type="button" class="btn btn-default" id="btnoutstandingprint" onclick="funoutPrint();" data-toggle="tooltip" title="Outstanding Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
        </div> 
        <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>    
        </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="clientListDiv"><jsp:include page="clientListGrid.jsp"></jsp:include></div>          
      </div>
    </div>    



 
        
        
           <div id="modaltenantaccountstmt" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center"> Accounts Statement</h4>
                    </div>
                    <div class="modal-body">
						<div id="tenantaccountsdiv"><jsp:include page="tenantAccountsGrid.jsp"></jsp:include></div>                        
                    </div>
                    <div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			</div>
				</div>
            </div>
        </div>
        
        
        
          <div id="modalcontractview" class="modal fade" role="dialog">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="text-align:center"> Contract History</h4>
                    </div>
                    <div class="modal-body">
						<div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>                        
                    </div>
                    <div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			</div>
				</div>
            </div>
        </div>
        

        </div>
      </div>
    </div>
     <input type="hidden" name="hidcontrno" id="hidcontrno">  
  <input type="hidden" name="hidbrhid" id="hidbrhid">  
  <input type="hidden" name="hidstatus" id="hidstatus"> 
    <input type="hidden" name="hidcldocno" id="hidcldocno"> 
      <input type="hidden" name="hidacno" id="hidacno"> 
        <input type="hidden" name="hidbrhid" id="hidbrhid"> 
        <input type="hidden" name="hidname" id="hidname"> 
  
  <input type="hidden" name="hidcomments" id="hidcomments">  
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
        
        $('#btnsubmit').click(function(){    
        	clearfields();      
            loads(); 
        }); 
    	$('#btnoutstandingprint').click(function(){  
    		if ($('#hidcldocno').val() == '') {
                swal.fire({
                    type: 'warning',
                    title: 'Warning',
                    text: 'Please select a document'
                });
                return false;
            }
			var id=$(this).attr('id');
			var acno=$('#hidacno').val();
			var brnach="a";    
			var url=document.URL;     
	        var reurl=url.split("com/");     
	        var netamt=0.00;   
	        var fdate=window.parent.txtaccountperiodfrom.value;
	        fdate=fdate.replace(/-/g, '.');
            var tdate=window.parent.txtaccountperiodto.value; 
            tdate=tdate.replace(/-/g, '.');
	        var win= window.open(reurl[0]+"printOutstandingsStatementCR?atype=AR&acno="+acno+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+brnach+'&uptoDate='+tdate+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();     
		});
    	
    	$('#btntenantacprint').click(function(){
    		if ($('#hidcldocno').val() == '') {
                swal.fire({
                    type: 'warning',
                    title: 'Warning',
                    text: 'Please select a document'
                });
                return false;
            }
			var id=$(this).attr('id');
			var acno=$('#hidacno').val();
			var brnach="a";    
			var url=document.URL;     
	        var reurl=url.split("com/");     
	        var netamt=0.00;   
	        var fdate=window.parent.txtaccountperiodfrom.value;
	        fdate=fdate.replace(/-/g, '.');
            var tdate=window.parent.txtaccountperiodto.value; 
            tdate=tdate.replace(/-/g, '.');
	        var win= window.open(reurl[0]+"accounts/accountsstatement/printAccountsStatement?acno="+acno+'&netamount='+netamt+'&branch='+brnach+'&fromDate='+fdate+'&toDate='+tdate+'&email=Nil&print=1&chckopn=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();   
		});
    	
        $('#btncontractview').click(function(){    
	         var cldocno=$('#hidcldocno').val();   
	         var acname=$('#hidname').val();    

	         if(cldocno=="" || cldocno=="0"){  
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document!'      
					});
	        		return false;
	         }
			$('#modalcontractview .modal-dialog .modal-content .modal-header h4').text(' Contract History-'+acname);
			$('#modalcontractview').modal();
			$('#contractdiv').load("contractGrid.jsp?cldocno="+cldocno);

            $('#modalcontractview .modal-dialog .modal-content .modal-header h4').trigger('click');
	
		}); 
        $('#btntenantaccounts').click(function(){
			if ($('#hidcldocno').val() == '') {
                swal.fire({
                    type: 'warning',
                    title: 'Warning',
                    text: 'Please select a document'
                });
                return false;
            }
			var acname=$('#hidname').val();
			 var accdocno=$('#hidacno').val();
			 var branch=$('#hidbrhid').val();

			 var fdate=window.parent.txtaccountperiodfrom.value;
		     fdate=fdate.replace(/-/g, '.');
	         var tdate=window.parent.txtaccountperiodto.value; 
	         tdate=tdate.replace(/-/g, '.');
			$('#modaltenantaccountstmt .modal-dialog .modal-content .modal-header h4').text('Account Statement-'+acname);
			$('#modaltenantaccountstmt').modal();
			$('#tenantaccountsdiv').load("tenantAccountsGrid.jsp?fromdate="+fdate+"&todate="+tdate+"&branchval="+branch+"&accdocno="+accdocno+"&id=1");

            $('#modaltenantaccountstmt .modal-dialog .modal-content .modal-header h4').trigger('click');
		});
        $('#btnexcel').click(function(){  
        	$("#clientListDiv").excelexportjs({ 
        		containerid: "clientListDiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "client",   
        		columns: getColumns("client") ,   
        		worksheetName:"Client Review"  
         		});
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
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("hidcontrno").value=""; 
    	document.getElementById("hidcldocno").value="";   

    }
    
 
	
	
   
    function loads(){ 
    	
    	var aa="load";
	  	   
	  	$("#overlay, #PleaseWait").show();
	  	$("#clientListDiv").load("clientListGrid.jsp?check="+aa);
	 }  
   
  </script>
  </div>
  </form>   
</body>
</html>
