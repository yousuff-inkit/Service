
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchaseuom.ClsnipurchaseuomDAO" %>



	
<%

ClsnipurchaseuomDAO viewDAO=new ClsnipurchaseuomDAO();
%>
<script type="text/javascript">


var productdata= '<%=viewDAO.productSearch(session) %>';  

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'part_no', type: 'int'   },
     						{name : 'productname', type: 'string'   },
     						{name : 'munit', type: 'string'   },
     						{name : 'unit', type: 'string'   },
                        ],
                		localdata: productdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxProductSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
                            { text: 'Part No', hidden : true, datafield: 'part_no', width: '5%',hidden:true },
							{ text: 'Product Name', datafield: 'productname', width: '100%' },
							{ text: 'Unit', datafield: 'unit', width: '50%' },
							{ text: 'UnitId', datafield: 'munit',hidden:true },
						]
            });
            
             $('#jqxProductSearch').on('rowdoubleclick', function (event) {
            	 $('#nidescdetailsGrid').jqxGrid('render');
            	 var rowindex1 =$('#prdsetrowno').val();
                 var rowindex2 = event.args.rowindex;  
               var rows = $('#nidescdetailsGrid').jqxGrid('getrows');
                 var rowlength= rows.length;
                 /* if(rowindex1 == rowlength - 1)
                 	{  
                 $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
                 	} 
                  */	
               $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "description" ,$('#jqxProductSearch').jqxGrid('getcellvalue', rowindex2, "productname"));
                  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "unitid" ,$('#jqxProductSearch').jqxGrid('getcellvalue', rowindex2, "munit"));
                  $('#nidescdetailsGrid').jqxGrid('setcellvalue', rowindex1, "unit" ,$('#jqxProductSearch').jqxGrid('getcellvalue', rowindex2, "unit"));
                  $('#productSearchwindow').jqxWindow('close'); 
            
            });  
        });
    </script>
    <div id="jqxProductSearch"></div>
 