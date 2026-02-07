<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%         
	String contextPath=request.getContextPath();
%>
<%@page import="com.dashboard.realestate.propertymanagement.ClsPropertyManagementDAO"%>
<%
	ClsPropertyManagementDAO DAO= new ClsPropertyManagementDAO();  
%>
<% 
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();
String id=request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").toString();
%>
<style type="text/css">   
    .redClass
    {
        background-color: #FFA28E;
    }
</style>
<script type="text/javascript">              
	var spltdata;	  	 
	spltdata='<%=DAO.loadsplitGrid(id,docno)%>';                              
     
      $(document).ready(function () {
          // prepare the data
          var source =
          {
              datatype: "json",  
              datafields: [
                        {name : 'srno', type: 'string'  },
						{name : 'rowno', type: 'string'  },
						{name : 'name', type: 'string'  },
						{name : 'remarks', type: 'string'  },
						{name : 'status', type: 'number'  },
                      ],
                       localdata: spltdata,     
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          cellclassname = function (row, column, value, data) {
         	 if (data.status ==7) {
         	       return "redClass";
         	   }
          };
          var dataAdapter = new $.jqx.dataAdapter(source);
          $("#jqxsplitGrid").jqxGrid(    
          {
              width: '100%',  
              height: 210,
              source: dataAdapter,
              altRows:true,
              columnsresize:true,
              enabletooltips:true,
              editable:true,   
              selectionmode: 'singlecell', 
              handlekeyboardnavigation: function (event) {
            	    //var rows=$('#jqxsplitGrid').jqxGrid('getrows');
                    var cell = $('#jqxsplitGrid').jqxGrid('getselectedcell');
    				if (cell != undefined && cell.datafield == 'remarks' ) {    
                      var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                      if (key == 13 || key == 9) {
	                      	$("#jqxsplitGrid").jqxGrid('addrow', null, {});	 
	                      	//$("#jqxsplitGrid").jqxGrid('begincelledit', rows.length+1, "name");   
                      	    return true;
                      }     
                  }
              }, 
              columns: [  
					{ text: 'SL#', sortable: false, filterable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',cellclassname:cellclassname,
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>"; 
					}  
					},
					{ text: 'Name', datafield: 'name', width: '27%',cellclassname:cellclassname}, 
					{ text: 'Remarks', datafield: 'remarks',cellclassname:cellclassname},          
					{ text: 'rowno', datafield: 'rowno',hidden:true,width:'5%'},  
					{ text: 'srno', datafield: 'srno',hidden:true,width:'5%'}, 
					{ text: 'status', datafield: 'status',hidden:true,width:'5%'},            
				], 
          });  
          $("#overlay, #PleaseWait").hide();
          $("#jqxsplitGrid").jqxGrid('addrow', null, {});
        	$("#jqxsplitGrid").on('cellendedit', function (event) {    
        	    var args = event.args;
        	    var columnDataField = event.args.datafield;
        	    var rowIndex = event.args.rowindex;
        	    var cellValue = event.args.value;
        	    var oldValue = event.args.oldvalue;         
        	    if(columnDataField=="remarks"){            
        	    	$('#jqxsplitGrid').jqxGrid('setcellvalue', rowIndex, "remarks",cellValue);        
        	    }
        	});
        	$("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#jqxsplitGrid").on('contextmenu', function () {
                   return false;
               });
                   
               $("#Menu2").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#jqxsplitGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       editrow = rowindex;
                       var offset = $("#jqxsplitGrid").offset();
                       $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                       // get the clicked row's data and initialize the input fields.
                       var dataRecord = $("#jqxsplitGrid").jqxGrid('getrowdata', editrow);
                       // show the popup window.
                       $("#popupWindow2").jqxWindow('show');
                   }else {
                       var rowid = $("#jqxsplitGrid").jqxGrid('getrowid', rowindex);
                       var rowno=$('#jqxsplitGrid').jqxGrid('getcellvalue', rowid, "rowno");
                       if(typeof(rowno) != "undefined" && typeof(rowno) != "NaN" && rowno != ""){ 
                     	  funDelete(rowno);    
                       }else{
                    	   $("#jqxsplitGrid").jqxGrid('deleterow', rowid);        
                       }
                       
                   }
               });
               
               $("#jqxsplitGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
                       $("#jqxsplitGrid").jqxGrid('selectrow', event.args.rowindex);
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   
        		   }
               });   
      });
</script>      
<div id='jqxWidget'>
   <div id="jqxsplitGrid"></div>   
     <div id="popupWindow2">
        <div id='Menu2'>
	        <ul>
	            <li>Delete Selected Row</li>  
	        </ul>
       </div>
     </div>
</div>      