<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.replacementrequest.ClsReplacementRequestDAO" %>
<%
        ClsReplacementRequestDAO DAO =  new ClsReplacementRequestDAO();  
		String cldocno="0";
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
        String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim().toString(); 
        String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();   
        cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim().toString(); 
        String frmdtchk=request.getParameter("frmdtchk")==null?"":request.getParameter("frmdtchk").trim().toString(); 
 %>   
<script type="text/javascript"> 
var serschdata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 serschdata='<%=DAO.replaceReqLoad(session, id, fromdate, todate, cldocno, frmdtchk)%>';                       
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
		                	{name : 'brhid', type: 'String'  },
		                	{name : 'srno', type: 'String'  }, 
		                	{name : 'delid', type: 'String'  }, 
		                	{name : 'remarks', type: 'String'  },
							{name : 'time', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
							{name : 'wastetypeid', type: 'String' },
							{name : 'wastetype', type: 'String'  },
							{name : 'skipid', type: 'String'  },
							{name : 'skipsize', type: 'String'  },
							{name : 'skiptypeid', type: 'String'  },
							{name : 'skipstatus', type: 'String'  },
							{name : 'refname', type: 'String'  },
							{name : 'cuser', type: 'String'  },
							{name : 'cremarks', type: 'String'  }
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

            
            $("#jqxReplacementRequestGrid").jqxGrid(  
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',   
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
                              datafield: 'sl', columntype: 'number', width: '3%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'srno',datafield:'srno',width:'5%',editable:false,hidden:true},      
                            { text: 'Contract No', datafield: 'contrno',editable:false,width:'3%'},    
                            { text: 'Client', datafield: 'refname',editable:false,width:'15%'},       
                            { text: 'Site', datafield: 'site',editable:false,width:'17%'},   
                            { text: 'Date', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Time', datafield: 'time',editable:false,width:'3%',cellsformat:'HH:mm'},      
                            { text: 'Day', datafield: 'days',editable:false,width:'4%'},       
                            { text: 'Skip No', datafield: 'skipno',editable:false,width:'6%'},    
                            { text: 'Remarks', datafield: 'remarks',width:'15%',editable:false},   
                            { text: 'Schedule Type', datafield: 'skipstatus',editable:false,width:'8%'},  
                            { text: 'Doc No', datafield: 'doc_no',editable:false,width:'6%',hidden:true}, 
                            { text: 'brhid', datafield: 'brhid',editable:false,width:'6%',hidden:true}, 
                            { text: 'skipid', datafield: 'skipid',editable:false,width:'6%',hidden:true},  
                            { text: 'wastetype', datafield: 'wastetypeid',editable:false,width:'6%',hidden:true}, 
                            { text: 'wastetype', datafield: 'wastetype',editable:false,width:'6%',hidden:true},
                            { text: 'delid', datafield: 'delid',editable:false,width:'6%',hidden:true}, 
                            { text: 'skiptypeid', datafield: 'skiptypeid',editable:false,width:'6%',hidden:true},
                            { text: 'skipsize', datafield: 'skipsize',editable:false,width:'6%',hidden:true},
                            { text: 'Cancel User', datafield: 'cuser',editable:false,width:'6%'},
                            { text: 'Cancel Remarks', datafield: 'cremarks',editable:false,width:'15%'}
			     ]
            });
            $("#overlay, #PleaseWait").hide();
            $('#jqxReplacementRequestGrid').on('rowdoubleclick', function (event) {                
           	  var rowindex1=event.args.rowindex;    
           	  document.getElementById("hidbrhid").value=$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
           	  document.getElementById("hidcontrno").value=$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "contrno");
           	  document.getElementById("hiddocno").value=$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
           	  document.getElementById("hidsrno").value=$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "srno");
           	  document.getElementById("hiddelid").value=$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "delid");  
           	  document.getElementById("hidskipid").value=$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "skipid");  
           	  document.getElementById("hidskipstatus").value=$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "skipstatus");  
           	  $('.textpanel p').text($('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "contrno")+' - '+$('#jqxReplacementRequestGrid').jqxGrid('getcellvalue', rowindex1, "site"));   
           	  $('.comments-container').html('');          
          });
        });
    </script>
    <div id="jqxReplacementRequestGrid"></div>     