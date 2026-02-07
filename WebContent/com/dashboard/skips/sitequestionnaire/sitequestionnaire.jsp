<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Site Questionnaire</title>            
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
  		width:800px;  
  		/* height:50px;       */             
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
           	<button type="button" class="btn btn-default" id="btnquestionnaire" ><i class="fa fa-pencil-square-o" aria-hidden="true" data-toggle="tooltip" title="Questionnaire" data-placement="bottom"></i></button>  
        </div> 
       <div class="textpanel custompanel">        
            <p style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>   
	   </div>
      </div>
    </div>
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="contractdiv"><jsp:include page="contractGrid.jsp"></jsp:include></div>          
      </div>
    </div>    
    <div id="modalqstnaireupdate" class="modal fade" role="dialog">    
    	<div class="modal-dialog modal-md">
        	<div class="modal-content">
          		<div class="modal-header">
            		<button type="button" class="close" data-dismiss="modal">&times;</button>   
            		<h4 class="modal-title">Questionnaire Update<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
          		</div>
          		<div class="modal-body">
  					   <div class="row">      
					      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">         
					        <div id="qstiv"><jsp:include page="qstnaireGrid.jsp"></jsp:include></div>           
					      </div> 
					    </div> 
          		</div>
          		<div class="modal-footer"> 
          			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
          			<button type="button" class="btn btn-default btn-primary" id="btnqstnairesave">Save Changes</button>
            		
          		</div>
        </div>
      </div>
     </div> 
  <input type="hidden" name="hidcldocno" id="hidcldocno">  
  <input type="hidden" name="hidsite" id="hidsite">   
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
            loads(); 
            $("#qstnGrid").jqxGrid('clear');
            $('.textpanel p').text("");
        }); 
        
        $('#btnquestionnaire').click(function(){      
        	 var cldocno = $("#hidcldocno").val();       
	         if(cldocno==0 || cldocno==""){  
	        		Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document!'      
					});
	        		return false;
	         }   
	         $("#modalqstnaireupdate").modal('toggle'); 
		}); 
        $('#btnqstnairesave').click(function(){    
        	funUpdate("Questionnaire");  
        }); 
        
        $('#btnexcel').click(function(){  
        	$("#contractdiv").excelexportjs({ 
        		containerid: "contractdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxContractGrid",   
        		columns: getColumns("jqxContractGrid") ,   
        		worksheetName:"Site Questionnaire"  
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
    	$("#jqxContractGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#jqxContractGrid").jqxGrid('applyfilters');    
 	}
    
    function loads(){      
	    $("#overlay, #PleaseWait").show(); 
	    $('#contractdiv').load('contractGrid.jsp?id=1');             
    } 
	 
    function funUpdate(processid){ 
    	var cldocno = $("#hidcldocno").val(); 
    	var site = $("#hidsite").val(); 
		if(processid=="Questionnaire"){
			var docsarray = new Array();
			var rows = $('#qstnGrid').jqxGrid('getrows');
			var val = 0;
			for(var i=0;i<rows.length;i++){
			    var ansr= $.trim(rows[i].answer);
				if(ansr.trim()!="" && typeof(ansr)!="undefined" && typeof(ansr)!="NaN") {
					docsarray.push({"seqno":rows[i].seqno,"question":rows[i].question,"answer":rows[i].answer,"rowno":rows[i].rowno});
					//docsarray.push(rows[i].seqno+" :: "+rows[i].question+" :: "+rows[i].answer+" :: "+rows[i].rowno);
					val++;
				}
			 }  
			if(val==0){  
        		Swal.fire({
        			icon: 'warning',
					title: 'Warning',
					text: 'Please enter answers'         
				});
        		return false;
           }   
			
			Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {  
					if (result.isConfirmed) { 
						const jsobj={"questions":docsarray};
						const myarray = JSON.stringify(jsobj);
						saveData(processid,myarray,cldocno,site);                   
					}else{
					}
			});
		}else{}       
	} 
	function saveData(processid,docsarray,cldocno,site){                        
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){  
				var items=x.responseText;
					 if(parseInt(items)>0){  	  
						         loads();
								 swal.fire({  
										icon: 'success',
										title: 'Success',
										text: 'Successfully Updated'  
									});
								 $("#modalqstnaireupdate").modal('toggle');  
								 $("#qstnGrid").jqxGrid('clear');     
						}else{
								 swal.fire({  
									    icon: 'warning',
										title: 'Warning',
										text: 'Not Updated'     
									});
						} 
				}
		}   
		x.open("GET","saveData.jsp?processid="+encodeURIComponent(processid)+"&docsarray="+encodeURIComponent(docsarray)+"&site="+encodeURIComponent(site)+"&cldocno="+cldocno,true);                    
		x.send();                
	}       
  </script>
  </div>
  </form>   
</body>
</html>
