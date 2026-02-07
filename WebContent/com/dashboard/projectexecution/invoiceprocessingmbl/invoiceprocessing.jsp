<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Invoice Processing</title>                
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
<body onload="getBranch();getProcess();"> 
<form autocomplete="off"  id="frmopaccount" method="post">          
  <div class="container-fluid">
  		<div class="row padtop">
           <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="proformadiv">        
                <div class="card-container">
                    <div class="card-body text-center">
                        <div class="card-chart-container">
                            <div id="proforma"></div>  
                            <span><img src="icons/icons8-document-30.png" alt="" width="30" height="30"></span>  
                        </div>
                        <div class="card-detail-container">
                             <span>Proforma</span><br/>        
                             <span class="counter">10</span>    
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
            <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="notrcvddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">   
                            <div id="notrcvd"></div>
                            <span><img src="icons/icons8-unavailable-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                             <span>To Be Accepted</span><br/>         
                             <span class="counter">10</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="invprodiv">   
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="invpro"></div>  
                            <span><img src="icons/icons8-news-30.png" alt="" width="30" height="30"></span> 
                        </div>
                        <div class="card-detail-container">
                            <span>Invoice Processing</span><br/>  
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1">&nbsp;</div>	
             <div class="col-xs-12 col-sm-6 col-md-2 col-lg-2" id="tobecnfmeddiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                        <div class="card-chart-container">
                            <div id="tobecnfmed"></div>   
                            <span><img src="icons/icons8-checked-30.png" alt="" width="30" height="30"></span>   
                        </div>
                        <div class="card-detail-container">
                            <span>To Be Confirmed</span><br/>  
                             <span class="counter">10</span>  
                        </div>
                    </div>
                </div>
            </div>	
        </div>    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
      <div class="primarypanel custompanel">
               <label for="branch" class="branch">Branch</label>  
        </div>
        <div class="primarypanel custompanel">
               <select class="cmbbranch form-control input-sm" id="cmbbranch" name="cmbbranch" onchange="loads();getInitChartData();" value='<s:property value="cmbbranch"/>' style="width:140px;">
  					<option></option>     
				</select>
        </div>          
        <div class="primarypanel custompanel">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
        <div class="actionpanel custompanel">                                                                               
          <button type="button" class="btn btn-default" id="btnproformacreate" data-toggle="tooltip"  title="Proforma Invoice Create" data-placement="bottom"><i class="fa fa-file-text-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btnproformafollowup" data-toggle="tooltip"  title="Proforma Follow Up" data-placement="bottom"><i class="fa fa-id-card-o "  aria-hidden="true"></i></button>        
          <button type="button" class="btn btn-default" id="btninvoiceprocessing"  data-toggle="tooltip" title="Invoice Processing" data-placement="bottom"><i class="fa fa-file-powerpoint-o "  aria-hidden="true"></i></button>        
          <!-- <button type="button" class="btn btn-default" id="btnprogressiveinvoice"  data-toggle="tooltip" title="Progressive Invoice" data-placement="bottom"><i class="fa fa-file-text "  aria-hidden="true"></i></button>          
          <button type="button" class="btn btn-default" id="btnprojectinvoicereturn"  data-toggle="tooltip" title="Project Invoice Return" data-placement="bottom"><i class="fa fa-reply "  aria-hidden="true"></i></button> -->      
          <button type="button" class="btn btn-default" id="btnconfirm"  data-toggle="tooltip" title="Confirm" data-placement="bottom"><i class="fa fa-check-circle "  aria-hidden="true"></i></button>              
        </div>          
        <div class="otherpanel custompanel">                    
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
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
        <div id="opadiv"><jsp:include page="opaccountGrid.jsp"></jsp:include></div>                 
      </div>
    </div>    

   <!--Proforma Create Modal-->      
    <div id="modalproformacreate" class="modal fade" role="dialog">      
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Proforma Invoice Create</h4>                              
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">   
	       <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">PO NO</div>          
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">    
            			 <input type="text" id="proinvno" name="proinvno" class="form-control input-sm"/>   
					</div>  
           </div>  
	        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">PO Date</div>                
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">  
            			<div id="invdate" style="border: 1px solid black" style="width:69%;" class="form-control input-sm"></div>   
					</div>  
          </div>  
          <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">Description</div>  
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">  
            			 <textarea class="form-control" rows="3" placeholder="Description" id="invdesc"></textarea>
					</div>  
          </div>
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">  
		          <button type="button" class="btn btn-default" onclick="funProformaInvoice();">SAVE</button>     
		            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
		          </div>                 
		        </div>
		      </div>
	</div>    	    
	
	<!--Proforma Followup Modal-->        
    <div id="modalproformafollowup" class="modal fade" role="dialog">    
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Proforma Follow Up</h4>                             
          </div>     
      <div class="modal-body"> 
	    <div class="container-fluid">  
	    <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Process</div>    
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<select id="cmbprocess" name="cmbprocess"></select>  
					</div>  
         </div>      
	        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Date</div>      
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="flwupdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div> 
					</div>  
        </div>  
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>  
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="flwupdesc"></textarea>
					</div>  
        </div>
        <div class="row">      
		      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
		        <div id="flwupdiv"><jsp:include page="proformaflwupGrid.jsp"></jsp:include></div>                          
		      </div>
        </div>
		</div>
		<div class="clear"></div>    
		</div>  
		          <div class="modal-footer" style="background-color:#CDFDFA">  
		          <button type="button" class="btn btn-default" onclick="funproformafollowup();">SAVE</button>     
		            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
		          </div>                 
		        </div>
		      </div>
	</div>
	
	<!--Invoice Processing Modal-->      
    <div id="modalinvoiceprocessing" class="modal fade" role="dialog">      
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Invoice Processing</h4>                              
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">   
	       <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">PO NO</div>          
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">    
            			 <input type="text" id="invno" name="invno" class="form-control input-sm"/> 
					</div>  
           </div>  
	        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">PO Date</div>            
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">  
            			<div id="invprocessdate" style="border: 1px solid black"   style="width:69%;" class="form-control input-sm"></div>   
					</div>  
          </div>  
          <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-3">Description</div>  
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-9">  
            			 <textarea class="form-control" rows="3" placeholder="Description" id="invprocessdesc"></textarea>
					</div>  
          </div>
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">  
		          <button type="button" class="btn btn-default" onclick="funinvoiceprocessing();">SAVE</button>     
		            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
		          </div>                 
		        </div>
		      </div>
	</div>  
	 <!-- Progressive Invoice Modal-->
    <div id="modalprogressiveinvoice" class="modal fade" role="dialog">          
      <div class="modal-dialog modal-xl">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Progressive Invoice</h4>                                 
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">   
	   <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">Certified Percentage</div>    
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">  
            			<input type="text" name="certifyper"  id="certifyper"> 
            		</div> 
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">Description</div>  
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-4">    
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="progressdesc"></textarea>
					</div> 
					<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2"> 
            		     <button type="button" class="btn btn-default" id="btncertycomplete" onclick="funcompletionsave();">Save</button>    
            		     <button type="button" class="btn btn-default" id="btncertycalc" onclick="funcalculate();">Calculate</button> 
            		</div>          
        </div>
         <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">Payment Value</div>    
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">  
            			<input type="text" name="paymentvalue"  id="paymentvalue" readonly>   
            		</div>
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">Already Invoiced</div>      
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">  
            			<input type="text" name="alreadyinvoiced"  id="alreadyinvoiced" readonly>   
            		</div> 
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">To Be Invoiced</div>    
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">  
            			<input type="text" name="tobeinvoiced"  id="tobeinvoiced" readonly>     
            		</div>          
        </div>
         <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">Retention Amount</div>      
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">  
            			<input type="text" name="retentionamount"  id="retentionamount" readonly>     
            		</div>   
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">Invoice Date</div>        
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">  
            			<div id="progressdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>     
					</div>       
        </div> 
        <div class="row rowgap">     
            		<div class="col-xs-12 col-sm-12 col-md-2 col-lg-2">Invoice Description</div>      
            		<div class="col-xs-12 col-sm-12 col-md-10 col-lg-10">    
            			 <input type="text" style="width:100%;" placeholder="Description" id="invoicedesc"/>  
					</div>  
        </div> 
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">    
		            <button type="button" class="btn btn-default" id="btnprogresssave" onclick="funProgressiveInvoice();">SAVE</button>
		            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
		          </div>                 
		        </div>
		      </div>  
	</div> 
	<!--Project Invoice Return Modal-->      
    <div id="modalprojectinvoicereturn" class="modal fade" role="dialog">      
      <div class="modal-dialog">
        <div class="modal-content"> 
          <div class="modal-header" style="background-color:#CDFDFA">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title" style="text-align:center">Project Invoice Return</h4>                              
          </div>  
      <div class="modal-body"> 
	    <div class="container-fluid">     
	        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Inv Date</div>        
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			<div id="invreturndate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>   
					</div>  
        </div> 
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Amount</div>            
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">    
            			 <input type="text" id="invreturnamount"/>    
					</div>  
        </div> 
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Legal Fee</div>            
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">    
            			 <input type="text" id="invreturnlegalfee"/>    
					</div>  
        </div> 
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Description</div>  
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">  
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Description" id="invreturndesc"></textarea>
					</div>  
        </div>
        <div class="row rowgap">   
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">Notes</div>            
            		<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">    
            			 <textarea class="textarea-simple-1" style="width:100%;height:80px;" placeholder="Notes" id="invreturnnotes"></textarea>  
					</div>  
        </div>
		</div>
		<div class="clear"></div>    
		</div>
		          <div class="modal-footer" style="background-color:#CDFDFA">  
		          <button type="button" class="btn btn-default" onclick="funinvoicereturn();">SAVE</button>        
		            <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
		          </div>                 
		        </div>
		      </div>
	</div>  	    

  <input type="hidden" name="divname" id="divname">       
  <input type="hidden" name="hidcomments" id="hidcomments">
  <input type="hidden" name="jobdocno" id="jobdocno">    
  <input type="hidden" name="jobvocno" id="jobvocno">   
  <input type="hidden" name="brhid" id="brhid">  
  <input type="hidden" name="dtype" id="dtype">         
  <input type="hidden" name="pdrowno" id="pdrowno">            
  <input type="hidden" name="cldocno" id="cldocno"> 
  <input type="hidden" name="reten" id="reten"> 
  <input type="hidden" name="contractval" id="contractval">    
  <input type="hidden" name="invoiced" id="invoiced"> 
  <input type="hidden" name="ppivdocno" id="ppivdocno"> 
  <input type="hidden" name="certydesc" id="certydesc"> 
  <input type="hidden" name="certyper" id="certyper"> 
  <input type="hidden" name="pjivtrno" id="pjivtrno">  
  <input type="hidden" name="ccdocno" id="ccdocno"> 
  <input type="hidden" name="invprog" id="invprog"> 
  <input type="hidden" name="hidinvamount" id="hidinvamount">    
  
  <input type="hidden" name="hidretbalamt" id="hidretbalamt">    
  <input type="hidden" name="hidretballegchrg" id="hidretballegchrg"> 
  <input type="hidden" name="hidretamount" id="hidretamount">    
  <input type="hidden" name="hidretlegalcharge" id="hidretlegalcharge">            
   
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip(); 
    	$("#invprocessdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
    	$("#flwupdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
    	$("#invdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
    	$("#invreturndate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true}); 
     	$("#progressdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
    	getInitChartData(); 
    	//inputload();
    	document.getElementById('selecteddiv').innerHTML=" - Proforma";    
    	document.getElementById("divname").value="proforma";
    	
    	
        $('#btnsubmit').click(function(){    
        	clearfields();      
            loads(); 
            getInitChartData(); 
        }); 
    	$('#btnconfirm').click(function(){     
        	var rowno=$('#pdrowno').val();
	    	if(rowno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	} 
	    	funconfirm(rowno);       
        });
    	$('#btnprojectinvoicereturn').click(function(){     
        	var enqno=$('#jobdocno').val();
        	var retbalamt=$('#hidretbalamt').val();
        	var retballegchrg=$('#hidretballegchrg').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	} 
	    	funRoundAmt(retbalamt,"invreturnamount");  
	    	funRoundAmt(retballegchrg,"invreturnlegalfee");     
	    	$("#modalprojectinvoicereturn").modal('toggle');     
        });
        $('#btnproformacreate').click(function(){   
        	var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	} 
	    	$("#modalproformacreate").modal('toggle');     
        });
        $('#btnproformafollowup').click(function(){   
        	var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;  
	    	}   
		    $('#flwupdiv').load('proformaflwupGrid.jsp?trno='+enqno+'&id=1');       
	    	$("#modalproformafollowup").modal('toggle');  
        });
        $('#btninvoiceprocessing').click(function(){      
	        var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	}
	    	$("#modalinvoiceprocessing").modal('toggle');        
        });
        $('#btnprogressiveinvoice').click(function(){         
        	var enqno=$('#jobdocno').val();
	    	if(enqno==""){
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
	    		return false;
	    	} 
	    	$('#progressdesc').val($('#certydesc').val());       
	    	$('#certifyper').val($('#certyper').val());
	    	$('#invoicedesc').attr('disabled', true);
			$('#invoicedesc').attr('readonly', true);  
			$('#progressdate').jqxDateTimeInput({ disabled: true}); 
			var ccdocno=$('#ccdocno').val();
			if(parseInt(ccdocno)==0){       
				$('#btncertycalc').attr('disabled', true);
				$('#btnprogresssave').attr('disabled', true); 
				$('#btncertycomplete').attr('disabled', false);  
			}else{
				$('#btncertycalc').attr('disabled', false);  
				$('#btncertycomplete').attr('disabled', true);  
			}
			document.getElementById("paymentvalue").value="";
			document.getElementById("alreadyinvoiced").value=""; 
			document.getElementById("tobeinvoiced").value="";
			document.getElementById("retentionamount").value="";   
	    	$("#modalprogressiveinvoice").modal('toggle');      
        });
        $('#btnattachs').click(function(){   
        	funAttachs(event);      
        });
         
        $('#btnexcel').click(function(){  
        	$("#opadiv").excelexportjs({
        		containerid: "opadiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxopaccountGrid", 
        		columns: getColumns("jqxopaccountGrid") ,     
        		worksheetName:"Op Accounting"    
         		});
        });
        
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#jqxEnquiryGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
    function funRoundAmt(value,id){
        var res=parseFloat(value).toFixed(window.parent.amtdec.value);
        var res1=(res=='NaN'?"0":res);
        document.getElementById(id).value=res1;  
       }
    function funselect(){
		var rect =  $('#rect').val();
		if(rect=="1")
			{
			$('#txtdesc').attr("disabled",false);
			}
		else{
			document.getElementById("txtdesc").value ="";  
			$('#txtdesc').attr("disabled",true);
		}
	}
    function clearfields(){
    	$('.textpanel p').text(''); 
    	document.getElementById("jobdocno").value="";  
    	document.getElementById("jobvocno").value=""; 
    	document.getElementById("brhid").value=""; 
    	document.getElementById("hidcomments").value="";  
  /*   	document.getElementById("schtrno").value="";  
    	document.getElementById("surtrno").value="";  
    	document.getElementById("cldocno").value="";  
    	document.getElementById("address").value="";  
    	document.getElementById("client").value="";  
    	document.getElementById("pertel").value="";  
    	document.getElementById("per_mob").value="";  
    	document.getElementById("mail1").value="";  
    	document.getElementById("salname").value="";  
    	document.getElementById("salid").value="";  
    	document.getElementById("esttrno").value="";  
    	document.getElementById("txtcpersonid").value="";  
    	document.getElementById("txtcperson").value="";  
    	document.getElementById("txtcpersondet").value="";  
    	document.getElementById("txtsjobtype").value="";  
    	document.getElementById("txtclienttaxper").value=""; 
		document.getElementById("contrtype").value=""; 
		document.getElementById("cpersonmob").value="";  */
	
    }
    function getInitChartData(){
		  var x=new XMLHttpRequest();
		  x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
				var items=x.responseText.trim();
				var guagedata=JSON.parse(items);           
		        
				$("#proforma").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.proformacount);
	          	$("#notrcvd").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.notrcvdcount);	
	          	$("#invpro").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.invprocount);
	          	$("#tobecnfmed").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.tobecnfmedcount);     
				
			}
			else{    
			}
		}
		x.open("GET","getInitChartData.jsp?brhid="+$("#cmbbranch").val(),true);                          
		x.send();    
	 }
   
    function inputload(){
    	 var assgnid=document.getElementById("hidgroupid").value;
		 $('#groupmember').load('servicegrptoearch.jsp?assgnid='+assgnid);    
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
    	$("#jqxEnquiryGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxEnquiryGrid").jqxGrid('applyfilters');
 	}
     
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var brhid=$("#cmbbranch").val();
	    var divname=$("#divname").val();
	    $('#opadiv').load('opaccountGrid.jsp?divname='+divname+'&brhid='+brhid+'&id=1');      
    }   

	function funAttachs(event){                         
		var brchid="<%= session.getAttribute("BRANCHID").toString() %>";    
   		var docno=document.getElementById("jobvocno").value; 
   		var url=document.URL;
		var reurl=url.split("com/");
 		if(docno!="" && docno!="0"){                
   			var frmdet="SJOB"; 
   			var fname="Job Contract";   
   		    var  myWindow= window.open(reurl[0]+"/com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
   		}else{   
			swal({
				type: 'warning',
				title: 'Warning',
				text: 'Select a Document....!'                                   
			});
			return;
		    }               
	   }     
 	$('div').click(function() {
		  var divid=$(this).attr('id');  
		  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){
			  var realid=divid.replace(/div/g, "");
			  if(realid=="proforma" || realid=="notrcvd" || realid=="invpro" || realid=="tobecnfmed"){ 
				  clearfields();      
				  document.getElementById("divname").value=realid;       
				  loads();            
			  }
			  if(realid=="proforma"){ 
				  document.getElementById('selecteddiv').innerHTML=" - Proforma";  
			  }else if(realid=="notrcvd"){
				  document.getElementById('selecteddiv').innerHTML=" - To Be Accepted";  
			  }else if(realid=="invpro"){
				  document.getElementById('selecteddiv').innerHTML=" - Invoice Processing"; 
			  }else if(realid=="tobecnfmed"){
				  document.getElementById('selecteddiv').innerHTML=" - To Be Confirmed";
			  }else{}   
		  }
	  });  
	function getBranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
				items = items.split('####');
				
				var branchIdItems  = items[0].split(",");
				var branchItems = items[1].split(",");
				var perm = items[2];  
				var optionsbranch;
				 if(perm==0){
				 optionsbranch = '<option value="a" selected>All</option>';
				}
				else{    
					
				}
				for (var i = 0; i < branchItems.length; i++) {
					optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
							+ branchItems[i] + '</option>';
				}
				$("select#cmbbranch").html(optionsbranch);
				/* if ($('#hidcmbbranch').val() != null) {
					$('#cmbbranch').val($('#hidcmbbranch').val());
				} */
			} else {
				//alert("Error");
			}  
		}
		x.open("GET","<%=contextPath%>/com/dashboard/getBranch.jsp", true);  
		x.send();
	}
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option  value="' + srno[i].trim() + ':'+ process[i].trim() +'">'
					+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);  
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}
	
	function funProformaInvoice(){      
		 var invno=$('#proinvno').val();
		 var invdate=$('#invdate').val();
		 var invdesc=$('#invdesc').val();
		 invdesc = invdesc.replace(/\n/g, " ");
		 var jobdocno=$('#jobdocno').val();
		 var pdrowno=$('#pdrowno').val();  
		 var brhid=$('#brhid').val();  
		 if(jobdocno==""){  
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document!!!'                                          
				});
			 return false;
		 } 
		 if(invdate==""){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Invoice Date is Madatory'                                        
				});
			 return false;
		 }
		 if(invno==""){    
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please enter PO No'                                          
				});
			 return false;
		 }  
		 $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){       
	 			if (r){
	 				saveProformaInvoice(invdate,invdesc,jobdocno,pdrowno,brhid,invno);           
	 			}
		 });
	
	 }    
	
     function saveProformaInvoice(invdate,invdesc,jobdocno,pdrowno,brhid,invno){            	
        var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");  
				if(parseInt(items[0])>0){     
					swal({
						type: 'success',
						title: 'Success',
						text: 'PINV - '+items[1]+' Successfully Generated'         
					});
					document.getElementById("invdesc").value="";
					$('#invdate').val(new Date());   
					loads();
					getInitChartData();    
					$("#modalproformacreate").modal('toggle');      
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Generated'    
					});
				}
			}
			else
			{
			}         
		}
		x.open("GET","saveProformaInvoice.jsp?invdate="+invdate+"&invdesc="+encodeURIComponent(invdesc)+"&jobdocno="+jobdocno+"&pdrowno="+pdrowno+"&brhid="+brhid+"&invno="+invno,true);       
		x.send();  
   }
   
 	function funinvoiceprocessing(){      
		 var invdate=$('#invprocessdate').val();
		 var invdesc=$('#invprocessdesc').val(); 
		 var invno=$('#invno').val();    
		 invdesc = invdesc.replace(/\n/g, " ");  
		 var jobdocno=$('#jobdocno').val();
		 var pdrowno=$('#pdrowno').val();  
		 var brhid=$('#brhid').val();  
		 if(jobdocno==""){  
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document!!!'                                          
				});
			 return false;
		 } 
		 if(invdate==""){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Invoice Date is Madatory'                                        
				});
			 return false;
		 }
		 if(invno==""){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please enter PO No'                                          
				});
			 return false;
		 }  
		 $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){       
	 			if (r){
	 				saveinvoiceprocessing(invdate,invdesc,jobdocno,pdrowno,brhid,invno);                 
	 			}
		 });   
	
	 }    
	
    function saveinvoiceprocessing(invdate,invdesc,jobdocno,pdrowno,brhid,invno){            	
       var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");  
				if(parseInt(items[0])>0){     
					swal({
						type: 'success',
						title: 'Success',
						text: 'SRS - '+items[1]+' Successfully Generated'             
					});
					//$('#pjivtrno').val(items[1]);       
					document.getElementById("invprocessdesc").value="";   
					document.getElementById("invno").value="";    
					$('#invprocessdate').val(new Date());  
					loads();
					getInitChartData(); 
					$("#modalinvoiceprocessing").modal('toggle');      
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Generated'      
					});
				}
			}
			else
			{
			}                   
		}
		x.open("GET","saveInvoiceProcessing.jsp?invdate="+invdate+"&pono="+invno+"&invdesc="+encodeURIComponent(invdesc)+"&jobdocno="+jobdocno+"&pdrowno="+pdrowno+"&brhid="+brhid,true);    
		x.send();    
  } 
    
	function funproformafollowup(){  
		var pro= $('#cmbprocess').val().split(":");
		var bibid=pro[0].trim();
		var proname=pro[1].trim();
		var date =  $('#flwupdate').val();
		var branchid = $('#brhid').val();
		var remarks = $('#flwupdesc').val();
		var docno = $('#jobdocno').val();
		var rdtype = $('#dtype').val();
	
		
		if(bibid==''){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Choose a Process.'                                        
				});
			 return 0;
		 }
		 if(remarks==''){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please Enter Remarks.'                                        
				});
			 return 0;
		 }
		
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveFlwupData(bibid,proname,date,branchid,docno,rdtype,remarks);	
		     	}
		});
	} 
	function saveFlwupData(bibid,proname,date,branchid,docno,rdtype,remarks){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
				var items=x.responseText;
				if(parseInt(items)=="1"){	  
					$('#cmbprocess').val('');
					$('#flwupdate').val(new Date());  
					$('#flwupdesc').val('');
					swal({
						type: 'success',
						title: 'Success',
						text: 'Record Successfully Updated'        
					});
					$("#modalproformafollowup").modal('toggle'); 
					loads();
					getInitChartData();
				}else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Updated'    
					});
				}
			}   
		}
	x.open("GET","saveFlwupData.jsp?bibid="+bibid+"&proname="+proname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&rdtype="+rdtype+"&remarks="+remarks,true);
	x.send();
	}
	
	function funcompletionsave(){           
		 var certifyper=$('#certifyper').val();
		 var progressdesc=$('#progressdesc').val();   
		 progressdesc = progressdesc.replace(/\n/g, " ");  
		 var jobdocno=$('#jobdocno').val();  
		 var brhid=$('#brhid').val(); 
		 var cldocno=$('#cldocno').val();  
		 var pdrowno=$('#pdrowno').val();  
		 var contractval=$('#contractval').val();    
		 if(jobdocno==""){  
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document!!!'                                          
				});
			 return false;
		 } 
		 if(certifyper==""){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Certified Percentage is Madatory'                                          
				});
			 return false;    
		 }
		    
		 $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){          
	 			if (r){
	 				completioncertificate(certifyper,progressdesc,jobdocno,cldocno,brhid,pdrowno,contractval);              
	 			}
		 });
	
	 }    
	
    function completioncertificate(certifyper,progressdesc,jobdocno,cldocno,brhid,pdrowno,contractval){                  	
       var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");  
				if(parseInt(items[0])>0){     
					swal({
						type: 'success',
						title: 'Success',
						text: ' Successfully Saved'         
					});
					document.getElementById("certifyper").value="";
					document.getElementById("progressdesc").value=""; 
					document.getElementById("ccdocno").value=items[1];            
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Saved'    
					});
				}
			}
			else
			{
			}         
		}
		x.open("GET","savecompletioncertificate.jsp?certifyper="+certifyper+"&contractval="+contractval+"&progressdesc="+encodeURIComponent(progressdesc)+"&jobdocno="+jobdocno+"&pdrowno="+pdrowno+"&cldocno="+cldocno+"&brhid="+brhid,true);      
		x.send();  
    }
	
    function funcalculate(){
		$('#invoicedesc').attr('disabled', false);
		$('#invoicedesc').attr('readonly', false);  
		$('#progressdate').jqxDateTimeInput({ disabled: false});
		var cval=parseFloat(document.getElementById("contractval").value);
		var cper=document.getElementById("certifyper").value;
		var retn=document.getElementById("reten").value;
		var ctotinv=parseFloat(document.getElementById("invoiced").value);  
		var tobeinv=parseFloat(cval)*(parseFloat(cper)/100);
		var tobeinvoiced=parseFloat(tobeinv)-parseFloat(ctotinv);
		var retnamt1=parseFloat(tobeinvoiced)*(parseFloat(retn)/100);
		var retnamt=retnamt1.toFixed(2);
		
		document.getElementById("paymentvalue").value=cval.toFixed(2);
		document.getElementById("alreadyinvoiced").value=ctotinv.toFixed(2); 
		document.getElementById("tobeinvoiced").value=tobeinvoiced.toFixed(2);
		document.getElementById("retentionamount").value=retnamt;
		$('#btnprogresssave').attr('disabled', false);   
  } 
    
	function funProgressiveInvoice(){  
		 var cval=$('#paymentvalue').val();
		 var ctotinv=$('#alreadyinvoiced').val();
		 var tobeinvoiced=$('#tobeinvoiced').val();
		 var retnamt=$('#retentionamount').val();   
		 
		 var invdates=$('#progressdate').val();
		 var invdescp=$('#invoicedesc').val();   
		 invdescp = invdescp.replace(/\n/g, " ");    
		 var contrno=$('#jobdocno').val();  
		 var docno=$('#ccdocno').val();    
		 var brhid=$('#brhid').val();  
		 var pdrowno=$('#pdrowno').val();      
		    
		 $.messager.confirm('Confirm', 'Do you want to save changes?', function(r){          
	 			if (r){
	 				saveProgressiveInvoice(cval,ctotinv,tobeinvoiced,retnamt,invdates,invdescp,contrno,docno,brhid,pdrowno);                    
	 			}
		 });
	
	 }    
	
   function saveProgressiveInvoice(cval,ctotinv,tobeinvoiced,retnamt,invdates,invdescp,contrno,docno,brhid,pdrowno){                  	
      var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("###");     
				if(parseInt(items[0])>0){     
					swal({
						type: 'success',
						title: 'Success',
						text: '  Invoice No. '+items[1]+' is Successfully Generated'         
					});
					document.getElementById("invoicedesc").value="";
					$('#progressdate').val(new Date()); 
					$("#modalprogressiveinvoice").modal('toggle'); 
					//$('#pjivtrno').val(items[2]);        
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Generated'    
					});
				}
			}
			else
			{
			}           
		}
		x.open("GET","saveProgressiveInvoice.jsp?cval="+cval+"&ctotinv="+ctotinv+"&tobeinvoiced="+tobeinvoiced+"&retnamt="+retnamt+"&invdates="+invdates+"&invdescp="+encodeURIComponent(invdescp)+"&docno="+docno+"&contrno="+contrno+"&pdrowno="+pdrowno+"&brhid="+brhid,true);      
		x.send();     
   }
   function invoicebtnenable(){     
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();	
				if(parseInt(items)>0)          
					{  
					 $("#btninvoiceprocessing").attr('disabled', false );     
					}
				else
					{
					 $("#btninvoiceprocessing").attr('disabled', true );           
					}
			} else {  
			}  
		}
		x.open("GET", "getEditStat.jsp?rowno="+$('#pdrowno').val(), true);     
		x.send();
	}
	function funinvoicereturn(){      
		 var invdate=$('#invreturndate').val();
		 var invdesc=$('#invreturndesc').val(); 
		 var invnotes=$('#invreturnnotes').val();  
		 var invamount=$('#invreturnamount').val();
		 var invlegalfee=$('#invreturnlegalfee').val();   
		 var amount=$('#hidretbalamt').val(); 
		 var legalfee=$('#hidretballegchrg').val();   
		 invdesc = invdesc.replace(/\n/g, " ");
		 invnotes = invnotes.replace(/\n/g, " ");         
		 var jobdocno=$('#jobdocno').val();
		 var pdrowno=$('#pdrowno').val();  
		 var brhid=$('#brhid').val();  
		 var retamount=$('#hidretamount').val(); 
		 var retlegalcharge=$('#hidretlegalcharge').val();     
		 if(jobdocno==""){  
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document!!!'                                          
				});
			 return false;
		 } 
		 if(invdate==""){
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Invoice Date is Madatory'                                        
				});
			 return false;
		 }
		 if(parseFloat(invamount)>amount){    
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Amount should be less than or equal to invoice amount!!!'                                              
				});
			 return false;
		 }  
		 if(parseFloat(invlegalfee)>legalfee){    
			 swal({
					type: 'warning',
					title: 'Warning',
					text: 'Legal Fee should be less than or equal to invoice Legal Fee!!!'                                                  
				});
			 return false;
		 } 
		 $.messager.confirm('Confirm', 'Do you want to Generate Invoice Return?', function(r){         
	 			if (r){
	 				saveinvoicereturn(invdate,invdesc,jobdocno,pdrowno,brhid,invnotes,invamount,invlegalfee,retamount,retlegalcharge);                       
	 			}
		 });   
	
	 }    
	
   function saveinvoicereturn(invdate,invdesc,jobdocno,pdrowno,brhid,invnotes,invamount,invlegalfee,retamount,retlegalcharge){              	
      var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim().split("::");  
				if(parseInt(items[0])>0){     
					swal({
						type: 'success',
						title: 'Success',
						text: 'PJIR - '+items[1]+' Successfully Generated'             
					});
					document.getElementById("invreturndesc").value="";   
					document.getElementById("invreturnnotes").value=""; 
					document.getElementById("invreturnamount").value="";
					document.getElementById("invreturnlegalfee").value="";
					$('#invreturndate').val(new Date());  
					$("#modalprojectinvoicereturn").modal('toggle');  
				    $('#hidretbalamt').val(items[2]);
		        	$('#hidretballegchrg').val(items[3]);   
				}
				else{
					swal({
						type: 'error',
						title: 'Error',
						text: 'Not Generated'    
					});
				}
			}
			else
			{
			}                     
		}
		x.open("GET","saveInvoiceReturn.jsp?invdate="+invdate+"&invnotes="+encodeURIComponent(invnotes)+"&invdesc="+encodeURIComponent(invdesc)+"&jobdocno="+jobdocno+"&pdrowno="+pdrowno+"&brhid="+brhid+"&invamount="+invamount+"&invlegalfee="+invlegalfee+"&retamount="+retamount+"&retlegalcharge="+retlegalcharge,true);         
		x.send();    
 }
   function funconfirm(rowno){
	   $.messager.confirm('Confirm', 'Do you want to Confirm?', function(r){         
			if (r){
				saveConfirm(rowno);                            
			}
	 });
   }
   function saveConfirm(rowno){              	
	      var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();  
					if(parseInt(items)>0){     
						swal({
							type: 'success',
							title: 'Success',
							text: ' Successfully Confirmed'             
						});
						loads(); 
						getInitChartData();
					}
					else{
						swal({
							type: 'error',
							title: 'Error',
							text: 'Not Confirmed'      
						});
					}
				}
				else
				{
				}                     
			}
			x.open("GET","saveConfirm.jsp?rowno="+rowno,true);              
			x.send();    
	 }
  </script>
  </div>
  </form>  
</body>
</html>
