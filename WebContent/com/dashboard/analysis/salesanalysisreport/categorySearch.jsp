<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.salesanalysisreport.*"%>
<%ClsSalesAnalysisReport DAO= new ClsSalesAnalysisReport();%>
<script type="text/javascript">
$(document).ready(function () {
   var deptdata;
   deptdata='<%=DAO.catSearch(session)%>';
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'category',type:'String'},
                  		
                  		
                  		],
				    localdata: deptdata,
        
        
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
    
    
    $("#catSearch").jqxGrid(
    {
        width: '100%',
        height: 340,
        source: dataAdapter,
       
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'20%',hidden:true},
       				{ text:'Category',datafield:'category',width:'95.5%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btndept" ).click(function() {
    	
    	var rows = $("#catSearch").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="CATEGORY";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidcat").value="CATEGORY\n---------------------------";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\CATEGORY";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidcat").value+="\CATEGORY\n---------------------------";
        	}	
    	}
    	
		//document.getElementById("hideptid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#catSearch').jqxGrid('getcellvalue',rows[i],'category');
    		var docno=$('#catSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidcat").value+="\n"+dummy;
    		if(i==0){
    			//document.getElementById("hideptid").value+=docno;
    			
    			
    			
      			if(document.getElementById("hidcatid").value=="")
				{
			document.getElementById("hidcatid").value+=docno;
				}
			else
				{
				document.getElementById("hidcatid").value+=","+docno;
				}
    			
    			
    			
    		}
    		else{
    			document.getElementById("hidcatid").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#searchWindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#searchWindow').jqxWindow('close');
    	});
});

	
	 
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btndept" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="catSearch"></div>