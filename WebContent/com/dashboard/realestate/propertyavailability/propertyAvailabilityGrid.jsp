<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.realestate.propertyavailability.*"%>
<%   
	String branchid = request.getParameter("branchid")==null?"0":request.getParameter("branchid").trim();
	String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
	String relodestatus = request.getParameter("relodestatus")==null?"0":request.getParameter("relodestatus").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	ClsPropertyAvailabilityDAO DAO= new ClsPropertyAvailabilityDAO();
%>
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
    .yellowClass
    {
        background-color: #FFFFD1;
    }
    
     .orangeClass
    {
        background-color: #FFEBC2;
    }
    
</style>
<script type="text/javascript">
    
       var type='<%=id%>';
       var padata;
    	 
	  	if(type=='1'){ 
	  		padata='<%=DAO.getPropertyData(uptodate,relodestatus,id)%>';    
	  	} 
		else{
			padata;
	}

$(document).ready(function () {
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
             
                  
                     
                        {name : 'unit_number', type: 'String'  },
                        {name : 'unit_of', type: 'String'  },
                        {name : 'type', type: 'String'  },
                        {name : 'unit_type', type: 'String'  },
						{name : 'area', type: 'String'  },
						{name : 'landmark', type: 'String'  },
						{name : 'transaction_type', type: 'String'  },
						{name : 'owner_name', type: 'String'  },
						{name : 'availability_date', type: 'date'  },
						
						],
				    localdata: padata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
    	
		 if (data.isqty !=0) {
            return "yellowClass";
        }else{
        	return "orangeClass";
        };
    };

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    $("#pagrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    });
   
    
    $("#pagrid").jqxGrid(
    {
        width: '100%',
        height: 500,
        source: dataAdapter,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
       	selectionmode: 'singlerow',                 
       	showfilterrow: true,
        sortable:true,
                                
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%' ,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                    
               { text: 'Owner Name', datafield: 'owner_name',  width: '20%'},
               { text: 'Unit Number', datafield: 'unit_number',  width: '7%'  },
           	   { text: 'Unit Of', datafield: 'unit_of',  width: '10%'  }, 
           	   { text: 'Type', datafield: 'type',  width: '10%'  }, 
           	   { text: 'Unit Type', datafield: 'unit_type',  width: '10%'  }, 
           	   { text: 'Area', datafield: 'area',  width: '10%'  },   
           	   { text: 'Availability Date', datafield: 'availability_date',  width: '8%',cellsformat:'dd.MM.yyyy' },
	           { text: 'Nearest Land Mark', datafield: 'landmark',  width: '10%'  },
	           { text: 'Transaction Type', datafield: 'transaction_type',  width: '10%'  },
           	   
           
    ]		 
   
    });

    $("#overlay, #PleaseWait").hide();
});


</script>
<div id="pagrid"></div>