<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Stock Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
 <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.min.js"></script>



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

.form-control{
	height:34px !important;
}

.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
.myButtons:active {
	position:relative;
	top:1px;
}


  </style>

</head>
<body onLoad="getInitData();">
	
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
            <label class="form-group">Branch:</label>
            <div class="form-group">
              <select id="cmbbranch" name="cmbbranch" style="width:100%"></select>
            </div>
          </div>
        </div>
        <div class="primarypanel custompanel">
          <div class="form-group col-auto">
            <label class="form-group" style="margin-bottom: 5px;margin-top: 3px;" >From:</label>
            <div class="form-group">
              <div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
            </div>
            <label class="form-group">To:</label>
            <div class="form-group">
              <div id='todate' name='todate' value='<s:property value="todate"/>'></div>
            </div>
          </div>
        </div>
        <div class="primarypanel custompanel" style="padding: 7px 10px;">
          <div class="form-group col-auto">
            <!-- <label class="form-group">Type:</label> -->
            <div class="form-group">
              <select id="cmbtype" name="cmbtype"  class="form-control" onchange="fundisable();" >
              <option value="rsumm">Summary</option>
              <option value="rdet">Details</option>
              </select>
            </div>
          </div>
        </div>
       <div class="primarypanel custompanel">
    <div class="form-group">
        <!-- <label class="form-group">Product:</label> -->
        <div class="form-group cmbproduct">
            <select id="prodsearchby" name="prodsearchby"></select>
        </div>
        <div class="form-group cmbproduct">
            <button type="button" class="btn btn-default" onClick="setprodSearch();" id="additem" name="btnadditem" data-toggle="tooltip" title="Add" data-placement="bottom">
                <i class="fa fa-plus" aria-hidden="true"></i>
            </button>&nbsp;
            <button type="button" class="btn btn-default" onClick="setRemove();" id="btnremoveitem" name="btnremoveitem" data-toggle="tooltip" title="Remove" data-placement="bottom">
                <i class="fa fa-minus" aria-hidden="true"></i>
            </button>
            <button type="button" class="btn btn-default" id="popoverButton">
                <i class="fa fa-list" aria-hidden="true" data-toggle="tooltip" title="Product Details" data-placement="bottom"></i>
            </button>
            <textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:90%;" rows="13" readonly hidden=true></textarea>
        </div>
        <div class="form-group" id="productdiv" style="margin-bottom: 6px;">
            <input id="name" name="name" placeholder="Select Product" />
        </div>
    </div>
</div>
     <%--    <div class="primarypanel custompanel">
    <div class="form-group">
        <label class="form-group">Product:</label>
        <div class="form-group cmbproduct">
            <select id="prodsearchby" name="prodsearchby"></select>
        </div>
        <div class="form-group cmbproduct">
            <button type="button" class="btn btn-default" onClick="setprodSearch();" id="additem" name="btnadditem" data-toggle="tooltip" title="Add" data-placement="bottom">
                <i class="fa fa-plus" aria-hidden="true"></i>
            </button>&nbsp;
            <button type="button" class="btn btn-default" onClick="setRemove();" id="btnremoveitem" name="btnremoveitem" data-toggle="tooltip" title="Remove" data-placement="bottom">
                <i class="fa fa-minus" aria-hidden="true"></i>
            </button>
            <button type="button" class="btn btn-default" id="popoverButton">
                <i class="fa fa-list" aria-hidden="true" data-toggle="tooltip" title="Product Details" data-placement="bottom"></i>
            </button>
<textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:90%;" rows="13"  readonly hidden=true></textarea>
            
        </div>
        <div class="form-group" id="productdiv" style="margin-bottom: 6px;">
            <input id="name" name="name" placeholder="Select Product" />
        </div>
        <div class="form-group" id="tagsContainer" style="margin-top: 10px;">
            <div id="tags" class="tag-input" contenteditable="true" oninput="updateTags()" style="border: 1px solid #ccc; padding: 10px; min-height: 40px; display: flex; flex-wrap: wrap;"></div>
            <input type="hidden" id="tagsValue" name="tagsValue" /> <!-- Hidden input to hold tags data -->
        </div>
    </div>
