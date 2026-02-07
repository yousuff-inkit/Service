<%@page import="com.seal.service.ClsServiceDAO" %>


<%
 ClsServiceDAO DAO= new ClsServiceDAO();  
%>
<%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>


<script type="text/javascript">
 
 var radata;
 var rowIndex='<%=rowIndex%>';
 
 radata='<%=DAO.accountsearch()%>';
 
 //alert(radata)
        $(document).ready(function () { 
              var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'docno', type: 'String'  },
     						{name : 'account', type: 'String'  },
     						{name : 'description', type: 'String'  },
     					
                          	],
                          	localdata: radata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxaccountsearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
               filterable: true,
               showfilterrow: true,

            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'DOC NO', datafield: 'docno', width: '25%',hidden:true },
					{ text: 'ACCOUNT NO', datafield: 'account', width: '25%' },
					{ text: 'ACCOUNT NAME', datafield: 'description' },
							 
					
					]
            });
     $('#jqxaccountsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				            	        document.getElementById("accdocno").value=$('#jqxaccountsearch').jqxGrid('getcellvalue', rowindex1, "docno");
				               			document.getElementById("txtacc").value=$('#jqxaccountsearch').jqxGrid('getcellvalue', rowindex1, "description");
				              
				                $('#accinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
          
      }); 
				       
                       
    </script>
    <div id="jqxaccountsearch"></div> 
    
    </body>
</html>