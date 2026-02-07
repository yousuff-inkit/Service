<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractreview.ClsContractReviewDAO" %>
<%
         ClsContractReviewDAO DAO= new ClsContractReviewDAO();  
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		 String cldocno=request.getParameter("cldocno")==null || request.getParameter("cldocno")==""?"0":request.getParameter("cldocno").trim().toString();  
		 
 %>   
<script type="text/javascript">
  
var hrldata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
             hrldata='<%=DAO.hrLogLoad(session, id, cldocno)%>';                                      
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'status', type: 'String'  },
                        	{name : 'user', type: 'String'  },
                        	{name : 'date', type: 'Date'  },  
                        	{name : 'remarks', type: 'String'  },
                            {name : 'doc_no', type: 'String'  },
                 ],
                 localdata: hrldata,    
                
                
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

            
            $("#jqxHRLog").jqxGrid(  
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
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                           { text: 'Docno', datafield: 'doc_no',editable:false, width: '5%'}, 
                            { text: 'Date', datafield: 'date',editable:false, width: '8%',cellsformat:'dd.MM.yyyy'},
                            { text: 'User', datafield: 'user',editable:false, width: '15%'},    
                            { text: 'Status', datafield: 'status',editable:false, width: '12%'},     
                            { text: 'Remarks', datafield: 'remarks',editable:false}, 
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
        });
    </script>
    <div id="jqxHRLog"></div>       