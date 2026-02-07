<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.clientreview.ClsClientReviewDAO" %>
<%
ClsClientReviewDAO DAO= new ClsClientReviewDAO();         
String check = request.getParameter("check")==null?"0":request.getParameter("check");
		%>   
<script type="text/javascript">
  
var data;
var temp='<%=check%>';
$(document).ready(function () {   	
	if(temp=="load") {
	 	data = '<%=DAO.clientListGridLoading()%>';
	}
            var source =
            {
                datatype: "json",
                datafields:
                [
                    { name: 'cldocno', type: 'string' },
                    { name: 'category', type: 'string' },
                    { name: 'refname', type: 'string' },
                    { name: 'per_mob', type: 'string' },
                    { name: 'sal_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'mail1', type: 'string' },
                    { name: 'crdprd', type: 'string' },
                    { name: 'crdlmt', type: 'string' },
                    { name: 'trnnumber', type: 'string' },
                    { name: 'date', type: 'date' },
                    { name: 'code', type: 'number' },
                    { name: 'acno', type: 'number' },
                    { name: 'accgroup', type: 'String' },
                    { name: 'crmaxdays', type: 'number' },
                    { name: 'tel', type: 'String' },
                    { name: 'area', type: 'String' },
                    { name: 'city', type: 'String' },
                    { name: 'country', type: 'String' },
                    { name: 'grpcmpname', type: 'String' },
                    { name: 'status', type: 'String' },
                    { name: 'cntrcount', type: 'String' },
                    { name: 'brhid', type: 'String' }

                ],
                 localdata: data,  
                
                
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

            
            $("#client").jqxGrid(  
            {
                width: '100%',
                height: 600,
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
                	
                	// { text: 'Date', groupable: true, datafield: 'date', width: '5%',cellsformat:'dd.mm.yyyy' },
   				     { text: 'Code',  datafield: 'code', width: '4%' },
   				     { text: 'Name', datafield: 'refname', width: '17%' },
   				     { text: 'A/c No',  datafield: 'acno', width: '5%' },
                     { text: 'Category',  datafield: 'category', width: '7%' },
                     { text: 'Acc. Group', datafield: 'accgroup', width: '8%' },
                     { text: 'Salesman',  datafield: 'sal_name', width: '7%' },
                     { text: 'TRN No',  datafield: 'trnnumber', width: '6%' },
                     { text: 'Group Company',  datafield: 'grpcmpname', width: '7%' },
                     { text: 'No of Contract', datafield: 'cntrcount', width: '7%' },
                     { text: 'Status', datafield: 'status', width: '5%' },
                     { text: 'Address',  datafield: 'address', width: '16%' },
                     { text: 'Telephone',  datafield: 'tel', width: '7%' },
                     { text: 'Mobile',  datafield: 'per_mob', width: '9%' },
                     { text: 'Email Id',  datafield: 'mail1', width: '13%' },
                     { text: 'Area', datafield: 'area', width: '12%' },
                     { text: 'City',  datafield: 'city', width: '7%' },
                     { text: 'Country',  datafield: 'country', width: '7%' },
                     { text: 'Credit Period Min',  datafield: 'crdprd', width: '7%' },
                     { text: 'Credit Period Max', datafield: 'crmaxdays', width: '7%' },
                     { text: 'Credit Limit', datafield: 'crdlmt', width: '5%' },
                     { text: 'Cldocno', datafield: 'cldocno', width: '5%',hidden:true },
                     { text: 'brhid', datafield: 'brhid', width: '5%',hidden:true },

   			
                        	]
            });
            $("#overlay, #PleaseWait").hide(); 
             $('#client').on('rowdoubleclick', function (event) {       
             	  var rowindex1=event.args.rowindex;  
             	  document.getElementById("hidcldocno").value=$('#client').jqxGrid('getcellvalue', rowindex1, "cldocno"); 
             	  document.getElementById("hidacno").value=$('#client').jqxGrid('getcellvalue', rowindex1, "acno"); 
             	  document.getElementById("hidname").value=$('#client').jqxGrid('getcellvalue', rowindex1, "refname"); 
             	  document.getElementById("hidbrhid").value=$('#client').jqxGrid('getcellvalue', rowindex1, "brhid"); 

            }); 
        });
    </script>
    <div id="client"></div> 