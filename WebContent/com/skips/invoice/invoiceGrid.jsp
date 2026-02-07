<%@page import="com.skips.invoice.ClsManualInvoiceDAO1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
	String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
	String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
	ClsManualInvoiceDAO1 invdao=new ClsManualInvoiceDAO1();  
%>

 <script type="text/javascript">
        
        $(document).ready(function () { 	
        	var  invoicedata='<%=invdao.getInvoiceGridData(docno)%>';  	
        	var num = 1; 
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
                    
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                	 		 {name :'rowno',type:'number'},   
                             {name :'idno',type:'number'},
     						 {name : 'account', type: 'string'},
     						 {name : 'description', type: 'string'},
     						 {name : 'qty', type: 'number'},
     						 {name : 'rate', type: 'number'},
     						 {name : 'total', type: 'number'},
     						 {name : 'taxper', type: 'number'},
     						 {name : 'taxamt', type: 'number'},
     						 {name : 'nettotal', type: 'number'},  
                 ],               
               localdata:invoicedata,
               
              /*  deleterow: function (rowid, commit) {
                   commit(true);
               }, */  
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

            
            
            $("#jqxManualInvoice").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                showaggregates:true,
                showstatusbar:true,
                //pageable: true,
                editable: true,
                altRows: true,
                showfilterrow: true,  
                filterable: true,   
                sortable: true,
                enabletooltips:true,  
                selectionmode: 'singlecell',
               // pagermode: 'default',
                //Add row method
                handlekeyboardnavigation: function (event) {
                    var cell = $('#jqxManualInvoice').jqxGrid('getselectedcell');
                    var cell1 = $('#jqxManualInvoice').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'account') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
        						return false;
        					}
                        	document.getElementById("invoicerow").value=cell1.rowindex;
                        	$('#jqxManualInvoice').jqxGrid('clearselection'); 
                        	$('#jqxManualInvoice').jqxGrid('render');
                        	$('#accountwindow').jqxWindow('open');
        					$('#accountwindow').jqxWindow('focus');
        					 accountSearchContent('accountSearchGrid.jsp?', $('#accountwindow'));
                          }
                        
                    }
                },
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text: 'rowno',datafield:'rowno',width:'20%',hidden:true},  	
                            { text: 'ID',datafield:'idno',width:'20%',hidden:true},					
							{ text: 'Account', datafield: 'account', width: '20%' ,editable: false },  
							{ text: 'Description', datafield: 'description',editable: false },
							{ text: 'Quantity', datafield: 'qty', width: '7%',cellsformat:'d2' },
							{ text: 'Rate', datafield: 'rate', width: '7%' ,cellsalign:'right',cellsformat:'d2',aggregatesrenderer:rendererstring1},
							{ text: 'Total', datafield: 'total', width: '7%',editable: false,cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Tax%', datafield: 'taxper', width: '7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Tax Amount', datafield: 'taxamt',editable: false, width: '7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Net Total', datafield: 'nettotal',editable: false, width: '7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	              ]
            });
       $('#jqxManualInvoice').on('celldoubleclick', function (event) {
    	   var row1=event.args.rowindex;
    	   document.getElementById("invoicerow").value=row1;
    	   $('#jqxManualInvoice').jqxGrid('clearselection');
				if(event.args.datafield=='account'){
					if(document.getElementById("mode").value!="A" && document.getElementById("mode").value!="E"){
						return false;
					}
				
					$('#jqxManualInvoice').jqxGrid('render');
				    $('#accountwindow').jqxWindow('open');
					$('#accountwindow').jqxWindow('focus');
					
					accountSearchContent('accountSearchGrid.jsp?', $('#accountwindow'));
				}
                });
       $("#jqxManualInvoice").on('cellvaluechanged', function (event) {
        	 var rowBoundIndex = event.args.rowindex;
      	     var rows = $('#jqxManualInvoice').jqxGrid('getrows');
             var rowlength= rows.length;
             var total= $('#jqxManualInvoice').jqxGrid('getcellvalue', rowBoundIndex, "total");
             var qty= $('#jqxManualInvoice').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
	      	 var rate= $('#jqxManualInvoice').jqxGrid('getcellvalue', rowBoundIndex, "rate");
	      	 var taxper= $('#jqxManualInvoice').jqxGrid('getcellvalue', rowBoundIndex, "taxper");
	      	 var taxamt= $('#jqxManualInvoice').jqxGrid('getcellvalue', rowBoundIndex, "taxamt"); 
	      	 var totalval=0.0,nettotal=0.0,taxamtval=0.0;    
	      	 var datafield = event.args.datafield;
	      	 if(datafield=="qty" || datafield=="rate" || datafield=="taxper") {           
	      		totalval=parseFloat(rate)*parseFloat(qty);   
	       		$('#jqxManualInvoice').jqxGrid('setcellvalue', rowBoundIndex, "total",totalval.toFixed(2)); 
	       		taxamtval=totalval*(parseFloat(taxper)/100);  
	       		$('#jqxManualInvoice').jqxGrid('setcellvalue', rowBoundIndex, "taxamt",taxamtval.toFixed(2)); 
	       		nettotal=parseFloat(totalval.toFixed(2))+parseFloat(taxamtval.toFixed(2));   
	       		$('#jqxManualInvoice').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);   
	      	 }   
   });
       $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
       // create context menu  
          var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
          $("#jqxManualInvoice").on('contextmenu', function () {
              return false;
          });
              
          $("#Menu2").on('itemclick', function (event) {
       	   var args = event.args;
              var rowindex = $("#jqxManualInvoice").jqxGrid('getselectedrowindex');
              if ($.trim($(args).text()) == "Edit Selected Row") {
                  editrow = rowindex;
                  var offset = $("#jqxManualInvoice").offset();
                  $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                  // get the clicked row's data and initialize the input fields.
                  var dataRecord = $("#jqxManualInvoice").jqxGrid('getrowdata', editrow);
                  // show the popup window.
                  $("#popupWindow2").jqxWindow('show');
              }
              else {
                  var rowid = $("#jqxManualInvoice").jqxGrid('getrowid', rowindex);
                  var rowno=$('#jqxManualInvoice').jqxGrid('getcellvalue', rowid, "rowno");
                  if(typeof(rowno) != "undefined" && typeof(rowno) != "NaN" && rowno != ""){   
                	  funDelete(rowno);    
                  }
                  $("#jqxManualInvoice").jqxGrid('deleterow', rowid);
              }
          });
          
          $("#jqxManualInvoice").on('rowclick', function (event) {
              if (event.args.rightclick) {
   		   
                  $("#jqxManualInvoice").jqxGrid('selectrow', event.args.rowindex);
                  var scrollTop = $(window).scrollTop();
                  var scrollLeft = $(window).scrollLeft();
                  contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                  return false;
              
   		   }
          });       
       var rows=$("#jqxManualInvoice").jqxGrid("getrows");
       if(rows.length==0){
    	   $("#jqxManualInvoice").jqxGrid("addrow", null, {});   
       } 
    });
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
    </script>
    <input type="hidden" name="invoicerow" id="invoicerow">
       <div id='jqxWidget'>
     <div id="jqxManualInvoice"></div>  
    <div id="popupWindow2">
        <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>