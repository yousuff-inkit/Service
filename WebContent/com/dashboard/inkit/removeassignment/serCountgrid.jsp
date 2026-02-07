<%@page import="com.dashboard.inkit.removeassignment.RemoveAssignmentDAO" %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%RemoveAssignmentDAO DAO=new RemoveAssignmentDAO();%>
<% 
String chkfromdate = request.getParameter("chkfromdate")==null?"0":request.getParameter("chkfromdate").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();  
String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();
int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
%>
 
<script type="text/javascript">

var schedata='<%=DAO.serCountgrid(session,chkfromdate,fromdate,date,branch,clientid,area,id)%>'; 

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
                    
                 	{name : 'dtype', type: 'string'  },
					{name : 'count', type: 'string'  }
						
						],
				    localdata: schedata,
        
        
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
    
    
    $("#jqxSerCount").jqxGrid(
    {
        width: '100%',
        height: 88,
        source: dataAdapter,
        rowsheight:15,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 17,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: '', datafield: 'dtype', width: '70%' ,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
						{ text: 'Count', datafield: 'count', width: '30%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
					]
    
    });
   
    $('#jqxSerCount').on('rowdoubleclick', function (event) { 
    	var rowindex = event.args.rowindex;

    	var date=$('#todate').val();
    	var barchval = document.getElementById("cmbbranch").value;
    	var clientid=$('#clientid').val();
    	var area=document.getElementById("txtareaid").value;
    	var dtype=$('#jqxSerCount').jqxGrid('getcellvalue', rowindex, "dtype");
    	var id=1;
    	
    	$("#overlay, #PleaseWait").show();
    	
    	$("#serschedulediv").load("serScheduleDetails.jsp?date="+date+"&barchval="+barchval+"&clientid="+clientid+"&area="+area+"&dtype="+dtype+"&id="+id+"&chkfromdate="+'<%=chkfromdate%>'+"&fromdate="+'<%=fromdate%>');
    				
    });
});

function toDate(dateStr) {
    var parts = dateStr.split("-");
    return new Date(parts[2], parts[1] - 1, parts[0]);
}
	
</script>
<div id="jqxSerCount"></div>