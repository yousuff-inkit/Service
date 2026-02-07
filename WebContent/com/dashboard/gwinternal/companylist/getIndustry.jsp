
<%@page import="com.dashboard.gwinternal.companylist.ClsCompanyListDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsCompanyListDAO DAO= new ClsCompanyListDAO(); %>
 <%int rowIndex=request.getParameter("rowBoundIndex")==null?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); %>

 <script type="text/javascript">
 
 var inddata;

 var rowIndex='<%=rowIndex%>';
 

 
 inddata='<%=DAO.indSearch(session)%>'; 
 
 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'code', type: 'String'  },
     						{name : 'name', type: 'String'  },
     						{name : 'srno', type: 'String'  },

     						
     						
                          	],
                          	localdata: inddata,
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
            $("#jqxindsearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
            
     					
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Code', datafield: 'code', width: '21%' },
					{ text: 'Industry', datafield: 'name', width: '75%' },
					{ text: 'Srno', datafield: 'srno', width: '75%',hidden:true }

					 
					
					]
            });
    
            //$("#jqxindsearch").jqxGrid('addrow', null, {});
      
				            
				           $('#jqxindsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				            	 
				              	document.getElementById("txtind").value=$('#jqxindsearch').jqxGrid('getcellvalue', rowindex1, "name");
		              	        document.getElementById("indcode").value=$('#jqxindsearch').jqxGrid('getcellvalue', rowindex1, "code");
		              	        document.getElementById("indsrno").value=$('#jqxindsearch').jqxGrid('getcellvalue', rowindex1, "srno");

				              
				                $('#indinfowindow').jqxWindow('close');
				               
				            
				            		 }); 	 
				           
        
                  }); 

       
        
                       
    </script>
    <div id="jqxindsearch"></div>
    
    </body>
</html>