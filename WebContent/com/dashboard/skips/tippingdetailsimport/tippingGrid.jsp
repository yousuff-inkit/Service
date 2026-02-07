<%@page import="com.dashboard.skips.tippingdetailsimport.ClsTippingDetailsImportDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsTippingDetailsImportDAO DAO= new ClsTippingDetailsImportDAO();       
 %>
 <%
 String barchval=request.getParameter("barchval")==null || request.getParameter("barchval")==""?"0":request.getParameter("barchval").trim().toString(); 
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 %> 
 <style type="text/css">
  .redClass {
       background-color: #FE9892; 
    }
    .blueClass {
       background-color: #B0E2FF; 
    }
     .pinkClass {
       background-color: #FBC4EC; 
    }
</style>
    <script type="text/javascript">
    var ccdata;  
    var id='<%=id%>';

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
  	  
    	ccdata='<%=DAO.tippingData(session,id,barchval)%>';  
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'contno', type: 'String'  },
		                	{name : 'oldcontno', type: 'string'  },
			      		    {name : 'dono', type: 'string'  },
		      	       	    {name : 'dodate', type: 'date'  },
		                  	{name : 'wastetype', type: 'string'  },
		                	{name : 'skipsize', type: 'String'  }, 
		                	{name : 'valid', type: 'number'  },
		                	{name : 'valid1', type: 'number'  },
		                	{name : 'brhid', type: 'String'  },
		                	{name : 'qty', type: 'String'  },
		                	{name : 'rate', type: 'number'  },
		                	{name : 'weight', type: 'number'  },
		                	{name : 'price', type: 'number'  },
                          	],
                 localdata: ccdata,
                
                
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
            
            var cellclassname =  function (row, column, value, data) {
                var valid= $('#jqxtippingGrid').jqxGrid('getcellvalue', row, "valid");
                var valid1= $('#jqxtippingGrid').jqxGrid('getcellvalue', row, "valid1");
         	    if(parseInt(valid)>0) { 
         		    return "blueClass";  
         	    } 
         	   if(parseInt(valid1)>0) { 
        		    return "pinkClass";    
        	    }
          } 
            $("#jqxtippingGrid").jqxGrid(
            {
                width: '100%',
                height: 560,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable:true,
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                showfilterrow:true,
                //Add row method
                columns: [{ text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname:cellclassname,
                    groupable: false, draggable: false, resizable: false,
                    datafield: '', columntype: 'number', width: '4%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";  
		                    }
					},
					{ text: 'Cont No', datafield: 'contno', width: '8%',editable:false,cellclassname:cellclassname },	
					{ text: 'Old Cont No', datafield: 'oldcontno', width: '15%',editable:false,cellclassname:cellclassname},
					{ text: 'Qty', datafield: 'qty', width: '8%',editable:false,cellclassname:cellclassname},
					{ text: 'Rate', datafield: 'rate', width: '8%',editable:false,cellclassname:cellclassname,cellsalign:'right',align:'right',cellsformat:'d2'},
					{ text: 'Weight', datafield: 'weight', width: '8%',editable:false,cellclassname:cellclassname},
					{ text: 'Price', datafield: 'price', width: '8%',editable:false,cellclassname:cellclassname,cellsalign:'right',align:'right',cellsformat:'d2'},
					{ text: 'DNO', datafield: 'dono', width: '8%',editable:false,cellclassname:cellclassname},
					{ text: 'DNO Date', datafield: 'dodate', width: '7%',editable:false,cellsformat:'dd.MM.yyyy',cellclassname:cellclassname },	
					{ text: 'Waste Type', datafield: 'wastetype',editable:false,cellclassname:cellclassname },
					{ text: 'Skip Size', datafield: 'skipsize', width: '12%',editable:false,cellclassname:cellclassname },     
					{ text: 'brhid', datafield: 'brhid', width: '23%',editable:false,hidden:true },   
					{ text: 'valid', datafield: 'valid', width: '23%',editable:false,hidden:true },
					{ text: 'valid1', datafield: 'valid1', width: '23%',editable:false,hidden:true },  
					]    
            });
       	 $("#overlay, #PleaseWait").hide();
            $("#jqxtippingGrid").jqxGrid('addrow', null, {});
      });
    </script>
    <div id="jqxtippingGrid"></div>    