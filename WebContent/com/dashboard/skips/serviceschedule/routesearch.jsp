<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.serviceschedule.ClsServiceScheduleDAO" %>
<%
ClsServiceScheduleDAO DAO= new ClsServiceScheduleDAO(); 
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
							{name : 'driverid', type: 'String'  },
							{name : 'helperid', type: 'String'  },
							{name : 'helperid2', type: 'String'  },
							{name : 'fleetno', type: 'String'  },
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
                height: 310,
                source: dataAdapter,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							  
							{ text: 'Code', datafield: 'code', width: '5%'},
							{ text: 'Route', datafield: 'name', width: '5%'},
							{ text: 'Group', datafield: 'gname', width: '5%' }, 
							{ text: 'Site', datafield: 'site', width: '20%'},
							{ text: 'Waste Type', datafield: 'wastetype'},  
							{ text: 'Driver', datafield: 'driver', width: '15%'},    
							{ text: 'Helper', datafield: 'helper1', width: '15%'},    
							{ text: 'Helper2', datafield: 'helper2', width: '10%'},    
							{ text: 'Reg No', datafield: 'reg_no', width: '5%'},  
							
							{ text: 'driverid', datafield: 'driverid', width: '10%',hidden:true},  
							{ text: 'helperid', datafield: 'helperid', width: '10%',hidden:true},  
							{ text: 'helperid2', datafield: 'helperid2', width: '10%',hidden:true}, 
							{ text: 'fleetno', datafield: 'fleetno', width: '10%',hidden:true}, 
							{ text: 'Doc No', datafield: 'doc_no', width: '8%',hidden:true },
					]
            });  
			 $('#jqxRouteSearch').on('rowdoubleclick', function (event) {        
				               var rowindex1=event.args.rowindex;
				               document.getElementById("hidrouteid").value= $('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");  
				               document.getElementById("txtroute").value=$('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "name");
				               $('#cmbdriver').val($('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "driverid")).trigger('change');
				               $('#cmbvehicle').val($('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "fleetno")).trigger('change');
				               $('#cmbhelper').val($('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "helperid")).trigger('change');
				               $('#cmbhelper2').val($('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "helperid2")).trigger('change');
	
				               //document.getElementById("cmbvehicle").value= $('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "fleetno");
				               //document.getElementById("cmbdriver").value= $('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "driverid");
				               //document.getElementById("cmbhelper").value= $('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "helperid");
				               //document.getElementById("cmbhelper2").value= $('#jqxRouteSearch').jqxGrid('getcellvalue', rowindex1, "helperid2");
							   $('#routeinfoWindow').jqxWindow('close');        
		  }); 	 
      }); 
    </script>
    <div id="jqxRouteSearch"></div>  