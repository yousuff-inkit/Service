<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<%ClsEnquiryDAO ClsEnquiryDAO=new ClsEnquiryDAO(); %>
<style>
.column
{
   background-color: #ECF8E0;            
}
.advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }
</style>

<%
   	int enq_id = request.getParameter("enq_id")==null?0:Integer.parseInt(request.getParameter("enq_id").trim());%>
   	
<script type="text/javascript">
        var data2;
        $(document).ready(function () { 	
        	
        	var enq_id='<%=enq_id%>'; 

        	
        		 var data2='<%=ClsEnquiryDAO.InspCostGridload (enq_id) %>'; 
				//alert("==data2==="+data2);
        
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'nh', type: 'string' },
							{name : 'hh', type: 'string' },
							{name : 'th', type: 'string' },
							{name : 'e8h', type: 'string' },
							{name : 'h8h', type: 'string' },
							{name : 't10h', type: 'string' },
							{name : 'h10h', type: 'string' },
							{name : 'e22dx8h', type: 'string' },
							{name : 'e22hx8h', type: 'string' },
							{name : 't22dx10h', type: 'string' },
							{name : 't22hx10h', type: 'string' },
							{name : 'ot8', type: 'string' },
							{name : 'ot10', type: 'string' },
							{name : 'hot8', type: 'string' },
							{name : 'hot10', type: 'string' },
							{name : 'magekm', type: 'string' },
							{name : 'magemi', type: 'string' },
							{name : 'field_name', type: 'string' },
							{name : 'costfield_id', type: 'string' },
							{name : 'perdium', type: 'string' },
							{name : 'lodging', type: 'string' },
							{name : 'carexp', type: 'string' },
							{name : 'trainexp', type: 'string' },
							{name : 'busexp', type: 'string' },
							{name : 'taxiexp', type: 'string' },
							{name : 'flightexp', type: 'string' },
							{name : 'mealsexp', type: 'string' },
							{name : 'tollexp', type: 'string' },
							{name : 'fuelexp', type: 'string' },
							{name : 'otherexp', type: 'string' }
							
                        ],
                		    localdata: data2, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxInspCostGrid").jqxGrid(
            {
                width: '95%',
                height: 152,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
              //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxInspCostGrid').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxInspCostGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'commodity' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxInspCostGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                
                columns: [
					{ text: ' ', datafield: 'field_name', width: '9%',cellclassname:'column',editable:false },
					{ text: 'COSTFIELDID', datafield: 'costfield_id', width: '9%',cellclassname:'column',editable:false,hidden:true },
					{ text: 'NormalHr', datafield: 'nh', width: '6%',cellclassname:'column',editable:false },
					{ text: 'HolidayHr', datafield: 'hh', width: '6%',cellclassname:'column',editable:false },
					{ text: 'TravelHr', datafield: 'th', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Mday8Hr', datafield: 'e8h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Holiday8Hr', datafield: 'h8h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Mday10Hr', datafield: 't10h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Holiday10Hr', datafield: 'h10h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Mnth:22DX8H', datafield: 'e22dx8h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Mnth:22HX8H', datafield: 'e22hx8h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Mnth:22DX10H', datafield: 't22dx10h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Mnth:22HX10H', datafield: 't22hx10h', width: '6%',cellclassname:'column',editable:false },
					{ text: 'OT>8Hr', datafield: 'ot8', width: '6%',cellclassname:'column',editable:false },
					{ text: 'OT>10Hr', datafield: 'ot10', width: '6%',cellclassname:'column',editable:false },
					{ text: 'HOT>8Hr', datafield: 'hot8', width: '6%',cellclassname:'column',editable:false },
					{ text: 'HOT>10Hr', datafield: 'hot10', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Milage/KM', datafield: 'magekm', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Milage/KM', datafield: 'magemi', width: '6%',cellclassname:'column',editable:false },
					{ text: 'Perdium', datafield: 'perdium', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Lodging', datafield: 'lodging', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Car', datafield: 'carexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Train', datafield: 'trainexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Bus', datafield: 'busexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Taxi', datafield: 'taxiexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Flight', datafield: 'flightexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Meals', datafield: 'mealsexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Toll', datafield: 'tollexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Fuel', datafield: 'fuelexp', width: '9%',cellclassname:'advanceClass',editable:false },
					{ text: 'Other', datafield: 'otherexp', width: '9%',cellclassname:'advanceClass',editable:false }
					
						]
            });
            //$("#jqxCostEstimateGrid").jqxGrid('addrow', null, {});
            /* if(document.getElementById("mode").value=='view'){
            	$('#jqxCostEstimateGrid').jqxGrid({ disabled: true});
            } */
        });
    </script>
    <div id="jqxInspCostGrid"></div>
    <input type="hidden" id="rowindex"/>