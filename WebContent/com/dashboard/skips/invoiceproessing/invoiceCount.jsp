<%@page import="com.dashboard.skips.invoiceproessing.*" %>
<%ClsInvoiceProcessingDAO dao=new ClsInvoiceProcessingDAO();%>  
<%  
String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();
String brhid =request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String id =request.getParameter("id")==null?"":request.getParameter("id").toString();
String cldocno =request.getParameter("cldocno")==null?"":request.getParameter("cldocno").toString();  
%>

 <script type="text/javascript">
 var brhid='<%=brhid%>';  
 var todate='<%=todate%>';
 var cldocno='<%=cldocno%>';  
 var  cdata='<%=dao.countData(todate, brhid, id, cldocno)%>';      
 
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                			{name : 'name', type: 'String'  },
	                    	{name : 'count', type: 'number'  },       
	                    	{name : 'val', type: 'number'  },       
                 ],
                 localdata: cdata,
                
                
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
            $("#jqxCountGrid").jqxGrid(   
            {
                width: '100%',
                height: 200,  
                source: dataAdapter,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow', 
                filterable: true,
                filtermode:'excel',
                //showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,   
                sortable: true,
                //Add row method
                columns: [
                      { text: 'Name', datafield: 'name' },   
                  	  { text: 'Count', datafield: 'count', width: '30%' },	
                  	  { text: 'val', datafield: 'val', width: '5%',hidden:true },	     
	              ]
            }); 
           $('#overlay,#PleaseWait').hide();
           $('#jqxCountGrid').on('rowdoubleclick', function (event) { 
        	   	  var rowindex1=event.args.rowindex;
        	   	  $('#overlay,#PleaseWait').show();
        	   	  var val=$('#jqxCountGrid').jqxGrid('getcellvalue', rowindex1, "val"); 
        	   	  if(val=="3" || val=="4" || val=="5" || val=="6"){    
        	   		document.getElementById("servchargechk").disabled = false;
        	   		document.getElementById("tfeechk").disabled = false;
        	   		document.getElementById("gfeechk").disabled = false;  
        	   	  }else{
        	   		document.getElementById("servchargechk").disabled = true;
        	   		document.getElementById("tfeechk").disabled = true;
        	   		document.getElementById("gfeechk").disabled = true;  
        	   	  }
        	   	  document.getElementById("type").value=$('#jqxCountGrid').jqxGrid('getcellvalue', rowindex1, "val");   
        	   	  $("#invdiv").load("invoiceGrid.jsp?type="+val+"&todate="+todate+"&brhid="+brhid+"&cldocno="+cldocno+"&id="+1);          
           });   
        });
    </script>
    <div id="jqxCountGrid"></div>  