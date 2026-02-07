<%@page import="com.dashboard.management.productlist.ClsProductListDAO" %>
<%ClsProductListDAO amd=new ClsProductListDAO(); %>
 <%
String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
//System.out.println("-------chk---"+chk);
%> 
 <script type="text/javascript">
 $(document).ready(function () {
	       var theme = getDemoTheme();  
           exceldata= '<%=amd.prdExcel(chk)%>';       
           var data = '<%=amd.prdList(chk)%>';    
            
            var source = 
            {
                datatype: "json",
                datafields: [
                	    {name : 'productid', type: 'String'  },
                        {name : 'productname', type: 'String'  },
                        {name : 'unit', type: 'String'  },
                        {name : 'brand', type: 'String'  },
						{name : 'type', type: 'String'  },
						{name : 'cat', type: 'String'  },
						{name : 'stdprice', type: 'number'  },
						{name : 'fixingprice', type: 'number'  },
						{name : 'fixedcharge', type: 'number'  },
						{name : 'department', type: 'String'  },
						{name : 'subcategory', type: 'String'  },
						{name : 'jdeno', type: 'String'  },
						{name : 'bhno', type: 'String'  },
                ],
                localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            var redRow;
            var yellowRow;
            var dataAdapter = new $.jqx.dataAdapter(source);
            // initialize jqxGrid 
            $("#jqxPRDGrid").jqxGrid(
            {
                width: '99.5%',
				height: 500,
                source: dataAdapter,
                groupable: true,
                //groupsrenderer: false,
                selectionmode: 'singlecell',
                groups: ['brand','department','unit'],   
                columns: [
		                	{ text: 'SL#', sortable: false, filterable: false, editable: false,
		                        groupable: false, draggable: false, resizable: false,
		                        datafield: 'sl', columntype: 'number', width: '5%' ,
		                        cellsrenderer: function (row, column, value) {
		                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
		                        }  
		                      },
		                    { text: 'Product', datafield: 'productid',  width: '8%'  },
		             	    { text: 'Product Name', datafield: 'productname'  }, 
		             	    { text: 'Unit', datafield: 'unit',  width: '7%'  }, 
		             	    { text: 'Brand', datafield: 'brand',  width: '9%'  }, 
		             	    { text: 'Type', datafield: 'type',  width: '9%',hidden:true },   
		             	    { text: 'Category', datafield: 'cat',  width: '9%',hidden:true  },
		             	    { text: 'Sub Category', datafield: 'subcategory',  width: '9%',hidden:true  },     
		             	    { text: 'Department', datafield: 'department',  width: '8%' },
		             	    { text: 'Standard cost', datafield: 'stdprice',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',hidden:'true'  },
		             	    { text: 'Selling price', datafield: 'fixingprice',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' ,hidden:'true' },
		             	    { text: 'Fixed charge', datafield: 'fixedcharge',  width: '8%' ,cellsformat: 'd2',cellsalign:'right',align:'right', hidden:'true' },
		             	    { text: 'Jde No', datafield: 'jdeno',  width: '8%',hidden:true   },
		             	    { text: 'BH No', datafield: 'bhno',  width: '8%',hidden:true  },     
                ],
				 groupsrenderer: function (defaultText, group, state, params) {   
						return false;
				 }   
				
            });
     	   $("#overlay, #PleaseWait").hide();
        });
</script>
<div id="jqxPRDGrid"></div>     