<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.it.quotationit.ClsQuotationItDAO"%>
<% ClsQuotationItDAO searchDAO = new ClsQuotationItDAO(); %>
<%

String rowBoundIndex=request.getParameter("rowBoundIndex")==null?"0":request.getParameter("rowBoundIndex").trim();
%> 
<script type="text/javascript">
var rowBoundIndex='<%=rowBoundIndex%>';
var locdata;
        $(document).ready(function () { 
        	locdata= '<%=searchDAO.searchProduct(session,"2") %>';        
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'deptid', type: 'String'  },    
                             {name : 'department', type: 'String'  },
                             {name : 'description', type: 'String'  },    
                             {name : 'price', type: 'String'  }
                        ],
                		localdata: locdata, 
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#deptgrid").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
                filterable: true,
                showfilterrow:true,
           
                selectionmode: 'singlerow',
                
                columns:[
          				{ text: 'ID', datafield: 'deptid', width: '20%',hidden:true},
    					{ text: 'Department', datafield: 'department', width: '50%' },
          				{ text: 'Description', datafield: 'description', width: '30%' },
          				{ text: 'Price', datafield: 'price', width: '20%' },
						]
            });

            $('#deptgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("errormsg").innerText="";
                $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "deptid",$('#deptgrid').jqxGrid('getcellvalue', rowindex1, "deptid"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "productname",$('#deptgrid').jqxGrid('getcellvalue', rowindex1, "department"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "description",$('#deptgrid').jqxGrid('getcellvalue', rowindex1, "description"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "unitprice",$('#deptgrid').jqxGrid('getcellvalue', rowindex1, "price"));
                $('#departmentsearchwindow').jqxWindow('close');  
            }); 
             
        });
    </script>
    <div id="deptgrid"></div>