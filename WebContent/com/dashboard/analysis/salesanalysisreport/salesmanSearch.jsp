<%@page import="com.dashboard.analysis.salesanalysisreport.*"%>
<%
ClsSalesAnalysisReport DAO= new ClsSalesAnalysisReport();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>

<script type="text/javascript">
 
var id='<%=id%>';
var data3;
 if(id=='1'){
data3='<%=DAO.salesManSearch()%>';
} 

$(document).ready(function () {
   
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		
                  		{name : 'sal_name',type:'string'}
                  	
				
                  		],
				    localdata: data3,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#salesmanSearch").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#salesmanSearch").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
       columnsresize: true,
       
        columns: [
         
       				{ text: 'Doc No',datafield:'doc_no',width:'20%'},
       				
       				{ text: 'Salesman Name',datafield:'sal_name',width:'76%'}
       				
       				]
    });
    
    $( "#btnok_slm" ).click(function() {
    	var rows = $("#salesmanSearch").jqxGrid('selectedrowindexes');
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="SALESMAN\n---------------------------";	
        		document.getElementById("salesman").value="SALESMAN\n---------------------------";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\nSALESMAN\n---------------------------";
        		document.getElementById("salesman").value+="SALESMAN\n---------------------------";
        	}	
    	}
    	document.getElementById("hidsalesman").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#salesmanSearch').jqxGrid('getcellvalue',rows[i],'sal_name');
    		var docno=$('#salesmanSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("salesman").value+="\n"+dummy;
    		if(i==0){
    			document.getElementById("hidsalesman").value=docno;
    		}
    		else{
    			document.getElementById("hidsalesman").value+=","+docno;
    		}
    	}
    	$('#searchWindow').jqxWindow('close');
    	});
    
    $( "#btncancel_slm" ).click(function() {
    	$('#searchWindow').jqxWindow('close');
    });
    	 
     
  
    });

	
	
</script>
<div align="center" style="padding-bottom:4px;">
	<button type="button" id="btnok_slm" name="btnok" class="myButton">OK</button>
	&nbsp;&nbsp;
	<button type="button" id="btncancel_slm" name="btncancel" class="myButton">Cancel</button>
</div>
<div id="salesmanSearch"></div>