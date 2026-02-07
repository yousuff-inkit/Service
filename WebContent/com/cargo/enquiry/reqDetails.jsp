<%@page import="com.cargo.enquiry.ClscargoEnquiryDAO"%>
<% ClscargoEnquiryDAO  cargoenquiryDAO = new ClscargoEnquiryDAO(); %> 

 <%
           	String enqrdocno = request.getParameter("enqrdocno")==null?"0":request.getParameter("enqrdocno").trim();
           	  %> 
<script type="text/javascript">
            var reqdata1; 
           	var temp1='<%=enqrdocno%>';
            var hide;
            if(temp1>0)
          	 {
            	  reqdata1='<%=cargoenquiryDAO.maingridreload(enqrdocno)%>'; 
          	      hide=2;      
          	 } 
                
        $(document).ready(function () { 	
        
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'mode', type: 'string'  },
							{name : 'modeid', type: 'int'   },
     						{name : 'submode', type: 'string'  },
     						{name : 'smodeid', type: 'int'   },
     						{name : 'shipment', type: 'string'  },
     						{name : 'shipmentid', type: 'int'   },
     						{name : 'terms', type: 'string'   },
     						{name : 'termid', type: 'int'   },
     						{name : 'orgin', type: 'string'  },
     						{name : 'pol', type: 'string'   },
     						{name : 'pod', type: 'string'   },
     						{name : 'polid', type: 'string'   },
     						{name : 'podid', type: 'string'   },
     						{name : 'comodity', type: 'string'   },
     						{name : 'weight', type: 'string'   },
     						
     						{name : 'noofpacks', type: 'number'  },
     						{ name: 'dimension', type: 'string' },
     						{name : 'volume', type: 'string' },
     						{ name: 'remarks', type: 'string' },
     						{ name: 'chkmode', type: 'string' },
     						{name : 'qty', type: 'int'  },
     						{name : 'sr_no', type: 'int'  }
     						
     											
                 ],
                 localdata: reqdata1,
                
                
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

            
            
            $("#jqxEnquiry").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
               
                disabled:true,
                editable: true,
                
                columnsresize: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
               
                handlekeyboardnavigation: function (event) {
               	
                	 var cell1 = $('#jqxEnquiry').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'mode') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                        	modeinfoSearchContent('modeSearch.jsp');
                        	 $('#jqxEnquiry').jqxGrid('render');
                        }
                        }
                	 if (cell1 != undefined && cell1.datafield == 'shipment') {  
                     	
                         var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                         if (key == 114) {  
                          	 document.getElementById("rowindex").value = cell1.rowindex;
                        
                         	modeinfoSearchContent('shipmentSearch.jsp');
                         	 $('#jqxEnquiry').jqxGrid('render');
                         }
                         }
               	 if (cell1 != undefined && cell1.datafield == 'terms') { 
                	
                     var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                     if (key == 114) {  
                    	 document.getElementById("rowindex").value = cell1.rowindex;
                    	 terminfoSearchContent('termSearch.jsp');
                    	 $('#jqxEnquiry').jqxGrid('render');
                     }
                  }
           
                 	 if (cell1 != undefined && cell1.datafield == 'submode') {  
                 
             
		                    var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
		                    if (key == 114) {  
		                    	 document.getElementById("rowindex").value = cell1.rowindex;
		                  	 
		                  	submodeinfoSearchContent('submodeSearch.jsp');
		                  	 $('#jqxEnquiry').jqxGrid('render');
		                    }
                    }
              
              
                  }, 
              
                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
                            },	
                            { text: 'Mode', datafield: 'mode', width: '9%' , editable: false },	
                            { text: 'Modeid', datafield: 'modeid', width: '2%' ,hidden:true },
							{ text: 'Submode', datafield: 'submode', width: '9%', editable: false , coloumnresizable:true},	
							{ text: 'Submodeid', datafield: 'smodeid', width: '2%',hidden:true },
							{ text: 'Shipment', datafield: 'shipment', width: '9%' , editable: false},
							{ text: 'Shipmentid', datafield: 'shipmentid', width: '2%' ,hidden:true },
							{ text: 'Terms', datafield: 'terms', width: '7%', editable: false },	
							{ text: 'Termid', datafield: 'termid', width: '2%',hidden:true },
							{ text: 'Pol', datafield: 'pol', width: '6%', editable: false},
							{ text: 'PoD', datafield: 'pod', width: '6%', editable: false},  	
							{ text: 'Qty', datafield: 'qty', width: '5%'},
							{ text: 'Weight', datafield: 'weight', width: '6%'},
							{ text: 'Orgin', datafield: 'orgin', width: '6%' },                 
							{ text: 'Commodity', datafield: 'comodity', width: '9%'},
							
							{ text: 'No of Packs', datafield: 'noofpacks', width: '6%' },	
							{ text: 'Dimension', datafield: 'dimension', width: '6%' },
							{ text: 'Volume', datafield: 'volume', width: '6%' },	
							{ text: 'Remarks', datafield: 'remarks', width: '6%' },	
							
							{ text: 'srno', datafield: 'sr_no', width: '9%',hidden:true},
							{ text: 'polid', datafield: 'polid', width: '9%',hidden:true},
							{ text: 'chkmode', datafield: 'chkmode', width: '9%',hidden:true},
							{ text: 'podid', datafield: 'podid', width: '9%',hidden:true}
			              ]
               
            });
           
            $("#jqxEnquiry").jqxGrid('addrow', null, {});
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#jqxEnquiry").jqxGrid({ disabled: false}); 
    		}
            $('#jqxEnquiry').on('cellclick', function (event) {
            	var rowindextemp = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
            });
   

            $('#jqxEnquiry').on('celldoubleclick', function (event) {
            	var columnindex1=event.args.columnindex;
            	var datafield = event.args.datafield;
            	 var rowindextemp = event.args.rowindex;
                	
             		  var chk=document.getElementById("hidmodechk").value;
             		 var smode=$('#jqxEnquiry').jqxGrid('getcellvalue', rowindextemp, "submode");
             			//alert("chk===="+chk+"=====smode==="+smode);
             			 if(datafield == "mode")
                 		  { 
               		
                 	 var rowindextemp = event.args.rowindex;
                 	    document.getElementById("rowindex").value = rowindextemp;  
                 	  $('#jqxEnquiry').jqxGrid('clearselection');
                 	modeinfoSearchContent('modeSearch.jsp');
                 	
                 		  } 
             			if(chk==1){
                  			
                  			if(smode==""){
                  				document.getElementById("errormsg").innerText="Sub Mode is Mandatory.";
                  				 var rowindextemp = event.args.rowindex;
                          	    document.getElementById("rowindex").value = rowindextemp;  
                          		  $('#jqxEnquiry').jqxGrid('clearselection');
                          	   
                          
                          	submodeinfoSearchContent('submodeSearch.jsp?modeval='+$('#jqxEnquiry').jqxGrid('getcellvalue', rowindextemp, "modeid"));
                  			}
                  			else{
                  				 if(datafield == "shipment")
                        		  { 
                             		var rowindextemp = event.args.rowindex;
                          
                             		
                        	    document.getElementById("rowindex").value = rowindextemp;  
                        	  $('#jqxEnquiry').jqxGrid('clearselection');
                        	shipmentinfoSearchContent('shipmentSearch.jsp');
                             		
                        		  }
                  				 if(datafield == "terms")
                       		  { 

                             		
                       	 var rowindextemp = event.args.rowindex;
                       	    document.getElementById("rowindex").value = rowindextemp;  
                       		  $('#jqxEnquiry').jqxGrid('clearselection');
                       	    terminfoSearchContent('termSearch.jsp?modeval='+$('#jqxEnquiry').jqxGrid('getcellvalue', rowindextemp, "modeid"));
                             		
                       		  }
                             	if(datafield == "pol")
                       		  { 

                             		
                       	 var rowindextemp = event.args.rowindex;
                       	    document.getElementById("rowindex").value = rowindextemp;  
                       		  $('#jqxEnquiry').jqxGrid('clearselection');
                       	    polSearchContent('polSearch.jsp');
                             		
                       		  }
                              	if(datafield == "pod")
                         		  { 

                             
                         	 var rowindextemp = event.args.rowindex;
                         	    document.getElementById("rowindex").value = rowindextemp;  
                         		  $('#jqxEnquiry').jqxGrid('clearselection');
                         	    podSearchContent('podSearch.jsp');
                              		
                         		  }	
                  			}
                  		} 
             	
             			else{
              	 if(datafield == "shipment")
         		  { 
              		var rowindextemp = event.args.rowindex;
           
              		
         	    document.getElementById("rowindex").value = rowindextemp;  
         	  $('#jqxEnquiry').jqxGrid('clearselection');
         	shipmentinfoSearchContent('shipmentSearch.jsp');
              		
         		  } 
              	 if(datafield == "submode")
         		  { 
              		
         	 var rowindextemp = event.args.rowindex;
         	    document.getElementById("rowindex").value = rowindextemp;  
         		  $('#jqxEnquiry').jqxGrid('clearselection');
         	   
         
         	submodeinfoSearchContent('submodeSearch.jsp?modeval='+$('#jqxEnquiry').jqxGrid('getcellvalue', rowindextemp, "modeid"));
              		
         		  } 
         	  
              	 if(datafield == "terms")
        		  { 

              		
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        		  $('#jqxEnquiry').jqxGrid('clearselection');
        	    terminfoSearchContent('termSearch.jsp?modeval='+$('#jqxEnquiry').jqxGrid('getcellvalue', rowindextemp, "modeid"));
              		
        		  }
              	if(datafield == "pol")
        		  { 

              		
        	 var rowindextemp = event.args.rowindex;
        	    document.getElementById("rowindex").value = rowindextemp;  
        		  $('#jqxEnquiry').jqxGrid('clearselection');
        	    polSearchContent('polSearch.jsp');
              		
        		  }
               	if(datafield == "pod")
          		  { 

              
          	 var rowindextemp = event.args.rowindex;
          	    document.getElementById("rowindex").value = rowindextemp;  
          		  $('#jqxEnquiry').jqxGrid('clearselection');
          	    podSearchContent('podSearch.jsp');
               		
          		  }	
             			}
                  }); 
            
            $("#jqxEnquiry").on('cellvaluechanged', function (event) 
         		   {
         		       var rowBoundIndex = event.args.rowindex;
         		       var datafield = event.args.datafield;
         		      if(datafield=="fromdate")
       		           {
         		    	  var fromdate=$('#jqxEnquiry').jqxGrid('getcellvalue', rowBoundIndex, "fromdate");
         		    		 var today = new Date();
         		            today.setHours(0, 0, 0, 0);
         		    	if(fromdate<today)
         		    		{
         		    		 document.getElementById("errormsg").innerText="From Date Less Than Current Date";
         		    		 document.getElementById("fromdatesval").value=1;
         					return 0;
         		    		}
         		    	else
         		    		{
         		    		 document.getElementById("errormsg").innerText="";
         		    		 document.getElementById("fromdatesval").value="";
         		    		}
         		    	   var text = $('#jqxEnquiry').jqxGrid('getcelltext', rowBoundIndex, "fromdate");
      		        	  $('#jqxEnquiry').jqxGrid('setcellvalue',rowBoundIndex, "hidfromdate",text);
       		       }
         		  }); 

        	$("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxEnquiry").on('contextmenu', function () {
                   return false;
               });
                   
               $("#Menu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxEnquiry").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxEnquiry").offset();
                       $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxEnquiry").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow2").jqxWindow('show');
                   }else {
                       var rowid = $("#jqxEnquiry").jqxGrid('getrowid', rowindex);
                       $("#jqxEnquiry").jqxGrid('deleterow', rowid);        
                   }   
               });
               
               $("#jqxEnquiry").on('rowclick', function (event) {
                   if (event.args.rightclick) {
                       $("#jqxEnquiry").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   
        		   }
               });
            
        });
    </script>      
   <div id='jqxWidget'>  
   <div id="jqxEnquiry"></div>   
     <div id="popupWindow2">
        <div id='Menu2'>
	        <ul>
	            <li>Delete Selected Row</li>  
	        </ul>
       </div>
     </div>
</div> 
    <input type="hidden" id="rowindex"/> 