<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>  
<title>IMPLEMENTATION STATUS</title>         
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>            
<link href="../../../../vendors/fonts/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">    
	  .branch {
		color: black;
		background-color: #ECF8E0;
		width: 100%;
		font-family: Tahoma;
		font-size: 12px;
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
  		width:260px;  
  		height:50px;                
  } 
  .textpanel1{
        color: #00008B;    
  }   
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
  </style>
</head>       
<body onload="getComp();"> 
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>  
<form  method="post" autocomplete="off">      
  <div class="container-fluid">
    <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
        <div class="primarypanel custompanel">
               <table width="100%">
                  <tr>
                  <td><label for="company" class="company">&nbsp;Company</label> </td>     
              <td> <select class="cmbCompany form-control input-sm" id="cmbCompany" name="cmbCompany" onchange="loads();" value='<s:property value="cmbCompany"/>' style="width:250px;">
  					<option></option>     
				</select></td>
                  </tr>
               </table>
        </div>          
        <div class="primarypanel custompanel">   
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btnUpdate" onclick="funsave()" data-toggle="tooltip" title="Update" data-placement="bottom" ><i class="fa fa-pencil-square-o" aria-hidden="true" ></i></button>    
        </div> 
       
      </div>
    </div>
     <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        <div id="implementationdiv"><jsp:include page="implementationGrid.jsp"></jsp:include></div>            
      </div>
    </div>  

<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
<script type="text/javascript">   
    $(document).ready(function(){
    	$('[data-toggle="tooltip"]').tooltip(); 
    	getComp();
        $('#btnsubmit').click(function(){
        	$("#rowindex").val('')
           loads(); 
        }); 
        
        $('#btnexcel').click(function(){  
        	$("#implementationdiv").excelexportjs({
        		containerid: "implementationdiv",       
        		datatype: 'json', 
        		dataset: null, 
        		gridId: "jqxProjectGrid", 
        		columns: getColumns("jqxProjectGrid") ,       
        		worksheetName:"Implementation Status"
            });
        });
        
    });
    function loads(){   
    	$('.load-wrapp').show(); 
	    var comps=$("#cmbCompany").val();
	    $('#implementationdiv').load('implementationGrid.jsp?comps='+comps+'&id=1'); 
    }   
    function getComp() {
    	var x = new XMLHttpRequest();
    	x.onreadystatechange = function() {
    		if (x.readyState == 4 && x.status == 200) {
    			var items = x.responseText;
    			items = items.split('####');
    			var yearItems = items[1].split(",");
    			var yearIdItems = items[0].split(",");   
    			var optionsyear = '<option value="">--Select--</option>';
    			for (var i = 0; i < yearItems.length; i++) {
    				optionsyear += '<option value="' + yearIdItems[i].trim() + '">'
    						+ yearItems[i].trim() + '</option>';
    			}
    			$("select#cmbCompany").html(optionsyear);
    		} else {
    		}
    	}
    	x.open("GET", "getComp.jsp", true);
    	x.send();
    } 
    function funsave(){
    	 var compid = $("#cmbCompany").val();
    	 var gridarray=new Array();
		 var rows=$('#jqxProjectGrid').jqxGrid('getrows');
		 var val=0;
		 for(var i=0;i<rows.length;i++){
		    var checked=rows[i].checked;
		    var remarks=rows[i].remarks;
			if((typeof(checked)!="undefined" && typeof(checked)!="NaN" && checked!="" && checked!=null) || (typeof(remarks)!="undefined" && typeof(remarks)!="NaN" && remarks!="" && remarks!=null)){  
				 gridarray.push(rows[i].checked+" :: "+rows[i].remarks+" :: "+rows[i].details+" :: ");            
				 val++;
			} 
		}
		if(val==0){
			    Swal.fire({
       			    icon: 'warning',
					title: 'Warning',
					text: 'Please enter data!!'
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
					$('.load-wrapp').show(); 
					save(gridarray,compid);	
				}
		});
    }
    function save(gridarray,compid){      
    	var x=new XMLHttpRequest();
    	x.onreadystatechange=function(){
    		if (x.readyState==4 && x.status==200){  
    			var items=x.responseText;
    			 $('.load-wrapp').hide();
    		if(parseFloat(items)>0){
    			
    			Swal.fire({
           			icon: 'success',
   					title: 'Success',
   					text: ' Record Successfully Saved '
   				});
    		}else{
    			Swal.fire({
           			icon: 'error',
   					title: 'Error',
   					text: ' Not Saved'
   				});
    		}
    			
    	   }
    	}
    	x.open("GET", "saveData.jsp?gridarray="+gridarray+"&compid="+compid, true);
    	x.send();
    }
  </script>
  </div>
  </form>   
</body>
</html>