</div> --%>
<%--         <div class="primarypanel custompanel" >
          <div class="form-group">
            <label class="form-group">Product:</label>
            <div class="form-group cmbproduct" >
             <select  id="prodsearchby" name="prodsearchby"></select></div>
 			<div class="form-group cmbproduct">
            	<button type="button" class="btn btn-default" onClick="setprodSearch();" id="additem" name="btnadditem" data-toggle="tooltip" title="Add" data-placement="bottom">
            	<i class="fa fa-plus" aria-hidden="true"></i>
        		</button>&nbsp;
        		<button type="button" class="btn btn-default" onClick="setRemove();" id="btnremoveitem" name="btnremoveitem" data-toggle="tooltip" title="Remove" data-placement="bottom">
            	<i class="fa fa-minus" aria-hidden="true"></i>
        		</button>
        		 <button type="button" class="btn btn-default" id="popoverButton">
           		<i class="fa fa-list" aria-hidden="true" data-toggle="tooltip" title="Product Details" data-placement="bottom"></i>
          		</button>
        	<textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:90%;" rows="13"  readonly hidden=true></textarea>
          </div>
            <div class="form-group" id="productdiv" style="margin-bottom: 6px;">
              <input id="name" name="name" placeholder="Select Product" />
            </div>
             <div class="form-group" id="tagsContainer" style="margin-top: 10px;">
            
            <input id="tags" name="tags" style="display:none; border: none;" />  <!-- Hidden input for tags -->
        </div>
          </div>
        </div> --%>
       
        <div class="primarypanel custompanel">
          <button type="button" class="btn btn-default" style="padding: 4px 8px;" id="btnsubmit" data-toggle="tooltip" onclick="funreload(event);" title="Submit" data-placement="bottom">
            <i class="fa fa-refresh" aria-hidden="true"></i>
          </button>
          <button type="button" class="btn btn-default" style="padding: 4px 8px;" id="btnexcel" data-toggle="tooltip"  title="Export" data-placement="bottom">
            <i class="fa fa-file-excel-o " aria-hidden="true"></i>
          </button>
        <i class="btn btn-default fa fa-info-circle" style="padding:7px 8px;" id="btninfo" aria-hidden="true"></i>
         <!--  <button type="button" class="btn btn-default" style="padding: 4px 8px;" id="btnsubmit" data-toggle="tooltip" onclick="funreload(event);" title="Submit" data-placement="bottom">
            <i class="fa fa-refresh" aria-hidden="true"></i>
          </button> -->
        
        </div>
        
      </form>
    </div>
  </div>
  <div class="row">
  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div id="stockLedgerDiv">
       <jsp:include page="stockLedgerGridSummary.jsp"></jsp:include> 
    </div>
    <div id="stockLedgerDetDiv" hidden="">
       <jsp:include page="stockLedgerGridDetail.jsp"></jsp:include> 
    </div>
    
  </div>
</div>
</div>




<div id="modalinfo" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content" style="width: 850px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:center">Product Detailed Info</h4>
      </div>
        <div class="container-fluid">
         	  <div id="productDetailsInfoWindow"><jsp:include page="productDetailInfo.jsp"></jsp:include></div>  
<%--          	  <div id="productDetailsInfoWindow"><jsp:include page="productDetailInfo.jsp"></jsp:include></div>   --%>
         </div>
          
        </div>
        
        <div class="clear"></div>
      </div>
    </div>
<div id="modalprodet" class="modal fade" role="dialog">
  <div class="modal-dialog" style="width: 100%;height: 60%;margin: 0;padding: 0;top: 0;left: 0;position: absolute;margin-top: 6%;">
    <div class="modal-content" style="height: 100%;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:center">Product Detailed Summary</h4>
      </div>
        <div class="container-fluid" style="margin-left: 24px;">
         	  <div id="productDetailssummaryWindow"></div>  
