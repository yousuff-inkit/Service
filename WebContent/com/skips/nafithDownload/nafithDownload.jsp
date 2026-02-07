<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="java.util.logging.Logger" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
  <% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<style type="text/css">
	.gw-animate-opacity{
		animation:opac 0.8s;
	}
	@keyframes opac{
		from{
			opacity:0;
		}
		to{
			opacity:1;
		}
	}
	.gw-text-green{
		color:#4CAF50;
	}
	.gw-container:after,.gw-container-after{
		content: "";
		display: table;
		clear:both;
	}
	.gw-container{
		padding:0.01em 16px;
	}
	.gw-green{
		color:#fff;
		background-color:#4CAF50;
	}
	.gw-light-grey{
		color:#000;
		background-color:#f1f1f1;
	}
</style>
</head>
<body onload="setValues();">
	<div id="mainBG" class="homeContent" data-type="background" >
		<form id="frmNafithDownload" action="saveNafithDownload" method="post" autocomplete="off">
			<jsp:include page="../../../header.jsp"></jsp:include>
			<div  class='hidden-scrollbar'>
				<br>
				<table style="width:100%;">
					<tr>
						<td align="right">Username</td>
						<td><input type="text" name="username" id="username" placeholder="Press F3 to Search" onkeydown="getUsername();"></td>
						<td colspan="2"><input type="file" name="file" id="file"></td>
  						<td><button type="button" id="btnfileupload" name="btnfileupload" class="myButton">Upload</button></td>
					</tr>
					<tr>
    					<td colspan="5" align="center">
    						<br>
    						<button class="myButton" type="button"  id="btnGo" name="btnGo" onClick="funNotify();" >Download Now !!!</button>
    						<br>
    					</td>
					</tr>
					<tr>
						<td colspan="5">
							<div class="gw-container">
								<div class="gw-light-grey">
									<div id="gwProgressBar" class="gw-container gw-green" style="height:24px;width:0%;"></div>
								</div>
								<p id="gwprogresstext">Added <span id="itemcount" name="itemcount"><s:property value="itemcount"/></span> of <span id="itemtotalcount" name="itemtotalcount"><s:property value="itemtotalcount"/></span> <span id="itemtype" name="itemtotalcount"><s:property value="itemtype"/></span></p>	
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="5"><div id="downloaddiv"><jsp:include page="downloadGrid.jsp"></jsp:include></div></td>
					</tr>
				</table>
			</div>
			<div id="unameWindow">
   				<div></div><div></div>
			</div>
			<input type="hidden"  id="msg" name="msg"  value='<s:property value="msg"/>'/>
			<input type="hidden"  id="mode" name="mode"  value='<s:property value="mode"/>'/>
			<input type="hidden"  id="docno" name="docno"  value='<s:property value="docno"/>'/>
			<script type="text/javascript" src="ajaxfileupload.js"></script>
			<script type="text/javascript">
				$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     			$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../icons/31load.gif'/></div>");
				
				$('#unameWindow').jqxWindow({width: '30%', height: '40%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
	     		$('#unameWindow').jqxWindow('close');
	     		
	     		$('#username').dblclick(function(){
			 		unameSearchContent('usernameSearchGrid.jsp?id=1');
		 		});
		 		
		 		$('#btnfileupload').click(function(e){
					if(document.getElementById("file").files.length > 0 ){
						$("#overlay, #PleaseWait").show();
						var username=$('#username').val();
			        	$.get('getExcelDoc.jsp',{'username':username},function(data){
			        		data=JSON.parse(data);
			        		var docno=data.exceldocno;
				        	var attachdesc='Excel attachment of NAFITH#'+docno;
							$.ajaxFileUpload({
			          			url:'appAttachAction.action?formCode=NFT&doc_no='+docno+'&descpt='+attachdesc+'&reftypid=1',
			        			secureuri:false,//false  
			        			fileElementId:'file',//id  <input type="file" id="file" name="file" />  
			        			dataType: 'json',// json  
			        			success: function (data, status){  
			           				if(status=='success'){
			           					
					            		//$.messager.alert('Message','Upload Successfull');
					            		moveProgressBar();
			           					$.post('readExcel.jsp',{exceldocno:docno},function(salikdata,status){
			           						salikdata=JSON.parse(salikdata);
			           						$("#downloaddiv").load("downloadGrid.jsp?xdocs="+salikdata.salikdocno);
			           				        //$('#loadsalikdata').show();	           						
			           				     	$("#overlay, #PleaseWait").hide();
			           				     	getFinalCount();
			           					});
			              			}
			              			else if(typeof(data.error) != 'undefined'){
			              				$("#overlay, #PleaseWait").hide();
			                  			if(data.error != ''){
			                  				$.messager.alert('Warning',data.error);
			                  			}
			                  			else{
			                  				$("#overlay, #PleaseWait").hide();
			                  				$.messager.alert('Warning',data.message);
			                  			}  
			              			}  
			          			},  
			          			error: function (data, status, e){
			          				$("#overlay, #PleaseWait").hide(); 
			          				$.messager.alert('Warning',e);
			          			}  
			      			}); 	
			        	});
			        	 
		  			}
				});
		 		function unameSearchContent(url) {
	    			$('#unameWindow').jqxWindow('open');
					$.get(url).done(function (data) {
						$('#unameWindow').jqxWindow('setContent', data);
						$('#unameWindow').jqxWindow('bringToFront');
					}); 
				}
				
				function funReadOnly(){
		 			//fundisable();
	 			}
	 
	 			function funRemoveReadOnly(){}
	 
	 			function funSearchLoad(){}
		
	 			function funChkButton() {
					/* funReset(); */
				}
	 
	 			function funFocus(){
					//$('#jqxCashPaymentDate').jqxDateTimeInput('focus'); 	    		
	    		}
	   
	  			function funNotify(){	
	    			document.getElementById("frmNafithDownload").submit();
					document.getElementById("errormsg").innerHTML="Download under Progress...Please wait...";
	    			//return 1;
				}
				
				function setValues(){
					if($('#docno').val()!=''){
						var docno=$('#docno').val();
						$("#downloaddiv").load("downloadGrid.jsp?xdocs="+docno);
					}
					if(document.getElementById("itemcount").innerHTML==""){
						document.getElementById("itemcount").innerHTML="0";
						document.getElementById("itemtotalcount").innerHTML="0";
						document.getElementById("itemtype").innerHTML="Nafiths";
						document.getElementById("gwProgressBar").style.width="0%";
		  			}
				}
				
				function getUname(event){
          			var x= event.keyCode;
          			if(x==114){
 			 			unameSearchContent('usernameSearchGrid.jsp?id=1');
          			}
          			else{
           			}
          		}
          		function moveProgressBar(){
					var elm=document.getElementById("gwProgressBar");
					var width=0;
					//var interval=setInterval(frame,50);
					var interval=setInterval(function() {frame();},2000);
					function frame(){
						$.get('getItemCount.jsp',function(data){
							//console.log(data);
							var items=JSON.parse(data.trim());
							if(width>=100){
								clearInterval(interval);
								document.getElementById("gwprogresstext").className="gw-text-green gw-animate-opacity";
								document.getElementById("gwprogresstext").innerHTML="Successfully downloaded "+totalitemcount+" Nafiths!";
							}
							else{
								var width=(parseInt(items.itemcount)/parseInt(items.totalitemcount))*100;
								width=width.toFixed(2);
								elm.style.width=width+'%';
								document.getElementById("itemcount").innerHTML=items.itemcount;
								document.getElementById("itemtotalcount").innerHTML=items.totalitemcount;
								$("#downloaddiv").load("downloadGrid.jsp?xdocs="+items.itemcurrentdocno);
							}
						});
					}
				}
				
				function getFinalCount(){
					$.get('getItemCount.jsp',{'finalcount':1},function(data){
						var items=JSON.parse(data.trim());
						var elm=document.getElementById("gwProgressBar");
	            		var width=(parseInt(items.itemcount)/parseInt(items.totalitemcount))*100;
						width=width.toFixed(2);
					
						elm.style.width=100+'%';
						document.getElementById("gwprogresstext").className="gw-text-green gw-animate-opacity";
						document.getElementById("gwprogresstext").innerHTML="Successfully Downloaded "+items.itemcount+" Nafiths!";
					});
				}
			</script>
		</form>
	</div>
</body>
</html>