<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.warehousemanagement.ClsWarehouseManagementDAO"%>  
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsWarehouseManagementDAO DAO= new ClsWarehouseManagementDAO();    
%>
<script type="text/javascript">  
       var data3;
       data3='<%=DAO.getTransferData(id)%>';                                  

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
							{name : 'bin', type: 'String'  }, 
							{name : 'binid', type: 'String'  }, 
							{name : 'jdeno', type: 'String'  }, 
					        {name : 'bhno', type: 'String'  },
						],
				    localdata: data3,  

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
    
    $("#jqxtransferGrid").jqxGrid(
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
					     /* { text: 'Doc No',datafield: 'voc_no', width: '5%' },  
	         			 { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'}, */
	         			 { text: 'Bin', datafield: 'bin',  width: '10%' }, 
	         			 { text: 'JDE', datafield: 'jdeno', width: '6%'},  
					     { text: 'BH No', datafield: 'bhno', width: '6%'},  
	           	         { text: 'Product Id', datafield: 'productid',  width: '7%' }, 
	           	         { text: 'Product Name', datafield: 'productname' },
	           	         { text: 'Qty', datafield: 'qty',  width: '6%' ,cellsformat:'d2'},
	           	         { text: 'prodoc', datafield: 'prodoc',  width: '5%',hidden:true },
	           	   	     { text: 'psrno', datafield: 'psrno',  width: '5%',hidden:true },  
	           	   	     { text: 'rdocno', datafield: 'rdocno',  width: '5%',hidden:true },  
	           	         { text: 'rdtype', datafield: 'rdtype',  width: '5%',hidden:true },  
	           	         { text: 'rbrhid', datafield: 'rbrhid',  width: '5%',hidden:true },  
	           	         { text: 'balqty', datafield: 'balqty',  width: '5%',cellsformat:'d2',hidden:true }, 
	           	         { text: 'binid', datafield: 'binid',  width: '5%',cellsformat:'d2',hidden:true }, 
	         ]      
    });
    $("#overlay, #PleaseWait").hide();
    $('#jqxtransferGrid').on('rowdoubleclick', function (event) {                              
        var rowindex2 = event.args.rowindex;    
        document.getElementById("txtproduct3").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'productname');        
        document.getElementById("txtqty3").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'balqty'); 
        document.getElementById("hidprodoc").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'prodoc'); 
        document.getElementById("hidpsrno").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'psrno');  
        document.getElementById("hidrdocno").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'rdocno');  
        document.getElementById("hidrdtype").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'rdtype');    
        document.getElementById("hidrbrhid").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'rbrhid'); 
        document.getElementById("hidbalqty").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'balqty');   
        document.getElementById("txtbin").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'bin'); 
        document.getElementById("hidoldbin").value=$("#jqxtransferGrid").jqxGrid('getcellvalue',rowindex2,'binid');  
        $('.comments-container').html('');     
    }); 
});
</script>
<div id="jqxtransferGrid"></div>        