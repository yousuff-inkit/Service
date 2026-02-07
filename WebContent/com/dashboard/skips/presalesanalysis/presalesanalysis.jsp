<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="s" uri="/struts-tags" %>   
  <% String contextPath=request.getContextPath();%>   

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
    .card-container{
        background-color: var(--white);
        box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);   
        border-radius: 8px;
        margin-bottom: 10px;
		background-color:#fff;
    }
    .card-container .card-body{
        width: 100%;
        padding-top: 8px;
        padding-bottom: 8px;
    } 
     .card-container .card-body .card-chart-container,.card-icon-container{
        width: 30%;
        text-align: right;
        vertical-align: middle;
    } 
     .card-container .card-body .card-detail-container{
        width:68%;
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
    /*  .card-container{
     background-color: var(--white);
     box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
    }
    .card-container .card-body{
     width: 100%; 
     padding-top: 2px; 
    }
     .card-container .card-body .card-chart-container,.card-icon-container{
      width: 20%;
      text-align: center;
      icon-align: center;
     }
     .card-container .card-body .card-detail-container{
      width:20%;
      vertical-align: center;
     }  */
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
    .custompanel2{
      float: left;
      display: inline-block;
      /* margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px; */  
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
    .textpanel{
      color: blue;
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
  .padtop{
        padding-top: 5px; 
    }
    body{
    overflow:hidden;
    }
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
      	<div class="row padtop">
      	<div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="allitemdiv">    
                <div class="card-container">
                    <div class="card-body text-center">
                        <!-- <div class="card-chart-container">   -->
                            <div id="allitem"></div>
                            <%-- <span><img src="../icons/icons-all.png" alt="" width="30" height="30"></span> --%>   
                        <!-- </div>   -->
                        <div class="card-detail-container">
                             <span>All</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
           <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="enqdiv">    
                <div class="card-container">
                    <div class="card-body text-center">
                       <!--  <div class="card-chart-container">   -->   
                            <div id="enq"></div>
                           <%--  <span><img src="../icons/icons-collaboration.png" alt="" width="30" height="30"></span>  
                        </div> --%>
                        <div class="card-detail-container">
                             <span>Enquired</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="enqdclddiv">        
                <div class="card-container">
                    <div class="card-body text-center">
                     <!--    <div class="card-chart-container">       -->
                            <div id="enqdcld"></div>
                           <%--  <span><img src="../icons/icons-collaboration.png" alt="" width="30" height="30"></span>  
                        </div> --%>   
                        <div class="card-detail-container">
                             <span>Enq.Dcld</span><br/>          
                             <span class="counter">0</span>       
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="qotdclddiv">         
                <div class="card-container">
                    <div class="card-body  text-center">
                       <!--  <div class="card-chart-container"> -->
                            <div id="qotdcld"></div>  
                          <%--   <span><img src="../icons/icons-survey.png" alt="" width="30" height="30"></span> 
                        </div> --%>
                        <div class="card-detail-container">
                             <span>Qot.Dcld</span><br/>         
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>	
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="unmgapdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                       <!--  <div class="card-chart-container">   -->
                            <div id="unmgap"></div>
                           <%--  <span><img src="../icons/icons-decision.png" alt=""  width="30" height="30"></span> 
                        </div> --%>
                        <div class="card-detail-container">
                             <span>Under.Mng</span><br/>  
                             <span class="counter">0</span>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="quotdiv">   
                <div class="card-container">
                    <div class="card-body  text-center">
                       <!--  <div class="card-chart-container"> -->
                            <div id="quot"></div>
                            <%-- <span><img src="../icons/icons-paycheque.png" alt="" width="30" height="30"></span> 
                        </div> --%>
                        <div class="card-detail-container">
                             <span>Exst.Client</span><br/>       
                             <span class="counter">0</span>
                        </div>
                    </div>
                </div>
            </div>	
             <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="newcrmdiv">       
                <div class="card-container">
                    <div class="card-body  text-center">
                     <!--    <div class="card-chart-container"> -->
                            <div id="newcrm"></div>
                           <%--  <span><img src="../icons/icons-survey.png" alt="" width="30" height="30"></span> 
                        </div> --%>
                        <div class="card-detail-container">
                             <span>New.CRM</span><br/>       
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>	
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="apprdiv">      
                <div class="card-container">
                    <div class="card-body  text-center">
                      <!--   <div class="card-chart-container"> -->
                            <div id="appr"></div>    
                            <%-- <span><img src="../icons/icons-survey.png" alt="" width="30" height="30"></span> 
                        </div> --%>
                        <div class="card-detail-container">     
                             <span>Approved</span><br/>         
                             <span class="counter">0</span>    
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="chklistdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                       <!--  <div class="card-chart-container">  -->
                            <div id="chklist"></div>
                         <%--   <span><img src="../icons/icons-ok.png" alt="" width="30" height="30"></span>  
                        </div> --%>  
                        <div class="card-detail-container">
                            <span>Checklist</span><br/>
                             <span class="counter">0</span>
                        </div>
                    </div>
                </div>
            </div> 
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="allqotdiv">      
                <div class="card-container">
                    <div class="card-body text-center">
                        <!-- <div class="card-chart-container">   -->   
                            <div id="allqot"></div>
                            <%-- <span><img src="../icons/icons-all.png" alt="" width="30" height="30"></span> --%>   
                        <!-- </div>   -->
                        <div class="card-detail-container">  
                             <span>All Quote</span><br/>        
                             <span class="counter">0</span>  
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-sm-6 col-md-1 col-lg-1" id="amcdiv"> 
                <div class="card-container">
                    <div class="card-body  text-center">
                         <!-- <div class="card-chart-container">  -->
                            <div id="amc"></div>
                           <%--  <span><img src="../icons/icons-ledger.png" alt=""  width="30" height="30"></span> --%> 
                        <!-- </div>  -->
                        <div class="card-detail-container">
                            <span>Contracted</span><br/>
                             <span class="counter">0</span>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <form class="form-inline"> 
        <div class="primarypanel custompanel">
	                       <div class="form-group col-auto">
				           <label class="form-group" for="cmbbranch">Branch:</label>
    						<div class="form-group">
      							<select id="cmbbranch" name="cmbbranch" style="width:124px;" onchange="getInitChartData();funload();"></select>
    						</div>
    						<label class="form-group" for="cmbsalesman">Salesman:</label>   
    						<div class="form-group">
      							<select id="cmbsalesman" name="cmbsalesman" style="width:150px;" onchange="getInitChartData();funload();"></select>  
    						</div>
    						<label class="form-group" for="cmbtype">Type</label>  
    						<div class="form-group">
      							<select id="cmbtype" name="cmbtype" style="width:80%;" onchange="funchangetype();">              
                                 	<option value="enq">Enquiry</option><option value="qot">Quoted</option><option value="cnt">Contracted</option>
                                </select>
                           <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>
    						</div>  
    						</div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="fromdate">From:</label>
    						<div class="form-group mb-2">
      							<div id='fromdate' name='fromdate'></div>
    						</div> </div>
    						 <div class="form-group mb-2">
    						<label class="form-group mb-2" for="todate">To:</label>   
    						<div class="form-group mb-2">
      							<div id='todate' name='todate'></div>      
			               </div> 	</div>
			                </div>		      
					  <div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div>
         <div class="otherpanel custompanel">            
          <button type="button" class="btn btn-default" id="btnenqview"><i class="fa fa-etsy" aria-hidden="true" data-toggle="tooltip"  title="View Enquiry" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnquoteview"><i class="fa fa-quora" aria-hidden="true" data-toggle="tooltip"  title="View Quotation" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnchecklist"><i class="fa fa-check-circle" aria-hidden="true" data-toggle="tooltip"  title="Checklist" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncontractview"><i class="fa fa-scribd" aria-hidden="true" data-toggle="tooltip"  title="View Service Contract" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btnsalesmanwise"><i class="fa fa-bar-chart" aria-hidden="true" data-toggle="tooltip"  title="Salesman wise Statistics" data-placement="bottom"></i></button>    
          <button type="button" class="btn btn-default" id="btnattachs" data-toggle="modal" data-target="#modalattach" ><i class="fa fa-download" aria-hidden="true" data-toggle="tooltip" title="Attach" data-placement="bottom"></i></button>
          <button type="button" class="btn btn-default" id="btncomment"  data-toggle="modal" data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
         </div>       
				</form>             
			</div> 
		</div>	 
		<div class="row">
           <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	           <div class="textpanel custompanel2" >
				   <label for="divid" id="selecteddiv" style="font-size:75%;padding-right:10px"></label>        
	           </div>  
	           <div class="textpanel custompanel2" >
				    <label for="divid" id="lblselectedrowdetail" style="font-size:75%;"></label>        
	           </div> 
           </div>   
        </div>    
 
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="presalesdiv"><jsp:include page="presalesanalysisGrid.jsp"></jsp:include></div>
      </div>
    </div>
	 <div class="row" style="padding-top: 5px">
    </div>
      <div id="modalchecklist" class="modal fade" role="dialog">  
    	<div class="modal-dialog">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>  
            		<h4 class="modal-title">Checklist<span></span></h4>
          		</div>
          		<div class="modal-body">
	          		<div class="form-horizontal">
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        <div id="chklistDiv"><jsp:include page="checklistGrid.jsp"></jsp:include></div>
					      </div>  
	          		</div>  
	          		<div class="form-horizontal">   
		          		  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					        	<label for="returnedselected" id="returnedstatus"></label>       
					      </div>  
	          		</div>  
          		</div>
          		<div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			<!-- <button type="button" class="btn btn-default btn-primary" id="btnchecklistsave">Save Changes</button>   -->
            		
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
    <div id="modalsalesmanwise" class="modal fade" role="dialog">  
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header" >
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Salesman wise Statistics</h4>      
           <!--  <h6 class="modal-title" style="text-align:center"><label class="status" id="lblclientstatus9" name="lblclientstatus9"></label></h6>   -->
          </div>
          <div class="modal-body">     
          <div id="smldiv"><jsp:include page="salesmanwiseGrid.jsp"></jsp:include></div>  
          </div>
          <div class="modal-footer">
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          		</div> 
        </div>  
      </div>
       <div id="sidesearchwndow">
	   <div ></div>
	</div>
    </div>
 
       <input type="hidden" name="hidreturned" id="hidreturned">        
       <input type="hidden" name="divname" id="divname"> 
       <input type="hidden" id="reportdocno" name="reportdocno">
       <input type="hidden" id="surveydocno" name="surveydocno">
       <input type="hidden" id="enqdocno" name="enqdocno">
       <input type="hidden" id="sitedocno" name="sitedocno" >  
       <input type="hidden" id="reftrno" name="reftrno" >
       <input type="hidden" id="salmanid" name="salmanid" >
       <input type="hidden" id="qottrno" name="qottrno" >
       <input type="hidden" id="qotchkno" name="qotchkno" >
       <input type="hidden" id="brhid1" name="brhid1">  
       <input type="hidden" id="refdtype" name="refdtype">
       <input type="hidden" id="client" name="client">
       <input type="hidden" id="cldocno" name="cldocno">
       <input type="hidden" id="address" name="address">
       <input type="hidden" id="pertel" name="pertel">
       <input type="hidden" id="per_mob" name="per_mob">
       <input type="hidden" id="mail1" name="mail1">
       <input type="hidden" id="salname" name="salname">
       <input type="hidden" id="salid" name="salid" >  
       <input type="hidden" id="hidchecklist" name="hidchecklist">  
       <input type="hidden" id="hidcheckrowno" name="hidcheckrowno"> 
       <input type="hidden" id="hidcmbacgroup" name="hidcmbacgroup">   
       <input type="hidden" id="hidcontrno" name="hidcontrno"> 
       <input type="hidden" id="hidpayterms" name="hidpayterms"> 
       <input type="hidden" id="hidgroupcompanies" name="hidgroupcompanies"> 
       <input type="hidden" id="hidbillingmethod" name="hidbillingmethod">   
       <input type="hidden" id="hidcperson" name="hidcperson"> 
       <input type="hidden" id="hidcpersonid" name="hidcpersonid"> 
       <input type="hidden" id="hiddesignation" name="hiddesignation">          
</div>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){   
    	$('[data-toggle="tooltip"]').tooltip();
		$("#fromdate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		$("#todate").jqxDateTimeInput({ width: '115px', height: '22px',formatString:"dd.MM.yyyy"});
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1));     
		getBranch();getSalesman();
    	
		var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		var onemounth=new Date(fromdates.getFullYear(), fromdates.getMonth(), 1);   
	    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
		$('#todate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			   if(todates<fromdates){      
				   Swal.fire({  
	        			icon: 'warning',
						title: 'Warning',
						text: 'To Date Less Than From Date'
					});
			        return false;  
			  }else{
				  getInitChartData()
			  }     
		 });
		$('#fromdate').on('change', function (event) {
			   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			   var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
			   if(fromdates>todates){  
				   Swal.fire({  
	        			icon: 'warning',
						title: 'Warning',
						text: 'From Date Greater Than To Date' 
					});
			        return false;  
			   }else{
				   getInitChartData()
			   }   
		 });
		document.getElementById('selecteddiv').innerHTML=" - Enquired"; 
    	document.getElementById("divname").value="enq";  
    	 
    	$('#btnattachs').click(function(){   
         	funAttachs(event);      
         });
    	 $('#btnenqview').click(function(){  
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
			viewEnquiry();    
		});
    	$('#btnquoteview').click(function(){    
			 var enqdocno=$('#reftrno').val();
	         if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         var qottrno=$('#qottrno').val();
	         if(qottrno=="" || qottrno=="0"){   
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Quotation is not created'
					});
	        		return false;
	         }
			 viewQuotation();                  
		});
    	$('#btncontractview').click(function(){    
			 var enqdocno=$('#reftrno').val();
	         if(enqdocno==""){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	         var contrno=$('#hidcontrno').val();  
	         if(contrno=="" || contrno=="0"){
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Contract is not created'    
					});
	        		return false;
	         }
	         viewContract();                  
		});
    	 
		$('#btnsalesmanwise').click(function(){  
			  var brhid=$('#cmbbranch').val();
			  var fromdate= $("#fromdate").val();
			  var todate= $("#todate").val();
			$('.load-wrapp').show();  
			$('#modalsalesmanwise').modal('show');  
			$('#smldiv').load('salesmanwiseGrid.jsp?id=1&fromdate='+fromdate+'&todate='+todate+'&brhid='+brhid);                 
		});
		$('#btnchecklist').click(function(){  
			 var enqdocno=$('#reftrno').val();
	        	if(enqdocno==""){
	        		Swal.fire({
						icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
	         }
	        var qotno=$('#qottrno').val();    
		         if(qotno=="" || qotno=="0"){   
		    	      Swal.fire({
		    	    	    icon: 'warning',
		    				 title: 'Warning',
		    				 text: 'Quotation not created'  
		    		  });
		    	       return false;
		    } 
			$('.load-wrapp').show();  
			$('#modalchecklist').modal('show'); 
			$('#chklistDiv').load('checklistGrid.jsp?id=1&docno='+qotno);        
		});
		$('#btnsubmit').click(function(){   
			 $('.load-wrapp').show();
			 getInitChartData();   
			 funload();
		});
		
		$('#btnexcel').click(function(){
			$("#presalesdiv").excelexportjs({  
				containerid: "presalesdiv",
				datatype: 'json',
				dataset: null,
				gridId: "enqlistgrid",
				columns: getColumns("enqlistgrid"),
				worksheetName: "Pre Sales Analysis"
			});
		});
		$('#btncomment').click(function(){
			getComments();
        });
		$('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var reftrno=$('#reftrno').val();
        	if(txtcomment==""){
        		swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(reftrno==""){
        		swal({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
	});
    function getSource(event){
  	  var x= event.keyCode;
  	  if(x==114){
   		 $('#sourcesearchwndow').jqxWindow('open');
   		 sourceinfoSearchContent('searchSource.jsp?', $('#sourcesearchwndow'));   
   	 }
   	 else{
   	 }
    }
    function sourceinfoSearchContent(url) {
  	  $.get(url).done(function (data) {
  		  $('#sourcesearchwndow').jqxWindow('open');
  		  $('#sourcesearchwndow').jqxWindow('setContent', data);
  	  }); 
    }
	function SearchContent(url,id) {
    	$.get(url).done(function (data) {
  			$('#'+id).jqxWindow('setContent', data);
		}); 
	}
	function getComments(){
    	var reftrno=$('#reftrno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				$('.comments-container').html('');
				if(x.responseText.trim()!=""){
					var items=x.responseText.trim().split(",");
					var str='';
					for(var i=0;i<items.length;i++){
						str+='<div class="comment"><div class="msg"><p>'+items[i].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[i].split("::")[1]+' - '+items[i].split("::")[2]+'</p></div></div>';
					}
					$('.comments-container').html($.parseHTML(str));		
				}
			
			}
			else
			{
			}
		}
		x.open("GET","getComments.jsp?reftrno="+reftrno,true);
		x.send();
    }
	function saveComment(){
    	var comment=$('#txtcomment').val();
    	var reftrno=$('#reftrno').val();
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
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&reftrno="+reftrno,true);
		x.send();
    }
 
		function getInitChartData(){
			  var brhid=$('#cmbbranch').val();
			  var type=$('#cmbtype').val();
			  var fromdate= $("#fromdate").val();
			  var todate= $("#todate").val();
			  var salid= $("#cmbsalesman").val();  
			  var x=new XMLHttpRequest();
			  x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200){
					var items=x.responseText.trim();
					var guagedata=JSON.parse(items);           
					$("#allitem").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.allitemcount);
		          	$("#enq").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.enqcount);
		        	$("#quot").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.quotcount);  
		          	$("#newcrm").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.newcrmcount);	
		          	$("#amc").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.amccount);
		        	$("#unmgap").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.unmgapcount);
		        	$("#chklist").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.cklist); 
		        	$("#enqdcld").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.enqdcldcount); 
		        	$("#qotdcld").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.qotdcldcount); 
		        	$("#appr").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.apprcount); 
		        	$("#allqot").closest('.card-container').find('.card-detail-container').find('.counter').text(guagedata.allqotcount); 
				}
				else{  
				}
			}
			x.open("GET","getInitChartData.jsp?brhid="+brhid+'&froms='+fromdate+'&tos='+todate+'&type='+type+'&salid='+salid,true);                                   
			x.send();    
		 }
		$('div').click(function() {
			  var divid=$(this).attr('id');  
			  if(divid!="" && typeof(divid)!="undefined" && typeof(divid)!="NaN" && divid!=null){     
				  var realid=divid.replace(/div/g, "");
				  if(realid=="allitem" ||realid=="enq" || realid=="newcrm" || realid=="amc" || realid=="quot" || realid=="unmgap" || realid=="chklist" || realid=="enqdcld" || realid=="qotdcld" || realid=="appr" || realid=="allqot"){        
					  $('#btnconfirm').attr("disabled",true);
					  document.getElementById("divname").value=realid;
					  document.getElementById('lblselectedrowdetail').innerHTML="";   
					  funload();             
				  }
				  if(realid=="allitem"){ 
					  document.getElementById('selecteddiv').innerHTML=" - All";
			      }else if(realid=="enq"){ 
					  document.getElementById('selecteddiv').innerHTML=" - Enquired";
				  }else if(realid=="newcrm"){
					  document.getElementById('selecteddiv').innerHTML=" - Under Client Creation";     
				  }else if(realid=="amc"){
					  document.getElementById('selecteddiv').innerHTML=" - Contracted";
				  }else if(realid=="quot"){
					  document.getElementById('selecteddiv').innerHTML=" - Quoted";  
				  }else if(realid=="unmgap"){
					  document.getElementById('selecteddiv').innerHTML=" - Under Mngt. Approval";    
				  }else if(realid=="chklist"){
					  document.getElementById('selecteddiv').innerHTML=" - Checklist";    
				  }else if(realid=="enqdcld"){
					  document.getElementById('selecteddiv').innerHTML=" - Enquiry Declined";       
				  }else if(realid=="qotdcld"){
					  document.getElementById('selecteddiv').innerHTML=" - Quote Declined";            
				  }else if(realid=="appr"){   
					  document.getElementById('selecteddiv').innerHTML=" - Approved";                       
				  }else if(realid=="allqot"){   
					  document.getElementById('selecteddiv').innerHTML=" - All Quote";                              
				  }else{}   
			  }
		  });
		function funload(){
			 $('.load-wrapp').show();  
			 var divname=$('#divname').val();  
			 var brhid=$('#cmbbranch').val();
			 var type=$('#cmbtype').val();
			 var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			 var salid= $("#cmbsalesman").val();  
			 $('#presalesdiv').load('presalesanalysisGrid.jsp?id=1&brhid='+brhid+'&froms='+fromdate+'&tos='+todate+'&divname='+divname+'&type='+type+'&salid='+salid);     
		}
		function getSalesman() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var branchIdItems  = items[0].split(",");
					var branchItems = items[1].split(",");
					var perm = items[2];  
					var optionsbranch = '<option value="" selected>-- Select -- </option>';
					for (var i = 0; i < branchItems.length; i++) {
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
					}
					
					$("select#cmbsalesman").html(optionsbranch);
					//getInitChartData();
				} else {
				}  
			}
			x.open("GET","getSalesman.jsp", true);          
			x.send();
		} 
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
					 optionsbranch = '<option value="a" selected></option>';
					}
					else{    
						
					}
					for (var i = 0; i < branchItems.length; i++) {
						optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
								+ branchItems[i] + '</option>';
					}
					$("select#cmbbranch").html(optionsbranch);
					//getInitChartData();
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
		function funAttachs(event){                         
			var brchid=document.getElementById("brhid1").value;  
	   		var docno=document.getElementById("enqdocno").value;  
	   		var url=document.URL;
			var reurl=url.split("com/");
	 		if(docno!="" && docno!="0"){                
	   			var frmdet="ENQ"; 
	   			var fname="Enquiry";
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

		function viewEnquiry(){        
			var refdocno=document.getElementById("enqdocno").value;
			var reftrno=document.getElementById("reftrno").value;
			var address=document.getElementById("address").value;
			var brch=document.getElementById("brhid1").value;
			
			var path1="com/skips/enquiry/enquiry.jsp";  
			var name="Enquiry";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Enquiry";
			window.parent.formCode.value="ENQ";
			window.parent.branchid.value=brch;
			var detName="Enquiry";  
			var mode="view";  
			  
			var path= path1+"?modes="+mode+"&brhid="+brch+"&docno="+reftrno+"&enqdocno="+refdocno;         
			top.addTab( detName,reurl[0]+""+path);
		}
		function viewQuotation(){           
			var qottrno=document.getElementById("qottrno").value;  
			var brch=document.getElementById("brhid1").value; 
			
			var path1="com/skips/quotation/quotation.jsp";      
			var name="Quotation";
			var url=document.URL;  
			var reurl=url.split("com/");

			window.parent.formName.value="Quotation";   
			window.parent.formCode.value="QOT";
			window.parent.branchid.value=brch;             
			var detName="Quotation";  
			var mode="view";  
			  
			var path= path1+"?modes="+mode+"&brhid="+brch+"&qottrno="+qottrno;             
			top.addTab( detName,reurl[0]+""+path);
		}
		function viewContract(){                             
			var contracttrno=document.getElementById("hidcontrno").value;         
			var brch=document.getElementById("brhid1").value; 
			
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
		function funchangetype(){
			 $('.load-wrapp').show();
			 getInitChartData();   
			 funload();    
		} 
</script>
</body>
</html>