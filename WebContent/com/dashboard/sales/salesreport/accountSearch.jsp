<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.sales.salesreport.ClsSalesReportDAO" %>
<%ClsSalesReportDAO DAO= new ClsSalesReportDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");

%>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 var id='<%=id%>';
$(document).ready(function () {
 
   var datedata;
   if(id==4){
   	datedata='<%=DAO.accSearch(session)%>';
   }
   else{
	   datedata="";
   }
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'string'},
                  		{name : 'account',type:'string'},
                  		{name : 'description',type:'string'}
                  		
                  		
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
    
    
    $("#accSearch").jqxGrid(
    {
        width: '100%',
        height: 340,
        source: dataAdapter,
       	filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        selectionmode: 'checkbox',
       	sortable:false,
        columns: [
               
       				{ text: 'Account No.',datafield:'account',width:'20%'},
       				{ text: 'Account Name',datafield:'description',width:'76%'},
       				{ text: 'ACC No.',datafield:'doc_no',width:'86%'}
					]

    });
    
    $( "#btnacc" ).click(function() {
    	
    	var rows = $("#accSearch").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="ACCOUNT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("accno").value="ACCOUNT\n---------------------------";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\ACCOUNT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("accno").value+="\ACCOUNT\n---------------------------";
        	}	
    	}
    	
		//document.getElementById("hideptid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#accSearch').jqxGrid('getcellvalue',rows[i],'account');
    		var docno=$('#accSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("accno").value+="\n"+dummy;
    		if(i==0){
    			if(document.getElementById("hidaccno").value==""){
					document.getElementById("hidaccno").value+=docno;
				}
				else{
					document.getElementById("hidaccno").value+=","+docno;
				}
    		}
    		else{
    			document.getElementById("hidaccno").value+=","+docno;
    		}
    	}
   		
    	
    	$('#searchWindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#searchWindow').jqxWindow('close');
    	});
});

	
	 
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnacc" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="accSearch"></div>