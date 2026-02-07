<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<%ClsOperationDAO assignment=new ClsOperationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>

<script type="text/javascript">
		 var mcpdata1;  
        $(document).ready(function () {     
          
             
             <%-- if(temp>0){  
            	 mcpdata1='<%=DAO.multipleCashPurchaseGridReloading(session,docNo,check)%>';       
           	 } --%>
             
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
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'docno', type: 'int' },
                            {name : 'vendor', type: 'string' },
                            {name : 'tinno', type: 'string' },
                            {name : 'invno', type: 'string' },
                            {name : 'invdate', type: 'date' },
                            {name : 'tax', type: 'string' },
                            {name : 'srvtaxper', type: 'number' },
                            
     						{name : 'type', type: 'string' }, 
     						{name : 'accounts', type: 'string'   },
     						{name : 'accountname1', type: 'string'  },
     						{name : 'currency', type: 'string'   },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'rate', type: 'number' },
     						{name : 'costtype', type: 'string'  },
							{name : 'costgroup', type: 'string' },
							{name : 'costcode', type: 'number'  },
     						{name : 'amount1', type: 'number' },
     						{name : 'taxamt', type: 'number' },
     						{name : 'total', type: 'number' },
     						{name : 'description', type: 'string'   },
     						{name : 'grtype', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'rowno', type: 'int'  },
     						{name : 'vendorid', type: 'number'  },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'hidinvdate', type: 'string' },
     						{name : 'trno', type: 'string' },
     						{name : 'psrno', type: 'string' },
     						{name : 'qty', type: 'number' },
     						{name : 'unitprice', type: 'number' },
     						//{name : 'tax', type: 'string'   }
                        ],
                         localdata: mcpdata1,       
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['AP', 'AR', 'GL', 'HR'];
            
            $("#jqxMCPCash").jqxGrid(
            {
                width: '100%',   
                height: 160,
                source: dataAdapter,
                editable: true,
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
             	enabletooltips:true,    
             	columnsresize:true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#jqxMCPCash').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'accounts') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {    
                        	var value = $('#jqxMCPCash').jqxGrid('getcellvalue', cell1.rowindex, "type");
                        	$('#mcpaccrowindex').val(cell1.rowindex);
                        	$('#mcpaccid').val(1);      
                        	McpSearchContent('multipleCashPurchaseSearchGrid.jsp?atype='+value);    
                          }
                    }
                    
                    var cell2 = $('#jqxMCPCash').jqxGrid('getselectedcell');
                    if (cell2 != undefined && cell2.datafield == 'costgroup') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	var value = $('#jqxMCPCash').jqxGrid('getcellvalue', cell2.rowindex, "grtype");
         	            if(value==4 || value==5){
                    	if (key == 114) { 
                        	costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxMCPCash");
                        	 $('#jqxMCPCash').jqxGrid('render');
             	           }
                          }
                    	}
                        
                    var cell3 = $('#jqxMCPCash').jqxGrid('getselectedcell');
                    if (cell3 != undefined && cell3.datafield == 'costcode') {
    	                   var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
    	                   var value1 = $('#jqxMCPCash').jqxGrid('getcellvalue', cell3.rowindex, "grtype");
	        	           if(value1==4 || value1==5){
    	                   if (key == 114) {   
    	                	   var value=  $('#jqxMCPCash').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	                	   costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxMCPCash&costtype="+value);
    	                	   $('#jqxMCPCash').jqxGrid('render');
    	        	           }
    	                   }
    	               }
                },
                       
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '3%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No', hidden: true, datafield: 'docno',  width: '5%' },
							
							{ text: 'Vendor', datafield: 'vendor',  editable: false, width: '7%' },
							{ text: 'Tin No', datafield: 'tinno',  editable: false, width: '5%' },
							{ text: 'Inv No', datafield: 'invno',  editable: true, width: '4%' },
			                { text: 'Inv Date', datafield: 'invdate', columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy', width: '7%'},
							{ text: 'tax', datafield: 'tax',  editable: false, width: '7%', hidden:true },
                            { text: 'Type', datafield: 'type', width: '3%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }   
                            },
							{ text: 'Account', datafield: 'accounts',  editable: false, width: '4%' },	
							{ text: 'Account Name', datafield: 'accountname1', editable: false, width: '15%' },	
							{ text: 'Currency', datafield: 'currency', editable: false, width: '4%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Rate', datafield: 'rate', cellsformat: 'd4', editable: true, width: '4%', cellsalign: 'right', align: 'right' },
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false, hidden: true },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%', hidden: true,editable: false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Qty', datafield: 'qty', width: '5%' },
							{ text: 'Unit Price', datafield: 'unitprice', cellsformat: 'd4', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd4', width: '5%',editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tax %', datafield: 'srvtaxper', width: '5%',cellsalign: 'right', align:'right',cellsformat:'d4' , width: '5%' },
							{ text: 'Tax Amount', datafield: 'taxamt', editable: false, cellsformat: 'd4', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Total', datafield: 'total', editable: false, cellsformat: 'd4', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description' },          
							{ text: 'Group Type', datafield: 'grtype', hidden: true, editable: false, width: '10%' },
							{ text: 'SR No', datafield: 'sr_no', hidden: true, editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Vendorid',datafield:'vendorid',width:'12%',editable:false,hidden:true},
							{ text: 'rowno',datafield:'rowno',width:'12%',editable:false,hidden:true},
							{ text: 'Hid-Inv-Date', datafield: 'hidinvdate', editable: false, hidden: true,  width: '10%' },
							//{ text: 'dtype',datafield:'dtype',width:'12%',editable:false,hidden:true},
							{ text: 'PSRNO', datafield: 'psrno', width: '5%',hidden:true },
						]
            });
         	  $("#jqxMCPCash").on('cellvaluechanged', function (event) 
         	  {         		
         		var datafield = event.args.datafield;
          		var rowindexestemp = event.args.rowindex;
          		 if(datafield=="qty" || datafield=="unitprice"){
          		 
          		 var qty=  $("#jqxMCPCash").jqxGrid('getcellvalue', rowindexestemp, "qty");
          		 
          		 var uprice=  $("#jqxMCPCash").jqxGrid('getcellvalue', rowindexestemp, "unitprice");
          		 
          		 var amnt=parseFloat(qty)*parseFloat(uprice);
          		 
          		  $('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,amnt);
          		 
          		 }
         		 if(datafield=="amount1" || datafield=="rate" || datafield=="srvtaxper"){

                 var taxper= $("#jqxMCPCash").jqxGrid('getcellvalue', rowindexestemp, "srvtaxper");
         		 var value1= $("#jqxMCPCash").jqxGrid('getcellvalue', rowindexestemp, "amount1"); 
                 var rate= $("#jqxMCPCash").jqxGrid('getcellvalue', rowindexestemp, "rate");
                 //alert(taxper+"==="+rate+"===="+value1);
                 var type= $("#jqxMCPCash").jqxGrid('getcellvalue', rowindexestemp, "currencytype");
                 
                
                 
                 //var baseamount = getBaseAmountInGrid(value1,rate,type);
                 var intrst = parseFloat(value1)*(parseFloat(taxper)/100);
                 var total1 = value1+intrst;
                
	                	 $('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "taxamt" ,intrst);
	                	 $('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "total" ,total1);
	               
	               
                var totalbase=$('#jqxMCPCash').jqxGrid('getcolumnaggregateddata', 'total', ['sum'], true);
                //alert(totalbase);
                totalbase1=parseFloat(totalbase.sum.replace(',','')).toFixed(2);
          		//var totalbase2= totalbase1.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
                document.getElementById("billamount").value=totalbase1;  
                var settle=0.0;
                settle=totalbase1-parseFloat($("#advamount").val());           
                funRoundAmt(settle,"settleamount");        
                //rate = $('#txtrate').val();     
	            baseamount = totalbase1;     
	            //alert(rate);
		    	//currencytype = $('#hidcurrencytype').val().trim();
		    	
			    	if(!isNaN(totalbase1)){
					       
			    	}else if(isNaN(totalbase1)){
					    	 $('#billamount').val(0.00);
				    }
         		}
         		
         		 if(datafield=="invdate")
	        {
	            var issdate = $('#jqxMCPCash').jqxGrid('getcelltext', rowindexestemp, "invdate");
	            $('#jqxMCPCash').jqxGrid('setcellvalue',rowindexestemp, "hidinvdate",issdate);
	         } 
         		if(datafield=="type"){
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');	
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "rate" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
      			}
         		
         		if(datafield=="costtype"){
         			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');	
     			}
         
        });
         	  
         	 $("#jqxMCPCash").on('cellvaluechanged', function (event) {
           	   var rowindexestemp = event.args.rowindex;
           	   $('#rowindex').val(rowindexestemp);
           	   
        		var value = $('#jqxMCPCash').jqxGrid('getcellvalue', rowindexestemp, "type");
       			// $('#type').val(value);
              });      
         	 
           $('#jqxMCPCash').on('celldoubleclick', function (event) {
         		if(event.args.datafield=="description")
            	   {
            		 var rowindextemp = event.args.rowindex;
            		 var id=1;
            		 getproductdetails(rowindextemp,id);
            	   }   
             if(event.args.columnindex == 2)
        		  {
        			var rowindextemp = event.args.rowindex;
        			document.getElementById("rowindex").value = rowindextemp;
                    var value = $('#jqxMCPCash').jqxGrid('getcellvalue', rowindextemp, "type");
                    // alert(rowindextemp);
        		    VendorSearchContent('mcpVendorSearch.jsp?rowindex='+rowindextemp+'&id='+1);                                                 
                  }
        	  if(event.args.columnindex == 8)
        		  {
        			var rowindextemp = event.args.rowindex;
        		    var value = $('#jqxMCPCash').jqxGrid('getcellvalue', rowindextemp, "type");
        		    $('#mcpaccrowindex').val(rowindextemp);     
                	$('#mcpaccid').val(1);
        		    McpSearchContent('multipleCashPurchaseSearchGrid.jsp?atype='+value);   
                  } 
        	  
        	  if(event.args.columnindex == 13){  
        	       
    	           var rowindextemp = event.args.rowindex;
    	           var value = $('#jqxMCPCash').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value==4 || value==5){
    	           $('#jqxMCPCash').jqxGrid('clearselection');
    	           costTypeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costTypeSearchGrid.jsp?formname=jqxMCPCash");
    	          }
                } 
                if(event.args.columnindex == 15){
    	           var rowindextemp = event.args.rowindex;
    	           var value = $('#jqxMCPCash').jqxGrid('getcellvalue', rowindextemp, "grtype");
    	           var cell3 = $('#jqxMCPCash').jqxGrid('getselectedcell');
    	           document.getElementById("rowindex").value = rowindextemp;
    	           if(value==4 || value==5){
    	           $('#jqxMCPCash').jqxGrid('clearselection');
    	           var value1=  $('#jqxMCPCash').jqxGrid('getcellvalue', cell3.rowindex, "costtype");
    	           costCodeSearchContent(<%=contextPath+"/"%>+"com/costcenter/costCodeSearchGrid.jsp?formname=jqxMCPCash&costtype="+value1);
    	          }   
                } 
               if(event.args.columnindex == 0)
     		   {
     			var rowindexestemp = event.args.rowindex;
     			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "docno" ,'');
     			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "type" ,'');	
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "accounts" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "accountname1" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "currency" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "currencyid" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "costgroup" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "costtype" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "costcode" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "amount1" ,'0.00');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "taxamt" ,'0.00');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "description" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "grtype" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "sr_no" ,'');
 	   			$('#jqxMCPCash').jqxGrid('setcellvalue', rowindexestemp, "currencytype" ,'');
               }
               
            }); 
        });
    
</script>
<div id="jqxMCPCash"></div>         
 <input type="hidden" id="rowindex"/>  
<input type="hidden" id="mcpaccrowindex"/>
<input type="hidden" id="mcpaccid"/>     
<input type="hidden" id="type"/>  