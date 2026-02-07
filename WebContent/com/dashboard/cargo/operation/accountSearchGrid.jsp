<%@page import="com.dashboard.cargo.operation.ClsOperationDAO"%>
<% ClsOperationDAO DAO=new ClsOperationDAO();
String atype = request.getParameter("atype")==null?"":request.getParameter("atype").trim();
%>     

<script type="text/javascript">
        var acc= '<%=DAO.accountGridSearch(atype) %>';           
        $(document).ready(function () { 	   
                     
            // prepare the data   
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'account', type: 'string'   },
                        ],
                		 localdata: acc, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountSearch").jqxGrid(
            {
            	width: '100%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			filterable: true,
     	        showfilterrow: true,    
     			localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No', hidden : true, datafield: 'doc_no', width: '5%' },
							{ text: 'Account', datafield: 'account', width: '100%' },      
						]
            });
            
            
            $('#jqxAccountSearch').on('rowdoubleclick', function (event) {  
	              var rowindex1 =$('#rowindex2').val();           
	              var rowindex2 = event.args.rowindex;  
	              $('#jqxExpense').jqxGrid('setcellvalue', rowindex1, "acno" ,$('#jqxAccountSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
	              $('#jqxExpense').jqxGrid('setcellvalue', rowindex1, "account" ,$('#jqxAccountSearch').jqxGrid('getcellvalue', rowindex2, "account"));
	              $('#accountDetailsFromWindow').jqxWindow('close');        
            });        
        });
    </script>
    <div id="jqxAccountSearch"></div>
 