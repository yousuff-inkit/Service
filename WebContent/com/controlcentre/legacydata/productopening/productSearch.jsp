<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.legacydata.productopening.ClsproductopeningDAO"%>
<% ClsproductopeningDAO searchDAO = new ClsproductopeningDAO();
 
String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");
String docnoss=request.getParameter("docnoss")==null?"0":request.getParameter("docnoss");
String productname=request.getParameter("productname")==null?"0":request.getParameter("productname");
  
%>
 <script type="text/javascript">
 
$(document).ready(function () {
 
   var proddata;
   
	   proddata='<%=searchDAO.productSearch(session,aa,docnoss,productname)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'String'},
                  		{name : 'prodcode',type:'String'},
                  		{name : 'prodname',type:'String'},
                  		{name : 'unit',type:'String'},
                  		
                		{name : 'brandname',type:'String'},
                      	
                		{name : 'specid',type:'String'},
                      	
                  		
                  		 
                  		
                  		
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
        height: 358,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        showfilterrow: true,
        filterable: true,
       sortable:false,
        columns: [
               
				
     
          		  
                 
       				{ text: 'Doc No',datafield:'doc_no',width:'10%'},
       				{ text:'Product Code',datafield:'prodcode',width:'30%'},
       				{ text:'Product Name',datafield:'prodname',width:'50%'},
       				{ text:'Unit',datafield:'unit',width:'20%'},
       				
       				
       				
       				{ text:'brandname ',datafield:'brandname',width:'50%',hidden:true},
       				{ text:'specid',datafield:'specid',width:'20%',hidden:true}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $('#prodSearch').on('rowdoubleclick', function (event) 
    		{ 

    
      
     var rowindex1 = event.args.rowindex;
     
     var rowindex2=  document.getElementById("rowindex").value;


     $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "psrno",$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"));

     $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "productid",$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "prodcode"));
     
     
     $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "productname",$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "prodname"));
     
     $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "unit",$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "unit"));
     $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "brandname",$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "brandname"));
     
     
     $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "specid",$('#prodSearch').jqxGrid('getcellvalue', rowindex1, "specid"));
     var rows = $('#purchasedetails').jqxGrid('getrows');
     var rowlength= rows.length;
     if(rowindex2 == rowlength - 1)
     	{  
     $("#purchasedetails").jqxGrid('addrow', null, {});
     	} 
     	  
    		  	
    	$('#sidesearchwndow').jqxWindow('close');
    	});
    

});

	
	
</script>
<!-- <div align="center" style="padding-bottom:4px;"><button type="button" id="btnproduct" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div> -->
<div id="prodSearch"></div>