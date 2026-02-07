 <%@page import="com.finance.nipurchase.suppliers.ClsVendorDetailsDAO"%>
<%
ClsVendorDetailsDAO VendorDetailsDAO=new ClsVendorDetailsDAO();

%>
       <script type="text/javascript">
 
		  var barnddata='<%=VendorDetailsDAO.searchBrand()%>';
			 
			 
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'brandname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  },
                            {name : 'brand', type: 'string'  },
                            
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxbrandSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                              { text: 'BRAND', datafield: 'brand', width: '40%' },
                              { text: 'BRAND NAME', datafield: 'brandname', width: '60%' }
						
			
	             
						]
            });
            
          $('#jqxbrandSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#brandgrid').jqxGrid('setcellvalue', rowindex1, "brandname" ,$('#jqxbrandSearch').jqxGrid('getcellvalue', rowindex2, "brandname"));
                $('#brandgrid').jqxGrid('setcellvalue', rowindex1, "doc_no" ,$('#jqxbrandSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
         
                var rows = $('#brandgrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                	  $("#brandgrid").jqxGrid('addrow', null, {});	
                }
              
                document.getElementById("errormsg").innerText="";
                
                
              $('#brandsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxbrandSearch"></div>