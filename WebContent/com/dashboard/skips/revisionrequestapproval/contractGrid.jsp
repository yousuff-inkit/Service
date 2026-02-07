<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.revisionrequestapproval.ClsRevisionRequestApprovalDAO" %>
<%
ClsRevisionRequestApprovalDAO DAO= new ClsRevisionRequestApprovalDAO();        
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		String status=request.getParameter("status")==null || request.getParameter("status")==""?"":request.getParameter("status").toString(); 

		%>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(session,id,status)%>';           
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
                	
		                	{name : 'contractno', type: 'String'  },
		                  	{name : 'client', type: 'String'  },
							{name : 'fromdate', type: 'date'  },
		              		{name : 'todate', type: 'date'  },
							{name : 'invmthd', type: 'int'   },
							{name : 'skipsize', type: 'string'   },
		              		{name : 'ownership', type: 'String'  },
							{name : 'reqremarks', type: 'String'  },
							{name : 'requser', type: 'String'  },
							{name : 'reqdate', type: 'date'  },
							{name : 'status', type: 'String'  },
		                	{name : 'doc_no', type: 'String'  },
		                	{name : 'brhid', type: 'String'  },
		                	{name : 'user_id', type: 'String'  },
							{name : 'stat', type: 'String'  },
							{name : 'witheffectdate', type: 'date'  },
							{name : 'reason', type: 'String'  },
							{name : 'apprdate', type: 'date'  },
                        	
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

            $("#jqxContractGrid").on('bindingcomplete', function (event) {  
                	var status = $("#cmbstatus").val();
                	if(parseInt(status)==0){
                		$("#jqxContractGrid").jqxGrid('hidecolumn', 'user_id');  
                  		$("#jqxContractGrid").jqxGrid('hidecolumn', 'apprdate'); 
                  		$("#jqxContractGrid").jqxGrid('hidecolumn', 'reason');                    
                	}else{
                		$("#jqxContractGrid").jqxGrid('showcolumn', 'user_id');  
                  		$("#jqxContractGrid").jqxGrid('showcolumn', 'apprdate'); 
                  		$("#jqxContractGrid").jqxGrid('showcolumn', 'reason'); 
                	}
            });
            
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
                rowsheight:25,
                filtermode:'excel',
                sortable:true,
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
                            { text: 'Contract No',datafield:'contractno',width:'5%',editable:false},    
                            { text: 'Client',datafield:'client',editable:false,width:'24%'},  
                            { text: 'From Date', datafield: 'fromdate',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'},  
                            { text: 'To Date', datafield: 'todate',editable:false,width:'5%',cellsformat:'dd.MM.yyyy'}, 
                            { text: 'Invoice Method', datafield: 'invmthd',editable:false,width:'7%'},   
                            { text: 'Skip Size', datafield: 'skipsize',editable:false,width:'8%'},  
                            { text: 'Ownership', datafield: 'ownership',editable:false,width:'5%'}, 
                            { text: 'Request Remarks', datafield: 'reqremarks',editable:false,width:'15%'},  
                            { text: 'Request User', datafield: 'requser',editable:false,width:'6%'},   
                        	{ text: 'Request Date',datafield:'reqdate',width:'5%',editable:false,cellsformat:'dd.MM.yyyy'},
                        	{ text: 'Witheffect Date',datafield:'witheffectdate',width:'5%',editable:false,cellsformat:'dd.MM.yyyy'},
                            { text: 'Status', datafield: 'stat',editable:false,width:'6%'},   
                        	{ text: 'Approved/Rejected By', datafield: 'user_id',editable:false,width:'7%'},
                        	{ text: 'Approved Date',datafield:'apprdate',width:'5%',editable:false,cellsformat:'dd.MM.yyyy'},    
                        	{ text: 'Remarks', datafield: 'reason',editable:false,width:'15%'},
                        	{ text: 'Status',datafield:'status',width:'6%',editable:false,hidden:true},
                        	{ text: 'doc_no',datafield:'doc_no',width:'10%',editable:false,hidden:true},
                        	{ text: 'brhid',datafield:'brhid',width:'10%',editable:false,hidden:true},
                        	]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {       
             	  var rowindex1=event.args.rowindex;  
             	  document.getElementById("hidcontrno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "contractno");
             	  document.getElementById("hidbrhid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidstatus").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "status"); 
             	  document.getElementById("hiddocno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
             	  document.getElementById("lblname").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "contractno")+" - "+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "client");  
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "contractno")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "client"));
            }); 
        });
    </script>
    <div id="jqxContractGrid"></div> 