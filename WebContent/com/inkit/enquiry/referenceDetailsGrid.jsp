<%@page import="com.common.ClsAttach"%>
<%ClsAttach ClsAttach=new ClsAttach();  %>
<script type="text/javascript">
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
System.out.println("formCode===="+request.getParameter("formCode"));%>

$(document).ready(function(){
	var data4='<%=ClsAttach.reGridload(docNo,request.getParameter("formCode"))%>';
	
	Check(data4);
		});	

function Check(data4){
	   
	
	  var source =
      {
          datatype: "json",
          datafields: [
					{name : 'date', type: 'date'  },
						{name : 'user', type: 'string'  },
						{name : 'description', type: 'string'    },
						{name : 'remarks', type: 'string'    },
						 {name : 'type', type: 'string'    },
						 {name : 'addressed', type: 'string'    },
						 {name : 'path', type: 'string'    },
						 {name : 'filename', type: 'string'    },
						     						
           ],
           localdata: data4, 
          pager: function (pagenum, pagesize, oldpagenum) {
              // callback called when a page or page size is changed.
          }
      };
      
      var dataAdapter = new $.jqx.dataAdapter(source,
      		 {
          		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
           
            
            $("#jqxReferenceDetails").jqxGrid(
            {
                width: '95%',
                height: 180,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
              //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxReferenceDetails').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxReferenceDetails').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'addressed' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxReferenceDetails").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                
                columns: [
							{  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							   groupable: false, draggable: false, resizable: false,datafield: '',
							   columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							   }  
							},  
							{ text: 'Date', datafield: 'date',  columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '10%', editable: false },
							{ text: 'User', datafield: 'user', width: '15%', editable: false },
							{ text: 'Description', datafield: 'description', width: '25%', editable: false },
							{ text: 'Remarks', datafield: 'remarks', width: '25%', editable: false },
							{ text: 'Type', datafield: 'type', width: '10%', editable: false },
							{ text: 'Addressed', datafield: 'addressed', width: '10%', editable: false },
							{ text: 'Path', datafield: 'path', width: '10%', editable: false, hidden: true },
							{ text: 'FileName', datafield: 'filename', width: '10%', editable: false, hidden: true },
						]
            });
            //$("#jqxReferenceDetails").jqxGrid('addrow', null, {});
            $('#jqxReferenceDetails').on('rowdoubleclick', function (event) 
            		{ 
              	var rowindexes=event.args.rowindex;
              	SaveToDisk($('#jqxReferenceDetails').jqxGrid('getcellvalue', rowindexes, "path"),$('#jqxReferenceDetails').jqxGrid('getcellvalue', rowindexes, "filename"));
            		});
            $('#jqxReferenceDetails').on('rowclick', function (event) 
            		{
            	
              	var rowindexes=event.args.rowindex;
              	//alert("rowclick"+$('#jqxReferenceDetails').jqxGrid('getcellvalue', rowindexes, "filename"));
              	document.getElementById("filename").value=$('#jqxReferenceDetails').jqxGrid('getcellvalue', rowindexes, "filename");
            		});
        };
   	
    </script>
    <div id="jqxReferenceDetails"></div>
    <input type="hidden" id="rowindex"/>