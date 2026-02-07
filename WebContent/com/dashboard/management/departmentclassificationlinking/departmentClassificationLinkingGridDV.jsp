<%@page import="com.dashboard.management.departmentclassificationlinking.ClsDepartmentClassificationLinkingDAO"%>
 
 <%
 ClsDepartmentClassificationLinkingDAO cld = new ClsDepartmentClassificationLinkingDAO();
 String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
%>

<script type="text/javascript">
 var temp4='<%=barchval%>';
var rdatas;
var putdatasex;
 if(temp4!='NA')
{ 
	 rdatas='<%=cld.deptclassgrid()%>';		 
	 rdatasex='<%=cld.deptclassgridvd()%>';
		 
} 
else
{ 
	
	 rdatasex;
	
	}  
$(document).ready(function () {
		  var source =
    {
        datatype: "json",
        datafields:[    {name:'rowno', type:'int'},
                     	{name:'doc_no', type:'int'},
                     	{name:'name', type:'String'},
						{name : 'department', type: 'String'},
						{name:'deptid', type:'int'},
						{name:'description', type:'String'}
						],
				    localdata: rdatasex,
        
        
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
    
    
   
   
    
    $("#orderlistdetails").jqxGrid(
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
        selectionmode: 'checkbox',
        pagermode: 'default',
        sortable:true,
        columns: [   
                    { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '7%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                      {text:'rowno', dataield:'rowno',hidden:true},
					  {text: 'Department', datafield: 'department', width:'30%', hidden:false},
					  { text: 'Name', datafield: 'name', width: '30%' },					  
					  {text:'doc_no', datafield:'doc_no', hidden:true},
					  {text:'deptid', datafield:'deptid',hidden:true},
					  {text:'Description', datafield:'description', hidden:false, width: '30%'}
					]
   
    });
    $("#overlay, #PleaseWait").hide();
    
    var rows=$("#orderlistdetails").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#orderlistdetails").jqxGrid("addrow", null, {});	
    }
});


</script>
<div id="orderlistdetails"></div>