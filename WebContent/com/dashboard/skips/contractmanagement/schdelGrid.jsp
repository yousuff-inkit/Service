<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractmanagement.ClsContractManagementDAO" %>
<%
         ClsContractManagementDAO DAO= new ClsContractManagementDAO();  
		 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		 String rdocno=request.getParameter("rdocno")==null || request.getParameter("rdocno")==""?"0":request.getParameter("rdocno").trim().toString();  
		 String srno=request.getParameter("srno")==null || request.getParameter("srno")==""?"0":request.getParameter("srno").trim().toString();  
 %>   
<script type="text/javascript">
  
var schdeldata;
var id='<%=id%>';
$(document).ready(function () {     	
             var num = 1;   
             schdeldata='<%=DAO.quotedetLoad(session, rdocno, srno, id)%>';                       
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
		                  	{name : 'wastetype', type: 'String'  },
                        	{name : 'skiptype', type: 'String'  },
                        	{name : 'site', type: 'String'  },  
                        	{name : 'qty', type: 'number'  },  
                        	{name : 'balqty', type: 'number'  },  
                        	{name : 'skip', type: 'String'  },  
                        	{name : 'skipid', type: 'String'  },  
                        	{name : 'delid', type: 'String'  },  
                        	{name : 'driverid', type: 'String'  },
                        	{name : 'helperid', type: 'String'  },
                        	{name : 'schdate', type: 'Date'  },
                        	{name : 'schtime', type: 'String'  },
                        	{name : 'name', type: 'String'  },
                        	{name : 'mobile', type: 'String'  },
                        	{name : 'email', type: 'String'  },
                        	{name : 'dayshift', type: 'String'  },
                        	{name : 'location', type: 'String'  }, 
                        	{name : 'fleetno', type: 'String'  },
                 ],
                 localdata: schdeldata,  
                
                
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

            
            $("#jqxschdelGrid").jqxGrid(  
            {
                width: '100%',
                height: 100,
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
                            { text: 'Skip', datafield: 'skip',editable:false, width: '20%'},  
                            { text: 'Waste Type', datafield: 'wastetype',editable:false, width: '20%'},    
                            { text: 'Skip Size', datafield: 'skiptype',editable:false, width: '20%'},
                            { text: 'Site', datafield: 'site',editable:false, width: '20%'},  
                            { text: 'Qty', datafield: 'qty',editable:false, width: '8%'},
                            { text: 'Bal Qty', datafield: 'balqty',editable:false, width: '8%'},  
                            { text: 'Skipid', datafield: 'skipid',editable:false, width: '4%',hidden:true},   
                            { text: 'delid', datafield: 'delid',editable:false, width: '4%',hidden:true},  
                            { text: 'driverid', datafield: 'driverid',editable:false, width: '4%',hidden:true}, 
                            { text: 'helperid', datafield: 'helperid',editable:false, width: '4%',hidden:true}, 
                            { text: 'schdate', datafield: 'schdate',editable:false, width: '4%',hidden:true}, 
                            { text: 'schtime', datafield: 'schtime',editable:false, width: '4%',hidden:true}, 
                            { text: 'fleetno', datafield: 'fleetno',editable:false, width: '4%',hidden:true}, 
                            { text: 'name', datafield: 'name',editable:false, width: '4%',hidden:true}, 
                            { text: 'mobile', datafield: 'mobile',editable:false, width: '4%',hidden:true}, 
                            { text: 'email', datafield: 'email',editable:false, width: '4%',hidden:true}, 
                            { text: 'dayshift', datafield: 'dayshift',editable:false, width: '4%',hidden:true}, 
                            { text: 'location', datafield: 'location',editable:false, width: '4%',hidden:true},
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxschdelGrid').on('rowdoubleclick', function (event) {                 
           	  var rowindex1=event.args.rowindex;   
           	  document.getElementById("hiddelid").value=$('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "delid");
           	  var delid=$('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "delid");
           	  if(delid>0){   
           		  $('#hidskipid').val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "skipid")); 
           		  getSkips();
           		  $('#schdeldate').val(new Date($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "schdate")));  
   	   		      $('#schdeltime').val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "schtime")); 
	   	   		  $('#txtname').val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "name")); 
	   	   		  $('#txtmobile').val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "mobile")); 
	   	   		  $('#txtemail').val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "email")); 
	   	   		  $('#txtdayshift').val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "dayshift"));   
	   	   		  $('#txtlocmap').val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "location"));
		   	   	  $("#cmbskip").val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "skipid")).trigger('change'); 
	  	   		  $("#cmbdriver").val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "driverid")).trigger('change');
	  	   		  $("#cmbhelper").val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "helperid")).trigger('change');
	  	   		  $("#cmbvehicle").val($('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "fleetno")).trigger('change');  
           	  }else{
           		clearfields();
           		$('#hiddelid').val("0");
           	  }  
              document.getElementById("lblotherdetails1").innerHTML=$("#lblname").val()+" Skip -"+$('#jqxschdelGrid').jqxGrid('getcellvalue', rowindex1, "skip"); 
          });
        });
    </script>
    <div id="jqxschdelGrid"></div>    