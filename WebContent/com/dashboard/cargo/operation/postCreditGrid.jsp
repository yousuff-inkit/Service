<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<% ClsOperationDAO DAO=new ClsOperationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno");
String check=request.getParameter("id")==null?"0":request.getParameter("id");
%>      
<script type="text/javascript">
		 var postdata2;  
		 postdata2='<%=DAO.postCreditGridReloading(docno,check)%>';   
        $(document).ready(function () {       
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
                         localdata: postdata2,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            var list = ['AP', 'AR', 'GL', 'HR'];
            
            $("#jqxPostCredit").jqxGrid(
            {
                width: '100%',
                height: 160,        
                source: dataAdapter,
                editable: false,   
                showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25,
             	enabletooltips:true,    
             	columnsresize:true,   
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
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
							{ text: 'Cost Type', datafield: 'costgroup', width: '7%',editable: false,hidden: true },
							{ text: 'Cost Id', datafield: 'costtype', width: '8%',hidden: true },
							{ text: 'Cost Code', datafield: 'costcode', width: '5%',hidden: true,editable: false, aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Qty', datafield: 'qty', width: '5%' },
							{ text: 'Unit Price', datafield: 'unitprice', cellsformat: 'd4', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Amount', datafield: 'amount1', cellsformat: 'd4', width: '5%',editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Tax %', datafield: 'srvtaxper', width: '5%',cellsalign: 'right', align:'right',cellsformat:'d4' , width: '5%' },
							{ text: 'Tax Amount', datafield: 'taxamt', editable: false, cellsformat: 'd4', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Total', datafield: 'total', editable: false, cellsformat: 'd4', width: '5%', cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Description', datafield: 'description'},      
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
        });
    
</script>   
<div id="jqxPostCredit"></div>  