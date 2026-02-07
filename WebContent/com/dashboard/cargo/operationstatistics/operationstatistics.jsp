<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Operation Statistics</title>               
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>     
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">     
  <style type="text/css">   
     
  .btn-group>.btn:first-child:not(:last-child):not(.dropdown-toggle) {     
    border-radius: 30px !important;       
} 
  .btn:focus,.btn:active {
   outline: none !important;
   box-shadow: none;
   }
   .modalStyle {      
    background-color:#33b5e5; `
    padding: 10px; 
   }
   .borderStyle{  
    margin-bottom: 0;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    border: none;
    line-height: 1.42857143;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
   box-shadow: 1px 2px 7px 3px #d4cece;                          
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
  }   
  .iconStyle{
	color: #000000 !important;  
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;   
  }
  .btnStyle{  
  	display: inline-block;   
    margin-bottom: 0;
    font-weight: 400;
    margin-right:5px;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    background-image: none;
    border: none;
    padding: 3px 8px;  
    font-size: 14px;
    line-height: 1.42857143;
    border-radius: 30px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);                     
    position: relative;
   -webkit-transition: all 0.3s;
   -moz-transition: all 0.3s;
   transition: all 0.3s;
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
      margin-top: 0px; 
      padding-top: 10px;
      padding-bottom: 0px;
      border-radius: 8px;
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      /* background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%); */
      background-color:#FEFE56;   
      color: black;
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
    #border1 {
	  border-radius: 25px;
	  padding: 8px;
	  -moz-box-shadow:    inset 0 0 3px #000000;
      -webkit-box-shadow: inset 0 0 3px #000000;
      box-shadow:         inset 0 0 3px #000000;   
}
  </style>