<%--          	  <div id="productDetailsInfoWindow"><jsp:include page="productDetailInfo.jsp"></jsp:include></div>   --%>
         </div>
          
        </div>
        
        <div class="clear"></div>
      </div>
    </div>
<div id="modaldel" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content" style="width: 789px;">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title" style="text-align:center">Product Search</h4>
      </div>
        <div class="container-fluid">
         	<div class="row">
         		<div class="col-sm-4">
         			<div class="form-group">
         				<label>Docno : </label>
         				<input class="form-control" type="text" style="height: 34px;" name="docnos" id="docnos" value='<s:property value="docnos"/>' />
         			</div>
         		</div>
         		<div class="col-sm-4">
         			<div class="form-group">
         				<label>Product Code : </label> <input class="form-control" style="height: 34px;" type="text" name="pcode" id="pcode"  value='<s:property value="pcode"/>' />
         			</div>
         		</div>
         		<div class="col-sm-4">
         			<div class="form-group">
         				<label>Product Name : </label> <input class="form-control" style="height: 34px;" type="text" name="pname" id="pname"   value='<s:property value="pname"/>' />
         			</div>
         		</div>
         	</div>
         	<div class="row">
         		<div class="col-sm-3">
         			<div class="form-group">
         				<label>Brand : </label>
         				<input class="form-control" type="text" name="brand" id="brand" style="height: 34px;" value='<s:property value="brand"/>'>
         			</div>
         		</div>
         		<div class="col-sm-3">
         			<div class="form-group">
         				<label>Category : </label> <input class="form-control" type="text"  style="height: 34px;" name="cat" id="cat"  value='<s:property value="cat"/>'>
         			</div>
         		</div>
         		<div class="col-sm-3">
         			<div class="form-group">
         				<label>Sub Category : </label> <input class="form-control" type="text" style="height: 34px;" id="subcat" name="subcat"  value='<s:property value="subcat"/>'>
         			</div>
         		</div>
         		<div class="col-sm-3">
         			<div class="form-group">
         				<input type="button" class="btn btn-primary"  style="width: 70%;margin-top: 24px;" name="mbtnrasearch" id="mbtnrasearch"  value="Search"  onclick="getProduct();">
         			</div>
         		</div>
         	</div>
        <div id="productDetailsWindow"><jsp:include page="productsSearch.jsp"></jsp:include></div> 
         </div>
          
        </div>
        
        <div class="clear"></div>
      </div>
      <!-- <div class="modal-footer">
        <button type="button" class="btn btn-default" id="btncreatedel">Save</button>
        <button type="button" class="btn btn-default" data-dismiss="modal" style="background-color:red">Close</button>
      </div> -->
    </div>
 


 <input type="hidden" name="searchdetails1" id="searchdetails1">
 <input type="hidden" name="searchdetails" id="searchdetails">
<input type="hidden" name="psrno" id="psrno">
<input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  <input type="hidden" name="hidvendoracno" id="hidvendoracno">
			  <input type="hidden" name="hidvendorcldocno" id="hidvendorcldocno">
			  <input type="hidden" name="hidvendoraccount" id="hidvendoraccount">
			  <input type="hidden" name="hidcurates" id="hidcurates">
			  <input type="hidden" name="hidcurid" id="hidcurid">
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct">
			  <input type="hidden" name="hidvendor" id="hidvendor">

<div id="locationwindow">
	<div></div>
</div>
<div id="ptypewindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="departmentwindow">
<div></div>
</div>
<div id="productwindow">
<div></div>
</div>
<div id="pcategorywindow">
<div></div>
</div>
<div id="psubcategorywindow">
<div></div>
</div>
<div id="pvendorwindow">
<div></div>
</div>
<div id="salwindow">
	<div></div>
</div>
<div id="textviewWindow">
	<div></div><div></div>
