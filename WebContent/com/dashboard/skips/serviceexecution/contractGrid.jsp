<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.serviceexecution.ClsServiceExecutionDAO" %>
<%
        ClsServiceExecutionDAO DAO= new ClsServiceExecutionDAO();  
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
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
  
var quotedata;  

var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		   quotedata='<%=DAO.contractGridLoad(session,id,divname)%>';              
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
                        	
                        	{name : 'delsch' , type: 'String'},
    						{name : 'routeasgn' , type: 'String'},
    						{name : 'collsch' , type: 'String'},
    						{name : 'pullout' , type: 'String'},
    						{name : 'schdate' , type: 'date'},
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
            var cellclassnameds =  function (row, column, value, data) {
               var delsch = $('#jqxContractGrid').jqxGrid('getcellvalue', row, "delsch");
         	   if(delsch=='C') {
         		    return "lightGreen";  
         	   } 
         		  if(delsch.includes("P")) {   
              		   return "lightRed";  
              	   } 
            }
            var cellclassnamera =  function (row, column, value, data) {
                var routeasgn = $('#jqxContractGrid').jqxGrid('getcellvalue', row, "routeasgn");
          	   if(routeasgn=='C') {
          		    return "lightGreen";  
          	   } 
          	  if(routeasgn.includes("P")) {   
            		   return "lightRed";  
            	   }
             }
            var cellclassnamecs =  function (row, column, value, data) {
                var collsch = $('#jqxContractGrid').jqxGrid('getcellvalue', row, "collsch");
          	   if(collsch=='C' || collsch=='CB') {
          		    return "lightGreen";  
          	   } 
          	  if(collsch.includes("P")) {   
            		   return "lightRed";  
            	   }
             }
            var cellclassnamepo =  function (row, column, value, data) {
                var pullout = $('#jqxContractGrid').jqxGrid('getcellvalue', row, "pullout");
          	   if(pullout=='C') {
          		    return "lightGreen";  
          	   } 
          	  if(pullout.includes("P")) {   
            		   return "lightRed";  
            	   }
             }
            $("#jqxContractGrid").jqxGrid(  
            {
                width: '100%',
                height: 400,
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
                            { text: 'ROWNO',datafield:'rowno',width:'5%',editable:false,hidden:true},    
                            { text: 'TR_NO',datafield:'tr_no',width:'5%',editable:false,hidden:true},  
                            { text: 'DOC NO', datafield: 'doc_no',editable:false,width:'5%'},  
                            { text: 'DATE', datafield: 'date',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'OLD CONT.NO', datafield: 'oldcontno',editable:false,width:'9%'}, 
                            { text: 'REF. NO', datafield: 'refno',editable:false,width:'7%'},   
                            { text: 'CLIENT', datafield: 'refname',editable:false,width:'15%'}, 
                            { text: 'CONTACT PERSON',datafield:'cperson',width:'9%',editable:false},
                        	{ text: 'MOB',datafield:'mob',width:'9%',editable:false},
                            { text: 'PROCESS STATUS', datafield: 'status',editable:false,width:'7%',hidden:true},  
                            { text: 'SITE', datafield: 'site',editable:false,width:'10%'},   
                        	{ text: 'SITEID',datafield:'siteid',width:'5%',editable:false,hidden:true}, 
                        	
                        	{ text: 'DS', datafield: 'delsch', width: '4%',cellclassname:cellclassnameds},    
							{ text: 'RA', datafield: 'routeasgn', width: '4%',cellclassname:cellclassnamera},
							{ text: 'CS', datafield: 'collsch', width: '4%',cellclassname:cellclassnamecs},  
							{ text: 'PO', datafield: 'pullout', width: '4%',cellclassname:cellclassnamepo},   
							
                        	{ text: 'SKIP', datafield: 'skip',width:'8%',editable:false}, 
                        	{ text: 'ROUTE', datafield: 'route',width:'8%',editable:false},
                        	{ text: 'SER.REQ. NO', datafield: 'srdocno',width:'6%',editable:false},  
                        	{ text: 'SER.REQ. REMARKS', datafield: 'srdesc',width:'8%',editable:false},
                        	{ text: 'CONT. TYPE', datafield: 'cntstatus',width:'6%',editable:false}, 
                        	{ text: 'DOC. STATUS', datafield: 'docstatus',width:'6%',editable:false},  
                        	{ text: 'TYPE', datafield: 'cnttype',width:'3%',editable:false},            
                        	
                        	{ text: 'GROUP COMPANIES', datafield: 'groupcompanies', width: '9%' ,editable:false},	
                        	{ text: 'EMAIL', datafield: 'email', width: '9%' ,editable:false},	
                        	{ text: 'SALESMAN', datafield: 'salesman', width: '9%' ,editable:false},	  
                            
							{ text: 'WASTE TYPE', datafield: 'wastetype', width: '9%' ,editable:false},	
							{ text: 'SKIP SIZE', datafield: 'skiptype', width: '5%',editable:false },	
							{ text: 'SPEC', datafield: 'spec', width: '5%',editable:false },	
							{ text: 'SERVICE BY', datafield: 'serviceby', width: '6%',editable:false,hidden:true},
							{ text: 'OWNERSHIP', datafield: 'ownership', width: '6%',editable:false},
				            { text: 'QTY', datafield: 'nos', width: '4%'},
				            { text: 'SERVICE TERM', datafield: 'serviceterm', width: '6%',editable:false},  
							{ text: 'NO OF VISIT', datafield: 'days', width: '4%'},   
							{ text: 'COLLECTION', datafield: 'collection', width: '4%',editable:false},  
							{ text: 'RATE PER COLLLECTION', datafield: 'rate', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },	
							{ text: 'ADMIN FEE', datafield: 'adminfee', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },
							{ text: 'FOC TRIPS', datafield: 'foc', width: '4%'},
							{ text: 'SKIP RENT', datafield: 'rent', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring,hidden:true },	   
							{ text: 'GPSX',datafield:'gpsx',width:'5%',editable:false,hidden:true},  
							{ text: 'GPSY',datafield:'gpsy',width:'5%',editable:false,hidden:true},  
							{ text: 'BRHID',datafield:'brhid',width:'5%',editable:false,hidden:true},
							{ text: 'END DATE', datafield: 'enddt',editable:false,width:'5%',cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'STATUSID',datafield:'statusid',width:'5%',editable:false,hidden:true},  
						    { text: 'GPSX', datafield: 'gpsx1', width: '7%' ,editable:false},	
                        	{ text: 'GPSY', datafield: 'gpsy1', width: '7%' ,editable:false},
                        	{ text: 'NAME', datafield: 'dlname', width: '7%' ,editable:false},
                        	{ text: 'MOBILE', datafield: 'dlmobile', width: '7%' ,editable:false},
                        	{ text: 'EMAIL', datafield: 'dlemail', width: '7%' ,editable:false},
                        	{ text: 'DAY SHIFT', datafield: 'dldayshift', width: '7%' ,editable:false},  
                        	{ text: 'SRNO',datafield:'srno',width:'5%',editable:false,hidden:true}, 
                        	{ text: 'SKIPDOC',datafield:'skipdoc',width:'5%',editable:false,hidden:true},
                        	{ text: 'AREA',datafield:'area',width:'5%',editable:false,hidden:true},
                        	{ text: 'AREAID',datafield:'areaid',width:'5%',editable:false,hidden:true},
                        	{ text: 'CLDOCNO',datafield:'cldocno',width:'5%',editable:false,hidden:true},
                        	{ text: 'CPERSONID',datafield:'cpersonid',width:'5%',editable:false,hidden:true},
                        	{ text: 'CPEMAIL',datafield:'cpemail',width:'5%',editable:false,hidden:true},
                        	{ text: 'SKIPNO',datafield:'skipno',width:'5%',editable:false,hidden:true},
                        	{ text: 'SKIPID',datafield:'skipid',width:'5%',editable:false,hidden:true}, 
                        	{ text: 'schdate',datafield:'schdate',width:'5%',editable:false,hidden:true}, 
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {         
             	  var rowindex1=event.args.rowindex;    
             	  
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
             	  document.getElementById("hidposkipno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "skipid");   
            	  document.getElementById("hidposkipsize").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "skipno");
            	  document.getElementById("pocontract").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
             	  document.getElementById("lblname").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+" - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname");  
             	  document.getElementById("lblotherdetails").innerHTML=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+", Site: "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site")+", Service Term : "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "serviceterm")+", No of Visit : "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "days")+", End Date : "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "enddt");
             	  if($("#divname").val()=="hold"){
             		 $("#btnrelease").attr({disabled:false});   
             	  }else{
             		 $("#btnrelease").attr({disabled:true});
             	  }
             	  var delsch = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "delsch");   
             	  var routeasgn = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "routeasgn");   
             	  var collsch = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "collsch");  
             	  var pullout = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "pullout");
             	  if((delsch=="C" || delsch=="") && (routeasgn=="C" || routeasgn=="") && (collsch=="C" || collsch=="") && (pullout=="C" || pullout=="")){
             		 $("#btnconfirm").attr({disabled:false});   
             	  }else{
             		 $("#btnconfirm").attr({disabled:true});
             	  } 
             	  
             	 var schdate = $('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "schdate");   
             	 if(schdate!="" && schdate!=null){
             		$('#servdate').jqxDateTimeInput('setDate', new Date(schdate));
             	 }   
             	 
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site"));
             	  $('.comments-container').html('');    
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 