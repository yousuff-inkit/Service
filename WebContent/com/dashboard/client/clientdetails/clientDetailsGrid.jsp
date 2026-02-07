 <%@page import="com.dashboard.client.clientdetails.ClsClientDetailsDAO"%>
<%ClsClientDetailsDAO logdao=new ClsClientDetailsDAO();%>
 
 <%
 	String branch=request.getParameter("branch")==null?"":request.getParameter("branch").trim();
 	String id=request.getParameter("id")==null?"":request.getParameter("id").trim();
 	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
 	String todate=request.getParameter("todate")==null?"":request.getParameter("todate").trim();
    String hidform=request.getParameter("hidform")==null?"":request.getParameter("hidform").trim();
 	String hiduser=request.getParameter("hiduser")==null?"":request.getParameter("hiduser").trim();
 	%> 
           	  
 <style>
 
 .addClass
        {
            background-color: #FFEBEB;
        }
 .editClass
	{
    background-color: #FFFFD1;
	}
 .deleteClass
	{
   background-color: #FFFAFA;
	}
 </style>
<script type="text/javascript">
 var temp4='<%=branch%>';
var data;
var exceldata;
var bb;
if(temp4!='')
{ 
	 data='<%=logdao.getClientDetails(branch,id)%>';
	 bb=0;
	
	<%-- exceldata='<%=logdao.getLogExcelData(branch, fromdate, todate, id, hiduser, hidform)%>'; --%> 
}
else
{
	 bb=1;
	data;
	} 
$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
       
                  		
						{name : 'doc_no', type: 'string'  },
						{name : 'ipdetails', type: 'string'  },
						{name : 'clientname', type: 'string'  },
						{name : 'username', type: 'string'  },
						{name : 'pwd', type: 'string'  },
						{name : 'remarks', type: 'string'  },
						{name : 'addbtn', type: 'string'  },
						{name : 'dtlsdate', type: 'date'  }
						
						
						],
				    localdata: data,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    /* $("#datalogGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        

    
	var cellclassname = function (row, column, value, data) {
		if (data.action=='Add') {
            return "addClass";
        } else if (data.action=='Edit') {
            return "editClass";
        }
        else if (data.action=='Delete') {
            return "deleteClass";
        }
        else{
        
        };
    }; */
    
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
       
    $("#clientGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        sortable:true,
        editable: true,
        enabletooltips:true,
        selectionmode: 'singlecell',
       // pagermode: 'default',
       
        columns: [
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
    						groupable: false, draggable: false, resizable: false,datafield: '',
    						columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
    						cellsrenderer: function (row, column, value) {
     							return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
  								}    
					},
					
					{ text: 'Doc No', datafield: 'doc_no', width: '10%', hidden: true},
					{ text: 'Date', datafield: 'dtlsdate', width: '10%',cellsformat:'dd.MM.yyyy',hidden: true},
					{ text: 'Client Name', datafield: 'clientname', width: '20%', editable: true},
					{ text: 'IP/Connection', datafield: 'ipdetails', width: '15%', editable: true},
					{ text: 'User Name', datafield: 'username', width: '15%', editable: true},
					{ text: 'Password', datafield: 'pwd', width: '15%', editable: true},
					{ text: 'Remarks', datafield: 'remarks', width: '25%', editable: true},
					{ text: '', datafield: 'addbtn', width: '5%', columntype: "button"}
					/* { text: 'Staff Type', datafield: 'renttype', width: '5%' ,cellclassname: cellclassname },
					{ text: 'Idle days', datafield: 'idealdys', width: '10%' ,cellsalign: 'right', align:'right',cellclassname: 'advanceClass'}, */
											
						]
    
    });
    $("#overlay, #PleaseWait").hide();
    $("#clientGrid").jqxGrid('addrow', null, {}); 
   
    $('#clientGrid').on('cellclick', function (event) 
    		{ 
    	 var datafield = event.args.datafield;
    	 if(datafield=="addbtn"){
    		 $("#clientGrid").jqxGrid('addrow', null, {}); 
    	 }
    		});
    $('#clientGrid').on('celldoubleclick', function (event) 
    		{ 
    	
    	
    		
    		    var boundIndex = event.args.rowindex;
    		    
    		    
    		   
    		});
    


    
});

	
	
</script>
<div id="clientGrid"></div>