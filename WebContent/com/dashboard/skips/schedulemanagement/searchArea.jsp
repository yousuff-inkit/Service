<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.schedulemanagement.ClsScheduleManagementDAO"%>
<%
ClsScheduleManagementDAO searchDAO = new ClsScheduleManagementDAO();
%> 

 
<script type="text/javascript">


var locdata= '<%=searchDAO.searchArea(session) %>';   
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    	{name : 'areadocno', type: 'String'  },
						{name : 'area', type: 'String'  },
						{name : 'city_name', type: 'String'  },
						{name : 'country_name', type: 'String'  },
						{name : 'region_name', type: 'String'  }
						
                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#areaGrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
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
				{ text: 'AREA', datafield: 'area', width: '25%' },
				{ text: 'State', datafield: 'city_name', width: '25%' },
				{ text: 'Country', datafield: 'country_name', width: '25%' },
				{ text: 'Region', datafield: 'region_name', width: '20%' }
				
			  
                	]
            });
            
             $('#areaGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("hidareaid").value = $('#areaGrid').jqxGrid('getcellvalue', rowindex1, "areadocno");
                document.getElementById("txtarea").value = $('#areaGrid').jqxGrid('getcellvalue', rowindex1, "area");

              $('#areasearchwndow').jqxWindow('close');  
        
            }); 
             
        });
    </script>
    <div id="areaGrid"></div>