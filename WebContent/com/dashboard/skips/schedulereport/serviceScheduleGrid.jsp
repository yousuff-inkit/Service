<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.schedulereport.ClsScheduleReportDAO" %>
<%
ClsScheduleReportDAO DAO= new ClsScheduleReportDAO();     
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
        String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim().toString(); 
        String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();   
        String routeid=request.getParameter("routeid")==null?"":request.getParameter("routeid").trim().toString();   
        String cldocno=request.getParameter("cldocno")==null?"":request.getParameter("cldocno").trim().toString();   
        String contrno=request.getParameter("contrno")==null?"":request.getParameter("contrno").trim().toString();   
        String divname=request.getParameter("divname")==null?"":request.getParameter("divname").trim().toString();   

 
 %>   
<script type="text/javascript">
  
var serschdata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 serschdata='<%=DAO.serScheduleLoad(session, id, fromdate, todate, routeid,cldocno,contrno,divname)%>';                      
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

            
            $("#jqxServiceScheduleGrid").jqxGrid(  
            {
                width: '100%',
                height: 475,
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
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'srno',datafield:'srno',width:'5%',editable:false,hidden:true},      
                            { text: 'tr_no',datafield:'tr_no',width:'5%',editable:false,hidden:true},  
                            { text: 'Contract No', datafield: 'contrno',editable:false,width:'6%'},    
                            { text: 'Site', datafield: 'site',editable:false},   
                            { text: 'Date', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Time', datafield: 'time',editable:false,width:'5%',cellsformat:'HH:mm'},      
                            { text: 'Day', datafield: 'days',editable:false,width:'7%'},       
                            { text: 'Route', datafield: 'route',editable:false,width:'15%'},   
                            { text: 'Skip No', datafield: 'skipno',editable:false,width:'15%'}, 
                            { text: 'Status', datafield: 'status',width:'7%',editable:false},
                            { text: 'Skipstatus', datafield: 'skipstatus',editable:false,width:'7%'},  
                            { text: 'Doc No', datafield: 'doc_no',editable:false,width:'6%',hidden:true}, 
                            { text: 'brhid', datafield: 'brhid',editable:false,width:'6%',hidden:true}, 
                            { text: 'skipid', datafield: 'skipid',editable:false,width:'6%',hidden:true},  
                            { text: 'wastetype', datafield: 'wastetypeid',editable:false,width:'6%',hidden:true}, 
                            { text: 'wastetype', datafield: 'wastetype',editable:false,width:'6%',hidden:true},
                            { text: 'delid', datafield: 'delid',editable:false,width:'6%',hidden:true}, 
                            { text: 'routeid', datafield: 'routeid',editable:false,width:'6%',hidden:true},
                            { text: 'driverid', datafield: 'driverid',editable:false,width:'6%',hidden:true},
                            { text: 'helperid', datafield: 'helperid',editable:false,width:'6%',hidden:true},
                            { text: 'helperid2', datafield: 'helperid2',editable:false,width:'6%',hidden:true},
                            { text: 'fleetno', datafield: 'fleetno',editable:false,width:'6%',hidden:true}, 
                            
                            { text: 'skiptypeid', datafield: 'skiptypeid',editable:false,width:'6%',hidden:true},
                            { text: 'skipsize', datafield: 'skipsize',editable:false,width:'6%',hidden:true},
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
             	  document.getElementById("pocontract").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "contrno");   
             	  document.getElementById("hidsrno").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "srno");
             	  document.getElementById("hiddelid").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "delid");  
             	  document.getElementById("hidskipid").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "skipid");  
             	 
             	  $('#skipnodiv').load("skipnoSearch.jsp?delid="+$("#hiddelid").val()+"&type="+1);
             	  $('#rpskipnodiv').load("skipnoSearchRp.jsp?type="+2);
             	  document.getElementById("lblotherdetails5").innerHTML=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "contrno")+", Skip No - "+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "skipno"); 
             	  document.getElementById("lblotherdetails6").innerHTML=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "contrno")+", Skip No - "+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "skipno");     
             	  /*document.getElementById("hidrouteid").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "routeid");  
	              document.getElementById("txtroute").value=$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "route");
             	  document.getElementById("cmbvehicle").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "fleetno");
	              document.getElementById("cmbdriver").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "driverid");
	              document.getElementById("cmbhelper").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "helperid");
	              document.getElementById("cmbhelper2").value= $('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "helperid2");*/   
             	  //$('.textpanel p').text($('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "contrno")+' - '+$('#jqxServiceScheduleGrid').jqxGrid('getcellvalue', rowindex1, "site"));   
             	  $('.comments-container').html('');          
            });
        });
    </script>
    <div id="jqxServiceScheduleGrid"></div>     