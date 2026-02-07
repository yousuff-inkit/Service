<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Service Schedule Analysis</title>            
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
  		width:250px;            
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
<form id="frmServiceScheduleAnalysis" action="saveSSA" method="post" autocomplete="off">         
  <div class="container-fluid">  
    <div class="row rowgap">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
         <div class="todatepanel custompanel1">
	      <table>
		      <tr> 
			      <td align="right"><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
			      <td align="left"><div id='fromdate' name='fromdate'></div></td>
			      <td align="right"><label class="branch" style="font-size: 13px">&nbsp;To Date &nbsp;&nbsp;</label></td>  
			      <td align="left"><div id='todate' name='todate'></div></td> 
			      <td align="right"><label class="branch" style="font-size: 13px">&nbsp;Group By &nbsp;&nbsp;</label></td>  
			      <td align="left"><select class="form-control select2" name="cmbgroupby" id="cmbgroupby" style="width:100%;" onchange="funChange();">
			      <option value="">--Select--</option><option value="Customer">Customer wise</option><option value="Vehicle">Vehicle wise</option><option value="Driver">Driver wise</option></select></td>     
		      </tr>                                                 
		 </table>          
       </div>   
       <div class="primarypanel custompanel1">  
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
         <div class="textpanel custompanel">      
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>                            
        </div>    
      </div>
    </div>
    <div class="row" id="normalgrid">               
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
        <div id="serschdiv"><jsp:include page="serviceScheduleGrid.jsp"></jsp:include></div>          
      </div>
    </div>  
    <div class="row" id="groupedgrid">                 
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">              
        <div id="groupwisediv"><jsp:include page="groupWiseGrid.jsp"></jsp:include></div>          
      </div>
    </div>  
    <input type="hidden" name="hiddocno" id="hiddocno">   
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
	<script src="../../../../js/sweetalert2.all.min.js"></script>  
	<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
	<script type="text/javascript">     
    $(document).ready(function(){    
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
    	$('[data-toggle="tooltip"]').tooltip();
    	$('#contractWindow').jqxWindow({ width: '65%', height: '60%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Contract Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
        $('#contractWindow').jqxWindow('close');   
	    $("#fromdate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"});          
	    $("#todate").jqxDateTimeInput({ width: '100px', height: '25px',formatString:"dd.MM.yyyy"}); 
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
	    $("#groupedgrid").hide(); 
	    $("#normalgrid").show();
    	$('#txtcontract').dblclick(function(){     
	    	$('#contractWindow').jqxWindow('open');
	    	contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+1, $('#contractWindow'));         
	    });
    	
        $('#btnsubmit').click(function(){    
            loads(); 
            $('.textpanel p').text('');  
        	document.getElementById("hiddocno").value=""; 
         	document.getElementById("hidbrhid").value="";
         	document.getElementById("hidcontrno").value="";
         	document.getElementById("lblname").value="";   
        });
        $('#btnexcel').click(function(){ 
        	var grptype = $("#cmbgroupby").val();
        	if(grptype=="Customer" || grptype=="Vehicle" || grptype=="Driver"){  
        		$("#groupwisediv").excelexportjs({ 
            		containerid: "groupwisediv",       
            		datatype: 'json', 
            		dataset: null, 
            		gridId: "jqxGroupwise",     
            		columns: getColumns("jqxGroupwise") ,     
            		worksheetName:"Service Schedule Analysis"                
             	}); 
		    }else {
		    	$("#serschdiv").excelexportjs({ 
	        		containerid: "serschdiv",       
	        		datatype: 'json', 
	        		dataset: null, 
	        		gridId: "jqxServiceScheduleGrid",     
	        		columns: getColumns("jqxServiceScheduleGrid") ,   
	        		worksheetName:"Service Schedule Analysis"                
	         	}); 
		    }
        });
        
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#jqxServiceScheduleGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
   
    function getContract(){     
     	 var x= event.keyCode;
     	 if(x==114){
	     	  $('#contractWindow').jqxWindow('open');  
	     	  contractSearchContent(<%=contextPath+"/"%>+"com/search/contractsearch/contractSearch.jsp?type="+1, $('#contractWindow'));      
	     }else{  
     	 }
        } 
   function contractSearchContent(url) {
   		$('#contractWindow').jqxWindow('open');
   		$.get(url).done(function (data) {
   		$('#contractWindow').jqxWindow('setContent', data);
   		$('#contractWindow').jqxWindow('bringToFront');
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
    	$("#jqxServiceScheduleGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxServiceScheduleGrid").jqxGrid('applyfilters');    
 	}  
    function loads(){   
	    $("#overlay, #PleaseWait").show();
	    var fromdate = $('#fromdate').jqxDateTimeInput('val');         
	    var todate = $('#todate').jqxDateTimeInput('val'); 
	    var grptype = $("#cmbgroupby").val();
	    if(grptype=="Customer" || grptype=="Vehicle" || grptype=="Driver"){     
	    	$('#groupwisediv').load('groupWiseGrid.jsp?fromdate='+fromdate+"&todate="+todate+"&grptype="+grptype+'&id=1');               
	    }else {
	    	$('#serschdiv').load('serviceScheduleGrid.jsp?fromdate='+fromdate+"&todate="+todate+'&id=1');               
	    }
    } 
    function funChange(){
    	  var grptype = $("#cmbgroupby").val();
    	  if(grptype=="Customer" || grptype=="Vehicle" || grptype=="Driver"){  
				$("#normalgrid").hide();
				$("#groupedgrid").show();
		  }else {
			    $("#groupedgrid").hide(); 
			    $("#normalgrid").show();
		  }
    	  loads();
    }
  </script> 
<div id="contractWindow">
	<div></div><div></div>
</div>  
  </div>
  </form>   
</body>
</html>
