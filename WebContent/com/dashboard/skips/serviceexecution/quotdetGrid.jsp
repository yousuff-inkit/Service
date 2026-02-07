<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.serviceexecution.ClsServiceExecutionDAO" %>
<%
ClsServiceExecutionDAO DAO= new ClsServiceExecutionDAO();  
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		 String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim().toString();  
		 String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString();  
 %>   
<script type="text/javascript">
  
var quotdetdata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
             quotdetdata='<%=DAO.quotedetLoad(session, rdocno, srno, id)%>'                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'wastetype', type: 'String'  },
                        	{name : 'skiptype', type: 'String'  },
                        	{name : 'site', type: 'String'  },  
                        	{name : 'qty', type: 'number'  },  
                        	{name : 'balqty', type: 'number'  },  
                        	{name : 'skip', type: 'String'  },  
                        	{name : 'skipid', type: 'String'  }, 
                        	{name : 'skipdoc', type: 'String'  },    
                 ],
                 localdata: quotdetdata,  
                
                
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

            
            $("#jqxquotdetGrid").jqxGrid(  
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlecell',    
                pagermode: 'default', 
                filterable: true,
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Waste Type', datafield: 'wastetype',editable:false, width: '20%'},    
                            { text: 'Skip Size', datafield: 'skiptype',editable:false, width: '20%'},
                            { text: 'skipdoc', datafield: 'skipdoc',editable:false, width: '4%',hidden:true}, 
                            { text: 'Site', datafield: 'site',editable:false, width: '20%'},  
                            { text: 'Qty', datafield: 'qty',editable:false, width: '8%'},
                            { text: 'Bal Qty', datafield: 'balqty',editable:false, width: '8%'},  
                            { text: 'Skip', datafield: 'skip',editable:false, width: '20%',hidden:true},  
                            { text: 'Skipid', datafield: 'skipid',editable:false, width: '4%',hidden:true}, 
			     ]
            });
            $('#jqxquotdetGrid').on('celldoubleclick', function(event) {   
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
 		        if((datafield=="skip")) {   
 		        	var skiptype=$('#jqxquotdetGrid').jqxGrid('getcellvalue', rowBoundIndex, "skipdoc"); 
 		    	 	getskip(rowBoundIndex,skiptype);    
	    	    }
 		   });
            $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="jqxquotdetGrid"></div>   