<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.warehousemanagement.ClsWarehouseManagementDAO"%>  
<%
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    ClsWarehouseManagementDAO DAO= new ClsWarehouseManagementDAO(); 
    String prodoc = request.getParameter("prodoc")==null?"0":request.getParameter("prodoc").trim();
    String psrno = request.getParameter("psrno")==null?"0":request.getParameter("psrno").trim();
    String rdocno = request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").trim();
    String rdtype = request.getParameter("rdtype")==null?"0":request.getParameter("rdtype").trim();
%>
<script type="text/javascript">  
       var datasub;
       datasub='<%=DAO.getPickingSubData(id,prodoc,psrno,rdocno,rdtype)%>';                                        
 
$(document).ready(function () {
	var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	if(typeof(value) == "undefined"){
       		value=0.00;
       	}
       	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
       }
	
var rendererstring1=function (aggregates){
        var value1=aggregates['sum1'];
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
       }
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
							{name : 'bin', type: 'String'  },   
							{name : 'binqty', type: 'number'  }, 
							{name : 'qty', type: 'number'  }, 
							{name : 'binid', type: 'String'  },  
						],
				    localdata: datasub,     

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
    
    $("#jqxpickingSubGrid").jqxGrid(
    {
        width: '100%',
        height: 150,
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
        editable:true,
        showaggregates: true,
     	showstatusbar:true,
     	rowsheight:25,
     	statusbarheight:25,
        columns: [   
					    { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,editable:false,
					      datafield: 'sl', columntype: 'number', width: '4%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     },  
	           	         { text: 'Bin', datafield: 'bin',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring1},    
	           	         { text: 'Bin Qty', datafield: 'binqty',  width: '10%',cellsformat:'d2',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring},
	           	         { text: 'Qty', datafield: 'qty',  width: '10%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	           	         { text: 'Binid', datafield: 'binid',editable:false,hidden:true},    
	         ]      
    });
    $("#overlay, #PleaseWait").hide();  
});
</script>
<div id="jqxpickingSubGrid"></div>         