<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.quotation.ClsQuotationDAO" %>
<%
 	    ClsQuotationDAO DAO= new ClsQuotationDAO();
		String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").trim().toString(); 
		String enqdocno=request.getParameter("enqdocno")==null || request.getParameter("enqdocno")==""?"0":request.getParameter("enqdocno").trim().toString(); 
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		String revisionno=request.getParameter("revisionno")==null || request.getParameter("revisionno").equals("")?"999999":request.getParameter("revisionno").trim().toString();   
 %> 
 <style type="text/css">   
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>  
<script type="text/javascript">

var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
             if(id==1){  
            	 quotedata='<%=DAO.quoteGridLoad(session,enqdocno,id,revisionno)%>';      
        	 }else if(id==2){
        		 quotedata='<%=DAO.quoteGridLoad(session,trno,id,revisionno)%>';   
        	 }else{}    
            // prepare the data
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
         	
           var rendererstring1=function (aggregates){
                 var value1=aggregates['sum1'];
                 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
                }
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'site', type: 'String'  },
		                  	{name : 'area', type: 'String'  },
     						{name : 'skiptype', type: 'string'  },
                          	{name : 'skipdoc', type: 'String'  },
     						{name : 'nos', type: 'number'   },
     						{name : 'wastetype', type: 'string'   },
                          	{name : 'wastedoc', type: 'String'  },
     						{name : 'serviceby', type: 'String'  },
     						{name : 'servicebyid', type: 'String'  },
     						{name : 'ownership', type: 'String'  },
     						{name : 'ownershipid', type: 'String'  },
                          	{name : 'serviceterm', type: 'String'  },
                        	{name : 'servicetermid', type: 'String'  },
                        	{name : 'collection', type: 'String'  },
                        	{name : 'collectionid', type: 'String'  },
                          	{name : 'days', type: 'number'  },
                        	{name : 'spec', type: 'string'  },
                          	{name : 'specid', type: 'String'  },
                          	{name : 'tippingfee', type: 'number'  },   
                          	{name : 'rate', type: 'number'  },
                        	{name : 'tariffrate', type: 'number'  },  
                          	{name : 'rent', type: 'number'  },
                          	{name : 'foc', type: 'number'  },
                          	{name : 'securityval', type: 'number'  }, 
                          	{name : 'tippingmethod', type: 'String'  },
                        	{name : 'tippingmethodid', type: 'String'  }, 
                        	{name : 'restricted', type: 'bool'  },  
                        	{name : 'tippingsecurity', type: 'number'  }, 
                        	{name : 'rowno', type: 'number'  }, 
                        	{name : 'tripsinmonth', type: 'number'  }, 
                        	{name : 'gatefee', type: 'number'  },
                        	{name : 'ctype', type: 'String'  },
                        	{name : 'ctypeid', type: 'String'  }, 
                        	{name : 'addrate', type: 'number'  }, 
     											
                 ],
                 localdata: quotedata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            $("#jqxQuote").on("bindingcomplete", function (event) { 
            	if(id==1){  
            	  funGetValues();
            	}
      		}); 
            var cellclassname = function (row, column, value, data) {
          		 if (data.ctype=="TRIP BASIS") {  
                      return "orangeClass";
                  };
               };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			            
		            }		
            );
            
            $("#jqxQuote").jqxGrid(
            {
                width: '100%',
                height: 120,
                source: dataAdapter,
                disabled:true,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
            	/* showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25, */ 
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            
							{ text: 'Site', datafield: 'site', width: '8%'}, 	  
							{ text: 'Waste Type', datafield: 'wastetype', width: '6%' ,editable:false},	  
							{ text: 'Wastedoc',datafield:'wastedoc',width:'5%',editable:false,hidden:true},
							{ text: 'Skip Size', datafield: 'skiptype', width: '7%',editable:false },	
							{ text: 'Skipdoc',datafield:'skipdoc',width:'5%',editable:false,hidden:true},
							{ text: 'Spec', datafield: 'spec', width: '7%',editable:false },	
							{ text: 'Specid',datafield:'specid',width:'5%',editable:false,hidden:true},  
							{ text: 'Service By', datafield: 'serviceby', width: '6%',editable:false,hidden:true},  
							{ text: 'Servicebyid',datafield:'servicebyid',width:'5%',editable:false,hidden:true},
							{ text: 'Ownership', datafield: 'ownership', width: '4%',editable:false},
							{ text: 'Ownershipid',datafield:'ownershipid',width:'5%',editable:false,hidden:true}, 
				            { text: 'Qty', datafield: 'nos', width: '2%'},
				            { text: 'Service Term', datafield: 'serviceterm', width: '6%',editable:false},  
							{ text: 'servicetermid',datafield:'servicetermid',width:'5%',editable:false,hidden:true}, 
							{ text: 'Nos', datafield: 'days', width: '2%',
						         validation: function (cell, value) {
						             if(value % 1 !== 0)  
						             {
						                 return { result: false, message: "No of Visit should contain only numbers" };  
						             }
						             return true;
						          }
						    },   
							{ text: 'Trips in Month', datafield: 'tripsinmonth', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
							{ text: 'Rate per Colllection', datafield: 'rate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Rate per Colllection', datafield: 'tariffrate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },	
							{ text: 'FOC / Restr. Trip', datafield: 'foc', width: '3%',hidden:true,    
						         validation: function (cell, value) {
						             if(value % 1 !== 0)  
						             {
						                 return { result: false, message: "FOC Trips should contain only numbers" };   
						             }
						             return true;
						          }
						    },    
						    { text: 'Add.Rate', datafield: 'addrate', width: '3%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						    { text: 'Ctype', datafield: 'ctype', width: '4%',editable:false},    
							{ text: 'Ctypeid',datafield:'ctypeid',width:'4%',editable:false,hidden:true},   
						    { text: 'Skip Rent', datafield: 'rent', width: '6%',cellsformat:'d0',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname:cellclassname },
							{ text: 'Security', datafield: 'securityval', width: '6%',cellsformat:'d0',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'T.Fee Method', datafield: 'tippingmethod', width: '6%',editable:false},    
							{ text: 'TippingMethodid',datafield:'tippingmethodid',width:'5%',editable:false,hidden:true},   
							{ text: 'T.Fee', datafield: 'tippingfee', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'T.Fee Security', datafield: 'tippingsecurity', width: '6%',cellsformat:'d0',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Collection', datafield: 'collection', width: '6%',editable:false},  
							{ text: 'Collectionid',datafield:'collectionid',width:'5%',editable:false,hidden:true},   
							{ text: 'Restricted', datafield: 'restricted', columntype: 'checkbox',width:'4%'}, 
							{ text: 'rowno', datafield: 'rowno', width: '6%',editable:false,hidden:true}, 
							{ text: 'Gate Fee', datafield: 'gatefee', width: '4%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						]    
            });
            if($("#docno").val()!=""){
            	getTotals()
            }   
           
            $("#jqxQuote").on('cellendedit', function (event) {    
        	    var args = event.args;
        	    var columnDataField = event.args.datafield;
        	    var rowIndex = event.args.rowindex;
        	    var cellValue = event.args.value;
        	    var oldValue = event.args.oldvalue;  
        	    var tippingmethod= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "tippingmethod"); 
        	    if(columnDataField=="tippingfee"){ 
        	    	if(tippingmethod=="FIXED"){
        	    		 funchangetipingfee(rowIndex);       
        	    		 $.messager.alert('Warning',"Tipping fee is fixed you can't change");
        	    	}
        	    }
        	});
            $("#jqxQuote").on('cellvaluechanged', function (event) {  
                      	 var rowBoundIndex = event.args.rowindex;
                    	 var rows = $('#jqxQuote').jqxGrid('getrows');
                         var rowlength= rows.length;
                         var tripsinmonth= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "tripsinmonth");	
                         var qty= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "nos");	
                    	 var rate= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "rate");
                    	 var foc= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "foc");
                    	 var days= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "days"); 
                    	 var ownership= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "ownership");
                         var rent=0.0,tippingsecurity=0.0,security=0.0;   
                    	 var datafield = event.args.datafield;
                    	 if(datafield=="nos" || datafield=="rate" || datafield=="days") {         
                     		if(qty==""){
                     			qty=1;  
                     		}
                     		if(rate==""){
                     			rate=1;  
                     		}
                     		if(days==""){  
                     			days=1;  
                     		}
                     		if(tripsinmonth==""){         
                     			tripsinmonth=1;  
                     		}
                     		rent=parseFloat(tripsinmonth)*parseFloat(days)*parseFloat(rate)*parseFloat(qty);
                     		if(ownership=="CLIENT SKIP"){ 
                     			rent=0.0;
                     			$('#jqxQuote').jqxGrid('setcellvalue', rowBoundIndex, "rent",rent);        
                     		}
                     		if(ownership=="OWN SKIP"){  
                     			$('#jqxQuote').jqxGrid('setcellvalue', rowBoundIndex, "rent",rent);   
                     		}
                     	}   
                    	var ownership= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "ownership");    
                    	var wastedoc= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "wastedoc");   
                    	var skipdoc= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "skipdoc"); 
                    	var tripsinmonth= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "tripsinmonth");
                     	if(datafield=="days") {       
                     		getTariffRate(skipdoc,ownership,days,tripsinmonth,rowBoundIndex);  
                     	} 
                    	rent= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "rent");  
                    	if(datafield=="rent") {               
                     		if(ownership=="CLIENT SKIP"){        
                     			$('#jqxQuote').jqxGrid('setcellvalue', rowBoundIndex, "securityval",0); 
                     		}
                     		if(ownership=="OWN SKIP"){
                     			security=rent*3;   
                     			$('#jqxQuote').jqxGrid('setcellvalue', rowBoundIndex, "securityval",security);   
                     		}
                     	}
                    	var tippingfee= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "tippingfee");
                    	security= $('#jqxQuote').jqxGrid('getcellvalue', rowBoundIndex, "securityval");  
                    	if(datafield=="tippingfee" || datafield=="securityval" || datafield=="rate") {                 
                     		if(tippingfee==""){
                     			tippingfee=0;  
                     		}
                     		if(rate==""){
                     			rate=0;     
                     		}
                     		if(security==""){    
                     			security=0;     
                     		}
                     		tippingsecurity=(security/parseFloat(rate))*parseFloat(tippingfee); 
                     		console.log(security+"="+rate+"="+tippingfee+"="+tippingsecurity);  
                     		$('#jqxQuote').jqxGrid('setcellvalue', rowBoundIndex, "tippingsecurity",tippingsecurity);        
                     	}
                    	getTotals()
            });
            $('#jqxQuote').on('celldoubleclick', function(event) { 
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
 		        if((datafield=="skiptype")) {
 		    	 	getskiptype(rowBoundIndex);
	    	    }
 		        if((datafield=="wastetype")) { 
 		    		getwastetype(rowBoundIndex);
	    	    }
 		        if((datafield=="spec")) { 
		    		getspec(rowBoundIndex); 
	    	    }
 		        if((datafield=="serviceby")) { 
 		    	    var type="SERVICEBY"; 
 		    	   getOtherDetails(rowBoundIndex,type);  
	    	    }
 		        if((datafield=="ownership")) { 
		    	    var type="SERVICEBY"; 
		    	   getOtherDetails(rowBoundIndex,type);  
	    	    }
 		        if((datafield=="serviceterm")) {   
		    	    var type="SCHEDULE"; 
		    	   getOtherDetails(rowBoundIndex,type);  
	    	    }
 		        if((datafield=="collection")) {   
		    	    var type="COLLECTION"; 
		    	   getOtherDetails(rowBoundIndex,type);  
	    	    }
 		        if((datafield=="tippingmethod")) {              
		    	    var type="TIPPINGFEEMETHOD"; 
		    	   getOtherDetails(rowBoundIndex,type);  
	    	    }
 		       if((datafield=="ctype")) {              
		    	    var type="CTYPE"; 
		    	   getOtherDetails(rowBoundIndex,type);  
	    	    }
 		   });
            console.log($('#mode').val());
            if($('#mode').val()=='view'){
         		 $("#jqxQuote").jqxGrid({ disabled: true});  
           }else{
        	   $("#jqxQuote").jqxGrid({ disabled: false}); 
           }
            $("#jqxQuote").jqxGrid('addrow', null, {});
            
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxQuote").on('contextmenu', function () {
                   return false;
               });
                   
               $("#Menu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxQuote").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxQuote").offset();
                       $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxQuote").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow2").jqxWindow('show');
                   }
                   else {
                       var rowid = $("#jqxQuote").jqxGrid('getrowid', rowindex);
                       var rowno=$('#jqxQuote').jqxGrid('getcellvalue', rowid, "rowno");
                       if(typeof(rowno) != "undefined" && typeof(rowno) != "NaN" && rowno != ""){   
                     	  funDelete(rowno);    
                       }
                       $("#jqxQuote").jqxGrid('deleterow', rowid);
                       getTotals()
                   }
               });
               
               $("#jqxQuote").on('rowclick', function (event) {
                   if (event.args.rightclick) {
        		   
                       $("#jqxQuote").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   
        		   }
               });  
        });
        function funchangetipingfee(rowIndex){
        	var wastedoc= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "wastedoc");  
   			var skipdoc= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "skipdoc");
   			var tippingmethod= $('#jqxQuote').jqxGrid('getcellvalue', rowIndex, "tippingmethod");     
	        getTariffFee(tippingmethod,skipdoc,wastedoc,rowIndex);
        }
        function funGetValues(){    
         	 var rows = $("#jqxQuote").jqxGrid('getrows');   
   		     for(var i=0 ; i < rows.length ; i++){
  			     var rent=0.0,tippingsecurity=0.0,security=0.0;
  			     var site=rows[i].site;
  				 if(site!="" && site!="0" && typeof(site)!="undefined" && typeof(site)!="NaN" && site!=null){
  					 var tripsinmonth=rows[i].tripsinmonth;
  					 var qty=rows[i].nos;
  					 var foc=rows[i].foc;
  					 var days=rows[i].days;
  					 var days1=rows[i].days;
  					 var ownership=rows[i].ownership;
  					 var skipdoc=rows[i].skipdoc;
  					 var wastedoc=rows[i].wastedoc;
  					 var tippingmethod=rows[i].tippingmethod;
  					 var skipdoc=rows[i].skipdoc;  
  					 getTariffRate(skipdoc,ownership,days,tripsinmonth,i);  
  					 getTariffFee(tippingmethod,skipdoc,wastedoc,i);
  				 }
   		     }
         }
        function funGetValues1(){  
        	 var rows = $("#jqxQuote").jqxGrid('getrows');   
  		     for(var i=0 ; i < rows.length ; i++){
 			     var rent=0.0,tippingsecurity=0.0,security=0.0;
 			     var site=rows[i].site;
 				 if(site!="" && site!="0" && typeof(site)!="undefined" && typeof(site)!="NaN" && site!=null){
 					 var tripsinmonth=rows[i].tripsinmonth;
 					 var qty=rows[i].nos;
 					 var foc=rows[i].foc;
 					 var days=rows[i].days;
 					 var days1=rows[i].days;
 					 var ownership=rows[i].ownership;
 					 var skipdoc=rows[i].skipdoc;
 					 var wastedoc=rows[i].wastedoc;
 					 var tippingmethod=rows[i].tippingmethod;
 					 var skipdoc=rows[i].skipdoc;  
 					 var rate=rows[i].rate;
 					 var tippingfee=rows[i].tippingfee;
 					 if(qty==""){
               			qty=1;  
               		 }
               		 if(rate==""){
               			rate=1;  
               	 	 }
               		 if(days==""){  
               			days=1;  
               		 }
               		 if(tripsinmonth==""){         
               			tripsinmonth=1;  
               		 }
               		 if(ownership=="CLIENT SKIP"){ 
               			rent=0.0;
               			$('#jqxQuote').jqxGrid('setcellvalue', i, "rent",rent);        
               		 }
               		 if(ownership=="OWN SKIP"){
               			rent=parseFloat(tripsinmonth)*parseFloat(days)*parseFloat(rate)*parseFloat(qty);  
               			$('#jqxQuote').jqxGrid('setcellvalue', i, "rent",rent);   
               		 }
               		 
              		 if(ownership=="CLIENT SKIP"){ 
              			 security=0.0;
              			 $('#jqxQuote').jqxGrid('setcellvalue', i, "securityval",security);    
              		 }
              		 if(ownership=="OWN SKIP"){    
              			security=rent*3;  
              			$('#jqxQuote').jqxGrid('setcellvalue', i, "securityval",security);  
              		 }
              		 security==rows[i].securityval;  
              		 if(tippingfee==""){    
              			tippingfee=0;  
              		 }
              		 if(security==""){    
              			security=0;  
              		 }  
              		 tippingsecurity=(security/parseFloat(rate))*parseFloat(tippingfee);           
              		 $('#jqxQuote').jqxGrid('setcellvalue', i, "tippingsecurity",tippingsecurity);  
 				 }
  		     }
  		   getTotals()
        }
        function funDelete(rowno){            
    	    var x=new XMLHttpRequest();
    			x.onreadystatechange=function(){
    				if (x.readyState==4 && x.status==200)
    				{  
    					var items=x.responseText.trim();     
    				}
    				else    
    				{       
    				}                     
    			}
    			x.open("GET","deleterows.jsp?rowno="+rowno,true);                                          
    			x.send();      
    	} 
        
        function getTotals(){  
        	 document.getElementById('calcshowlbl').innerHTML="";
        	 var site = $('#jqxQuote').jqxGrid('getcellvalue', 0, "site");
        	 var tippingmethod = $('#jqxQuote').jqxGrid('getcellvalue', 0, "tippingmethod");
        	 if(typeof(site)!="undefined" && typeof(site)!="NaN" && site!="" && site!=null){ 
		         var rateData = $("#jqxQuote").jqxGrid('getcolumnaggregateddata', 'rate', ['sum'],true);  
		       	 var rate = rateData.sum.replace(/,/g,''); 
		            
		       	 var tippingfeeData = $("#jqxQuote").jqxGrid('getcolumnaggregateddata', 'tippingfee', ['sum'],true);  
		       	 var tippingfee = tippingfeeData.sum.replace(/,/g,'');
		       	 
		       	 var qtyData = $("#jqxQuote").jqxGrid('getcolumnaggregateddata', 'nos', ['sum'],true); 
		       	 var qty = qtyData.sum;
		       	 
		       	 var nosData = $("#jqxQuote").jqxGrid('getcolumnaggregateddata', 'days', ['sum'],true);  
		       	 var nos = nosData.sum; 
		       	 
		       	 var tripsinmonthData = $("#jqxQuote").jqxGrid('getcolumnaggregateddata', 'tripsinmonth', ['sum'],true);  
		       	 var tripsinmonth = tripsinmonthData.sum.replace(/,/g,'');  
		            
		       	 var billingmethod = $("#cmbbillingmethod").val();
		       	 var bmode = 1;
		       	 var bname = "";
		       	 
		       	 
		         var gateData = $("#jqxQuote").jqxGrid('getcolumnaggregateddata', 'gatefee', ['sum'],true);  
		       	 var gate = gateData.sum.replace(/,/g,''); 
		       
		       	 
		         if(billingmethod=="1"){
		           	 bmode = 1;
		           	 bname = "Monthly";
		         }else if(billingmethod=="2"){
		           	 bmode = 12;
		           	 bname = "Yearly";  
		         }else{} 
		            
		         var totalcharges = 0.0;
		         if(tippingmethod == "ACTUAL"){
		             totalcharges = parseFloat(rate)+parseFloat(gate);
        	     }else{
        	    	 totalcharges = parseFloat(rate)+parseFloat(tippingfee)+parseFloat(gate);
        	     } 
		         var nooftrips = parseFloat(qty)*parseFloat(nos)*parseFloat(bmode)*parseFloat(tripsinmonth);
		         var permonthcharges = 0;
		         if(bmode!=0){  
		        	 permonthcharges = (totalcharges*Math.round(nooftrips))/parseFloat(bmode); 
		         } 
		         var totalservcharges = parseFloat(rate)*Math.round(nooftrips);
		         var tippingfeecharges = parseFloat(tippingfee)*Math.round(nooftrips);
		         var totalcntvalue = totalservcharges+tippingfeecharges; 
		            
		         document.getElementById('calcshowlbl').innerHTML="Total Charges = "+Math.round(totalcharges* 100)/ 100+"&emsp;&emsp;No of Trips - "+bname+" = "+Math.round(nooftrips)+"&emsp;&emsp;Per Month Charges = "+Math.round(permonthcharges)+"&emsp;&emsp;Total Service Charge - "+bname+" = "+Math.round(totalservcharges)+"&emsp;&emsp;Tipping Fee Charges - "+bname+" = "+Math.round(tippingfeecharges)+"&emsp;&emsp;Total Contract Value = "+Math.round(totalcntvalue);
        	 }  
       }
    </script>
     <div id='jqxWidget'>
     <div id="jqxQuote"></div>  
    <div id="popupWindow2">
        <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>