</head>       
<body>                        
  <div class="container-fluid">    
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
      <div class="todatepanel custompanel" style="padding-top: 18px;">
	      <table>
		      <tr>              
		      <td  align="right" ><label class="branch" style="font-size: 13px">From Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='fromdate' name='fromdate'></div></td>
		      <td  align="right" ><label class="branch" style="font-size: 13px">To Date &nbsp;&nbsp;</label></td>  
		      <td align="left"><div id='todate' name='todate'></div></td></tr>                                          
		 </table>          
      </div> 
      <div class="primarypanel custompanel"  style="padding-top: 18px;">      
	      <select id="cmbtype" class="form-control input-sm"><option value="1">Confirmed</option><option value="2">Live</option><option value="3">All</option></select>      
      </div> 
         <div class="primarypanel custompanel" style="margin-left:5px;">  
             <div id="border1">     
                <button type="button" class="btn btn-default btnStyle" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>        
	          	<button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
                <button type="button" class="btn btn-default btnStyle" id="btnjobsettlement" data-toggle="tooltip" title="Job Settlement" data-placement="bottom"><i class="fa fa-openid" aria-hidden="true"></i></button>
                <button type="button" class="btn btn-default btnStyle" id="btnattach"  onclick="funAttach();" data-toggle="tooltip" title="Attachments" data-placement="bottom"><i class="fa fa-paperclip " aria-hidden="true"></i></button>
               <button type="button" class="btn btn-default btnStyle" id="btncsprint"  onclick="funPrintCS();" data-toggle="tooltip" title="Cost Sheet Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>
                <button type="button" class="btn btn-default btnStyle" id="btncomment" data-toggle="tooltip" title="Comments" data-placement="bottom"><i class="fa fa-comments " aria-hidden="true"></i></button>
            </div>                                       
	  	 </div>             
        <div class="textpanel custompanel" style="margin-left:5px;padding-top:0;margin-top:0;padding-bottom:0;margin-bottom:0;top:25px;position:absolute;">        
			<p  style="font-size:0.9em;float:left;" id="selectedrow">&nbsp;</p>&nbsp;&nbsp;&nbsp;&nbsp;   
        </div>  
      </div>
    </div>     
    <br/>  
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="opndiv" class="borderStyle"><jsp:include page="assignmentGrid.jsp"></jsp:include></div>                 
      </div>                                  
    </div>
    <!-- Comments Modal-->     
    <div id="modalcomments" class="modal fade" role="dialog">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header modalStyle">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Comments</h4>
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
 <!-- Comments Modal--> 
   <!-- Job Settlement modal-->                   
    <div id="modaljobsettlement" class="modal fade" role="dialog">                
      <div class="modal-dialog modal-xl">    
        <div class="modal-content">
          <div class="modal-header modalStyle" style="padding:5px">
            <button type="button" class="close" data-dismiss="modal">&times;</button>  
            <h4 class="modal-title" style="text-align:center">Job Settlement</h4>                             
             <p id="lblname12" style="text-align:center;"></p>                                
          </div>                             
          <div class="modal-body">
            <p><!-- Some text in the modal. --></p>  
            <div class="container-fluid"> 
             <div class="row rowgap">  
                         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-1" style="text-align:center;">                
								 <label  style="font-size: 12px;font-weight: bold;">REVENUE:</label>
					     </div>    
					     <div class="col-xs-12 col-sm-12 col-md-12 col-lg-11" style="text-align:center;">&nbsp;</div>
	         </div>  
             <div class="row rowgap">    
		             <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">
						     <div id="revdiv" class="borderStyle"><jsp:include page="revenueGrid.jsp"></jsp:include></div>
					 </div>
             </div>
              <div class="row rowgap">  
                         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-1" style="text-align:center;">                
								 <label style="font-size: 12px;font-weight: bold;">EXPENSES:</label>  
					     </div> 
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
							  <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">             
								    <label style="font-size: 13px;">Advance</label>           
						      </div> 
						      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">               
								    <input type="text" id="expadvance" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
						      </div> 
						 </div>  
						 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">             
								    <label style="font-size: 13px;">Expense</label>     
						      </div> 
						      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">             
								    <input type="text" id="expexpense" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
						      </div>
						 </div>  
						 <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">             
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">             
								    <label style="font-size: 13px;">Balance</label>     
						      </div> 
						      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-8">             
								    <input type="text" id="expbalance" class="form-control input-sm text-right"  readonly onblur="funRoundAmt(value,id);"/>
						      </div>
						 </div>     
					     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-5"></div>   
	         </div> 
             <div class="row rowgap"> 
					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">    
						   <div id="expdiv" class="borderStyle"><jsp:include page="expensesGrid.jsp"></jsp:include></div> 
					</div>         
             </div>       
            </div>        
            </div>  
           <!-- <div class="modal-footer">     
            	<div class="row rowgap">
					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="text-align:center;">   
						<button type="button" class="btn btn-default btnStyle" id="btnjob" title="Create" data-placement="bottom" onclick="funJob();"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>
					</div>    
				</div>
            </div>  -->        
          </div>  
        </div>  
      </div>                              
 </div> .
  <input type="hidden" name="hidcomments" id="hidcomments">        
  <input type="hidden" name="hiddocno" id="hiddocno"> 
  <input type="hidden" name="hidvocno" id="hidvocno">  
  <input type="hidden" name="hidbrhid" id="hidbrhid"> 
  <input type="hidden" name="hidenqdocno" id="hidenqdocno">      
  <input type="hidden" name="hidqotdocno" id="hidqotdocno"> 
  <input type="hidden" name="hidcpvamount" id="hidcpvamount"> 
  <input type="hidden" name="hidlblname" id="hidlblname"> 
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>         
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">  
$(document).ready(function(){        
    	 $('[data-toggle="tooltip"]').tooltip();      
    	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("#fromdate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '100px', height: '23px',formatString:"dd.MM.yyyy"});
	     
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
			}});      
           $('#btnsubmit').click(function(){
        	$("#overlay, #PleaseWait").show();
        	funload();
            $('.textpanel p').text("");
            $('#hiddocno').val('');  
            $('#hidbrhid').val('');  
            $('#hidvocno').val('');  
            $('#hidenqdocno').val('');
			$('#hidqotdocno').val('');
			$('#hidcpvamount').val('');
        });          
        $('#btncomment').click(function(){    
	        var actdocno=$('#hiddocno').val();
	    	if(actdocno==""){  
	    		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'      
				});
	    		return false;
	    	}
	      	getComments(); 
	      	$('#modalcomments').modal('toggle');          
        }); 
        $('#btnjobsettlement').click(function() {       
     	    var docno = $('#hiddocno').val();
     	    var advance = $('#hidcpvamount').val();       
            if (docno == "") {
             swal({
                 type: 'warning',
                 title: 'Warning',
                 text: 'Please select a document'   
             });
             return false;
            }   
            document.getElementById("lblname12").innerHTML=$("#hidlblname").val();  
            loadRevenueGrid();
            funRoundAmt(advance,"expadvance"); 
            funRoundAmt(0,"expexpense");
            funRoundAmt(0,"expbalance");          
            $('#modaljobsettlement').modal('toggle');  
          });
        $('#btnexcel').click(function(){            
       	 $("#opndiv").excelexportjs({
				containerid: "opndiv",        
				datatype: 'json',
				dataset: null,
				gridId: "jqxAssignmentgrid",
				columns: getColumns("jqxAssignmentgrid") ,     
				worksheetName:"Operation Statistics"             
			});   
        });   
        $('#btncommentsend').click(function(){
        	 var actdocno=$('#hiddocno').val();
        	var txtcomment=$('#txtcomment').val();  
        	if(actdocno==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please select a document'   
				});
        		return false;
        	}
        	if(txtcomment==""){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	saveComment();
        });
        
       $('.warningpanel div button').click(function(){
        	var gridrows=$('#jqxAssignmentgrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		swal({
					type: 'warning',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');  
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{    
        		$('#jqxAssignmentgrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}   
        });  
    });
   function funRoundAmt(value,id){
	  var res=parseFloat(value).toFixed("2");                    
	  var res1=(res=='NaN'?"0":res);
	  document.getElementById(id).value=res1;  
	 }
   function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){   
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	//var filtercondition = 'contains';
	    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
	
	    	filtergroup.addfilter(filter_or_operator, filter1);
	    	//filtergroup.addfilter(filter_or_operator, filter2);
	    	// add the filters.
	    	$("#jqxAssignmentgrid").jqxGrid('addfilter', datafield, filtergroup);
	    	// apply the filters.
	    	$("#jqxAssignmentgrid").jqxGrid('applyfilters');
    	   
 	}
    function saveComment(){  
    	var comment=$('#txtcomment').val();
    	var docno=$('#hiddocno').val();
    	var srno=$('#hidsrno').val();
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
		x.open("GET","saveComment.jsp?comment="+encodeURIComponent($('#hidcomments').val())+"&docno="+docno+"&srno="+srno,true);  
		x.send();
    }
    function getComments(){
    	var docno=$('#hiddocno').val();
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
		x.open("GET","getComments.jsp?docno="+docno,true);           
		x.send();      
    }
    
   function funload(){  
	   var todate = $('#todate').jqxDateTimeInput('val');
       var fromdate = $('#fromdate').jqxDateTimeInput('val');
       var type = $('#cmbtype').val();                 
	   $('#opndiv').load("assignmentGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&type="+type+"&id="+1);                                                  
   }
   function loadRevenueGrid(){    
	   var docno=$("#hiddocno").val();   
	   var enqdocno=$('#hidenqdocno').val();    
	   var qotdocno=$('#hidqotdocno').val();  
       $('#revdiv').load("revenueGrid.jsp?enqdocno="+enqdocno+"&qotdocno="+qotdocno+"&docno="+docno+"&id="+1);
       $('#expdiv').load("expensesGrid.jsp?enqdocno="+enqdocno+"&qotdocno="+qotdocno+"&docno="+docno+"&id="+1);   
   }
   function funAttach(){
		var brchid=$('#hidbrhid').val();   
		var frmname="Estimation Create";      
		var frmcode="CESM";                        
		if ($("#hiddocno").val()!="") {        	  
			var  myWindow= window.open("<%=contextPath%>/com/common/Attachmaster.jsp?formCode="+frmcode
					 +"&docno="+document.getElementById("hidvocno").value+"&brchid="+brchid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();  
		} else {
			swal({
				type: 'warning',
				title: 'Warning',
				text: 'Please select a document'
			});
			return false; 
		}            
   }  
	function funCalcBalance(){            
		var expense=0.00,balance=0.00,advance=0.00;   
		var rows=$('#jqxExpense').jqxGrid('getrows');   
		for(var i=0;i<rows.length;i++){            
				var chk=rows[i].srvdocno;  
				var typechk=rows[i].type;
				var amount=rows[i].amount;      
				if((typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "") && (typeof(typechk) != "undefined" && typeof(typechk) != "NaN" && typechk != "")){           
					if(typechk=="CASH" || typechk=="CASH-VAT"){	
						if(typeof(amount) != "undefined" && typeof(amount) != "NaN" && amount != "" && amount != "0.00"){   
							expense=expense+parseFloat(amount);         
						}              
					}
				}          
		}
		console.log(expense);
		funRoundAmt(expense,"expexpense");
		advance=$("#expadvance").val();   
		console.log(expense+"=="+advance);  
		var balance=advance-expense;    
		console.log(balance);
		funRoundAmt(balance,"expbalance");   
	}
	function funPrintCS(){
	      var trno=$('#hiddocno').val();   
	      if(trno==""){      
			  swal({
                type: 'warning',
                title: 'Warning',   
                text: 'Please select a document!!!'                                                   
            });
			  return 0;     
		  }
		  var url=document.URL;    
	      var reurl=url.split("operationstatistics.jsp");                                                             
	      var win= window.open(reurl[0]+"printoperationstatistics?trno="+trno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	      win.focus();             
		}
  </script>
</body>
</html>
