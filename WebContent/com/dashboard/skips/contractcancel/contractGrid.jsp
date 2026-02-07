<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractcancel.ClsContractCancelDAO" %>
<%
		ClsContractCancelDAO DAO= new ClsContractCancelDAO();      
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
 %>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(session,id)%>';          
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
		                	{name : 'site', type: 'String'  },
		                  	{name : 'area', type: 'String'  },
							{name : 'skiptype', type: 'string'  },
		              		{name : 'skipdoc', type: 'String'  },
							{name : 'nos', type: 'int'   },
							{name : 'wastetype', type: 'string'   },
		              		{name : 'wastedoc', type: 'String'  },
							{name : 'serviceby', type: 'String'  },
							{name : 'servicebyid', type: 'String'  },
							{name : 'ownership', type: 'String'  },
							{name : 'ownershipid', type: 'String'  },
		                  	{name : 'serviceterm', type: 'String'  },
		                	{name : 'servicetermid', type: 'String'  },
		                	{name : 'collection', type: 'String'  },
		                	{name : 'collectionid', type: 'String'  },
		                  	{name : 'days', type: 'String'  },
		                	{name : 'spec', type: 'string'  },
		                  	{name : 'specid', type: 'String'  },
		                  	{name : 'adminfee', type: 'number'  },
		                  	{name : 'rate', type: 'number'  },
		                  	{name : 'rent', type: 'number'  },
		                  	{name : 'foc', type: 'String'  },
		                    {name : 'siteid', type: 'String'  },     
                        	{name : 'tr_no', type: 'String'  },   
                        	{name : 'doc_no', type: 'String'  },   
                        	{name : 'date', type: 'Date'  }, 
                        	{name : 'rowno', type: 'String'  }, 
                        	{name : 'refname', type: 'String'  }, 
                        	{name : 'status', type: 'String'  }, 
                        	{name : 'contrtype', type: 'String'  }, 
                        	{name : 'gpsx', type: 'String'  },
                        	{name : 'gpsy', type: 'String'  },
                        	{name : 'brhid', type: 'String'  },
                        	{name : 'enddt', type: 'Date'  }, 
                        	{name : 'statusid', type: 'String'  },
                        	{name : 'skip', type: 'String'  },
                        	{name : 'route', type: 'String'  },
                        	{name : 'gpsx1', type: 'String'  },
                        	{name : 'gpsy1', type: 'String'  }, 
                        	{name : 'acno', type: 'String'  }, 
                        	{name : 'approve', type: 'String'  },
                 ],
                 localdata: quotedata,  
                
                
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

            
            $("#jqxContractGrid").jqxGrid(  
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
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'acno',datafield:'acno',width:'5%',editable:false,hidden:true},
                            { text: 'rowno',datafield:'rowno',width:'5%',editable:false,hidden:true},    
                            { text: 'tr_no',datafield:'tr_no',width:'5%',editable:false,hidden:true},  
                            { text: 'Doc No', datafield: 'doc_no',editable:false,width:'5%'},  
                            { text: 'Date', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Client', datafield: 'refname',editable:false }, 
                            { text: 'Status', datafield: 'status',editable:false,width:'7%'},  
                            { text: 'Site', datafield: 'site',editable:false,width:'10%'},   
                        	{ text: 'siteid',datafield:'siteid',width:'5%',editable:false,hidden:true},
							{ text: 'Waste Type', datafield: 'wastetype', width: '10%' ,editable:false},	
							{ text: 'Skip Size', datafield: 'skiptype', width: '10%',editable:false },	
							{ text: 'Spec', datafield: 'spec', width: '5%',editable:false },	
							{ text: 'Service By', datafield: 'serviceby', width: '6%',editable:false,hidden:true},
							{ text: 'Ownership', datafield: 'ownership', width: '6%',editable:false},
				            { text: 'Qty', datafield: 'nos', width: '4%'},
				            { text: 'Service Term', datafield: 'serviceterm', width: '6%',editable:false},  
							{ text: 'No of Visit', datafield: 'days', width: '4%'},   
							{ text: 'Collection', datafield: 'collection', width: '4%',editable:false},  
							{ text: 'Rate per Colllection', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },	
							{ text: 'Admin Fee', datafield: 'adminfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
							{ text: 'FOC Trips', datafield: 'foc', width: '4%'},
							{ text: 'Skip Rent', datafield: 'rent', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },	   
							{ text: 'gpsx',datafield:'gpsx',width:'5%',editable:false,hidden:true},  
							{ text: 'gpsy',datafield:'gpsy',width:'5%',editable:false,hidden:true},  
							{ text: 'brhid',datafield:'brhid',width:'5%',editable:false,hidden:true},
							{ text: 'End Date', datafield: 'enddt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'statusid',datafield:'statusid',width:'5%',editable:false,hidden:true},  
							{ text: 'approve',datafield:'approve',width:'5%',editable:false,hidden:true},  
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {     
             	  var rowindex1=event.args.rowindex;    
             	  document.getElementById("hidapprove").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "approve");  
             	  document.getElementById("hidacno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "acno");
             	  document.getElementById("hidcontrno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	  document.getElementById("hidcondocno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");  
             	  document.getElementById("hidbrhid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidrowno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "rowno");  
             	  document.getElementById("lblname").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+" - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname");  
             	 
             	  var approve=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "approve");  
             	  var ownership=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "ownership");  
             	  if(ownership=="OWN SKIP" && approve=="1"){
             		 $('#btncollection').attr('disabled',false);   
             	  }else{
             		 $('#btncollection').attr('disabled',true);   
             	  }
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site"));
             	  $('.comments-container').html('');   
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 