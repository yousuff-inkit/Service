<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractrenewalfollowup.ClsContractRenewalFollowupDAO" %>  
<%
ClsContractRenewalFollowupDAO DAO= new ClsContractRenewalFollowupDAO();        
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
	  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();  
 %>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(session,id,todate)%>';          
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
							{name : 'renewalstatusid', type: 'String'   },
							
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
		                  	{name : 'foc', type: 'String'  },
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
		                  	{name : 'rent', type: 'number'  },
							{name : 'security', type: 'number'  },
							{name : 'fdate', type: 'date' },
							
							{name : 'payterms', type: 'String'  },
							{name : 'typeid', type: 'String'  },
							{name : 'groupcompanies', type: 'String'  },
							{name : 'remarks', type: 'String'  },  
							{name : 'billingmethod', type: 'String'  },
							{name : 'cldocno', type: 'String'  },
							{name : 'sal_id', type: 'String'  },
							{name : 'sal_name', type: 'String'  },
							{name : 'com_add1', type: 'String'  }, 
							{name : 'mob', type: 'String'  }, 
							{name : 'telno', type: 'String'  }, 
							{name : 'email', type: 'String'  },  
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
                height: 350,
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
                            { text: 'rowno',datafield:'rowno',width:'5%',editable:false,hidden:true},    
                            { text: 'tr_no',datafield:'tr_no',width:'5%',editable:false,hidden:true},  
                            { text: 'Doc No', datafield: 'doc_no',editable:false,width:'5%'},  
                            { text: 'Date', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Client', datafield: 'refname',editable:false,width:'15%'}, 
                            { text: 'SalesMan', datafield: 'sal_name', width: '7%' ,editable:false,hidden:false},
                            { text: 'Site', datafield: 'site',editable:false,width:'10%'},   
                        	{ text: 'siteid',datafield:'siteid',width:'5%',editable:false,hidden:true},
                        	{ text: 'Start Date', datafield: 'startdt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
                        	{ text: 'End Date', datafield: 'enddt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy' },
                        	{ text: 'Renewal Status', datafield: 'renewalstatusid',editable:false,width:'5%' },
                        	
                        	{ text: 'Followup Date', datafield: 'fdate', width: '5%',cellsformat:'dd.MM.yyyy'},  
                        	{ text: 'Skip', datafield: 'skip',width:'8%',editable:false}, 
                        	{ text: 'Route', datafield: 'route',width:'8%',editable:false},
							{ text: 'Waste Type', datafield: 'wastetype', width: '9%' ,editable:false},	
							{ text: 'Skip Size', datafield: 'skiptype', width: '5%',editable:false },	
							{ text: 'Spec', datafield: 'spec', width: '5%',editable:false },	
							{ text: 'Service By', datafield: 'serviceby', width: '6%',editable:false,hidden:true},
							{ text: 'Ownership', datafield: 'ownership', width: '6%',editable:false},
				            { text: 'Qty', datafield: 'nos', width: '4%'},
				            { text: 'Service Term', datafield: 'serviceterm', width: '6%',editable:false},  
							{ text: 'No of Visit', datafield: 'days', width: '4%'},   
							{ text: 'Collection', datafield: 'collection', width: '4%',editable:false},  
							{ text: 'Rate per collection', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
							{ text: 'FOC Trips', datafield: 'foc', width: '4%'}, 
							{ text: 'Skip rent', datafield: 'rent', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Security', datafield: 'security', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tipping Method', datafield: 'tippingmethod', width: '4%',editable:false},    
							{ text: 'Tipping Fee', datafield: 'tippingfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tipping Security', datafield: 'tippingsecurity', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tipping Rate', datafield: 'tariffrate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
							{ text: 'gpsx',datafield:'gpsx',width:'5%',editable:false,hidden:true},  
							{ text: 'gpsy',datafield:'gpsy',width:'5%',editable:false,hidden:true},  
							{ text: 'brhid',datafield:'brhid',width:'5%',editable:false,hidden:true},
							{ text: 'statusid',datafield:'statusid',width:'5%',editable:false,hidden:true},
							{ text: 'Gpsx', datafield: 'gpsx1', width: '7%' ,editable:false},	
                        	{ text: 'Gpsy', datafield: 'gpsy1', width: '7%' ,editable:false},	
                        	{ text: 'payterms', datafield: 'payterms', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'typeid', datafield: 'typeid', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'billingmethod', datafield: 'billingmethod', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'groupcompanies', datafield: 'groupcompanies', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'remarks', datafield: 'remarks', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'cldocno', datafield: 'cldocno', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'sal_id', datafield: 'sal_id', width: '7%' ,editable:false,hidden:true},
                        	
                        	{ text: 'com_add1', datafield: 'com_add1', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'mob', datafield: 'mob', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'telno', datafield: 'telno', width: '7%' ,editable:false,hidden:true},
                        	{ text: 'email', datafield: 'email', width: '7%' ,editable:false,hidden:true},  
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {         
             	  var rowindex1=event.args.rowindex; 
             	  document.getElementById("hidclient").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname");
             	  document.getElementById("hidcldocno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
             	  document.getElementById("hidaddress").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "com_add1");
             	  document.getElementById("hidpertel").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "telno");
             	  document.getElementById("hidper_mob").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "mob");
             	  document.getElementById("hidmail1").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "email");
             	  document.getElementById("hidsalname").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "sal_name");
             	  document.getElementById("hidsalid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "sal_id");
             	  document.getElementById("hidgrpname").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "groupcompanies");
             	  document.getElementById("hiddesc").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "remarks");
             	  document.getElementById("hidbilling").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "billingmethod");
             	  document.getElementById("hidtype").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "typeid");
             	  document.getElementById("hidpayterms").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "payterms");
             	  document.getElementById("hidenddt").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "enddt");
             	  document.getElementById("hidstartdt").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "startdt");  
             	  document.getElementById("hiddate").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "date");  
             	
             	  document.getElementById("hidtrno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	  document.getElementById("hiddocno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	  document.getElementById("hidbrhid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidrowno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "rowno");
             	  $("#amcfollowupGrid").jqxGrid('clear');     
             	  $("#detailDiv").load("detailGrid.jsp?rowno="+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "rowno"));   
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname"));
             	  $('.comments-container').html('');  
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 