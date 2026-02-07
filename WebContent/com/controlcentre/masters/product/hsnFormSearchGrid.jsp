<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<%ClsProductMasterDAO DAO= new ClsProductMasterDAO();%>
<script type="text/javascript">
 	
 	var data= '<%=DAO.hsncodesearch(session)%>';
    
    $(document).ready(function () { 
		var num = 0; 
   		var source ={
        				datatype: "json",
        				datafields: [{name : 'doc_no' , type: 'int' },
									 {name : 'hs_code', type: 'String'  }
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
  
    	$("#hsnsearch").jqxGrid(
            {
            	width: '100%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
                sortable: true,
                altrows:true,
                columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '50%' },
					{ text: 'hscode',columntype: 'textbox', filtertype: 'input', datafield: 'hs_code', width: '50%' }
	              ]
            });
            
            
                
    	$('#hsnsearch').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("cmbhsn").value= $('#hsnsearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("txthsn").value = $("#hsnsearch").jqxGrid('getcellvalue', rowindex1, "hs_code");
                $('#hsnsearchwindow').jqxWindow('close'); 
    		 }); 
				           
}); 
				                         
   </script>
<div id="hsnsearch"></div> 