<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%@page import="com.dashboard.sales.ClsSalesReportsDAO"%>
 <% ClsSalesReportsDAO searchDAO = new ClsSalesReportsDAO(); 
 
String brandid=request.getParameter("brandid")==null?"0":request.getParameter("brandid");
String catid=request.getParameter("catid")==null?"0":request.getParameter("catid");
String subcatid=request.getParameter("subcatid")==null?"0":request.getParameter("subcatid");
System.out.println("==brandid===="+brandid);
%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var proddata;
   
	   proddata='<%=searchDAO.productSearch(session)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'}, 
                  		{name : 'prodcode',type:'String'},
                  		{name : 'prodname',type:'String'},
                  		{name : 'unit',type:'String'},
                  		
                  		
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
    
    
    $("#prodSearch").jqxGrid(
    {
        width: '100%',
        height: 360,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        showfilterrow: true,
        filterable: true,
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'10%',hidden:true},
       				{ text:'Product Code',datafield:'prodcode',width:'30%'},
       				{ text:'Product Name',datafield:'prodname',width:'50%'},
       				{ text:'Unit',datafield:'unit',width:'20%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $('#prodSearch').on('rowdoubleclick', function (event) 
    		{ 
   
        var rowindex1 = event.args.rowindex;        
        
   
        document.getElementById("txtpartno").value = $('#prodSearch').jqxGrid('getcellvalue', rowindex1, "prodcode");
    
         document.getElementById("txtproductname").value = $('#prodSearch').jqxGrid('getcellvalue', rowindex1, "prodname");
         document.getElementById("psrno").value = $('#prodSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");	  	
    	$('#productDetailsWindow').jqxWindow('close');
    	});
    

});

	
	
</script>
<!-- <div align="center" style="padding-bottom:4px;"><button type="button" id="btnproduct" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div> -->
<div id="prodSearch"></div>