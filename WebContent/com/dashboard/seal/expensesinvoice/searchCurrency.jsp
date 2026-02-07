<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.seal.expensesinvoice.ClsExpensesInvoiceDAO"%>
<%ClsExpensesInvoiceDAO DAO = new ClsExpensesInvoiceDAO();%>
<%
 String date = request.getParameter("date")==null?"":request.getParameter("date");
 String brhid = request.getParameter("brhid")==null || request.getParameter("brhid").trim().equals("") || request.getParameter("brhid").trim().equals("a")?"1":request.getParameter("brhid");
%> 

 <script type="text/javascript">  
 
 var currdata;
 currdata='<%=DAO.currencySearch(date,brhid)%>';   
        $(document).ready(function () { 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
	     						{name : 'curid', type: 'String'  },  
	     						{name : 'code', type: 'String'  },
	     						{name : 'rate', type: 'number'  },
                          	],  
                          	localdata: currdata,
                          //	 url: url1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxCurrencyGrid").jqxGrid(
            {
                width: '99%',
                height: 150,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
     					
                columns: [
						{ text: 'Currency', datafield: 'code', width: '60%'  },  
						{ text: 'curid', datafield: 'curid', width: '0%',hidden:true },
						{ text: 'Rate', datafield: 'rate', width: '40%' },
					]
            });  
				            
				           $('#jqxCurrencyGrid').on('rowdoubleclick', function (event)   
				            		{ 
				              	var rowindex1=event.args.rowindex;
				             
				            		$('#txtcurr').val($('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "code"));
				            		$('#hidcurid').val($('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "curid"));
				            		$('#txtrate').val($('#jqxCurrencyGrid').jqxGrid('getcellvalue', rowindex1, "rate"));
				                $('#currinfowindow').jqxWindow('close');
				          }); 	 
                  }); 
    </script>
    <div id="jqxCurrencyGrid"></div> 