<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%@page import="com.dashboard.sales.salesinvoicesummarylist.*"%>
 <% ClsInvoiceSummaryListDAO searchDAO = new ClsInvoiceSummaryListDAO(); 
 
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
String catid=request.getParameter("catid")==null?"0":request.getParameter("catid");
String subcatid=request.getParameter("subcatid")==null?"0":request.getParameter("subcatid");
System.out.println("==brandid===="+brandid);
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var proddata;
   
	   proddata='<%=searchDAO.docnoSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
{name : 'doc_no',type:'number'},
                  		{name : 'voc_no',type:'number'}, 
                  		{name : 'name',type:'String'},
                  		{name : 'branch',type:'String'},
                  	 
                  		
                  		
                  		],
				    localdata: proddata,
        
        
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
    
    
    $("#docsearchs").jqxGrid(
    {
        width: '100%',
        height: 358,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        showfilterrow: true,
        filterable: true,
       sortable:false,
        columns: [
               
                   { text: 'Doc No',datafield:'doc_no',width:'20%',hidden:true},
       				{ text: 'Doc No',datafield:'voc_no',width:'20%'},
       				{ text:'Name',datafield:'name',width:'50%'},
       				
       				{ text:'Branch',datafield:'branch',width:'30%'},
       				
       				 
       			 
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $('#docsearchs').on('rowdoubleclick', function (event) 
    		{ 
   
        var rowindex1 = event.args.rowindex;        
        
   
        document.getElementById("invdocno").value = $('#docsearchs').jqxGrid('getcellvalue', rowindex1, "voc_no");
        
        document.getElementById("invdocnomaster").value = $('#docsearchs').jqxGrid('getcellvalue', rowindex1, "doc_no");
    
           	
    	$('#docWindow').jqxWindow('close');
    	});
    

});

	
	
</script>
<!-- <div align="center" style="padding-bottom:4px;"><button type="button" id="btnproduct" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div> -->
<div id="docsearchs"></div>