</div>
 <!-- <div id="productDetailsWindow">
 <div></div> 
</div> --> 
<input type="hidden" id="pmgt"/>
<input type="hidden" id="cmbvatype"/>

<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

<script type="text/javascript">

let loaded=false;

$(document).ready(function() {
	
    $('[data-toggle="tooltip"]').tooltip();
    $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    $('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Location Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
    $('#locationwindow').jqxWindow('close');  
		
    $('#textviewWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Selected',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#textviewWindow').jqxWindow('close');
    
    $('#salwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#salwindow').jqxWindow('close');
	
	 $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#ptypewindow').jqxWindow('close');
	 
	 $('#brandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   
	   $('#departmentwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#departmentwindow').jqxWindow('close');
	   
	   $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#productwindow').jqxWindow('close');
	   
	   $('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#pcategorywindow').jqxWindow('close');
	   
	   $('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#psubcategorywindow').jqxWindow('close');
	   
	   $('#pvendorwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Vendor Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#pvendorwindow').jqxWindow('close');

    //$("#masterdatedel").jqxDateTimeInput({width: '115px',height: '22px',formatString: "dd.MM.yyyy"});

    $('#txtlocationdel').dblclick(function() {
    	$('#locationwindow').jqxWindow('open');
    	innerWindowSearchContent('searchlocation.jsp?type=DEL&brhid='+$('#cmbbranch').val(),'locationwindow');
    });

    $('#txtsalesmandel').dblclick(function(){
		$('#salwindow').jqxWindow('open');
		innerWindowSearchContent('salesmanSearchGrid.jsp?type=DEL&id=1','salwindow');
   	});
    
	$('#txtlocation').dblclick(function() {
    	$('#locationwindow').jqxWindow('open');
    	innerWindowSearchContent('searchlocation.jsp?type=INV&brhid='+$('#cmbbranch').val(),'locationwindow');
    });

    $('#txtsalesman').dblclick(function(){
		$('#salwindow').jqxWindow('open');
		innerWindowSearchContent('salesmanSearchGrid.jsp?type=INV&id=1','salwindow');
   	});
    
    //$('#cmbtype').select2({});
    
    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	   
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
    $('#todate').on('change', function (event) {
		
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }  
	 });
    
    /*  $('#btnsubmit').click({
    	funreload(event);
    }); */ 
   // $('#productDetailsWindow').jqxWindow({width: '70%', height: '65%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Products Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 //$('#productDetailsWindow').jqxWindow('close');

    <%-- $('#name').dblclick(function(){
    	alert('test')
    	
		// var aa="STL";
	    productSearchContent1("<%=contextPath%>/com/productsearch/productSearch.jsp?frm="+aa,'productDetailsWindow'); 
	   
	 }); --%>
    
    // Use event delegation for the dblclick event
    $(document).on('dblclick', '#name', function() {
        // Open the modal
    	$('#modaldel').modal('show');
    });
    
    $('#productdiv').hide();
    
    $('#btninfo').click(function() {
        //alert('Button was clicked!');
        getStockDetailsInfo();
    	
    });
    
    $('#btnexcel').click(function(){
    	 var type=$('#cmbtype').val();
    	 if (type=='rsumm'){
    		 $("#stockLedgerDiv").excelexportjs({  
    				containerid: "stockLedgerDiv",
    				datatype: 'json',
    				dataset: null,
    				gridId: "partSearchgrid",
    				columns: getColumns("partSearchgrid"),
    				worksheetName: "Stock Ledger Summary"
    			});
    	 }
    	 if (type=='rdet'){
    		 $("#stockLedgerDetDiv").excelexportjs({  
    				containerid: "stockLedgerDetDiv",
    				datatype: 'json',
    				dataset: null,
    				gridId: "jqxStockDetailGrid",
    				columns: getColumns("jqxStockDetailGrid"),
    				worksheetName: "Stock Ledger Detail"
    			});
    	 }
		
	});
    data = {"productdata":[
    	
    	{"val":"","display":""},
    	{"val":"ptype","display":"TYPE"},
    	{"val":"pbrand","display":"BRAND"},
    	{"val":"pdept","display":"DEPARTMENT"},
    	{"val":"pcategory","display":"CATEGORY"},
    	{"val":"psubcategory","display":"SUB CATEGORY"},
    	{"val":"pproduct","display":"PRODUCT"}
    ]};
    
    htmldata = '';
    $.each(data.productdata, function(index, value) {
        htmldata += '<option value="' + value.val + '">' + value.display + '</option>';
    });
    $('#prodsearchby').html($.parseHTML(htmldata));
    $('#prodsearchby').select2({
        placeholder: "Select Product",
        allowClear: true
    });
    
    $('#popoverButton').click(function(){
    	var textdata = "<textarea rows="+30+" cols="+60+" style="+"border:none; outline: none; resize: none;"+">"+document.getElementById("searchdetails").value+"</textarea>";
    	 $('#textviewWindow').jqxWindow('setContent', textdata);
    	 $('#textviewWindow').jqxWindow('open');
    });
    
 
});



function getStockDetailsInfo() {
	var brch=$('#cmbbranch').val();
	if(!$.isNumeric(brch)){
		 Swal.fire({
            type: 'error',
            title: 'Warning',
            text: 'Please select a branch'
        });
        return false;
	}
	var frmdate=$('#fromdate').val();
	var load='yes';
	
	var todate=$('#todate').val();
//	$('#productDetailsInfoWindow').load('productDetailInfo.jsp?id=1&docno='+docno+'&fdate='+$('#fromdate').val()+'&billtype='+billtype+'&acno='+$('#acno').val());
	$('#productDetailsInfoWindow').load('productDetailInfo.jsp?branchid='+brch+'&frmdate='+frmdate+'&load='+load+'&todate='+todate);

	$('#modalinfo').modal('show');
	 $('.load-wrapp').show();
}

function getProDetails(value){
	var frmdate=$('#fromdate').val();
	var todate=$('#todate').val();
	var psrno=value;
	var branchid=$('#cmbbranch').val();
	 $('#detial').show();
	  // $('#stockLedgerDetDiv').show();		
     $("#overlay, #PleaseWait").show();
     $('.load-wrapp').show();
var load="yes";
// $("#stockLedgerDetDiv").load("stockLedgerGridDetail.jsp?todate="+todate+"&frmdate="+frmdate+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&load="+load+"&type=2");
$("#productDetailssummaryWindow").load("stockLedgerDetailGrid.jsp?todate="+todate+"&frmdate="+frmdate+"&hidproduct="+psrno+"&branchid="+branchid+"&load="+load+"&type=2");


	$('#modalprodet').modal('show');
}
function fundisable(){
	
	//funClearData();
	var type=$('#cmbtype').val();
	if (type=='rsumm') {
		  $('#stockLedgerDiv').show();
		   $('#stockLedgerDetDiv').hide();
		   $('#productdiv').hide();
		   $('.cmbproduct').show();
		}
	 else {
		  $('#stockLedgerDiv').hide();
		  $('#stockLedgerDetDiv').show();
		  $('.cmbproduct').hide();
		  $('#productdiv').show();
		}
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
        
        
        htmldata = '';
        $.each(data.billtypedata, function(index, value) {
            htmldata += '<option value="' + value.docno + '">' + value.code + '</option>';
        });
        $('#cmbbilltype').html($.parseHTML(htmldata));
              
        $('.load-wrapp').hide();
    });
}



