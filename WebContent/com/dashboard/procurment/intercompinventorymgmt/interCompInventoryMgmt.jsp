<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
<title>GIP Mgmt</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>

<link rel="stylesheet" href="../../../../vendors/bootstrap-v4/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
<link href="../../../../css/bistyle.css" rel="stylesheet" />
<script src="../../../../vendors/bootstrap-v4/js/bootstrap.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>

<style type="text/css">
	.card-item{
		display:flex;
		justify-content:space-between;
		align-items:center;
	}
	.card-item h6{
		margin-bottom:0;
		font-size:0.9rem;
	}
	.card-controls .card-body{
		margin-bottom:0;
	}
	.card-controls .card-body .form-group{
		margin-bottom:0;
	}
	.card-body{
		padding:0.75rem;
	}
	.form-control{
		font-size:0.85rem;
		
	}
	input.form-control{
		height:28px !important;
	}
	.modal-body{
		padding:10px;
	}
	.form-group{
		margin-bottom:0.2rem;
	}
	.modal-header .close span{
		padding-left: 0.3rem;
    	padding-right: 0.3rem;
	}
	
</style>
</head>
<body >
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  	<div class="container-fluid">
  		<div class="row" style="margin-top:8px;">
			<div class="col">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapsegip">
					<h6><strong>Purchase Order</strong></h6>
					<h2><span class="value">0</span></h2>
				</div>
			</div>
			<div class="col">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapseest">
					<h4><strong>Sales Order</strong></h4>
					<h2><span class="value">0</span></h2>
					
				</div>
			</div>
			<div class="col">
				<div class="card-item"  data-parent="#floorcard" data-toggle="collapse" data-target="#collapsejob">
					<h4><strong>Delivery Note</strong></h4>
					<h2><span class="value">0</span></h2>
				</div>
			</div>
			<div class="col">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapsejcc">
					<h4><strong>Goods Reciept Note</strong></h4>
					<h2><span class="value">0</span></h2>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<div class="card card-controls">
					<div class="card-body">
						<div class="form-inline">
							<div class="form-group mr-2">
								<select name="cmbcompany" id="cmbcompany" class="form-control"><option value="">--Select--</option></select>
							</div>
							<div class="form-group">
								<label class="mr-1">Upto Date</label>
								<div id="uptodate"></div>
							</div>
							<div class="btn-group ml-2">
								<button type="button" class="btn btn-outline-primary " id="btnsubmit" data-toggle="tooltip" data-placement="right" title="Refresh Data"><i class="fa fa-refresh" aria-hidden="true"></i></button>
								<button type="button" class="btn btn-outline-primary " id="btnexcel" data-toggle="tooltip" data-placement="right" title="Refresh Data"><i class="fa fa-file-excel-o" aria-hidden="true"></i></button>																
							</div>
							<div class="btn-group ml-3">
								<button type="button" class="btn btn-outline-primary " id="btnmodalsalesorder" data-toggle="tooltip" data-placement="right" title="Create Sales Order"><i class="fa fa-plus mr-2"></i>Sales Order</button>
								<button type="button" class="btn btn-outline-primary " id="btnmodaldelnote" data-toggle="tooltip" data-placement="right" title="Create Delivery Note"><i class="fa fa-plus mr-2"></i>Delivery Note</button>
								<button type="button" class="btn btn-outline-primary " id="btnmodalGRN" data-toggle="tooltip" data-placement="right" title="Create Goods Reciept Note"><i class="fa fa-plus mr-2"></i>GRN</button>
								<button type="button" class="btn btn-outline-primary " id="btnmodalPIV" data-toggle="tooltip" data-placement="right" title="Create Purchase Invoice"><i class="fa fa-plus mr-2"></i>PIV</button>
								<button type="button" class="btn btn-outline-primary " id="btnmodalINV" data-toggle="tooltip" data-placement="right" title="Create Sales Invoice"><i class="fa fa-plus mr-2"></i>INV</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12 col-12 col-md-12 col-lg-12">
				<div id="maingriddiv"><jsp:include page="purchaseOrderGrid.jsp"></jsp:include></div>
			</div>
		</div>
		
		<div class="modal fade" id="modalcreatesalesorder" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  			<div class="modal-dialog modal-lg" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h6 class="modal-title" id="exampleModalLongTitle">Create Sales Order for <span class="refvocno-text"></span></h6>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      				<div class="modal-body">
      					<div class="form-row">
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="salesorderdate">Date</label>
		    						<div name="salesorderdate" id="salesorderdate"></div>
		  						</div>
      						</div>
      						<div class="col-xs-2">
      							<div class="form-group">
		    						<label for="cmbsalesorderbranch">Branch</label>
		    						<select name="cmbsalesorderbranch" id="cmbsalesorderbranch" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Branch Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-xs-2">
      							<div class="form-group">
		    						<label for="salesorderrefno">Ref No</label>
		    						<input type="text" name="salesorderefno" id="salesorderrefno" class="form-control form-control-sm" placeholder="Reference No">
		  						</div>
      						</div>
      						<div class="col-xs-3">
      							<div class="form-group">
		    						<label for="cmbsalesordercustomer">Client</label>
		    						<select name="cmbsalesordercustomer" id="cmbsalesordercustomer" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Client Mandatory</span>
		  						</div>
      						</div>
      					</div>
      					<div class="form-row row">
      						<div class="col">
      							<div class="form-group">
		    						<label for="salesorderdesc">Description</label>
		    						<input type="text" name="salesorderdesc" id="salesorderdesc" class="form-control form-control-sm" placeholder="Description">
		  						</div>	
      						</div>
      					</div>
      					<div class="row">
      						<div class="colxs-12">
      							<div id="modalsalesorderdiv"><jsp:include page="modalSalesOrderGrid.jsp"></jsp:include></div>
      						</div>
      					</div>
      					
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-outline-secondary " data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary " id="btncreatesalesorder">Save changes</button>
      				</div>
    			</div>
  			</div>
		</div>
		
		<div class="modal fade" id="modalcreatedelnote" tabindex="-1" role="dialog" aria-labelledby="modalcreatedelnote" aria-hidden="true">
  			<div class="modal-dialog modal-lg" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h6 class="modal-title" id="exampleModalLongTitle">Create Delivery Note for <span class="refvocno-text"></span></h6>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      				<div class="modal-body">
      					<div class="form-row">
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="delnotedate">Date</label>
		    						<div name="delnotedate" id="delnotedate"></div>
		  						</div>
      						</div>
      						<div class="col">
      							<div class="form-group">
		    						<label for="cmbdelnotebranch">Branch</label>
		    						<select name="cmbdelnotebranch" id="cmbdelnotebranch" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Branch Mandatory</span>
		  						</div>
      						</div>
      						<div class="col">
      							<div class="form-group">
		    						<label for="cmbdelnotelocation">Location</label>
		    						<select name="cmbdelnotelocation" id="cmbdelnotelocation" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Location Mandatory</span>
		  						</div>
      						</div>
      						<div class="col">
      							<div class="form-group">
		    						<label for="delnoterefno">Ref No</label>
		    						<input type="text" name="delnoterefno" id="delnoterefno" class="form-control form-control-sm" placeholder="Reference No">
		  						</div>
      						</div>
      					</div>
      					<div class="form-row">
      						<div class="col">
      							<div class="form-group">
		    						<label for="delnotedesc">Description</label>
		    						<input type="text" name="delnotedesc" id="delnotedesc" class="form-control form-control-sm" placeholder="Description">
		  						</div>	
      						</div>
      						
      					</div>
      					<div class="row">
      						<div class="col">
      							<div id="modaldelnotediv"><jsp:include page="modalDelNoteGrid.jsp"></jsp:include></div>
      						</div>
      					</div>
      					
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-outline-secondary " data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary " id="btncreatedelnote">Save changes</button>
      				</div>
    			</div>
  			</div>
		</div>
		
		<div class="modal fade" id="modalcreateGRN" tabindex="-1" role="dialog" aria-labelledby="modalcreateGRN" aria-hidden="true">
  			<div class="modal-dialog modal-lg" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h6 class="modal-title" id="exampleModalLongTitle">Create GRN Note for <span class="refvocno-text"></span></h6>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      				<div class="modal-body">
      					<div class="form-row">
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="grndate">Date</label>
		    						<div name="grndate" id="grndate"></div>
		  						</div>
      						</div>
      						<div class="col-sm-4">
      							<div class="form-group">
		    						<label for="cmbgrnbranch">Branch</label>
		    						<select name="cmbgrnbranch" id="cmbgrnbranch" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Branch Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-sm-4">
      							<div class="form-group">
		    						<label for="cmbgrnlocation">Location</label>
		    						<select name="cmbgrnlocation" id="cmbgrnlocation" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Location Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="grnrefno">Ref No</label>
		    						<input type="text" name="grnrefno" id="grnrefno" class="form-control form-control-sm" placeholder="Reference No">
		  						</div>
      						</div>
      					</div>
      					<div class="form-row">
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="grninvdate">Inv.Date</label>
		    						<div name="grninvdate" id="grninvdate"></div>
		  						</div>
      						</div>
      						<div class="col-sm-4">
      							<div class="form-group">
		    						<label for="grninvno">Inv.No</label>
		    						<input type="text" name="grninvno" id="grninvno" class="form-control form-control-sm" placeholder="Invoice No.">
		  						</div>	
      						</div>
      						<div class="col-sm-6">
      							<div class="form-group">
		    						<label for="grndesc">Description</label>
		    						<input type="text" name="grndesc" id="grndesc" class="form-control form-control-sm" placeholder="Description">
		  						</div>	
      						</div>
      					</div>
      					<div class="row">
      						<div class="col">
      							<div id="modalgrndiv"><jsp:include page="modalGRNGrid.jsp"></jsp:include></div>
      						</div>
      					</div>
      					
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-outline-secondary " data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary " id="btncreateGRN">Save changes</button>
      				</div>
    			</div>
  			</div>
		</div>
		
		<div class="modal fade" id="modalcreatePIV" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  			<div class="modal-dialog modal-lg" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h6 class="modal-title" id="exampleModalLongTitle">Create Purchase Invoice for <span class="refvocno-text"></span></h6>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      				<div class="modal-body">
      					<div class="form-row">
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="pivdate">Date</label>
		    						<div name="pivdate" id="pivdate"></div>
		  						</div>
      						</div>
      						<div class="col-sm-3">
      							<div class="form-group">
		    						<label for="cmbpivlocation">Location</label>
		    						<select name="cmbpivlocation" id="cmbpivlocation" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Location Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-sm-3">
      							<div class="form-group">
		    						<label for="cmbpivbilltype">Bill Type</label>
		    						<select name="cmbpivbilltype" id="cmbpivbilltype" class="form-control form-control-sm" style="width:100%;">
		    							<option value="1">VAT</option>
		    							<option value="2">RCM</option>
		    						</select>
		  							<span class="invalid-feedback">Bill Type Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-sm-4">
      							<div class="form-group">
		    						<label for="pivrefno">Ref No</label>
		    						<input type="text" name="pivrefno" id="pivrefno" class="form-control form-control-sm" placeholder="Reference No">
		  						</div>
      						</div>
      					</div>
      					<div class="form-row">
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="pivinvdate">Inv.Date</label>
		    						<div name="pivinvdate" id="pivinvdate"></div>
		  						</div>
      						</div>
      						<div class="col-sm-3">
      							<div class="form-group">
		    						<label for="pivinvno">Inv.No</label>
		    						<input type="text" name="pivinvno" id="pivinvno" class="form-control form-control-sm" placeholder="Invoice No.">
		  						</div>	
      						</div>
      						<div class="col-sm-7">
      							<div class="form-group">
		    						<label for="pivdesc">Description</label>
		    						<input type="text" name="pivdesc" id="pivdesc" class="form-control form-control-sm" placeholder="Description">
		  						</div>	
      						</div>
      					</div>
      					<div class="row">
      						<div class="col-sm-12">
      							<div id="modalpivdiv"><jsp:include page="modalPIVGrid.jsp"></jsp:include></div>
      						</div>
      					</div>
      					
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-outline-secondary " data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary " id="btncreatePIV">Save changes</button>
      				</div>
    			</div>
  			</div>
		</div>
		
		<div class="modal fade" id="modalcreateINV" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  			<div class="modal-dialog modal-lg" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<h6 class="modal-title" id="exampleModalLongTitle">Create Sales Invoice for <span class="refvocno-text"></span></h6>
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
          					<span aria-hidden="true">&times;</span>
        				</button>
      				</div>
      				<div class="modal-body">
      					<div class="form-row">
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="invdate">Date</label>
		    						<div name="invdate" id="invdate"></div>
		  						</div>
      						</div>
      						<div class="col-sm-3">
      							<div class="form-group">
		    						<label for="cmbinvlocation">Location</label>
		    						<select name="cmbinvlocation" id="cmbinvlocation" class="form-control form-control-sm" style="width:100%;"><option value="">--Select--</option></select>
		  							<span class="invalid-feedback">Location Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="cmbinvbilltype">Bill Type</label>
		    						<select name="cmbinvbilltype" id="cmbinvbilltype" class="form-control form-control-sm" style="width:100%;">
		    							<option value="1">VAT</option>
		    							<option value="2">EXPORT</option>
		    						</select>
		  							<span class="invalid-feedback">Bill Type Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-sm-2">
      							<div class="form-group">
		    						<label for="cmbinvvattype">Bill Type</label>
		    						<select name="cmbinvvattype" id="cmbinvvattype" class="form-control form-control-sm" style="width:100%;">
		    							<option value="exclusive">Exclusive</option>
		    							<option value="inclusive">Inclusive</option>
		    							<option value="export">Export</option>
		    						</select>
		  							<span class="invalid-feedback">VAT Type Mandatory</span>
		  						</div>
      						</div>
      						<div class="col-sm-3">
      							<div class="form-group">
		    						<label for="invrefno">Ref No</label>
		    						<input type="text" name="invrefno" id="invrefno" class="form-control form-control-sm" placeholder="Reference No">
		  						</div>
      						</div>
      					</div>
      					<div class="form-row">
      						<div class="col-sm-12">
      							<div class="form-group">
		    						<label for="invdesc">Description</label>
		    						<input type="text" name="invdesc" id="invdesc" class="form-control form-control-sm" placeholder="Description">
		  						</div>	
      						</div>
      					</div>
      					<div class="row">
      						<div class="col-sm-12">
      							<div id="modalinvdiv"><jsp:include page="modalINVGrid.jsp"></jsp:include></div>
      						</div>
      					</div>
      					
      				</div>
      				<div class="modal-footer">
        				<button type="button" class="btn btn-outline-secondary " data-dismiss="modal">Close</button>
        				<button type="button" class="btn btn-primary " id="btncreateINV">Save changes</button>
      				</div>
    			</div>
  			</div>
		</div>
  	</div>
  	<ul class="data-container d-none"></ul>
  	<script type="text/javascript">
  		$(document).ready(function(){
  			$('[data-toggle="tooltip"]').tooltip();
  			$("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$("#salesorderdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$("#delnotedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$("#grndate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$("#grninvdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$("#pivdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$("#pivinvdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$("#invdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
  			$('#cmbcompany').select2({
  				placeholder:'Choose Company',
  				allowClear:true
  			});
  			$('#cmbpivbilltype').select2({
  				placeholder:'Choose Bill Type',
  				allowClear:true
  			});
  			$('#cmbinvbilltype').select2({
  				placeholder:'Choose Bill Type',
  				allowClear:true
  			});
  			$('#cmbinvvattype').select2({
  				placeholder:'Choose VAT Type',
  				allowClear:true
  			});
  			$('#cmbsalesordercustomer').select2({
  				placeholder:'Choose Customer',
  				allowClear:true
  			});
  			
  			getClient();
  			getBranch();
  			getInitData();
  			var activeCardIndex=-1;
  			$('.page-loader').hide();
  			
  			$('.card-item').on('click',function(){
  				$('.card-item').removeClass('active');
  				$(this).addClass('active');
  				activeCardIndex=$('.card-item').index($(this));
  				$('#btnsubmit').trigger('click');
  			});
  			
  			$('#btncreateINV').click(function(){
  				var brhid=$('#modalcreateINV').attr('data-brhid');
  				var locid=$('#cmbinvlocation').val();
  				if(brhid=='' || brhid=='undefined' || brhid==null){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Branch'
    				});
  					return false;
  				}
  				
  				if(locid=='' || locid=='undefined' || locid==null){
  					$('#cmbinvlocation').addClass('is-invalid');
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Location'
    				});
  					return false;
  				}
  				else{
  					$('#cmbinvlocation').removeClass('is-invalid');
  				}
  				
  				var rows=$('#modalINVGrid').jqxGrid('getrows');
  				if(rows.length==0){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select valid products'
    				});
  					return false;
  				}
  				
  				
  				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Sales Invoice?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Save'
				}).then((result) => {
	  				if (result.isConfirmed) {
	  					funCreateINV();
	  				}
				});
  			});
  			
  			$('#btncreateGRN').click(function(){
  				var brhid=$('#cmbgrnbranch').val();
  				var locid=$('#cmbgrnlocation').val();
  				if(brhid=='' || brhid=='undefined' || brhid==null){
  					$('#cmbgrnbranch').addClass('is-invalid');
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Branch'
    				});
  					return false;
  				}
  				else{
  					$('#cmbgrnbranch').removeClass('is-invalid');
  				}
  				if(locid=='' || locid=='undefined' || locid==null){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Location'
    				});
  					return false;
  				}
  				else{
  					$('#cmbgrnlocation').removeClass('is-invalid');
  				}
  				
  				var rows=$('#modalGRNGrid').jqxGrid('getrows');
  				if(rows.length==0){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select valid products'
    				});
  					return false;
  				}
  				
  				
  				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Goods Reciept Note?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Save'
				}).then((result) => {
	  				if (result.isConfirmed) {
	  					funCreateGRN();
	  				}
				});
  			});
  			
  			$('#btncreatedelnote').click(function(){
  				var brhid=$('#cmbdelnotebranch').val();
  				var locid=$('#cmbdelnotelocation').val();
  				if(brhid=='' || brhid=='undefined' || brhid==null){
  					$('#cmbdelnotebranch').addClass('is-invalid');
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Branch'
    				});
  					return false;
  				}
  				else{
  					$('#cmbdelnotebranch').removeClass('is-invalid');
  				}
  				if(locid=='' || locid=='undefined' || locid==null){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Location'
    				});
  					return false;
  				}
  				else{
  					$('#cmbdelnotelocation').removeClass('is-invalid');
  				}
  				
  				var rows=$('#modalDelNoteGrid').jqxGrid('getrows');
  				if(rows.length==0){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select valid products'
    				});
  					return false;
  				}
  				
  				
  				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Delivery Note?",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Save'
				}).then((result) => {
	  				if (result.isConfirmed) {
	  					funDelNoteStockCheck();
	  					//funCreateDelNote();	
	  				}
				});
  			});
  			
  			$('#btncreatesalesorder').click(function(){
  				var brhid=$('#cmbsalesorderbranch').val();
  				var cldocno=$('#cmbsalesordercustomer').val();
  				if(brhid=='' || brhid=='undefined' || brhid==null){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Branch'
    				});
  					return false;
  				}
  				
  				if(cldocno=='' || cldocno=='undefined' || cldocno==null){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Client'
    				});
  					return false;
  				}
  				else{
  					$('#cmbsalesordercustomer').removeClass('is-invalid');
  				}
  				var rows=$('#modalSalesOrderGrid').jqxGrid('getrows');
  				if(rows.length==0){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select valid products'
    				});
  					return false;
  				}
  				
  				
  				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create Sales Order",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Save'
				}).then((result) => {
	  				if (result.isConfirmed) {
	  					funCreateSalesOrder();	
	  				}
				});
  			});
  			
  			$('#btncreatePIV').click(function(){
  				var brhid=$('#modalcreatePIV').attr('data-brhid');
  				var cldocno=$('#modalcreatePIV').attr('data-cldocno');
  				if(brhid=='' || brhid=='undefined' || brhid==null){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Branch'
    				});
  					return false;
  				}
  				
  				if(cldocno=='' || cldocno=='undefined' || cldocno==null){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select Vendor'
    				});
  					return false;
  				}
  				
  				var rows=$('#modalPIVGrid').jqxGrid('getrows');
  				if(rows.length==0){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select valid products'
    				});
  					return false;
  				}
  				
  				
  				Swal.fire({
	  				title: 'Are you sure?',
	  				text: "Do you want to create PIV",
	  				icon: 'warning',
	  				showCancelButton: true,
	  				confirmButtonColor: '#3085d6',
	  				cancelButtonColor: '#d33',
	  				confirmButtonText: 'Save'
				}).then((result) => {
	  				if (result.isConfirmed) {
	  					funCreatePIV();	
	  				}
				});
  			});
  			$('#cmbsalesordercustomer,#cmbsalesorderbranch').change(function(){
  				var brhid=$('#cmbsalesorderbranch').val();
  				var cldocno=$('#cmbsalesordercustomer').val();
  				if(brhid!='' && cldocno!=''){
  					funLoadModalSalesOrder();	
  				}
  			});
  			
  			$('#cmbgrnbranch,#cmbgrnlocation').change(function(){
  				var brhid=$('#cmbgrnbranch').val();
  				var locid=$('#cmbgrnlocation').val();
  				if(brhid!='' && locid!=''){
  					funLoadModalGRN();	
  				}
  			});
  			
  			$('#cmbpivlocation').change(function(){
  				var locid=$('#cmbpivlocation').val();
  				if(locid!=''){
  					funLoadModalPIV();	
  				}
  			});
  			
  			$('#cmbinvlocation').change(function(){
  				var locid=$(this).val();
  				if(locid!=''){
  					funLoadModalINV();	
  				}
  			});
  			$('#cmbdelnotebranch').change(function(){
  				var brhid=$(this).val();
  				if(brhid!=''){
  					funLoadLoc(brhid,'delnote');
  					funLoadModalDelNote();	
  				}
  			});
  			
  			$('#cmbgrnbranch').change(function(){
  				var brhid=$(this).val();
  				if(brhid!=''){
  					funLoadLoc(brhid,'grn');
  				}
  			});
  			$('#btnsubmit').click(function(){
  				var uptodate=$('#uptodate').jqxDateTimeInput('val');
  				if(activeCardIndex==0){//Purchase Order
  					$('#maingriddiv').load('purchaseOrderGrid.jsp?id=1&uptodate='+uptodate);
  				}
  				else if(activeCardIndex==1){//Sales Order
  					$('#maingriddiv').load('salesOrderGrid.jsp?id=1&uptodate='+uptodate);
  				}
  				else if(activeCardIndex==2){//Delivery Note
  					$('#maingriddiv').load('delNoteGrid.jsp?id=1&uptodate='+uptodate);
  				}
  				else if(activeCardIndex==3){//Goods Reciept Note
  					$('#maingriddiv').load('GRNGrid.jsp?id=1&uptodate='+uptodate);
  				}
  				else if(activeCardIndex==4){//Sales Invoice
  					
  				}
  				
  			});
  			
  			$('#btnmodalsalesorder,#btnmodalGRN,#btnmodalPIV,#btnmodalINV').click(function(){
  				
  				var gridid='';
  				if($(this).attr('id')=='btnmodalsalesorder'){
  					gridid='#purchaseOrderGrid';
  				}
  				else if($(this).attr('id')=='btnmodalGRN'){
  					gridid='#purchaseOrderGrid';
  				}
  				else if($(this).attr('id')=='btnmodalPIV'){
  					gridid='#GRNGrid';
  				}
  				else if($(this).attr('id')=='btnmodalINV'){
  					gridid='#delNoteGrid';
  				}
  				var selectedrows=$(gridid).jqxGrid('getselectedrowindexes');
  				if(selectedrows.length==0){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select valid documents'
    				});
  					return false;
  				}
  				
  				var balqty=0;
				var product='';
				var restrictbranch=0;
				
  				var vendor='';
  				var brhid='';
  				var refvocno='';
  				var htmldata='';
  				var cldocno='';
  				
  				
  				for(var i=0;i<selectedrows.length;i++){
  					
  					if($(this).attr('id')=='btnmodalsalesorder'){
  						balqty=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'interbalqty');
  						product=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'product');
  						
  					}
  					else if($(this).attr('id')=='btnmodalGRN'){
  						balqty=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'balqty');
  						product=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'product');
  						restrictbranch=1;
  					}
  					else if($(this).attr('id')=='btnmodalPIV'){
  						balqty=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'balqty');
  						product=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'product');
  						restrictbranch=1;
  					}
  					else if($(this).attr('id')=='btnmodalINV'){
  						balqty=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'balqty');
  						product=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'product');
  						restrictbranch=1;
  					}
  					var podocno=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  					var psrno=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  					var detrowno=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'detrowno');
  					if(i==0){
  						vendor=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'refname');
  						brhid=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'brhid');
  						cldocno=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'cldocno');
  						refvocno=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  						htmldata=detrowno;
  					}
  					else{
  						htmldata+=','+detrowno;
  						refvocno+=','+$(gridid).jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  						if(vendor!=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'refname')){
  							Swal.fire({
  		    					icon:'warning',
  		    					type: 'warning',
  		    					text: 'Multiple vendors are not allowed'
  		    				});
  		  					return false;
  						}
  						
  						if(restrictbranch==1){
  							if(brhid!=$(gridid).jqxGrid('getcellvalue',selectedrows[i],'brhid')){
  	  							Swal.fire({
  	  		    					icon:'warning',
  	  		    					type: 'warning',
  	  		    					text: 'Multiple Branch are not allowed'
  	  		    				});
  	  		  					return false;
  	  						}	
  						}
  					}
  					
  					if(parseFloat(balqty)<=0){
  						Swal.fire({
	    					icon:'warning',
	    					type: 'warning',
	    					text: 'Insufficient Qty for '+product
	    				});
	  					return false;
  					}
  					
  				}
  				if($(this).attr('id')=='btnmodalsalesorder'){
  					$('#modalSalesOrderGrid').jqxGrid('clear');
  	  				$('#modalcreatesalesorder').attr('data-detrowno',htmldata);
  	  				$('#modalcreatesalesorder').find('.modal-header').find('.refvocno-text').text('PO # '+refvocno);
  	  				$('#modalcreatesalesorder').modal('show');
  				}
  				else if($(this).attr('id')=='btnmodalGRN'){
  					$('#modalGRNGrid').jqxGrid('clear');
  	  				$('#modalcreateGRN').attr('data-detrowno',htmldata);
  	  				$('#modalcreateGRN').attr('data-cldocno',cldocno);
  	  				$('#modalcreateGRN').find('.modal-header').find('.refvocno-text').text('PO # '+refvocno);
  	  				$('#modalcreateGRN').modal('show');
  				}
  				else if($(this).attr('id')=='btnmodalPIV'){
  					$('#modalPIVGrid').jqxGrid('clear');
  					funLoadLoc(brhid,'piv');
  	  				$('#modalcreatePIV').attr('data-detrowno',htmldata);
  	  				$('#modalcreatePIV').attr('data-cldocno',cldocno);
  	  				$('#modalcreatePIV').attr('data-brhid',brhid);
  	  				$('#modalcreatePIV').find('.modal-header').find('.refvocno-text').text('GRN # '+refvocno);
  	  				$('#modalcreatePIV').modal('show');
  				}
  				else if($(this).attr('id')=='btnmodalINV'){
  					$('#modalINVGrid').jqxGrid('clear');
  					funLoadLoc(brhid,'inv');
  	  				$('#modalcreateINV').attr('data-detrowno',htmldata);
  	  				$('#modalcreateINV').attr('data-cldocno',cldocno);
  	  				$('#modalcreateINV').attr('data-brhid',brhid);
  	  				$('#modalcreateINV').find('.modal-header').find('.refvocno-text').text('DEL # '+refvocno);
  	  				$('#modalcreateINV').modal('show');
  				}
  				
  			});
  			
  			
  			$('#btnmodaldelnote').click(function(){
  				var selectedrows=$('#salesOrderGrid').jqxGrid('getselectedrowindexes');
  				if(selectedrows.length==0){
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Please select valid documents'
    				});
  					return false;
  				}
  				
  				var customer='';
  				var refvocno='';
  				var htmldata='';
  				for(var i=0;i<selectedrows.length;i++){
  					var podocno=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  					var psrno=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  					var detrowno=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'detrowno');
  					if(i==0){
  						customer=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
  						refvocno=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  						htmldata=detrowno;
  					}
  					else{
  						htmldata+=','+detrowno;
  						refvocno+=','+$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
  						if(customer!=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno')){
  							Swal.fire({
  		    					icon:'warning',
  		    					type: 'warning',
  		    					text: 'Multiple Customers are not allowed'
  		    				});
  		  					return false;
  						}
  					}
  					
  					var balqty=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'balqty');
  					var product=$('#salesOrderGrid').jqxGrid('getcellvalue',selectedrows[i],'product');
  					if(parseFloat(balqty)<=0){
  						Swal.fire({
	    					icon:'warning',
	    					type: 'warning',
	    					text: 'Insufficient Qty for '+product
	    				});
	  					return false;
	  					
  					}
  				}
  				$('#modalDelNoteGrid').jqxGrid('clear');
  				$('#modalcreatedelnote').attr('data-cldocno',customer);
  				$('#modalcreatedelnote').attr('data-detrowno',htmldata);
  				$('#modalcreatedelnote').find('.modal-header').find('.refvocno-text').text('SO # '+refvocno);
  				$('#modalcreatedelnote').modal('show');
  			});
  		});
  		
  		function getInitData(){
  			$.get('getInitData.jsp',function(data){
  				data=JSON.parse(data);
  				$('.card-item').eq(0).find('span.value').text(data.pordercount);
  				$('.card-item').eq(1).find('span.value').text(data.salesordercount);
  				$('.card-item').eq(2).find('span.value').text(data.delnotecount);
  				$('.card-item').eq(3).find('span.value').text(data.grncount);
  				$('.card-item').eq(0).trigger('click');
  			});
  		}
  		
  		function funCreatePIV(){
  			var brhid=$('#modalcreatePIV').attr('data-brhid');
  			var cldocno=$('#modalcreatePIV').attr('data-cldocno');
  			var refno=$('#pivrefno').val();
  			var date=$('#pivdate').jqxDateTimeInput('val');
  			var desc=$('#pivdesc').val();
  			var pivinvdate=$('#pivinvdate').jqxDateTimeInput('val');
  			var pivinvno=$('#pivinvno').jqxDateTimeInput('val');
  			var locid=$('#cmbpivbilltype').val();
  			var billtype=$('#cmbpivbilltype').val();
  			var refdocarray=[];
			var selectedindexes=$('#GRNGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedindexes.length;i++){
				refdocarray.push($('#GRNGrid').jqxGrid('getcellvalue',selectedindexes[i],'doc_no'));
			}
			
			var refdocno='';
			if(refdocarray.length>1){
				refdocarray=Array.from(new Set(refdocarray));
				refdocno=refdocarray.join(',');	
			}
			else{
				refdocno=refdocarray[0];
			}
  			var rows=$('#modalPIVGrid').jqxGrid('getrows');
  			var prodarray=new Array();
  			for(var i=0;i<rows.length;i++){
  				var psrno=rows[i].psrno;
  				
  				if(psrno!="" && psrno!="undefined" && psrno!=null && typeof(psrno)!="undefined"){
  					prodarray.push(rows[i].psrno+"::"+rows[i].psrno+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "
  						   +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discountvalue+" :: "+rows[i].nettotal+" :: "+rows[i].balqty
  						   +" :: "+"pro"+" :: "+rows[i].specid+" :: "+rows[i].discountpercent+" :: "+rows[i].stockid+" :: "+rows[i].oldqty+" :: "+0
  						   +" :: "+0+" :: "+0+"::"+rows[i].taxpercent+"::"+rows[i].taxamount+"::"+rows[i].taxtotal+"::"+0+"::"
  						   +""+"::"+rows[i].taxdocno+"::"+"0000"+"::");
  				}
  			}
  			
  			$.post('createPIV.jsp',{'refdocno':refdocno,'invdate':pivinvdate,'invno':pivinvno,'locid':locid,'billtype':billtype,'brhid':brhid,'cldocno':cldocno,'refno':refno,'date':date,'desc':desc,'prodarray[]':prodarray},function(data,status){
  				data=JSON.parse(data);
  				if(data.errorstatus=="0"){
  					Swal.fire({
    					icon:'success',
    					type: 'success',
    					text: 'Successfully Created PIV#'+data.docno
    				});
  					$('#modalcreatePIV').modal('hide');
  					$('#btnsubmit').trigger('click');
  				}
  				else{
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Not Saved'
    				});
  					return false;
  				}
  			});
  		}
  		
  		function funCreateINV(){
  			var brhid=$('#modalcreateINV').attr('data-brhid');
  			var cldocno=$('#modalcreateINV').attr('data-cldocno');
  			var refno=$('#invrefno').val();
  			var date=$('#invdate').jqxDateTimeInput('val');
  			var desc=$('#invdesc').val();
  			var locid=$('#cmbinvlocation').val();
  			var billtype=$('#cmbinvbilltype').val();
  			var vattype=$('#cmbinvvattype').val();
  			var refdocarray=[];
			var selectedindexes=$('#delNoteGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedindexes.length;i++){
				refdocarray.push($('#delNoteGrid').jqxGrid('getcellvalue',selectedindexes[i],'doc_no'));
			}
			
			var refdocno='';
			if(refdocarray.length>1){
				refdocarray=Array.from(new Set(refdocarray));
				refdocno=refdocarray.join(',');	
			}
			else{
				refdocno=refdocarray[0];
			}
  			var rows=$('#modalINVGrid').jqxGrid('getrows');
  			var prodarray=new Array();
  			for(var i=0;i<rows.length;i++){
  				var psrno=rows[i].psrno;
  				
  				if(psrno!="" && psrno!="undefined" && psrno!=null && typeof(psrno)!="undefined"){
  					console.log(rows[i]);
  					prodarray.push(rows[i].psrno+"::"+rows[i].unitdocno+"::"+rows[i].qty+"::"+0+"::"+0+"::"+
  							 rows[i].unitprice+"::"+rows[i].total+"::"+rows[i].discountpercent+"::"+rows[i].discountvalue+"::"+rows[i].nettotal+"::"+rows[i].specid+"::"+
  							 rows[i].outqty+"::"+rows[i].stockid+"::"+rows[i].outqty+"::"+0+"::"+locid+"::"+rows[i].taxpercent+"::"
  							 +rows[i].taxtotal+"::"+rows[i].allowdiscount+"::"+000+"::"+0+"::"+rows[i].taxdocno+"::"+rows[i].taxamount+"::"+"0000"+"::");
  				}
  			}
  			
  			$.post('createINV.jsp',{'refdocno':refdocno,'locid':locid,'billtype':billtype,'vattype':vattype,'brhid':brhid,'cldocno':cldocno,'refno':refno,'date':date,'desc':desc,'prodarray[]':prodarray},function(data,status){
  				data=JSON.parse(data);
  				if(data.errorstatus=="0"){
  					Swal.fire({
    					icon:'success',
    					type: 'success',
    					text: 'Successfully Created INV#'+data.docno
    				});
  					$('#modalcreateINV').modal('hide');
  					$('#btnsubmit').trigger('click');
  				}
  				else{
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Not Saved'
    				});
  					return false;
  				}
  			});
  		}
  		
  		
  		function funCreateSalesOrder(){
  			var brhid=$('#cmbsalesorderbranch').val();
  			var cldocno=$('#cmbsalesordercustomer').val();
  			var refno=$('#salesorderefno').val();
  			var date=$('#salesorderdate').jqxDateTimeInput('val');
  			var desc=$('#salesorderdesc').val();
  			
  			var rows=$('#modalSalesOrderGrid').jqxGrid('getrows');
  			var prodarray=new Array();
  			for(var i=0;i<rows.length;i++){
  				var psrno=rows[i].psrno;
  				if(psrno!="" && psrno!="undefined" && psrno!=null && typeof(psrno)!="undefined"){
  					prodarray.push(psrno+" :: "+rows[i].qty+" :: "+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discountpercent+" :: "+rows[i].discountvalue+" :: "+rows[i].nettotal+" :: "+rows[i].taxpercent+" :: "+rows[i].taxamount+" :: "+rows[i].taxtotal+" :: "+rows[i].specid+" :: "+rows[i].unitdocno+"::"+rows[i].rowno);
  				}
  			}
  			
  			$.post('createSalesOrder.jsp',{'brhid':brhid,'cldocno':cldocno,'refno':refno,'date':date,'desc':desc,'prodarray[]':prodarray},function(data,status){
  				data=JSON.parse(data);
  				if(data.errorstatus=="0"){
  					Swal.fire({
    					icon:'success',
    					type: 'success',
    					text: 'Successfully Created SO#'+data.docno
    				});
  					$('#modalcreatesalesorder').modal('hide');
  					$('#btnsubmit').trigger('click');
  				}
  				else{
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Not Saved'
    				});
  					return false;
  				}
  			});
  		}
  		
  		
  		function funGRNStockCheck(){
  			var brhid=$('#cmbgrnbranch').val();
  			var locid=$('#cmbgrnlocation').val();
  			var rows=$('#modalGRNGrid').jqxGrid('getrows');
  			var stockcheckarray=new Array();
  			for(var i=0;i<rows.length;i++){
  				var psrno=rows[i].psrno;
  				if(psrno!="" && psrno!="undefined" && psrno!=null && typeof(psrno)!="undefined"){
  					stockcheckarray.push(psrno+" :: "+rows[i].specid+" :: "+rows[i].qty+" :: "+rows[i].balqty);
  				}
  			}
  			
  			$.get('../../../sales and marketing/Sales/deliverynote/validateqtys.jsp',{'list':stockcheckarray.join(','),'branch':brhid,'location':locid,'mode':'A'},function(data){
  				data=data.trim().split("###");
  				var htmldata='';
  				var checkarray=new Array();
  				if(data[0]!=''){
  					htmldata+='<table class="table" style="width:100%;"><thead><tr><th>Product ID</th><th>Avail.Stock</th></thead><tbody>';
  					if(data[0].includes(',')){
  						//Multiple Products
  						for(var i=0;i<data[0].split(",").length;i++){
  							var detpsrno=data[0].split(",")[i];
  							var detmaxqty=data[1].split(",")[i];
  							for(var j=0;j<rows.length;j++){
  								if(detpsrno==rows[j].psrno){
  									htmldata+='<tr>';
  									htmldata+='<td align="left">'+rows[j].productid+'</td>';
  									htmldata+='<td align="left">'+detmaxqty+'</td>';
  									htmldata+='</tr>';
  									checkarray.push({'psrno':rows[j].psrno,'product':rows[j].productid,'maxqty':detmaxqty});
  								}
  							}
  						}
  					}
  					htmldata+='</tbody></table>';
  					
  					Swal.fire({
  						icon: 'info',
  						title: 'Stock Not Available',
  					  	html:htmldata
  					});
  					return false;
  				}
  				else{
  					funCreateGRN();
  				}
  				
  			});
  		}
  		function funDelNoteStockCheck(){
  			var brhid=$('#cmbdelnotebranch').val();
  			var locid=$('#cmbdelnotelocation').val();
  			var rows=$('#modalDelNoteGrid').jqxGrid('getrows');
  			var stockcheckarray=new Array();
  			for(var i=0;i<rows.length;i++){
  				var psrno=rows[i].psrno;
  				if(psrno!="" && psrno!="undefined" && psrno!=null && typeof(psrno)!="undefined"){
  					stockcheckarray.push(psrno+" :: "+rows[i].specid+" :: "+rows[i].qty+" :: "+rows[i].oldqty);
  				}
  			}
  			
  			$.get('../../../sales and marketing/Sales/deliverynote/validateqtys.jsp',{'list':stockcheckarray.join(','),'branch':brhid,'location':locid,'mode':'A'},function(data){
  				data=data.trim().split("###");
  				var htmldata='';
  				var checkarray=new Array();
  				if(data[0]!=''){
  					htmldata+='<table class="table" style="width:100%;"><thead><tr><th>Product ID</th><th>Avail.Stock</th></thead><tbody>';
  					if(data[0].includes(',')){
  						//Multiple Products
  						for(var i=0;i<data[0].split(",").length;i++){
  							var detpsrno=data[0].split(",")[i];
  							var detmaxqty=data[1].split(",")[i];
  							for(var j=0;j<rows.length;j++){
  								if(detpsrno==rows[j].psrno){
  									htmldata+='<tr>';
  									htmldata+='<td align="left">'+rows[j].productid+'</td>';
  									htmldata+='<td align="left">'+detmaxqty+'</td>';
  									htmldata+='</tr>';
  									checkarray.push({'psrno':rows[j].psrno,'product':rows[j].productid,'maxqty':detmaxqty});
  								}
  							}
  						}
  					}
  					htmldata+='</tbody></table>';
  					
  					Swal.fire({
  						icon: 'info',
  						title: 'Stock Not Available',
  					  	html:htmldata
  					});
  					return false;
  				}
  				else{
  					funCreateDelNote();
  				}
  				
  			});
  		}
  		
  		function funCreateGRN(){
  			var brhid=$('#cmbgrnbranch').val();
  			var locid=$('#cmbgrnlocation').val();
  			var refno=$('#grnrefno').val();
  			var date=$('#grndate').jqxDateTimeInput('val');
  			var invdate=$('#grninvdate').jqxDateTimeInput('val');
  			var invno=$('#grninvno').val();
  			var desc=$('#grndesc').val();
  			var cldocno=$('#modalcreateGRN').attr('data-cldocno');
			var refdocarray=[];
			var selectedindexes=$('#purchaseOrderGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedindexes.length;i++){
				refdocarray.push($('#purchaseOrderGrid').jqxGrid('getcellvalue',selectedindexes[i],'doc_no'));
			}
			
			var refdocno='';
			if(refdocarray.length>1){
				refdocarray=Array.from(new Set(refdocarray));
				refdocno=refdocarray.join(',');	
			}
			else{
				refdocno=refdocarray[0];
			}
			
  			var rows=$('#modalGRNGrid').jqxGrid('getrows');
  			var prodarray=new Array();
  			for(var i=0;i<rows.length;i++){
  				var psrno=rows[i].psrno;
  				
  				if(psrno!="" && psrno!="undefined" && psrno!=null && typeof(psrno)!="undefined"){
  					prodarray.push(psrno+" :: "+rows[i].psrno+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "+rows[i].qty+" :: "+"pro"+" :: "+rows[i].specid+" :: "+0+" :: "+rows[i].unitprice+" :: "+rows[i].discountvalue+" :: "+rows[i].discountpercent+" :: ");
  				}
  				
  			}
  			
  			$.post('createGRN.jsp',{'invdate':invdate,'invno':invno,'refdocno':refdocno,'locid':locid,'brhid':brhid,'cldocno':cldocno,'refno':refno,'date':date,'desc':desc,'prodarray[]':prodarray},function(data,status){
  				data=JSON.parse(data);
  				if(data.errorstatus=="0"){
  					Swal.fire({
    					icon:'success',
    					type: 'success',
    					text: 'Successfully Created GRN #'+data.docno
    				});
  					$('#modalcreateGRN').modal('hide');
  					$('#btnsubmit').trigger('click');
  				}
  				else{
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Not Saved'
    				});
  					return false;
  				}
  			});
  		}
  		function funCreateDelNote(){
  			var brhid=$('#cmbdelnotebranch').val();
  			var locid=$('#cmbdelnotelocation').val();
  			var refno=$('#delnoterefno').val();
  			var date=$('#delnotedate').jqxDateTimeInput('val');
  			var desc=$('#delnotedesc').val();
  			var cldocno=$('#modalcreatedelnote').attr('data-cldocno');
			var refdocarray=[];
			var selectedindexes=$('#salesOrderGrid').jqxGrid('getselectedrowindexes');
			for(var i=0;i<selectedindexes.length;i++){
				refdocarray.push($('#salesOrderGrid').jqxGrid('getcellvalue',selectedindexes[i],'doc_no'));
			}
			refdocarray=Array.from(new Set(refdocarray));
			var refdocno=refdocarray.join(',');
  			var rows=$('#modalDelNoteGrid').jqxGrid('getrows');
  			var prodarray=new Array();
  			for(var i=0;i<rows.length;i++){
  				var psrno=rows[i].psrno;
  				if(psrno!="" && psrno!="undefined" && psrno!=null && typeof(psrno)!="undefined"){
  					prodarray.push(psrno+" :: "+rows[i].unitdocno+" :: "+rows[i].qty+" :: "+0+" :: "+0+" :: "+rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discountpercent+" :: "+rows[i].discountvalue+" :: "+rows[i].nettotal+" :: "+rows[i].specid+" :: "+rows[i].outqty+" :: "+0+" :: "+rows[i].oldqty+" :: "+0+" :: "+rows[i].qty);
  				}
  			}
  			
  			$.post('createDelNote.jsp',{'refdocno':refdocno,'locid':locid,'brhid':brhid,'cldocno':cldocno,'refno':refno,'date':date,'desc':desc,'prodarray[]':prodarray},function(data,status){
  				data=JSON.parse(data);
  				if(data.errorstatus=="0"){
  					Swal.fire({
    					icon:'success',
    					type: 'success',
    					text: 'Successfully Created Del.Note#'+data.docno
    				});
  					$('#modalcreatedelnote').modal('hide');
  					$('#btnsubmit').trigger('click');
  				}
  				else{
  					Swal.fire({
    					icon:'warning',
    					type: 'warning',
    					text: 'Not Saved'
    				});
  					return false;
  				}
  			});
  		}
  		
  		function funLoadModalPIV(){
  			var detrowno=$('#modalcreatePIV').attr('data-detrowno');
			var cldocno=$('#modalcreatePIV').attr('data-cldocno');
			detrowno=encodeURIComponent(detrowno);
			var brhid=$('#modalcreatePIV').attr('data-brhid');
			var locid=$('#cmbpivlocation').val();
			var date=$('#pivdate').jqxDateTimeInput('val');
			var billtype=$('#cmbpivbilltype').val();
			$('#modalpivdiv').load('modalPIVGrid.jsp?detrowno='+detrowno+'&cldocno='+cldocno+'&id=1&brhid='+brhid+'&date='+date+'&locid='+locid+'&billtype='+billtype);
  		}
  		
  		function funLoadModalINV(){
  			var detrowno=$('#modalcreateINV').attr('data-detrowno');
			var cldocno=$('#modalcreateINV').attr('data-cldocno');
			detrowno=encodeURIComponent(detrowno);
			var brhid=$('#modalcreateINV').attr('data-brhid');
			var locid=$('#cmbinvlocation').val();
			var date=$('#invdate').jqxDateTimeInput('val');
			var billtype=$('#cmbinvbilltype').val();
			var vattype=$('#cmbinvvattype').val();
			$('#modalinvdiv').load('modalINVGrid.jsp?detrowno='+detrowno+'&cldocno='+cldocno+'&id=1&brhid='+brhid+'&date='+date+'&locid='+locid+'&billtype='+billtype+'&vattype='+vattype);
  		}
  		
  		
  		function funLoadModalSalesOrder(){
  			var detrowno=$('#modalcreatesalesorder').attr('data-detrowno');
			var cldocno=$('#cmbsalesordercustomer').val();
			detrowno=encodeURIComponent(detrowno);
			var brhid=$('#cmbsalesorderbranch').val();
			var date=$('#salesorderdate').jqxDateTimeInput('val');
			
			$('#modalsalesorderdiv').load('modalSalesOrderGrid.jsp?detrowno='+detrowno+'&cldocno='+cldocno+'&id=1&brhid='+brhid+'&date='+date);
  		}
  		
  		function funLoadModalDelNote(){
  			var detrowno=$('#modalcreatedelnote').attr('data-detrowno');
  			var cldocno=$('#modalcreatedelnote').attr('data-cldocno');
			detrowno=encodeURIComponent(detrowno);
			var brhid=$('#cmbdelnotebranch').val();
			var date=$('#delnotedate').jqxDateTimeInput('val');
			$('#modaldelnotediv').load('modalDelNoteGrid.jsp?detrowno='+detrowno+'&id=1&brhid='+brhid+'&date='+date);
  		}
  		
  		function funLoadModalGRN(){
  			var detrowno=$('#modalcreateGRN').attr('data-detrowno');
  			var cldocno=$('#modalcreateGRN').attr('data-cldocno');
			detrowno=encodeURIComponent(detrowno);
			var brhid=$('#cmbgrnbranch').val();
			var locid=$('#cmbgrnlocation').val();
			var date=$('#grndate').jqxDateTimeInput('val');
			$('#modalgrndiv').load('modalGRNGrid.jsp?detrowno='+detrowno+'&id=1&brhid='+brhid+'&date='+date+'&locid='+locid+'&cldocno='+cldocno);
  		}
  		
  		function getClient(){
  			$.get('getClient.jsp',function(data){
  				data=JSON.parse(data);
  				var htmldata='<option value="">--Select--</option>';
  				$.each(data.clientdata,function(index,value){
  					htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
  				});
  				$('#cmbsalesordercustomer').html($.parseHTML(htmldata));
  				$('#cmbsalesordercustomer').select2({
  					placeholder:"Choose Client",
  					allowClear:true
  				});
  				
  			})
  		}
  		
  		function getBranch(){
  			$.get('getBranch.jsp',function(data){
  				data=JSON.parse(data);
  				var htmldata='<option value="">--Select--</option>';
  				$.each(data.docdata,function(index,value){
  					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
  				});
  				$('#cmbsalesorderbranch,#cmbdelnotebranch,#cmbgrnbranch').html($.parseHTML(htmldata));
  				$('#cmbsalesorderbranch').select2({
  					placeholder:"Choose Branch",
  					allowClear:true
  				});
  				$('#cmbdelnotebranch').select2({
  					placeholder:"Choose Branch",
  					allowClear:true
  				});
  				$('#cmbgrnbranch').select2({
  					placeholder:"Choose Branch",
  					allowClear:true
  				});
  			});
  		}
  		
  		function funLoadLoc(brhid,formtype){
  			$.get('getLocation.jsp',{'brhid':brhid},function(data){
  				data=JSON.parse(data);
  				var htmldata='<option value="">--Select--</option>';
  				$.each(data.docdata,function(index,value){
  					htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
  				});
  				var targetlocation='';
  				if(formtype=='delnote'){
  					targetlocation='#cmbdelnotelocation';
  				}
  				else if(formtype=='grn'){
  					targetlocation='#cmbgrnlocation';
  				}
  				else if(formtype=='piv'){
  					targetlocation='#cmbpivlocation';
  				}
  				else if(formtype=='inv'){
  					targetlocation='#cmbinvlocation';
  				}
  				$(targetlocation).html($.parseHTML(htmldata));
  				$(targetlocation).select2({
  					placeholder:"Choose Location",
  					allowClear:true
  				});
  			});
  		}
  	</script>
  	</body>
  	</html>