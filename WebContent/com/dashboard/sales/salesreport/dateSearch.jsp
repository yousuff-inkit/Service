<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.sales.salesreport.ClsSalesReportDAO" %>
<%ClsSalesReportDAO DAO= new ClsSalesReportDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String id=request.getParameter("id")==null?"0":request.getParameter("id");

%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 var id='<%=id%>';
$(document).ready(function () {
 
   var datedata;
   if(id==3){
   	datedata='<%=DAO.dateSearch(session,fromdate,todate)%>';
   }
   else{
	   datedata="";
   }
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'date',type:'string'},
                  		{name : 'passdate',type:'string'}
                  		
                  		
                  		],
				    localdata: datedata,
        
        
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
    
    
    $("#dateSearch").jqxGrid(
    {
        width: '100%',
        height: 340,
        source: dataAdapter,
       	filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       	sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,datafield: '',
					    columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
					    	cellsrenderer: function (row, column, value) {
					     	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
		  					}    
					},
       				{ text: 'Date',datafield:'date',width:'86%'},
       				{ text: 'Pass Date',datafield:'passdate',width:'0%',hidden:true}
					]

    });
    
    $( "#btndate" ).click(function() {
    	
    	var rows = $("#dateSearch").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="DATE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hiddate").value="DATE\n---------------------------";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nDATE";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hiddate").value+="\DATE\n---------------------------";
        	}	
    	}
    	
		//document.getElementById("hideptid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#dateSearch').jqxGrid('getcellvalue',rows[i],'date');
    		var passdate=$('#dateSearch').jqxGrid('getcellvalue',rows[i],'passdate');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hiddate").value+="\n"+dummy;
    		
    	 	if(i==0){
				if(document.getElementById("hidpassdate").value=="") {
					document.getElementById("hidpassdate").value+="'"+passdate+"'";
				} else{
					document.getElementById("hidpassdate").value+=",'"+passdate+"'";
				}
			} else{
				document.getElementById("hidpassdate").value+=",'"+passdate+"'";
			}
   			$('#searchWindow').jqxWindow('close');
    	}
    	});
    
     $("#btncancel" ).click(function() {
    	$('#searchWindow').jqxWindow('close');
    	});
});

	
	 
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btndate" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="dateSearch"></div>