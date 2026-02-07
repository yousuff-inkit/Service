<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.serviceschedule.ClsServiceScheduleDAO" %>
<%
        ClsServiceScheduleDAO DAO= new ClsServiceScheduleDAO();  
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
        String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim().toString(); 
        String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();   
        String routeid=request.getParameter("routeid")==null?"":request.getParameter("routeid").trim().toString(); 
        String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim().toString();  
        String frmdtchk=request.getParameter("frmdtchk")==null?"":request.getParameter("frmdtchk").trim().toString(); 
        String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
 %>
<style type="text/css">
    .lightGreen {
       background-color: #CCFFCC; 
    }
    .lightRed {
       background-color: #FFC2C1;   
    }
</style>    
<script type="text/javascript"> 
  
var serschdata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 serschdata='<%=DAO.serScheduleLoad(session, id, fromdate, todate, routeid, cldocno, frmdtchk, divname)%>';                       
            // prepare the data
             var rendererstring=function (aggregates){ 
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
         	
           var rendererstring1=function (aggregates){
                 var value1=aggregates['sum1'];
                 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
                }
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'skipno', type: 'string'  },   
		                  	{name : 'days', type: 'String'  },
		                    {name : 'site', type: 'String'  },     
		                	{name : 'contrno', type: 'String'  },   
		                	{name : 'date', type: 'Date'  }, 
		                	{name : 'route', type: 'String'  },
		                	{name : 'tr_no', type: 'String'  },
		                	{name : 'brhid', type: 'String'  },
		                	{name : 'srno', type: 'String'  }, 
		                	{name : 'delid', type: 'String'  }, 
		                	{name : 'status', type: 'String'  },
		                	{name : 'substatus', type: 'String'  },
		                	{name : 'remarks', type: 'String'  },
							{name : 'time', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
							{name : 'wastetypeid', type: 'String'  },
							{name : 'wastetype', type: 'String'  },
							{name : 'skipid', type: 'String'  },
							{name : 'skipstatus', type: 'String'  },
							{name : 'skipsize', type: 'String'  },
							{name : 'skiptypeid', type: 'String'  },
							{name : 'routeid', type: 'String'  },
							{name : 'driverid', type: 'String'  },
							{name : 'helperid', type: 'String'  },
							{name : 'helperid2', type: 'String'  },
							{name : 'fleetno', type: 'String'  },
							{name : 'refname', type: 'String'  },
							{name : 'driver', type: 'String'  },
							{name : 'helper', type: 'String'  },
							{name : 'helper2', type: 'String'  },
							{name : 'regno', type: 'String'  },
							
							{name : 'skipscollected', type: 'String'  },
							{name : 'deliveredskipno', type: 'String'  },
							{name : 'pulloutskipno', type: 'String'  },
							{name : 'intime', type: 'String'  },
							{name : 'outtime', type: 'String'  },
							{name : 'dno', type: 'String'  },
							{name : 'weight', type: 'String'  },
							{name : 'tippingfee', type: 'String'  },
							{name : 'disposalsite', type: 'String'  },  
                 ],
                 localdata: serschdata,  
                
                
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
            
            var cellclassname =  function (row, column, value, data) {
            	var divid =  document.getElementById("divname").value;
                var status = $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', row, "status");
                if(divid=="totc"){
                	if(status!='') {
   	          		 	return "lightGreen";  
   	          	    }
                }
             }
            
            $("#jqxServiceScheduleGrid").jqxGrid(  
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'checkbox',   
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
            	//showaggregates: true,
             	//showstatusbar:true,
             	//statusbarheight:25,
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Doc No', datafield: 'contrno',editable:false,width:'6%', cellclassname:cellclassname},    
                            { text: 'Customer Name', datafield: 'refname',editable:false,width:'10%', cellclassname:cellclassname},
                            { text: 'Area along with Site', datafield: 'site',editable:false,width:'8%', cellclassname:cellclassname}, 
                            { text: 'Skip Size', datafield: 'skipno',editable:false,width:'8%', cellclassname:cellclassname},
                            { text: 'Type of Waste', datafield: 'wastetype',editable:false,width:'10%', cellclassname:cellclassname},
                            { text: 'No of Skips Collected', datafield: 'skipscollected',editable:false,width:'6%', cellclassname:cellclassname},  
                            { text: 'Vehicle No', datafield: 'fleetno',editable:false,width:'6%', cellclassname:cellclassname},
                            { text: 'Skip No Delivered', datafield: 'deliveredskipno',editable:false,width:'6%', cellclassname:cellclassname},
                            { text: 'Skip No PullOut', datafield: 'pulloutskipno',editable:false,width:'6%', cellclassname:cellclassname},
                            { text: 'Time In', datafield: 'intime',editable:false,width:'6%', cellclassname:cellclassname},
                            { text: 'Time Out', datafield: 'outtime',editable:false,width:'6%', cellclassname:cellclassname},
                            { text: 'Driver Name', datafield: 'driver',editable:false,width:'10%', cellclassname:cellclassname},   
                            { text: 'Helper Name', datafield: 'helper',editable:false,width:'10%', cellclassname:cellclassname}, 
                            { text: 'Transaction No', datafield: 'dno',editable:false,width:'6%', cellclassname:cellclassname}, 
                            { text: 'Weight', datafield: 'weight',editable:false,width:'6%', cellclassname:cellclassname},
                            { text: 'Tipping Fee', datafield: 'tippingfee',editable:false,width:'6%', cellclassname:cellclassname},
                            { text: 'Disposal Site', datafield: 'disposalsite',editable:false,width:'6%', cellclassname:cellclassname},   
                            
                            { text: 'Date', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy', cellclassname:cellclassname,hidden:true},  
                            { text: 'Time', datafield: 'time',editable:false,width:'4%',cellsformat:'HH:mm', cellclassname:cellclassname,hidden:true},      
                            { text: 'Day', datafield: 'days',editable:false,width:'6%', cellclassname:cellclassname,hidden:true},       
                            { text: 'Route', datafield: 'route',editable:false,width:'10%', cellclassname:cellclassname,hidden:true},    
                            { text: 'Status', datafield: 'status',width:'7%',editable:false, cellclassname:cellclassname,hidden:true},
                            { text: 'Sub Status', datafield: 'substatus',width:'8%',editable:false, cellclassname:cellclassname,hidden:true},
                            { text: 'Remarks', datafield: 'remarks',width:'15%',editable:false, cellclassname:cellclassname,hidden:true},   
                            { text: 'Schedule Type', datafield: 'skipstatus',editable:false,width:'7%', cellclassname:cellclassname,hidden:true},     
                            { text: 'Helper 2', datafield: 'helper2',editable:false,width:'10%', cellclassname:cellclassname,hidden:true},      
                            { text: 'Reg No', datafield: 'regno',editable:false,width:'10%', cellclassname:cellclassname,hidden:true},   
                            { text: 'Doc No', datafield: 'doc_no',editable:false,width:'6%',hidden:true}, 
                            { text: 'brhid', datafield: 'brhid',editable:false,width:'6%',hidden:true}, 
                            { text: 'skipid', datafield: 'skipid',editable:false,width:'6%',hidden:true},  
                            { text: 'wastetype', datafield: 'wastetypeid',editable:false,width:'6%',hidden:true},  
                            { text: 'delid', datafield: 'delid',editable:false,width:'6%',hidden:true}, 
                            { text: 'routeid', datafield: 'routeid',editable:false,width:'6%',hidden:true},
                            { text: 'driverid', datafield: 'driverid',editable:false,width:'6%',hidden:true},
                            { text: 'helperid', datafield: 'helperid',editable:false,width:'6%',hidden:true},
                            { text: 'helperid2', datafield: 'helperid2',editable:false,width:'6%',hidden:true},  
                            { text: 'skiptypeid', datafield: 'skiptypeid',editable:false,width:'6%',hidden:true},
                            { text: 'skipsize', datafield: 'skipsize',editable:false,width:'6%',hidden:true},
							{ text: 'srno',datafield:'srno',width:'5%',editable:false,hidden:true},      
                            { text: 'tr_no',datafield:'tr_no',width:'5%',editable:false,hidden:true},
                            
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxServiceScheduleGrid').on('rowdoubleclick', function (event) {                
             	  var rowindex1=event.args.rowindex;    
             	  document.getElementById("jqxwastetype").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "wastetype");
             	  document.getElementById("wasteid").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "wastetypeid");
             	  document.getElementById("hidbrhid").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidcontrno").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	  document.getElementById("hiddocno").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	  document.getElementById("lblname").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "contrno")+" - "+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "site");     
             	  document.getElementById("hidroute").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "routeid");
             	  document.getElementById("hidsrno").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "srno");
             	  document.getElementById("hiddelid").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "delid");  
             	  document.getElementById("hidskipid").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "skipid");  
             	 
             	  /*document.getElementById("hidrouteid").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "routeid");  
	              document.getElementById("txtroute").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "route");
             	  document.getElementById("cmbvehicle").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "fleetno");
	              document.getElementById("cmbdriver").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "driverid");
	              document.getElementById("cmbhelper").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "helperid");
	              document.getElementById("cmbhelper2").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "helperid2");*/   
             	  $('.textpanel p').text($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "contrno")+' - '+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "site"));   
             	  $('.comments-container').html('');          
            });
        });
    </script>
    <div id="jqxServiceScheduleGrid"></div>     