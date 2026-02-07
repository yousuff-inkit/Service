<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.procurment.productlist.ClsProductlistDAO" %>
<%   
	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	String fromDate = request.getParameter("frmdate")==null?"0":request.getParameter("frmdate").trim();
	String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	ClsProductlistDAO dao= new ClsProductlistDAO();
%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">
    
       var partdata;
       var exdata;
       var type='<%=type%>';
    	 
	  	if(type=='1'){ 
	  		
	  		
	  		<%-- exdata='<%=dao.productlistexcel(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,type)%>'; --%>     
	  		 partdata='<%=dao.productlist(session,hidbrand,fromDate,toDate,hidtype,hidcat,hidsubcat,hidproduct,branchid,hidept,type)%>';    
	  	} 
		else{
		partdata;
	}

$(document).ready(function () {
	
	
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                     
                  
        	            {name : 'slno', type: 'number'    },
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
						 
						
						
						],
				    localdata: partdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.isqty !=0) {
            return "yellowClass";
        }else{
        	return "orangeClass";
        };
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#partSearchgrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        showfilterrow: true,
        enabletooltips:true,
        columnsresize: true,
       selectionmode: 'singlerow',                 
       
       
                                
        pagermode: 'default',
        editable:false,
        columns: [   
        	   { text: 'Sr.No', datafield: 'slno', width: '4%' }, 
               { text: 'Product', datafield: 'productid',  width: '5%'  },
           	   { text: 'Product Name', datafield: 'productname',  width: '20%'  }, 
           	   { text: ' Unit', datafield: 'unit',  width: '6%'  }, 
           	   { text: ' Brand', datafield: 'brand',  width: '7%'  }, 
           	   { text: ' Type', datafield: 'type',  width: '10%'  },   
           	   { text: ' Category', datafield: 'cat',  width: '12%'  },
           	   
           	 { text: ' Sub Category', datafield: 'subcategory',  width: '12%'  },
           	 
           	 { text: ' Department', datafield: 'department',  width: '8%'  },
           	 { text: ' Standard cost', datafield: 'stdprice',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right'  },
           	 { text: ' Selling price', datafield: 'fixingprice',  width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right'  },
           	 { text: ' Fixed charge', datafield: 'fixedcharge',  width: '8%' ,cellsformat: 'd2',cellsalign:'right',align:'right', hidden:'true' }
           	
           
    ]		 
   
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="partSearchgrid"></div>