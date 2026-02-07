<%@page import="com.operations.clientrelations.clientsubcategory.ClsClientSubCategoryAction"%>
<% ClsClientSubCategoryAction ACTION= new ClsClientSubCategoryAction(); %>  
<script type="text/javascript">
  
        var data1= '<%=ACTION.searchDetails() %>';
        $(document).ready(function () {
             
            var source =     
            {
                datatype: "json",
                datafields: [
                	    {name : 'category', type: 'String'  },
	                   	{name : 'subcategory', type: 'String'  },
	                	{name : 'catid', type: 'String'  },
	                	{name : 'subcatid', type: 'String'  }
                 ],
               localdata: data1,
                
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
            $("#jqxCategorySearch").jqxGrid(
            {
            	width: '100%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                columnsresize: true,
               
                columns: [
                	 { text: 'Doc No', datafield: 'subcatid', width: '10%' },
					 { text: 'Category', datafield: 'category', width: '45%' },
					 { text: 'Sub Category', datafield: 'subcategory', width: '45%' },
					 { text: 'Catid', datafield: 'catid', hidden: true, width: '10%' },
	              ]
            });
            $('#jqxCategorySearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
   	         document.getElementById("cmbcategory").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "catid");
   	         document.getElementById("cmbsubcategory").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "subcategory");
   	         document.getElementById("docno").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "subcatid");
                
                $('#window').jqxWindow('close');
            }); 
            
        });
    </script>
    <div id="jqxCategorySearch"></div>