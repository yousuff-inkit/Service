<%@page import="com.dashboard.skips.contractcreation.ClsContractCreationDAO"%>
<% ClsContractCreationDAO DAO= new ClsContractCreationDAO();%>   
<%  String chk = request.getParameter("id")==null?"0":request.getParameter("id").toString();  %>   
 <script type="text/javascript">
        $(document).ready(function () { 
        	 var radata='<%=DAO.areaSearch(chk)%>';   
             var num = 0; 
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
            $("#jqxareasearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
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
    	    
            $('#jqxareasearch').on('rowdoubleclick', function (event) { 
				        var rowindex1=event.args.rowindex;
				        var temp="";
				        temp=temp+$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "country_name");
				        temp=temp+","+$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "region_name");
				                
				        document.getElementById("txtareadet").value=temp; 
						document.getElementById("txtareaid").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno");
						document.getElementById("txtarea").value=$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area");
				        $('#areainfowindow').jqxWindow('close');
			}); 	 
	 }); 
    </script>
    <div id="jqxareasearch"></div>
    </body>
</html>