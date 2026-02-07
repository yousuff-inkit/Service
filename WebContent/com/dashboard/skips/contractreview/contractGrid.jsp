<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractreview.ClsContractReviewDAO" %>
<%
        ClsContractReviewDAO DAO= new ClsContractReviewDAO();        
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();  
		String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();  
		String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();  
		String divname = request.getParameter("divname")==null?"0":request.getParameter("divname").trim();    
 %>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(session,id,fromdate,todate,type,divname)%>';            
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
                        	{name : 'startdt1', type: 'Date'  },       
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
                        	{name : 'cntstatus', type: 'String'  }, 
                        	{name : 'inctipfee', type: 'String'  }, 
                        	{name : 'cntvalue', type: 'number'  },
                        	{name : 'closedate', type: 'String'  },
                        	{name : 'closereason', type: 'String'  }, 
                        	{name : 'srdocno', type: 'String'  },       
                        	{name : 'srdesc', type: 'String'  }, 
                        	{name : 'srno', type: 'String'  }, 
                        	{name : 'closeduser', type: 'String'  },     
                        	{name : 'cnttype', type: 'String'  },
                        	{name : 'pullqty', type: 'String'  },
                        	{name : 'foc', type: 'String'  },
                        	{name : 'dlname', type: 'String'  },
                        	{name : 'dlmobile', type: 'String'  },
                        	{name : 'dlemail', type: 'String'  },
                        	{name : 'dldayshift', type: 'String'  },	
                         	{name : 'docstatus', type: 'String'  }, 
                         	{name : 'gatefee', type: 'number'  },
                         	{name : 'cldocno', type: 'String'  }, 
                         	{name : 'srfstatus', type: 'String'  }, 
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
                height: 420,   
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                sortable:true,   
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
                            { text: 'rowno',datafield:'rowno',width:'5%',editable:false,hidden:true},    
                            { text: 'tr_no',datafield:'tr_no',width:'5%',editable:false,hidden:true},  
                            { text: 'Doc No', datafield: 'doc_no',editable:false,width:'5%'},
                            { text: 'Revision', datafield: 'revision_no',editable:false,width:'4%'},
                            { text: 'Date', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'}, 
                            { text: 'Old Cont.No', datafield: 'oldcontno',editable:false,width:'9%'}, 
                            { text: 'Ref. No', datafield: 'refno',editable:false,width:'7%'},   
                            { text: 'Client', datafield: 'refname',editable:false,width:'15%'}, 
                            { text: 'Group Name', datafield: 'groupcompanies', width: '9%' ,editable:false},
                            { text: 'Site', datafield: 'site',editable:false,width:'10%'},   
                            { text: 'Cont. Status', datafield: 'cntstatus',editable:false,width:'7%'}, 
                            { text: 'Process Status', datafield: 'status',editable:false,width:'7%'},
                            { text: 'Doc. Status', datafield: 'docstatus',width:'6%'},
                            { text: 'Skip Size', datafield: 'skiptype', width: '5%',editable:false },	
                            { text: 'Skip Qty', datafield: 'nos', width: '4%'},
                            { text: 'Skip @site(Qty)', datafield: 'delqty', width: '5%'},
                            { text: 'Skip Status', datafield: 'skipstatus', width: '9%' ,editable:false},
                            { text: 'No of Visit', datafield: 'days', width: '4%'},
				            { text: 'Service Term', datafield: 'serviceterm', width: '6%',editable:false},
                            { text: 'siteid',datafield:'siteid',width:'5%',editable:false,hidden:true},
                        	{ text: 'Contract Start Date', datafield: 'startdt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
                        	{ text: 'Contract End Date', datafield: 'enddt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
                        	{ text: 'Rate per collection', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Add. Rate', datafield: 'addrate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'Billing Method', datafield: 'billingmethod', width: '6%' ,editable:false},	
							{ text: 'Contract Type', datafield: 'ctype', width: '6%' ,editable:false},	
							{ text: 'Skip rent', datafield: 'rent', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Security Deposit', datafield: 'security', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Including Tipping Fee', datafield: 'inctipfee', width: '4%',editable:false },
							{ text: 'Tipping Method', datafield: 'tippingmethod', width: '5%',editable:false}, 
							{ text: 'Tipping Fee', datafield: 'tippingfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tipping Fee Deposit', datafield: 'tippingsecurity', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Gate Fee', datafield: 'gatefee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Salesman', datafield: 'salesman', width: '9%' ,editable:false},	   
							{ text: 'Ownership', datafield: 'ownership', width: '6%',editable:false},
							{ text: 'Type of Waste', datafield: 'wastetype', width: '9%' ,editable:false},
							{ text: 'Route', datafield: 'route',width:'8%',editable:false},
                        	{ text: 'Email', datafield: 'email', width: '9%' ,editable:false},
                        	{ text: 'Whole Contract Value', datafield: 'cntvalue', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
                        	{ text: 'Skip', datafield: 'skip',width:'8%'},    
                        	{ text: 'Ser.Req. No', datafield: 'srdocno',width:'6%'},  
                        	{ text: 'Ser.Req. Remarks', datafield: 'srdesc',width:'8%'},  
                        	{ text: 'Ter/Rev Date', datafield: 'closedate',width:'6%',editable:false},
                        	{ text: 'Ter/Rev Reason', datafield: 'closereason',width:'16%',editable:false},   
                        	{ text: 'Ter/Rev User', datafield: 'closeduser',width:'12%',editable:false},          
                        	    
                        	{ text: 'Renewed From', datafield: 'renewalno',editable:false,width:'5%',hidden:true},   
							{ text: 'billingmethodid', datafield: 'billingmethodid',width:'8%',editable:false,hidden:true},
                        	{ text: 'Remarks', datafield: 'remarks',width:'15%',editable:false,hidden:true},  
							{ text: 'Service By', datafield: 'serviceby', width: '6%',editable:false,hidden:true},
						    { text: 'Tipping Rate', datafield: 'tariffrate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
							{ text: 'gpsx',datafield:'gpsx',width:'5%',editable:false,hidden:true},  
							{ text: 'gpsy',datafield:'gpsy',width:'5%',editable:false,hidden:true},  
							{ text: 'brhid',datafield:'brhid',width:'5%',editable:false,hidden:true},
							{ text: 'statusid',datafield:'statusid',width:'5%',editable:false,hidden:true},
							{ text: 'srno',datafield:'srno',width:'5%',hidden:true}, 
							{ text: 'Contract Start Date', datafield: 'startdt1',editable:false,width:'5%',hidden:true}, 
							{ text: 'Type', datafield: 'cnttype',width:'3%'},            
							{ text: 'Spec', datafield: 'spec', width: '5%' },	
							{ text: 'Pull Out Qty', datafield: 'pullqty', width: '4%'}, 
							{ text: 'Collection', datafield: 'collection', width: '4%'},
							{ text: 'FOC Trips', datafield: 'foc', width: '4%'},							
							{ text: 'Gpsx', datafield: 'gpsx1', width: '7%' },	
							{ text: 'Gpsy', datafield: 'gpsy1', width: '7%' },
							{ text: 'Name', datafield: 'dlname', width: '7%' },
							{ text: 'Mobile', datafield: 'dlmobile', width: '7%' },
							{ text: 'Email', datafield: 'dlemail', width: '7%' },
							{ text: 'Day Shift', datafield: 'dldayshift', width: '7%' },
							{ text: 'cldocno',datafield:'cldocno',width:'5%',editable:false,hidden:true},
							{ text: 'srfstatus',datafield:'srfstatus',width:'5%',editable:false,hidden:true},
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {         
             	  var rowindex1=event.args.rowindex;  
             	  document.getElementById("hidrowindex").value = rowindex1;   
             	  document.getElementById("hidstartdt").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "startdt1");  
             	  document.getElementById("hidsrno").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "srno");
             	  document.getElementById("hidsrdocno").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "srdocno");
             	  document.getElementById("hidcontrno").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	  document.getElementById("hidbrhid").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidrowno").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "rowno");   
             	  document.getElementById("cldocno").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");   
             	  document.getElementById("hidtype").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "srfstatus");
             	  document.getElementById("lblnamesrf").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+" - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+", Site - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site")+", Skip Size - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "skiptype")+", Service Term - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "serviceterm")+", Qty - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "nos")+", No Of Visit - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "days") ; 
             	  document.getElementById("lblname").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+" - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname");  
             	  getSRFDetails();
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site"));
             	  $('.comments-container').html('');     
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 
    <input type="hidden" name="hidrowindex" id="hidrowindex">