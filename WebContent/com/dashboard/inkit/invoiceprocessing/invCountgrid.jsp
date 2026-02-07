<%@page import="com.dashboard.inkit.invoiceprocessing.ClsInvoiceProcessingDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsInvoiceProcessingDAO sd=new ClsInvoiceProcessingDAO(); %>


 <% String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();%>
 <% String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();%>
 <% String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();%>
 <% int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
 %>
 
<script type="text/javascript">
	
	 var invdata;
		 invdata= '<%=sd.invCountgrid(session, date, branch, clientid, id)%>';    
		 
$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	
     	if(typeof(value)=='undefined'){
     		value=0;
     	}
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
     }

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'count', type: 'string'  },
						{name : 'type', type: 'string'  },
						{name : 'typeid', type: 'string'  }
						],
				    localdata: invdata,
        
        
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
    
    
    $("#jqxInvCount").jqxGrid(
    {
        width: '100%',
        height: 120,
        source: dataAdapter,
        rowsheight:20,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 20,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: '', datafield: 'type', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'id', datafield: 'typeid', width: '30%',hidden:true},
					]
    
    });
   
    $('#jqxInvCount').on('rowdoubleclick', function (event) 
    		{ 
    	
    		    var rowindex = event.args.rowindex;
    		    
    		    var clientid=$('#clientid').val();
    			var date=$('#todate').val();
    			var barchval = document.getElementById("cmbbranch").value;
    		    var type=$('#jqxInvCount').jqxGrid('getcellvalue', rowindex, "typeid");
    		    
    		    $("#jqxpinvGrid").jqxGrid('clear');   
    		    $("#overlay, #PleaseWait").show();
    		 
	    		var id=1;
	    		$("#profinvdiv").load("invoiceprocessingGrid.jsp?barchval="+barchval+"&date="+date+"&clientid="+clientid+"&id="+id+"&type="+type);  
    		});  
});
$("#overlay, #PleaseWaitSub").hide();  
</script>
<div id="jqxInvCount"></div>