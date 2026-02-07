<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.inkit.assignmentlist.AssignmentListDAO" %>
<%AssignmentListDAO DAO=new AssignmentListDAO();%>

<% 
String chkfromdate = request.getParameter("chkfromdate")==null?"0":request.getParameter("chkfromdate").trim();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();  
String date =request.getParameter("date")==null?"0":request.getParameter("date").toString();
String branch =request.getParameter("barchval")==null?"0":request.getParameter("barchval").toString();
String clientid =request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
String area =request.getParameter("area")==null?"0":request.getParameter("area").toString();
String emp =request.getParameter("emp")==null?"0":request.getParameter("emp").toString();
int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id").toString());
%>
<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
<script type="text/javascript">
var data;
 
  data= '<%= DAO.serviceScheduleGridLoad(session,chkfromdate,fromdate,date,branch,clientid,area,id,emp) %>';  
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [

                	{name : 'dtype', type: 'String'},
					{name : 'refdocno', type: 'String'},
					{name : 'site', type: 'String'},
					{name : 'empgroup', type: 'String'},
					{name : 'emp', type: 'String'},
					{name : 'asgnmode', type: 'String'},
					{name : 'refname', type: 'String'},
					{name : 'sal_name', type: 'String'},
					{name : 'plannedon' , type : 'date'},
					{name : 'inactivedate' , type : 'date'},

					{name : 'pltime', type: 'String'},
					{name : 'description', type: 'String'},
					{name : 'empid', type: 'String'},
					{name : 'dbname', type: 'String'},
					{name : 'brhid', type: 'String'},
					{name : 'active', type: 'String'},

     						
                 ],
                 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
 		$("#jqxloaddataGrid").on("bindingcomplete", function (event) {
            	// your code here.
          
            });           
 
            var cellclassname = function (row, column, value, data) {
            	
       		 if (data.gridrow==1) {
                   return "orangeClass";
               };
               
               if(typeof(data.pldate) != "undefined" && typeof(data.pldate) != "NaN" && data.pldate != ""){
	               var currentdate= new Date(new Date());
	               var planneddate=(data.pldate).split("-");
	               
	               if (parseInt(planneddate[2])==parseInt(currentdate.getFullYear())){
		                if (parseInt(planneddate[1])==parseInt(currentdate.getMonth()+1)) { 
		                   return "yellowClass";
		                };
	           	   };
               }
           	   
            };
					
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99.5%',
                height: 500,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                filtermode:'excel',
				showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                enabletooltips:true,
                //Add row method
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
					{ text: 'DTYPE',columntype: 'textbox', datafield: 'dtype', width: '4%',cellclassname:cellclassname },
					{ text: 'DOC NO',columntype: 'textbox',  datafield: 'refdocno', width: '4%',cellclassname:cellclassname },
					{ text: 'SITE NAME',columntype: 'textbox', datafield: 'site', width: '8%',cellclassname:cellclassname },
					{ text: 'ASSIGN.GROUP',columntype: 'textbox', datafield: 'empgroup', width: '6%',cellclassname:cellclassname },
					{ text: 'EMPLOYEE',columntype: 'textbox', datafield: 'emp', width: '12%',cellclassname:cellclassname },
					{ text: 'ASSIGN.MODE',columntype: 'textbox', datafield: 'asgnmode', width: '5%',cellclassname:cellclassname },
					{ text: 'CLIENT NAME',columntype: 'textbox',  datafield: 'refname', width: '12%',cellclassname:cellclassname },
					{ text: 'SALESMAN',columntype: 'textbox',  datafield: 'sal_name', width: '7%',cellclassname:cellclassname,hidden:true },
					{ text: 'START DATE', datafield: 'plannedon', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname:cellclassname},
					{ text: 'PLANNED TIME', datafield: 'pltime', width: '5%' ,cellclassname:cellclassname},
					{ text: 'END DATE', datafield: 'inactivedate', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname:cellclassname},
					{ text: '',columntype: 'textbox', datafield: 'active', width: '6%',cellclassname:cellclassname },
					{ text: 'DESCRIPTION',  datafield: 'description' ,cellclassname:cellclassname},
		
	              ]
            });
            
            $("#overlay, #PleaseWait").hide();
        });
    </script>
<div id="jqxloaddataGrid"></div>