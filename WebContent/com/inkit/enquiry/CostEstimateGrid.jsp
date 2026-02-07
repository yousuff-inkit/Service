
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
<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<%
ClsEnquiryDAO ClsEnquiryDAO=new ClsEnquiryDAO();
   	int enq_id = request.getParameter("enq_id")==null?0:Integer.parseInt(request.getParameter("enq_id").trim());
    System.out.println("==enq_id==enq_id===enq_id="+enq_id);
  int estatusid = (request.getParameter("estatusid")==null || request.getParameter("estatusid")=="")?0:Integer.parseInt(request.getParameter("estatusid").trim());
   	
   	System.out.println("==estatusid==estatusid===estatusid="+estatusid);   	
   	%>
   	
<script type="text/javascript">
        var data2;
        $(document).ready(function () { 	
        	
        	var rmdocno='<%=enq_id%>'; 

        	
        	  data2='<%=ClsEnquiryDAO.CEGridload (enq_id,estatusid) %>';
        	
        	  
				//alert("==data2==="+data2);
        
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'field_name', type: 'string' },
							{name : 'cefield_id', type: 'string' },
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
							{name : 'otherexp', type: 'string' },
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
							{name : 'magemi', type: 'string' }
                        ],
                		    localdata: data2, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxCostEstimateGrid").jqxGrid(
            {
                width: '95%',
                height: 250,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
              //Add row method
                handlekeyboardnavigation: function (event) {
                	
                	var rows = $('#jqxCostEstimateGrid').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxCostEstimateGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'commodity' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxCostEstimateGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                    
                    
                },
                
                columns: [
					{ text: ' ', datafield: 'field_name', width: '9%',cellclassname:'column',editable:false },
					{ text: 'CEFIELDID', datafield: 'cefield_id', width: '9%',cellclassname:'column',editable:false,hidden:true },
					{ text: 'NormalHr', datafield: 'nh', width: '6%',cellclassname:'column' },
					{ text: 'HolidayHr', datafield: 'hh', width: '6%',cellclassname:'column' },
					{ text: 'TravelHr', datafield: 'th', width: '6%',cellclassname:'column' },
					{ text: 'Mday8Hr', datafield: 'e8h', width: '6%',cellclassname:'column' },
					{ text: 'Holiday8Hr', datafield: 'h8h', width: '6%',cellclassname:'column' },
					{ text: 'Mday10Hr', datafield: 't10h', width: '6%',cellclassname:'column' },
					{ text: 'Holiday10Hr', datafield: 'h10h', width: '6%',cellclassname:'column' },
					{ text: 'Mnth:22DX8H', datafield: 'e22dx8h', width: '6%',cellclassname:'column' },
					{ text: 'Mnth:22HX8H', datafield: 'e22hx8h', width: '6%',cellclassname:'column' },
					{ text: 'Mnth:22DX10H', datafield: 't22dx10h', width: '6%',cellclassname:'column' },
					{ text: 'Mnth:22HX10H', datafield: 't22hx10h', width: '6%',cellclassname:'column' },
					{ text: 'OT>8Hr', datafield: 'ot8', width: '6%',cellclassname:'column' },
					{ text: 'OT>10Hr', datafield: 'ot10', width: '6%',cellclassname:'column' },
					{ text: 'HOT>8Hr', datafield: 'hot8', width: '6%',cellclassname:'column' },
					{ text: 'HOT>10Hr', datafield: 'hot10', width: '6%',cellclassname:'column' },
					{ text: 'Milage/KM', datafield: 'magekm', width: '6%',cellclassname:'column' },
					{ text: 'Milage/KM', datafield: 'magemi', width: '6%',cellclassname:'column' },
					{ text: 'Perdium', datafield: 'perdium', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Lodging', datafield: 'lodging', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Car', datafield: 'carexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Train', datafield: 'trainexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Bus', datafield: 'busexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Taxi', datafield: 'taxiexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Flight', datafield: 'flightexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Meals', datafield: 'mealsexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Toll', datafield: 'tollexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Fuel', datafield: 'fuelexp', width: '9%',cellclassname:'advanceClass' },
					{ text: 'Other', datafield: 'otherexp', width: '9%',cellclassname:'advanceClass' }
					
						]
            });
            
            $("#jqxCostEstimateGrid").on('cellvaluechanged', function (event){
                
                var rowBoundIndex = args.rowindex;
                
                var data = args.datafield;
                
               // var currate=document.getElementById("clientcurrate").value;
                //alert($('#jqxCostEstimateGrid').jqxGrid('getcellvalue', rowBoundIndex,data));
                 //$('#jqxCostEstimateGrid').jqxGrid('setcellvalue',m,"comodityid",row.doc_no);
                //$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', rowBoundIndex, data,($('#jqxCostEstimateGrid').jqxGrid('getcellvalue', rowBoundIndex,data)*currate));
                
                
                var gridrow = $("#jqxCostEstimateGrid").jqxGrid('getrows');
            	
            	var gridlen=gridrow.length;
            	var cltotalrow=gridlen-2;
            	var insptotalrow=gridlen-3;
            	var rateproprow=gridlen-4; 
            	var pvmarow=gridlen-5; 
            	var clraterow=gridlen-6; 
            	var svmrow=gridlen-7; 
            	var caurow=gridlen-8; 
            	var inspraterow=gridlen-9; 
            	var qtyrow=gridlen-10;
            	var clrate=0.0,totalinsp=0.0,totalclient=0.0,pvmargin=0.0;
            	
            	var qty=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', qtyrow,data);
            	var insprate=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', inspraterow,data);
            	var rateprop=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', rateproprow,data);
            	var svmargin=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', svmrow,data);
            	
            	
            	 clrate=(insprate*(100/(100-svmargin))).toFixed(2);
            	 totalinsp=(insprate*qty).toFixed(2);
            	 totalclient=(rateprop*qty).toFixed(2);
            	 pvmargin=(((clrate/insprate)-1)*100).toFixed(2);
            	
            	 if(isNaN(clrate)){
            		 clrate=0.0;
            		}
            	 if(isNaN(totalinsp)){
            		 totalinsp=0.0;
            		}
            	 if(isNaN(totalclient)){
            		 totalclient=0.0;
            		}
            	 if(isNaN(pvmargin)){
            		 pvmargin=0.0;
            		}
            	 
            	 
            	 //clrate=(insprate*(100/(100-svmargin)));
            	
            	//clrate=(insprate*(100/(100-svmargin)));
            	
            	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', clraterow, data,clrate);
            	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', insptotalrow, data,totalinsp);
            	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', cltotalrow, data,totalclient);
           	    $('#jqxCostEstimateGrid').jqxGrid('setcellvalue', pvmarow, data,pvmargin);
            	
            	
            	/* if(rowBoundIndex==1){//for qty
            	var qty=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', qtyrow,data);
            	var insprate=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', inspraterow,data);
            	var rateprop=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', rateproprow,data);
            	var	totalinsp=(insprate*qty);
            	var totalclient=(rateprop*qty);
            	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', insptotalrow, data,totalinsp);
            	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', cltotalrow, data,totalclient);
            	           		
            	}
            	if(rowBoundIndex==2){//for insprate
            		var qty=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', qtyrow,data);
                	var insprate=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', inspraterow,data);
                	var rateprop=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', rateproprow,data);
                	var	totalinsp=(insprate*qty);
                	var totalclient=(rateprop*qty);
                	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', insptotalrow, data,totalinsp);
                	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', cltotalrow, data,totalclient);
                	
                	var svmargin=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', svmrow,data);
                	var insprate=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', inspraterow,data);
                	var clrate=0.0;
                	var pvmargin=(((clrate/insprate)-1)*100);
                	clrate=(insprate*(100/(100-svmargin)));
                	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', clraterow, data,clrate);
                	
                	 //var pvmargin=(((clrate/insprate)-1)*100);
                	 $('#jqxCostEstimateGrid').jqxGrid('setcellvalue', pvmarow, data,pvmargin);
                	}
            	
            	if(rowBoundIndex==4){
            		
            		var svmargin=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', svmrow,data);
                	var insprate=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', inspraterow,data);
                	var clrate=0.0;
                	clrate=(insprate*(100/(100-svmargin)));
                	var pvmargin=(((clrate/insprate)-1)*100);
                	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', clraterow, data,clrate);
                	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', pvmarow, data,pvmargin);
            		
            	}
            	
				if(rowBoundIndex==7){
					var qty=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', qtyrow,data);
					var rateprop=$('#jqxCostEstimateGrid').jqxGrid('getcellvalue', rateproprow,data);
	            	var totalclient=(rateprop*qty);
	            	$('#jqxCostEstimateGrid').jqxGrid('setcellvalue', cltotalrow, data,totalclient);
            	}
            */     
                
                
                
                }); 
            
        });
    </script>
    <div id="jqxCostEstimateGrid"></div>
    <input type="hidden" id="rowindex"/>