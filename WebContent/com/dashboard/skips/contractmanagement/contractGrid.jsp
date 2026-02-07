<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractmanagement.ClsContractManagementDAO" %>
<%
        ClsContractManagementDAO DAO= new ClsContractManagementDAO();  
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());
		String datechk = request.getParameter("datechk")==null?"":request.getParameter("datechk").trim().toString(); 
		String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim().toString();  		
 %>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(session, id, todate, datechk)%>';              
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
		                  	{name : 'areaid', type: 'String'  },
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
                        	{name : 'oldcontno', type: 'String'  },
                        	{name : 'refno', type: 'String'  }, 
                        	{name : 'email', type: 'String'  }, 
                        	{name : 'salesman', type: 'String'  }, 
                        	{name : 'groupcompanies', type: 'String'  }, 
                        	{name : 'srdesc', type: 'String'  }, 
                        	{name : 'srdocno', type: 'String'  }, 
                        	{name : 'srno', type: 'String'  }, 
                        	{name : 'dlname', type: 'String'  }, 
                        	{name : 'dlmobile', type: 'String'  }, 
                        	{name : 'dlemail', type: 'String'  }, 
                        	{name : 'dldayshift', type: 'String'  },   
                        	{name : 'cntstatus', type: 'String'  }, 
                        	{name : 'cnttype', type: 'String'  },  
                        	{name : 'cldocno', type: 'String'  }, 
                        	{name : 'cperson', type: 'String'  },  
                        	{name : 'cpersonid', type: 'String'  },  
                        	{name : 'cpemail', type: 'String'  },  
                        	{name : 'mob', type: 'String'  },  
                        	{name : 'docstatus', type: 'String'  },
                        	{name : 'skipno', type: 'String'  },
                        	{name : 'skipid', type: 'String'  }, 
                        	{name : 'delqty', type: 'number'  },
                        	{name : 'pullqty', type: 'number'  },
                        	{name : 'hold', type: 'number'  },
                        	{name : 'revision_no', type: 'number'  },
                        	{name : 'revision_no', type: 'String'  },
                        	{name : 'skipstatus', type: 'String'  },
                        	{name : 'addrate', type: 'number'  },
                        	{name : 'startdt', type: 'Date'  },
                        	{name : 'startdt1', type: 'Date'  },    
                        	{name : 'billingmethod', type: 'String'  },
                        	{name : 'ctype', type: 'String'  },
                        	{name : 'security', type: 'number'  },
                        	{name : 'inctipfee', type: 'String'  },
                        	{name : 'tippingfee', type: 'number'  },
                        	{name : 'tippingsecurity', type: 'String'  },
                        	{name : 'cntvalue', type: 'number'  },
                        	{name : 'tel', type: 'String'  },
                        	{name : 'extn', type: 'String'  },
                        	{name : 'actvty_id', type: 'String'  },
                        	{name : 'ay_name', type: 'String'  },
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
							 { text: 'SL#', sortable: false, filterable: false,  
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'rowno',datafield:'rowno',width:'5%',hidden:true},    
                            { text: 'tr_no',datafield:'tr_no',width:'5%',hidden:true},  
                            { text: 'Doc No', datafield: 'doc_no',width:'5%'},  
                            { text: 'Revision No', datafield: 'revision_no',width:'5%'}, 
                            { text: 'Date', datafield: 'date',width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'Old Cont.No', datafield: 'oldcontno',width:'9%'}, 
                            { text: 'Ref. No', datafield: 'refno',width:'7%'},   
                            { text: 'Client', datafield: 'refname',width:'15%'}, 
                            { text: 'Group Name', datafield: 'groupcompanies', width: '9%' },
                            { text: 'Site', datafield: 'site',width:'10%'},   
                            { text: 'Cont. Status', datafield: 'cntstatus',width:'6%'}, 
                            { text: 'Process Status', datafield: 'status',width:'7%',hidden:true},  
                            { text: 'Doc. Status', datafield: 'docstatus',width:'6%'},
                            { text: 'Skip Size', datafield: 'skiptype', width: '5%' },
                            { text: 'Skip Qty', datafield: 'nos', width: '4%'},
				            { text: 'Skip @site(Qty)', datafield: 'delqty', width: '4%'},
				            { text: 'Skip Status', datafield: 'skipstatus',width:'5%'},  
				            { text: 'No of Visit', datafield: 'days', width: '4%'},   
				            { text: 'Service Term', datafield: 'serviceterm', width: '6%'},  
				            { text: 'Contract Start Date', datafield: 'startdt',width:'5%',cellsformat:'dd.MM.yyyy' },
				            { text: 'Contract End Date', datafield: 'enddt',width:'5%',cellsformat:'dd.MM.yyyy' },
				            { text: 'Rate per Colllection', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },	
				            { text: 'Add. Rate', datafield: 'addrate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },	
				            { text: 'Billing Method', datafield: 'billingmethod',width:'6%'},   
				            { text: 'Contract Type', datafield: 'ctype',width:'6%'},      
				            { text: 'Skip Rent', datafield: 'rent', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },	   
				            { text: 'Security Deposit', datafield: 'security', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Including Tipping Fee', datafield: 'inctipfee', width: '4%',editable:false },
							{ text: 'Tipping Fee', datafield: 'tippingfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tipping Fee Deposit', datafield: 'tippingsecurity', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Salesman', datafield: 'salesman', width: '9%' ,editable:false},	 
							{ text: 'Ownership', datafield: 'ownership', width: '6%',editable:false},
							{ text: 'Type of Waste', datafield: 'wastetype', width: '9%' },
							{ text: 'Route', datafield: 'route',width:'8%',editable:false},
                        	{ text: 'Email', datafield: 'email', width: '9%' ,editable:false},
                        	{ text: 'Whole Contract Value', datafield: 'cntvalue', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring  },
				            
				            { text: 'siteid',datafield:'siteid',width:'5%',hidden:true},    
                        	{ text: 'Skip', datafield: 'skip',width:'8%'}, 
                        	{ text: 'Ser.Req. No', datafield: 'srdocno',width:'6%'},  
                        	{ text: 'Ser.Req. Remarks', datafield: 'srdesc',width:'8%'},
                        	{ text: 'Type', datafield: 'cnttype',width:'3%'},            
							{ text: 'Spec', datafield: 'spec', width: '5%' },	
							{ text: 'Service By', datafield: 'serviceby', width: '6%',hidden:true},
				            { text: 'Pull Out Qty', datafield: 'pullqty', width: '4%'}, 
							{ text: 'Collection', datafield: 'collection', width: '4%'},  
							{ text: 'Admin Fee', datafield: 'adminfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
							{ text: 'FOC Trips', datafield: 'foc', width: '4%'},
							{ text: 'gpsx',datafield:'gpsx',width:'5%',hidden:true},  
							{ text: 'gpsy',datafield:'gpsy',width:'5%',hidden:true},  
							{ text: 'brhid',datafield:'brhid',width:'5%',hidden:true},
							{ text: 'statusid',datafield:'statusid',width:'5%',hidden:true},  
						    { text: 'Gpsx', datafield: 'gpsx1', width: '7%' },	
                        	{ text: 'Gpsy', datafield: 'gpsy1', width: '7%' },
                        	{ text: 'Name', datafield: 'dlname', width: '7%' },
                        	{ text: 'Mobile', datafield: 'dlmobile', width: '7%' },
                        	{ text: 'Email', datafield: 'dlemail', width: '7%' },
                        	{ text: 'Day Shift', datafield: 'dldayshift', width: '7%' },  
                        	{ text: 'srno',datafield:'srno',width:'5%',hidden:true}, 
                        	{ text: 'skipdoc',datafield:'skipdoc',width:'5%',hidden:true},
                        	{ text: 'area',datafield:'area',width:'5%',hidden:true},
                        	{ text: 'areaid',datafield:'areaid',width:'5%',hidden:true},
                        	{ text: 'cldocno',datafield:'cldocno',width:'5%',hidden:true},
                        	{ text: 'cperson',datafield:'cperson',width:'5%',hidden:true},
                        	{ text: 'cpersonid',datafield:'cpersonid',width:'5%',hidden:true},
                        	{ text: 'cpemail',datafield:'cpemail',width:'5%',hidden:true},
                        	{ text: 'mob',datafield:'mob',width:'5%',hidden:true},
                        	{ text: 'skipno',datafield:'skipno',width:'5%',hidden:true},
                        	{ text: 'skipid',datafield:'skipid',width:'5%',hidden:true},  
                        	{ text: 'hold',datafield:'hold',width:'5%',hidden:true},
                        	{ text: 'tel',datafield:'tel',width:'5%',hidden:true},
                        	{ text: 'extn',datafield:'extn',width:'5%',hidden:true},
                        	{ text: 'actvty_id',datafield:'actvty_id',width:'5%',hidden:true},
                        	{ text: 'ay_name',datafield:'ay_name',width:'5%',hidden:true},
                        	{ text: 'Contract Start Date', datafield: 'startdt1',editable:false,width:'5%',hidden:true},
                        	{ text: 'srfstatus',datafield:'srfstatus',width:'5%',editable:false,hidden:true},
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {         
             	  var rowindex1=event.args.rowindex;    
             	  var hold=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "hold");   
             	  if(hold=="1"){
             		 $('#btnrelease').attr('disabled',false);
             	  }else{
             		 $('#btnrelease').attr('disabled',true);  
             	  }
             	  document.getElementById("hidstartdt").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "startdt1");    
             	  document.getElementById("cntclient").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname");
             	  document.getElementById("hidcntcldocno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
             	  document.getElementById("cntcperson").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "cperson");
             	  document.getElementById("hidcntcpersonid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "cpersonid");
             	  document.getElementById("cntemail").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "cpemail");
             	  document.getElementById("cntmobile").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "mob");
             	  document.getElementById("cntinvoicemail").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "email");
             	  document.getElementById("cntgrpcompany").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "groupcompanies");
             	  document.getElementById("cntrefno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refno");
             	  document.getElementById("cntsite").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site");
             	  document.getElementById("cntarea").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "area");
             	  document.getElementById("hidcntareaid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "areaid");
             	  document.getElementById("cntdesc").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "oldcontno");  
             	  $("#cnttelephno").val($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "tel"));  
             	  $("#cntextn").val($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "extn")); 
             	  $("#hidcntdesgid").val($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "actvty_id")); 
             	  $("#cntdesg").val($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "ay_name")); 
             	
             	  document.getElementById("hidskiptype").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "skipdoc");
             	  document.getElementById("hidsrno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "srno");
             	  document.getElementById("hidsrdocno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "srdocno");
             	  document.getElementById("hidcontrno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	  document.getElementById("hidbrhid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidrowno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "rowno");
             	  document.getElementById("txtgpsx").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "gpsx");
             	  document.getElementById("txtgpsy").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "gpsy");  
             	  document.getElementById("hidserviceterm").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "serviceterm");  
             	  document.getElementById("hidnoofvisit").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "days");
             	  document.getElementById("hidenddt").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "enddt");
             	  document.getElementById("hidstatusid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "statusid");
            	  document.getElementById("hidownership").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "ownership");
            	  $('#skipsizediv').load("skipsizeSearch.jsp?srno="+$("#hidsrno").val()+"&rdocno="+$("#hidcontrno").val());  
            	  var serviceterm=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "serviceterm");
             	  var ownership=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "ownership");   
             	  if(ownership=="OWN SKIP"){      
             		 $("#btnupdate").show();
             	  }else{
             		 $("#btnupdate").hide();   
             	  }
             	  if(serviceterm=="ALTERNATIVE"){
             		 document.getElementById("alternativechk").checked=true;
             	  }else{
             		 document.getElementById("alternativechk").checked=false;
             	  }
             	  funalternatecheck();  
             	  getSkips(); 
             	  document.getElementById("hidtype").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "srfstatus");
             	  document.getElementById("lblnamesrf").value = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+" - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+", Site - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site")+", Skip Size - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "skiptype")+", Service Term - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "serviceterm")+", Qty - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "nos")+", No Of Visit - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "days") ;
             	  document.getElementById("lblname").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+" - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname");  
             	  document.getElementById("lblotherdetails").innerHTML="Service Term : "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "serviceterm")+", No of Visit : "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "days");
             	  getSRFDetails();
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site"));
             	  $('.comments-container').html('');    
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 