<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.legacydata.productopening.ClsproductopeningDAO"%>
 <% ClsproductopeningDAO searchDAO = new ClsproductopeningDAO();
String docnosss = request.getParameter("reqdoc")==null?"0":request.getParameter("reqdoc").trim();
   %> 
<script type="text/javascript">

	var datass;
   var temp='<%=docnosss%>';
	if(temp>0)
        	{
	
 
 	 datass='<%=searchDAO.reloadsearch(docnosss)%>';
  
 	 }
	else
	{
		  datass;
	
	}
           	  
        
        $(document).ready(function () { 	 
        	 
 
        	    
            var source =
            {
                datatype: "json",
                datafields: [
                         	{name : 'productid', type: 'string'    }, 
                    		{name : 'productname', type: 'string'    },
                    		{name : 'unit', type: 'String'    },
     						{name : 'qty', type: 'number'    },
     						//{name : 'doc_no', type: 'number'    },
     						
     						 
     						{name : 'branch', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'psrno', type: 'number'    }, 
     				      
                    		 {name : 'specid', type: 'string'},
                    		 
                    		 {name : 'brandname', type: 'string'},
                    		 
                    		 
                    		 {name : 'stockid', type: 'string'},
                    		 
                    		 
                    		 {name : 'costprice', type: 'number'},
                    		 
                    		 {name : 'brhid', type: 'string'    },
      						{name : 'locid', type: 'string'    },
                    		 
                    		 
                     
                    		 
                    		 
     											
                 ],
                 localdata: datass,
                
                
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

            
            

            
            $("#purchasedetails").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                disabled:true,
                editable:true ,
        
             //   editmode: 'click',
                
                selectionmode: 'singlecell',
                pagermode: 'default',
                handlekeyboardnavigation: function (event) {
                   	
               	 var cell1 = $('#purchasedetails').jqxGrid('getselectedcell');     	 
               	 if (cell1 != undefined && cell1.datafield == 'productid' || cell1.datafield == 'productname' ) {  
               	
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {  
                        	 document.getElementById("rowindex").value = cell1.rowindex;
                      
                        	 SearchContent('productmastersearch.jsp?');
                       	 $('#purchasedetails').jqxGrid('render');
                       }
                       }
                  
              	 if (cell1 != undefined && cell1.datafield == 'branch') { 
               	
                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    if (key == 114) {  
                   	 document.getElementById("rowindex").value = cell1.rowindex;

        		    	branchSearchContent('branchmastersearch.jsp?');
                   	 $('#purchasedetails').jqxGrid('render');
                    }
                 }
          
                	 if (cell1 != undefined && cell1.datafield == 'location') {  
                
            
		                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                    if (key == 114) {  
		                    	 document.getElementById("rowindex").value = cell1.rowindex;
		               
		                  	locationSearchContent('locationmastersearch.jsp?brch='+$('#purchasedetails').jqxGrid('getcellvalue', cell1.rowindex, "brhid"));
		                  	 $('#purchasedetails').jqxGrid('render');
		                    }
                   }
             
             
                 }, 
             
            		
                columns: [
							 	
                            { text: 'SL#', sortable: false, filterable: false, editable: false,
                                groupable: false, draggable: false, resizable: false,cellsalign: 'center', align:'center',
                                datafield: 'sl', columntype: 'number', width: '6%',
                                cellsrenderer: function (row, column, value) {
                                    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                                }  
                              },
                            //{ text: 'Doc No', datafield: 'doc_no', width: '7%', editable:false  },
                          	{ text: 'Doc No', datafield: 'psrno', width: '7%', editable:false  },
  							{ text: 'Product', datafield: 'productid', width: '13%', editable:false  },
  							{ text: 'Product Name', datafield: 'productname', editable:false  },
  							
  							{text: 'Brand Name', datafield: 'brandname', width: '15%' , editable:false  },
  							{ text: 'Unit', datafield: 'unit', width: '5%', editable:false	},
  							
  							{ text: 'Branch', datafield: 'branch', width: '12%', editable:false  },
  							{ text: 'Location', datafield: 'location', width: '12%', editable:false },
  							
  							
  							
  							{text: 'brhid', datafield: 'brhid', width: '10%'  ,hidden:true },
							
  							
  							{text: 'locid', datafield: 'locid', width: '10%'  ,hidden:true  },
							
  							
  							
  							{ text: 'Quantity', datafield: 'qty', width: '5%' ,cellsalign: 'left', align:'left',cellsformat:'d2'},
  							{ text: 'Cost Price', datafield: 'costprice', width: '8%' ,cellsalign: 'right', align:'right',cellsformat:'d2'},
  							 
							
							{text: 'specid', datafield: 'specid', width: '10%'  ,hidden:true  },
							
							{text: 'stockid', datafield: 'stockid', width: '10%' ,hidden:true },
							 
			              ]
               
            });
         
            $("#purchasedetails").jqxGrid('addrow', null, {});

    		if ($("#mode").val() == "A" || $("#mode").val() == "E") {
    			
    			$("#purchasedetails").jqxGrid({ disabled: false});
    			
    		}
                    

            $('#purchasedetails').on('celldoubleclick', function (event) {

            	var rowBoundIndex = event.args.rowindex;
            	
            	document.getElementById("rowindex").value=rowBoundIndex;
            	
            	var datafield = event.args.datafield;
            	
            	if(datafield=="psrno" || datafield=="psrno")
 	    	   { 
             
  		    	SearchContent('productmastersearch.jsp?');
 	    	   }
            	if(datafield=="productid" || datafield=="productname")
 	    	   { 
             
  		    	SearchContent('productmastersearch.jsp?');
 	    	   }
  		    
            	
              	if(datafield=="branch")
  	    	   { 
              
   		    	branchSearchContent('branchmastersearch.jsp?');
  	    	   }
   		    
             	if(datafield=="location")
   	    	   { 
               
    		    	locationSearchContent('locationmastersearch.jsp?brch='+$('#purchasedetails').jqxGrid('getcellvalue', rowBoundIndex, "brhid"));
   	    	   }
    		    
            	 
            });
           
        
        
        });
        	
    
        $("#overlay, #PleaseWait").hide(); 
        	 
        	
    </script>
    <div id="purchasedetails"></div>
 
  <input type="hidden" id="rowindex"/> 
   <input type="hidden" id="datas"/>      
   
   
   
  