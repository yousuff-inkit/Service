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
        	locdata= '<%=searchDAO.searchProduct(session,"1") %>';   
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'brandid', type: 'String'  },    
                             {name : 'brandname', type: 'String'  },
                        ],
                		localdata: locdata, 
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#brandgrid").jqxGrid(
            {
                width: '100%',
                height: 370,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns:[
          				{ text: 'ID', datafield: 'brandid', width: '20%',hidden:true},
    					{ text: 'BRAND NAME', datafield: 'brandname', width: '100%' }
						]
            });

            $('#brandgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("errormsg").innerText="";
                $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "brandid",$('#brandgrid').jqxGrid('getcellvalue', rowindex1, "brandid"));
                $('#serviecGrid').jqxGrid('setcellvalue', rowBoundIndex, "brandname",$('#brandgrid').jqxGrid('getcellvalue', rowindex1, "brandname"));
                $('#brandsearchwindow').jqxWindow('close');  
            }); 
             
        });
    </script>
    <div id="brandgrid"></div>