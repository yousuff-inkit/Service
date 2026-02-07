<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.warehousemanagement.ClsWarehouseManagementDAO"%>  
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsWarehouseManagementDAO DAO= new ClsWarehouseManagementDAO();    
%>
<script type="text/javascript">  
       var data1;
       data1='<%=DAO.getStoringData(id)%>';                                

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
			        	    {name : 'voc_no', type: 'int'  },
							{name : 'date', type: 'date'  },
							{name : 'qty', type: 'number'  },
							{name : 'productid', type: 'String'  },
							{name : 'productname', type: 'String'  },
							{name : 'unit', type: 'String'  },  
							{name : 'prodoc', type: 'String'  },  
							{name : 'psrno', type: 'String'  },  
							{name : 'rdocno', type: 'String'  }, 
							{name : 'rdtype', type: 'String'  }, 
							{name : 'rbrhid', type: 'String'  }, 
							{name : 'balqty', type: 'number'  }, 
							{name : 'jdeno', type: 'String'  }, 
					        {name : 'bhno', type: 'String'  },
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
    
    $("#jqxstoringGrid").jqxGrid(
    {
        width: '100%',
        height: 250,
        source: dataAdapter,
        enableAnimations: true,
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,                                
        pagermode: 'default',
        enabletooltips:true,
        columns: [   
					    { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '4%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     },  
					     { text: 'Doc No',datafield: 'voc_no', width: '5%' },
	         			 { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
	         			 { text: 'JDE', datafield: 'jdeno', width: '6%'},  
					     { text: 'BH No', datafield: 'bhno', width: '6%'},  
	           	         { text: 'Product Id', datafield: 'productid',  width: '7%' },   
	           	         { text: 'Product Name', datafield: 'productname' },
	           	         { text: 'Unit', datafield: 'unit',  width: '5%' },
	           	         { text: 'Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2'},
	           	         { text: 'prodoc', datafield: 'prodoc',  width: '5%',hidden:true },
	           	   	     { text: 'psrno', datafield: 'psrno',  width: '5%',hidden:true },  
	           	   	     { text: 'rdocno', datafield: 'rdocno',  width: '5%',hidden:true },  
	           	         { text: 'rdtype', datafield: 'rdtype',  width: '5%',hidden:true },  
	           	         { text: 'rbrhid', datafield: 'rbrhid',  width: '5%',hidden:true },  
	           	         { text: 'balqty', datafield: 'balqty',  width: '5%',cellsformat:'d2',hidden:true },  
	         ]      
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxstoringGrid').on('rowdoubleclick', function (event) {                            
        var rowindex2 = event.args.rowindex; 
        document.getElementById("txtproduct1").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'productname');        
        document.getElementById("txtqty1").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'balqty'); 
        document.getElementById("hidprodoc").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'prodoc'); 
        document.getElementById("hidpsrno").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'psrno');  
        document.getElementById("hidrdocno").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'rdocno');  
        document.getElementById("hidrdtype").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'rdtype');    
        document.getElementById("hidrbrhid").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'rbrhid'); 
        document.getElementById("hidbalqty").value=$("#jqxstoringGrid").jqxGrid('getcellvalue',rowindex2,'balqty');   
        $('.comments-container').html('');     
    }); 
});
</script>
<div id="jqxstoringGrid"></div>        