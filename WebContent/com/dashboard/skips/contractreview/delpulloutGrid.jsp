<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractreview.ClsContractReviewDAO" %>  
<%
         ClsContractReviewDAO DAO= new ClsContractReviewDAO(); 
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		 String contrno=request.getParameter("contrno")==null || request.getParameter("contrno")==""?"0":request.getParameter("contrno").trim().toString();  
 %>   
<script type="text/javascript">
  
var schdeldata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
             schdeldata='<%=DAO.dpLoad(session, contrno, id)%>';                               
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [   
		                	{name : 'skiptype', type: 'String'  },
		                	{name : 'qty1', type: 'String'  },
		                	{name : 'delqty', type: 'String'  },  
		                	{name : 'deldate', type: 'date'  },  
		                	{name : 'remarks', type: 'String'  },  
		                	{name : 'pullqty', type: 'String'  },  
		                	{name : 'pulldate', type: 'date'  },  
		                	{name : 'pullremarks', type: 'String'  },  
		                	{name : 'atsite', type: 'String'  },  
		                	{name : 'srno', type: 'String'  }, 
		                	{name : 'delid', type: 'String'  },    
		                	{name : 'type', type: 'String'  },    
                 ],
                 localdata: schdeldata,  
                
                
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

            
            $("#jqxDeliveryGrid").jqxGrid(  
            {
                width: '100%',
                height: 180,    
                source: dataAdapter,
                editable: true,
                altRows: true,
                selectionmode: 'singlerow',      
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
                            { text: 'Skip Size', datafield: 'skiptype',editable:false, width: '15%'},  
                            { text: 'Qty', datafield: 'qty1',editable:false, width: '8%'},
                            { text: 'Del. Qty', datafield: 'delqty',editable:false, width: '8%'},
                            { text: 'Del. Date', datafield: 'deldate',editable:false, width: '8%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Remarks', datafield: 'remarks',editable:false },   
                            { text: 'Pull Out Qty', datafield: 'pullqty',editable:false, width: '8%' },  
                            { text: 'Pull Out Date', datafield: 'pulldate',editable:false, width: '8%',cellsformat:'dd.MM.yyyy' }, 
                            { text: 'Pull Out Remarks', datafield: 'pullremarks',editable:false, width: '15%' },           
                            { text: 'At Site', datafield: 'atsite',editable:false, width: '6%' }, 
                            { text: 'srno', datafield: 'srno',editable:false, width: '6%',hidden:true }, 
                            { text: 'delid', datafield: 'delid',editable:false, width: '6%',hidden:true }, 
                            { text: 'type', datafield: 'type',editable:false, width: '6%',hidden:true },     
			     ] 
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxDeliveryGrid').on('rowdoubleclick', function (event) {                 
	           	  var rowindex1=event.args.rowindex;         
	           	  document.getElementById("hiddpsrno").value=$('#jqxDeliveryGrid').jqxGrid('getcellvalue', rowindex1, "srno");  
	           	  document.getElementById("hiddpqty").value=$('#jqxDeliveryGrid').jqxGrid('getcellvalue', rowindex1, "qty1");    
	           	  document.getElementById("hiddpdeliveryqty").value=$('#jqxDeliveryGrid').jqxGrid('getcellvalue', rowindex1, "delqty");          
	           	  document.getElementById("hiddpdelid").value=$('#jqxDeliveryGrid').jqxGrid('getcellvalue', rowindex1, "delid");        
	           	  document.getElementById("hiddptype").value=$('#jqxDeliveryGrid').jqxGrid('getcellvalue', rowindex1, "type");        
            });                 
        });
    </script>
    <div id="jqxDeliveryGrid"></div>      