function getloc(event,type) {
    var x = event.keyCode;
    if (x == 114) {
        $('#locationwindow').jqxWindow('open');
        innerWindowSearchContent('searchlocation.jsp?type='+type+'&brhid='+$('#cmbbranch').val(),'locationwindow');
    }
}

function funreload(event){
	var type;
	var branchid;
	var hidbrand;
	var hidtype;
	var hidproduct;
	var hidcat;
	var hidsubcat;
	var frmdate;
	var todate;
	var hidsubcat;
	var type;
	
	 	 branchid=document.getElementById("cmbbranch").value;
	 	  hidbrand=document.getElementById("hidbrandid").value;
		 hidtype=document.getElementById("hidtypeid").value;
		 hidproduct=document.getElementById("hidproductid").value;
		 hidcat=document.getElementById("hidcatid").value;
		 hidsubcat=document.getElementById("hidsubcatid").value;
		 hidept=document.getElementById("hideptid").value; 
		 type=$('#cmbtype').val();
		 frmdate=$('#fromdate').jqxDateTimeInput('val');
		 todate=$('#todate').jqxDateTimeInput('val');
		 if (type=='' || type==null) {
			   $.messager.alert('Message','Select Summary /Detail','warning');
			   return false;
		   }
		 if (type=='rsumm') {
		   $('#stockLedgerDiv').show();	
		   $('.load-wrapp').show();
			  $('#summs').show();
	       $("#overlay, #PleaseWait").show();
			 var load="yes";
//	 $("#stockLedgerDiv").load("stockLedgerGridSummary.jsp?todate="+todate+"&frmdate="+frmdate+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&load="+load+"&type=1");
	 $("#stockLedgerDiv").load("stockLedgerGridSummary.jsp?todate="+todate+"&frmdate="+frmdate+"&branchid="+branchid+"&load="+load+"&type=1"+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept);
		 }
		 if (type=='rdet') {
			 if(document.getElementById("psrno").value=="")
				 {
				  $.messager.alert('Message','Select Product','warning');
				   return false;
				 }
			 $('#detial').show();
			   $('#stockLedgerDetDiv').show();		
		       $("#overlay, #PleaseWait").show();
		       $('.load-wrapp').show();
		 var load="yes";
		// $("#stockLedgerDetDiv").load("stockLedgerGridDetail.jsp?todate="+todate+"&frmdate="+frmdate+"&hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&branchid="+branchid+"&hidept="+hidept+"&load="+load+"&type=2");
		 $("#stockLedgerDetDiv").load("stockLedgerGridDetail.jsp?todate="+todate+"&frmdate="+frmdate+"&hidproduct="+document.getElementById("psrno").value+"&branchid="+branchid+"&load="+load+"&type=2");
		 }
	}
