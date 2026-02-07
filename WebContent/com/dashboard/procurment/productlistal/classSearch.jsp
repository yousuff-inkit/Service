<%@page import="com.dashboard.procurment.productlistal.ClsProductListAlDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%ClsProductListAlDAO DAO= new ClsProductListAlDAO();%>
<%String id=request.getParameter("id")==null?"0":request.getParameter("id");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=id%>';
   var cdata='<%=DAO.getClassificationGrid(session,id)%>';
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'docno',type:'number'},
                  		{name : 'description',type:'String'},
                  		
                  		
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
    
    
    $("#classSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'docno',width:'20%'},
       				{ text:'Classification',datafield:'description',width:'75%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */
					]

    });
    
    $( "#btnclass" ).click(function() {
    	
    	var textselect = $("#prodsearchby option[value='" + $("#prodsearchby").val() + "']").text()
    	var rows = $("#classSearch").jqxGrid('selectedrowindexes');
    		/* alert("id one"); */
    	if(rows!=""){
    		if(document.getElementById("searchdetails").value==""){
        		document.getElementById("searchdetails").value=textselect;
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidclassification").value=textselect;
        	}
        	else{
        		document.getElementById("searchdetails").value+="\n\n"+textselect;
        		document.getElementById("searchdetails").value+="\n---------------------------";
        		document.getElementById("hidclassification").value+="\n"+textselect;
        	}	
    	}
    	
		document.getElementById("hidclassification").value="";
    	
    	for(var i=0;i<rows.length;i++){
    		var dummy=$('#classSearch').jqxGrid('getcellvalue',rows[i],'description');
    		var docno=$('#classSearch').jqxGrid('getcellvalue',rows[i],'docno');
    		document.getElementById("searchdetails").value+="\n"+dummy;
    		document.getElementById("hidclassification").value+="\n"+dummy;
    		
    		document.getElementById("hidclassificationid").value=document.getElementById("hidclassificationid").value===""?docno:(document.getElementById("hidclassificationid").value+","+docno);
    		}
    	
    	$('#classwindow').jqxWindow('close');
    	});
    
    $( "#btncancel" ).click(function() {
    	$('#classwindow').jqxWindow('close');
    	});
});

	
	
</script>
<div align="center" style="padding-bottom:4px;"><button type="button" id="btnclass" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div>
<div id="classSearch"></div>