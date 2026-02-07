<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.changesalesman.ClsChangeSalesmanDAO" %>
<%
        ClsChangeSalesmanDAO DAO= new ClsChangeSalesmanDAO();           
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();  
		String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();  
		String salid = request.getParameter("salid")==null || request.getParameter("salid").equals("")?"0":request.getParameter("salid").trim();  
 %>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(session,id,fromdate,todate,salid)%>';              
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
							{name : 'delqty', type: 'int'   },
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
		                    {name : 'siteid', type: 'String'  },     
                        	{name : 'tr_no', type: 'String'  },   
                        	{name : 'doc_no', type: 'number'  },   
                        	{name : 'date', type: 'Date'  }, 
                        	{name : 'rowno', type: 'String'  }, 
                        	{name : 'refname', type: 'String'  }, 
                        	{name : 'status', type: 'String'  }, 
                        	{name : 'contrtype', type: 'String'  }, 
                        	{name : 'gpsx', type: 'String'  },
                        	{name : 'gpsy', type: 'String'  },
                        	{name : 'brhid', type: 'String'  },
                        	{name : 'enddt', type: 'Date'  }, 
                        	{name : 'startdt', type: 'Date'  }, 
                        	{name : 'statusid', type: 'String'  },
                        	{name : 'skip', type: 'String'  },
                        	{name : 'route', type: 'String'  },
                        	{name : 'gpsx1', type: 'String'  },
                        	{name : 'gpsy1', type: 'String'  },
                        	
                        	{name : 'tippingmethod', type: 'String'  },
                        	{name : 'tippingfee', type: 'number'  },
		                  	{name : 'tippingsecurity', type: 'number'  },
		                  	{name : 'tariffrate', type: 'number'  },
							{name : 'rate', type: 'number'  },
							{name : 'addrate', type: 'number'  },    
		                  	{name : 'rent', type: 'number'  },
							{name : 'security', type: 'number'  },
							{name : 'remarks', type: 'String'  },  
							{name : 'ctype', type: 'String'  },  
							{name : 'oldcontno', type: 'String'  },
                        	{name : 'refno', type: 'String'  }, 
                        	{name : 'email', type: 'String'  }, 
                        	{name : 'salesman', type: 'String'  }, 
                        	{name : 'groupcompanies', type: 'String'  },
                        	{name : 'billingmethod', type: 'String'  }, 
                        	{name : 'billingmethodid', type: 'String'  }, 
                        	{name : 'skipstatus', type: 'String'  }, 
                        	{name : 'renewalno', type: 'String'  },   
                        	{name : 'revision_no', type: 'String'  },   
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
                height: 440,
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
                            { text: 'brhid',datafield:'brhid',width:'5%',editable:false,hidden:true},    
                            { text: 'tr_no',datafield:'tr_no',width:'5%',editable:false,hidden:true},  
                            { text: 'Cont. No', datafield: 'doc_no',editable:false,width:'5%'},  
                            { text: 'Old Cont.No', datafield: 'oldcontno',editable:false,width:'9%'}, 
                            { text: 'Ref. No', datafield: 'refno',editable:false,width:'7%',hidden:true},   
                            { text: 'Date', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Client', datafield: 'refname',editable:false,width:'15%'},
                            { text: 'Salesman', datafield: 'salesman', width: '12%' ,editable:false},
                            { text: 'Status', datafield: 'status',editable:false,width:'7%'},  
                            { text: 'Site', datafield: 'site',editable:false,width:'10%'},   
                        	{ text: 'siteid',datafield:'siteid',width:'5%',editable:false,hidden:true},
                        	{ text: 'Start Date', datafield: 'startdt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
                        	{ text: 'End Date', datafield: 'enddt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
                            { text: 'Group Companies', datafield: 'groupcompanies', width: '9%' ,editable:false},	
                        	{ text: 'Email', datafield: 'email', width: '9%' ,editable:false},	
                        	{ text: 'Billing Method', datafield: 'billingmethod', width: '9%' ,editable:false},	
							{ text: 'Contract Type', datafield: 'ctype', width: '9%' ,editable:false},	
							{ text: 'Ownership', datafield: 'ownership', width: '6%',editable:false},
							{ text: 'Skip Size', datafield: 'skiptype', width: '5%',editable:false },	
							{ text: 'Waste Type', datafield: 'wastetype', width: '9%' ,editable:false},	
				            { text: 'Skip Qty', datafield: 'nos', width: '4%'},
							{ text: 'Spec', datafield: 'spec', width: '5%',editable:false },	
				            { text: 'Service Term', datafield: 'serviceterm', width: '6%',editable:false},  
							{ text: 'No of Visit', datafield: 'days', width: '4%'},   
							{ text: 'Collection', datafield: 'collection', width: '4%',editable:false},    
							{ text: 'Rate per collection', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Add. Rate', datafield: 'addrate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Skip rent', datafield: 'rent', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Security', datafield: 'security', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tipping Method', datafield: 'tippingmethod', width: '5%',editable:false},    
							{ text: 'Tipping Fee', datafield: 'tippingfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tipping Security', datafield: 'tippingsecurity', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {       
             	  var rowindex1=event.args.rowindex; 
             	  document.getElementById("hidbrhid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidcontrno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site"));
             	  $('.comments-container').html('');  
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 
    <input type="hidden" name="hidrowindex" id="hidrowindex">