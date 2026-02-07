<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.analysis.salesanalysisreport.*"%>
<%ClsSalesAnalysisReport DAO= new ClsSalesAnalysisReport();%>
<script type="text/javascript">
$(document).ready(function () {
   var deptdata;
   deptdata='<%=DAO.cdtSearch(session)%>';
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'name',type:'String'},
                  		
                  		
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
    
    
    $("#cdtSearch").jqxGrid(
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
       				{ text:'Client',datafield:'name',width:'95.5%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btncredit" ).click(function() {
    	
    	var rows = $("#cdtSearch").jqxGrid('selectedrowindexes');
   
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value="CREDIT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hicredit").value="CREDIT\n---------------------------";
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\CREDIT";
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hicredit").value+="\CREDIT\n---------------------------";
        	}	
    	}
    	
		//document.getElementById("hideptid").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#cdtSearch').jqxGrid('getcellvalue',rows[i],'name');
    		var docno=$('#cdtSearch').jqxGrid('getcellvalue',rows[i],'doc_no');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hicredit").value+="\n"+dummy;
    		if(i==0){
    			//document.getElementById("hideptid").value+=docno;
    			
    			
    			
      			if(document.getElementById("hicreditid").value=="")
				{
			document.getElementById("hicreditid").value+=docno;
				}
			else
				{
				document.getElementById("hicreditid").value+=","+docno;
				}
    			
    			
    			
    		}
    		else{
    			document.getElementById("hicreditid").value+=","+docno;
    		}
    	}
   	
    	
    	
    	$('#searchWindow').jqxWindow('close');
    	});
    
     $("#btncancel" ).click(function() {
    	$('#searchWindow').jqxWindow('close');
    	});
});

	
	 
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btncredit" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="cdtSearch"></div>