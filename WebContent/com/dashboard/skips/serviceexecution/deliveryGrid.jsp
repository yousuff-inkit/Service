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
  
var deldata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
             deldata='<%=DAO.quotedetLoad(session, rdocno, srno, id)%>';                            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'wastetype', type: 'String'  },
                        	{name : 'skiptype', type: 'String'  },
                        	{name : 'site', type: 'String'  },  
                        	{name : 'qty', type: 'number'  },  
                        	{name : 'skip', type: 'String'  },  
                        	{name : 'skipid', type: 'String'  },  
                        	{name : 'delid', type: 'String'  }, 
                        	{name : 'gpsx', type: 'String'  }, 
                        	{name : 'gpsy', type: 'String'  },   
                 ],
                 localdata: deldata,  
                
                
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
            
            $("#jqxdeliveryGrid").jqxGrid(  
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlerow',      
                pagermode: 'default', 
                filterable: true,
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                ready: function () {
                    // callback function which is called by jqxGrid when the widget is initialized and the binding is completed.
                    var ownership=$('#hidownership').val();
		            if (ownership=="OWN SKIP") {
		                $("#jqxdeliveryGrid").jqxGrid('showcolumn', 'skip');
		            } 
		            else {
		                $("#jqxdeliveryGrid").jqxGrid('hidecolumn', 'skip');   
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
                            { text: 'Skip', datafield: 'skip',editable:false, width: '20%'},  
                            { text: 'Waste Type', datafield: 'wastetype',editable:false},    
                            { text: 'Skip Size', datafield: 'skiptype',editable:false, width: '15%'},
                            { text: 'Site', datafield: 'site',editable:false, width: '20%'},
                            { text: 'GPSX', datafield: 'gpsx',editable:false, width: '10%'},  
                            { text: 'GPSY', datafield: 'gpsy',editable:false, width: '10%'},    
                            { text: 'Skipid', datafield: 'skipid',editable:false, width: '4%',hidden:true}, 
                            { text: 'delid', datafield: 'delid',editable:false, width: '4%',hidden:true}, 
			     ]
            });
            $("#overlay, #PleaseWait").hide();
            $('#jqxdeliveryGrid').on('rowdoubleclick', function (event) {           
           	  var rowindex1=event.args.rowindex;    
           	  var delid =$('#jqxdeliveryGrid').jqxGrid('getcellvalue', rowindex1, "delid");
           	  if(parseInt(delid)>0){
           		$('#hiddelid').val(delid);
           	  }else{
           		$('#hiddelid').val("0");  
           	  }
              document.getElementById("lblotherdetails3").innerHTML=$("#lblname").val()+" Skip -"+$('#jqxdeliveryGrid').jqxGrid('getcellvalue', rowindex1, "skip"); 
          });
        });
    </script>
    <div id="jqxdeliveryGrid"></div>      