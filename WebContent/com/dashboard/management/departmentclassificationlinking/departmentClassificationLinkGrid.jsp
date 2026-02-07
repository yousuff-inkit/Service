 <%@page import="com.dashboard.management.departmentclassificationlinking.ClsDepartmentClassificationLinkingDAO"%>
 
 <%
 ClsDepartmentClassificationLinkingDAO cld = new ClsDepartmentClassificationLinkingDAO();

 String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	
 %> 
       
 
<script type="text/javascript">
var temp4='<%=barchval%>';
var rdatas;
var rdatasex;
 if(temp4!='NA')
{ 
    rdatas='<%=cld.deptclassgrid()%>';		 
    rdatasex='<%=cld.deptclassgridvd()%>';	
    
} 
else
{ 
	
	rdatas;
	
	}  

$(document).ready(function () {

    var source =
    {
        datatype: "json",
        datafields: [   
                     	{name:'mid', type:'int'},
                     	{name:'name', type:'String'},
						{name : 'department', type: 'String'  },
						{name:'description', type:'String'}
						],
				    localdata: rdatas,
        
        
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
    
    
   
   
    
    $("#orderlist").jqxGrid(
    {
        width:'100%',
        height: 460,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filterable: true,
        showfilterrow: true,
        enabletooltips: true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
        sortable:true,
        columns: [   
                    { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '8%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                      {text:'docno', datafield:'mid',width:'10%', hidden:true},
					  { text: 'Name', datafield: 'name', width: '49%' },					  
					  {text: 'Department', datafield: 'department', width:'40%', hidden:true},
					  {text:'Description', datafield: 'description', width:'40%'}
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    var rows=$("#orderlist").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#orderlist").jqxGrid("addrow", null, {});	
    }
});


</script>
<div id="orderlist"></div>