function productSearchContent1(url,id) {
	//alert('url : '+url);
	//alert('id : '+id);
	$('#'+id).jqxWindow('open');
	$('#'+id).jqxWindow('focus');
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#'+id).jqxWindow('setContent', data);

	}); 
	}
function getDefaultLocation(brhid) {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            var item = items.split('::');

            document.getElementById("hidlocationiddel").value = item[0];
            document.getElementById("txtlocationdel").value = item[1];
            
            document.getElementById("hidlocationid").value = item[0];
            document.getElementById("txtlocation").value = item[1];
        } 
    }
    x.open("GET", "locationset.jsp?brhid="+brhid, true);
    x.send();
}
	function getProduct(){
		var docnos=$('#docnos').val();
		var pcode=$('#pcode').val();
		var pname=$('#pname').val();
		var brand=$('#brand').val();
		var cat=$('#cat').val();
		var subcat=$('#subcat').val();
		var frm="STL";
		var aa="YES";
		$('#productDetailsWindow').load('productsSearch.jsp?name='+pname+'&brand='+brand+'&cat='+cat+'&pcode='+pcode+'&subcat='+subcat+'&docnos='+docnos+'&load='+aa+'&frm='+frm);
		$('.load-wrapp').show();
		
	}
	
	function setprodSearch(){
		var value=$('#prodsearchby').val().trim();

		if(value=="ptype"){
			getPtype();
		}
		else if(value=="pbrand"){
			getPbrand(2);
		}
		else if(value=="pdept"){
			getDept();
		}
		else if(value=="pproduct"){
			getPProduct();
		}
		else if(value=="pcategory"){
			getPcategory();
		}
		else if(value=="psubcategory"){
			getPsubcategory();
		}
		
		else if(value=="pvendor"){
			getPvendor();
		}
		
		else{
			
		}
	}
	
	function getPtype(){
		  $('#ptypewindow').jqxWindow('open');
			$('#ptypewindow').jqxWindow('focus');
			typeSearchContent('typeSearch.jsp', $('#ptypewindow'));

	}
	function typeSearchContent(url) {
	  $.get(url).done(function (data) {
	//alert(data);
	$('#ptypewindow').jqxWindow('setContent', data);

	}); 
	}

	function getPbrand(t){
		 
		  $('#brandwindow').jqxWindow('open');
			$('#brandwindow').jqxWindow('focus');
			brandSearchContent('brandSearch.jsp?id='+t, $('#brandwindow'));

	}
	function brandSearchContent(url) {
	//alert(url);
	  $.get(url).done(function (data) {
	//alert(data);
	$('#brandwindow').jqxWindow('setContent', data);

	}); 
	}
	function getDept(){

		  $('#departmentwindow').jqxWindow('open');
			$('#departmentwindow').jqxWindow('focus');
			 deptSearchContent('deptSearch.jsp', $('#departmentwindow'));
	}
	function deptSearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#departmentwindow').jqxWindow('setContent', data);

		}); 
		}
	function getPProduct(){
		
		var brandid=$('#hidbrandid').val().trim();
		var catid=$('#hidcatid').val().trim();
		var subcatid=$('#hidsubcatid').val().trim();
		
		 $('#productwindow').jqxWindow('open');
			$('#productwindow').jqxWindow('focus');
			 productSearchContent('prodSearch.jsp?brandid='+brandid+'&catid='+catid+'&subcatid='+subcatid, $('#productwindow'));

	}
	function productSearchContent(url) {
		    $.get(url).done(function (data) {
		  $('#productwindow').jqxWindow('setContent', data);

		}); 
		}
		
	function getPcategory(){

		  $('#pcategorywindow').jqxWindow('open');
			$('#pcategorywindow').jqxWindow('focus');
			 categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
	}
	function categorySearchContent(url) {
	  $.get(url).done(function (data) {
	$('#pcategorywindow').jqxWindow('setContent', data);

	}); 
	}

	function getPsubcategory(){
		var catid=$('#hidcatid').val().trim();
		 $('#psubcategorywindow').jqxWindow('open');
			$('#psubcategorywindow').jqxWindow('focus');
			 subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));

	}
	function subcategorySearchContent(url) {
	    $.get(url).done(function (data) {
	  $('#psubcategorywindow').jqxWindow('setContent', data);

	}); 
	}

	function getPvendor(){
		 $('#pvendorwindow').jqxWindow('open');
			$('#pvendorwindow').jqxWindow('focus');
			 pvendorsearchContent('vendorsearch.jsp', $('#pvendorwindow'));

	}
	function pvendorsearchContent(url) {
	    $.get(url).done(function (data) {
	  $('#pvendorwindow').jqxWindow('setContent', data);

	}); 
	}
	
	function setRemove(){
		document.getElementById("hidbrandid").value="";
		document.getElementById("hidtypeid").value="";
		document.getElementById("hidproductid").value="";
		document.getElementById("hidcatid").value="";
		document.getElementById("hidsubcatid").value=""; 
		document.getElementById("hidbrand").value="";
		document.getElementById("hidtype").value="";
		document.getElementById("hidproduct").value="";
		document.getElementById("hidcat").value="";
		document.getElementById("hidsubcat").value="";
		document.getElementById("prodsearchby").value="";
		document.getElementById("searchdetails").value="";
		document.getElementById("hideptid").value="";
		document.getElementById("hidept").value="";
		$("#prodsearchby").val('').trigger('change');
	}
</script>

</body>
</html>
