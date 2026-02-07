<%@page import="com.dashboard.nipurchase.nipurchaserequestfollowup.ClsnipurchaserequestfollowupDAO"%>
<%ClsnipurchaserequestfollowupDAO sd=new ClsnipurchaserequestfollowupDAO();%>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
String nidoc=request.getParameter("nidoc")==null?"0":request.getParameter("nidoc").trim();
%>
<script type="text/javascript">

var descdata;

var nidoc='<%=nidoc%>';

if(nidoc!=''){
	descdata='<%=sd.loadnireq(nidoc)%>';  
} 

$(document).ready(function () { 	
        
	var rendererstring1=function (aggregates){
    	var value=aggregates['sum1'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
    }    
            
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
    }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
     						{name : 'description', type: 'string'    },
     						{name : 'qty', type: 'number'    },
     						{name : 'avlqty', type: 'number'    },
     						{name : 'unitprice', type: 'number'    },
     						{name : 'total', type: 'number'    },
     						{name : 'discount', type: 'number'    },
     						{name : 'netamt', type: 'number'    },
     						{name : 'nettotal', type: 'number'    },
     						{name : 'nuprice', type: 'number'    },
     						{name : 'srno', type: 'int'  },
     						{name : 'taxper', type: 'number'  },  
        					{name : 'taxamount', type: 'number'  },
        					{name : 'taxperamt', type: 'number'  },
     						{name : 'refrow', type: 'int'  },
     						{name : 'voc_no', type: 'int'  },
     						
                 ],
              
                 localdata: descdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );

            $("#descdetailsGrid").jqxGrid(
            {
                width: '99%',
                height: 302,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 25,
                selectionmode: 'singlecell',
                pagermode: 'default',
                filterable: true,
                showfilterrow:true,
                
                
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
							{ text: 'Description', datafield: 'description',editable:false },
							{ text: 'Quantity', datafield: 'qty',cellsformat:'d2', width: '6%' ,cellsalign: 'left', align:'left'},
							{ text: 'Unit Price', datafield: 'unitprice', width: '7%' ,cellsalign: 'right', align:'right', align:'right',cellsformat:'d2'},
							{ text: 'Total', datafield: 'total', width: '7%' ,editable: false,cellsalign: 'right', align:'right',cellsformat:'d2'},
		    				{ text: 'Discount', datafield: 'discount', width: '7%',cellsalign: 'right', align:'right',cellsformat:'d2' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
							{ text: 'Net Amount', datafield: 'nettotal', width: '8%',cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false},
							{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,editable:true},
							{ text: 'Tax Amount', datafield: 'taxperamt', width: '7%', cellsformat: 'd2'  , cellsalign: 'right', align: 'right'  ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Net Total', datafield: 'taxamount', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right'  ,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
							{ text: 'nuprice', datafield: 'nuprice', width: '9%',cellsformat:'d2',hidden:true},
							{ text: 'srno', datafield: 'srno', hidden:true},
							{ text: 'refrow', datafield: 'refrow', hidden:true},
							{ text: 'avlqty', datafield: 'avlqty', hidden:true},
							{ text: 'voc_no', datafield: 'voc_no', hidden:true},
							
	              ]
            });
            
            $("#descdetailsGrid").jqxGrid({ disabled: false});
         
            /*Delete Row*/
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#descdetailsGrid").on('contextmenu', function () {
                   return false;
               });
               
            $("#Menu2").on('itemclick', function (event) {
                var rowindex = $("#descdetailsGrid").jqxGrid('getselectedrowindex');
                    
                var rowid = $("#descdetailsGrid").jqxGrid('getrowid', rowindex);
                $("#descdetailsGrid").jqxGrid('deleterow', rowid);
            });
            $("#descdetailsGrid").on('cellclick', function (event) {
                if (event.args.rightclick) {
                    $("#descdetailsGrid").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);

                    return false;
                }
            });
            /*Delete Row Ends*/
            
            function valchange(rowBoundIndex)
            {
            	
            	var refrow= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "refrow");	
            	var qty= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            	var avlqty= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "avlqty");	
            	
            	if(parseInt(refrow)>0 && qty>avlqty){
            		$.messager.alert('Warning','Qty value not more than Actual Qty');
            		qty=avlqty;
            	 	$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",avlqty);
            	}
            	
            	var unitprice=	$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
            	var total=parseFloat(qty)*parseFloat(unitprice);
            	
            	
    		    $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
    		    
    		    var gtotal= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "total");
				  
    	   		var discount=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
    	        		    
    	        		
    	   		var nettotal=parseFloat(gtotal)-parseFloat(discount);
    	   		if(discount==""||discount==null||discount=="undefiend")
    	   			{
    	   		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
    	   			}
    	   		else{
    	   			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
    	   		}
    	        		    
    	        var summaryData= $("#descdetailsGrid").jqxGrid('getcolumnaggregateddata', 'nettotal', ['sum'],true);
    	                    
    	        document.getElementById("nettotal").value=parseFloat(summaryData.sum.replace(/,/g,'')).toFixed(2);
    	                    
    		    
    	        var nettotalval=  $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal");
           		var nuprice=parseFloat(nettotalval)/parseFloat(qty);
                       $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "nuprice",nuprice);
            	}

            $("#descdetailsGrid").on('cellvaluechanged', function (event) 
            {
            	var datafield = event.args.datafield;
        		
    		    var rowBoundIndex = event.args.rowindex;
    		     
            		if(datafield=="qty")
            		    {
            
            			valchange(rowBoundIndex);
            		    }
            		if(datafield=="unitprice")
        		    {
            			valchange(rowBoundIndex);
      
            			   var rows = $('#descdetailsGrid').jqxGrid('getrows');
                           var rowlength= rows.length;
                           if(rowBoundIndex == rowlength - 1)
                           	{  
                           //$("#descdetailsGrid").jqxGrid('addrow', null, {});
                           	} 
                           	
            			
        		    }
            		if(datafield=="discount")
        		    {
            			valchange(rowBoundIndex);
   				
        		    }
            		
           		  if(datafield=="taxper")
          		  {
          				var netotal=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
                  		
                  		
                
                  		  var taxper= $('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
                  		  if(parseFloat(taxper)>0)
                			{ 
                  			  
                  			  
                  		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
                  		  
                  		  
                  		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
                  		  
                  		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
                  		  
                  		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
                			}
                  		  
                  		  else
                  			  {
                  			  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
                  			  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
                  			  }
                  		  
          		  }
            		
            		
          	   	  if(datafield=="nettotal")
          		  {
          		var netotal=$('#descdetailsGrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
          		
          		
          		var taxpers=document.getElementById("taxpers").value ; 
          		if(parseFloat(taxpers)>0)
          			{
          			$('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxper",taxpers); 
      		 		 var taxper= taxpers; 
          		  
          		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
          		  
          		  
          		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
          		  
          		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
          		  
          		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
          			
          			}
          		else
          			{
          			 $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",0);
            		  $('#descdetailsGrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",netotal);
          			}
          		
          		  }
            		
            		 
            		});
		/*  $('#descdetailsGrid').on('celldoubleclick', function (event) {
            	
           	 
           	 if(event.args.datafield=="description")
         	   {
           		 
         		 var rowindextemp = event.args.rowindex;
                document.getElementById("prdsetrowno").value = rowindextemp;
         		getproductdetails();
         	   }
            }); */
            
          
        });
        function funinterstate()
		{
			
		   var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
				if (x.readyState==4 && x.status==200)
					{
			       var items= x.responseText.trim();
			       
			       var item = items.split('::');
					var itemval1  = item[0];
					var itemval2 = item[1];
			       
			    
			       if(parseInt(itemval1)>0){
			    	   $('#txtproducttype').show();
			    	   $('#billtype').show();
			    	      $('#descdetailsGrid').jqxGrid('showcolumn', 'taxper');
		            	  $('#descdetailsGrid').jqxGrid('showcolumn', 'taxamount');
		            	  $('#descdetailsGrid').jqxGrid('showcolumn', 'taxperamt');
		            	 // $('#descdetailsGrid').jqxGrid('hidecolumn', 'nettotal');
		                    	  
			       }
					else{
						 
						 $('#txtproducttype').hide();
				    	   $('#billtype').hide();
				    	   
				    	   
				    	   $('#descdetailsGrid').jqxGrid('hidecolumn', 'taxper');
			            	  $('#descdetailsGrid').jqxGrid('hidecolumn', 'taxamount');
			            	  $('#descdetailsGrid').jqxGrid('hidecolumn', 'taxperamt');
			            
						
					}
					}
				else{
					
				}
				}
		x.open("GET","interstate.jsp?docnos="+document.getElementById("accdocno").value,true);

		x.send();
				
		}
    </script>
<div id="descdetailsGrid"></div>
<input type="hidden" id="prdsetrowno"/>

<div id='jqxWidget'>
    <div id="popupWindow2">
 
 <div id='Menu2'>
    <ul>
        <li>Delete Selected Row</li>
    </ul>
</div>       
</div>
</div>
