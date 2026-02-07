<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractmanagement.ClsContractManagementDAO" %>
<%
ClsContractManagementDAO DAO= new ClsContractManagementDAO();
  %> 
 <script type="text/javascript">
 
 var rdata;
 rdata='<%=DAO.routeSearch(session)%>';          
 
        $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
	                	    {name : 'doc_no', type: 'String'  },
							{name : 'code', type: 'String'  },
							{name : 'name', type: 'String'  },
							{name : 'gname', type: 'String'  },
							{name : 'site', type: 'String'  },
							{name : 'wastetype', type: 'String'  },    
							{name : 'driver', type: 'String'  },    
							{name : 'helper1', type: 'String'  },    
							{name : 'helper2', type: 'String'  }, 
							{name : 'reg_no', type: 'String'  },      
                          	], 
                          	localdata: rdata,
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
            $("#jqxRouteSearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '8%',hidden:true },  
							{ text: 'Code', datafield: 'code', width: '8%'},
							{ text: 'Route', datafield: 'name', width: '20%'},
							{ text: 'Group', datafield: 'gname', width: '15%' }, 
							{ text: 'Site', datafield: 'site', width: '20%'},
							{ text: 'Waste Type', datafield: 'wastetype', width: '20%'},  
							{ text: 'Driver', datafield: 'driver', width: '15%'},    
							{ text: 'Helper', datafield: 'helper1', width: '15%'},    
							{ text: 'Helper2', datafield: 'helper2', width: '15%'},    
							{ text: 'Reg No', datafield: 'reg_no', width: '10%'},        
					]
            });  
			 $('#jqxRouteSearch').on('rowdoubleclick', function (event) {        
				               var rowindex1=event.args.rowindex;
				               document.getElementById("hidrouteid").value= $('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");  
				               document.getElementById("txtroute").value=$('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "name");
							   $('#routeinfoWindow').jqxWindow('close');      
		  }); 	 
        
      }); 
    </script>
    <div id="jqxRouteSearch"></div>  