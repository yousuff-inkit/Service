<%@page import="com.it.enquiryit.ClsEnquiryDAO"%>
<%ClsEnquiryDAO DAO=new ClsEnquiryDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String areas = request.getParameter("areas")==null?"0":request.getParameter("areas");
 String cities = request.getParameter("cities")==null?"0":request.getParameter("cities");
 String countries = request.getParameter("countries")==null?"0":request.getParameter("countries");
 String regions = request.getParameter("regions")==null?"0":request.getParameter("regions");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
 
  var radata;
  radata='<%=DAO.areaDetailsSearch(areas, cities, countries, regions, chk)%>';
        $(document).ready(function () { 
 
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
                height: 310,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
            
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Area', datafield: 'area', width: '25%' },
					{ text: 'City', datafield: 'city_name', width: '25%' },
					{ text: 'Country', datafield: 'country_name', width: '25%' },
					{ text: 'Region', datafield: 'region_name', width: '20%' }
					]
            });
    
				            
            $('#jqxareasearch').on('rowdoubleclick', function (event) { 
            	    var rowIndex =$('#rowindex').val();
              		var rowindex1=event.args.rowindex;
            	  
               		$('#jqxJobDetails').jqxGrid('setcellvalue', rowIndex, "area",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "area"));
               		$('#jqxJobDetails').jqxGrid('setcellvalue', rowIndex, "areaid",$('#jqxareasearch').jqxGrid('getcellvalue', rowindex1, "areadocno"));
            	  
               		var rows = $('#jqxJobDetails').jqxGrid('getrows');
      	            var rowlength= rows.length;
      	            var rowindex2 = rowlength - 1;
      	          	var serviceid=$("#jqxJobDetails").jqxGrid('getcellvalue', rowindex2, "serviceid");
      	          	if(typeof(serviceid) != "undefined" && serviceid != ""){
      	          		 $("#jqxJobDetails").jqxGrid('addrow', null, {});
      	          	}
               		
                	$('#areainfowindow2').jqxWindow('close');
            
            }); 
				           
        
}); 
				       
                       
</script>
<div id="jqxareasearch"></div>
    
</body>
</html>