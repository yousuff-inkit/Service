<%@page import="com.controlcentre.settings.productsettings.productmaster.ClsProductMasterDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%ClsProductMasterDAO DAO= new ClsProductMasterDAO(); %>
 <script type="text/javascript">
 	var data= '<%=DAO.hsncodelists()%>';
    
    $(document).ready(function () { 
		var num = 0; 
   		var source ={
        				datatype: "json",
        				datafields: [{name : 'doc_no' , type: 'number' },
									 {name : 'hs_code', type: 'String'  },
									 {name : 'description', type:  'String'}
                  	
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
  
    	$("#jqxhsncodeGrid").jqxGrid(
            {
            	width: '70%',
                height: 337,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlerow',
                sortable: true,
                altrows:true,
                columns: [
					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '30%' },
					{ text: 'hscode',columntype: 'textbox', filtertype: 'input', datafield: 'hs_code', width: '30%' },
					{ text: 'description',columntype: 'textbox', filtertype: 'input', datafield: 'description',width: '40%' }
	              ]
            });
            
            
        if(document.getElementById("mode").value=='A'){
            	$('#jqxhsncodeGrid').jqxGrid({ disabled: true});
            }
            
                
    	$('#jqxhsncodeGrid').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxhsncodeGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("hscode").value = $("#jqxhsncodeGrid").jqxGrid('getcellvalue', rowindex1, "hs_code");
                document.getElementById("description").value = $("#jqxhsncodeGrid").jqxGrid('getcellvalue', rowindex1, "description");
    		 	 $('#hsndate').jqxDateTimeInput({disabled: false});
    		 	 $("#hsndate").val($("#jqxhsncodeGrid").jqxGrid('getcellvalue', rowindex1, "date"));
	             $('#hsndate').jqxDateTimeInput({disabled: true});
    		 }); 
				           
}); 
				       
                       
    </script>
    <div id="jqxhsncodeGrid"></div>
    