<%@page import="com.common.ClsAttach"%>
<script type="text/javascript">
<% 
ClsAttach ClsAttach=new ClsAttach();
String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); 
System.out.println("formCode===="+request.getParameter("formCode"));%>

$(document).ready(function(){
	$("#jqxDateFrom").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#hidjqxDateFrom").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#jqxDateTo").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#hidjqxDateTo").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	 var data5;
	<%-- var data5='<%=ClsAttach.commGridload(docNo,request.getParameter("formCode"))%>'; --%>
	
	Check(data5);
		});	

function Check(data5){
	   
	
	  var source =
      {
          datatype: "json",
          datafields: [
					{name : 'date', type: 'date'  },
						{name : 'user', type: 'string'  },
						{name : 'description', type: 'string'},
						{name : 'remarks', type: 'string'},
						 {name : 'type', type: 'string' },
						 /* {name : 'addressed', type: 'string' }, */
						 {name : 'trade', type: 'string' },
						 /* {name : 'tradeid', type: 'int' }, */
						 {name : 'validfrm', type: 'date' },
						 {name : 'validto', type: 'date' },
						 {name : 'cername', type: 'string' },
						 {name : 'extn', type: 'string' },
						 {name : 'path', type: 'string' }
						     						
           ],
           localdata: data5, 
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
    
            $("#jqxCommunicationDetails").jqxGrid(
            {
                width: '95%',
                height: 180,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlerow',
                    
              //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxCommunicationDetails').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxCommunicationDetails').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'addressed' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {               
                            var commit = $("#jqxCommunicationDetails").jqxGrid('addrow', null, {});
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
							{ text: 'Description', datafield: 'description', width: '25%', editable: false,hidden:true },
							{ text: 'Remarks', datafield: 'remarks', width: '25%', editable: false },
							{ text: 'Type', datafield: 'type', width: '10%', editable: false },
							/* { text: 'Addressed', datafield: 'addressed', width: '10%' }, */
							{ text: 'Trade', datafield: 'trade', width: '15%', editable: false },
							/* { text: 'TradeId', datafield: 'tradeid', width: '15%',hidden:true }, */
							{ text: 'Valid From ', datafield: 'validfrm',  columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '13%', editable: false },
							{ text: 'Valid To', datafield: 'validto',  columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '13%', editable: false },
							{ text: 'Certificate Name', datafield: 'cername', width: '20%', editable: false },
							{ text: 'Extension', datafield: 'extn', width: '10%', editable: false },
							{ text: 'Path', datafield: 'path', width: '10%', editable: false,hidden:true }
						]
            });

            $('#jqxCommunicationDetails').on('rowdoubleclick', function (event) 
            		{ 
			
              	var crowindexes=event.args.rowindex;
		//alert($('#jqxCommunicationDetails').jqxGrid('getcellvalue', crowindexes, "path"));
		//alert($('#jqxCommunicationDetails').jqxGrid('getcellvalue', crowindexes, "cername"));
              	SaveToDisk($('#jqxCommunicationDetails').jqxGrid('getcellvalue', crowindexes, "path"),$('#jqxCommunicationDetails').jqxGrid('getcellvalue', crowindexes, "cername"));
            		});
            $('#jqxCommunicationDetails').on('rowclick', function (event) 
            		{
            	
              	var crrowindexes=event.args.rowindex;
              	//alert("rowclick"+$('#jqxCommunicationDetails').jqxGrid('getcellvalue', crrowindexes, "cername"));
              	document.getElementById("filename").value=$('#jqxCommunicationDetails').jqxGrid('getcellvalue', crrowindexes, "cername");
            		});
        };
    </script>
    <div id="jqxCommunicationDetails"></div>
    <input type="hidden" id="rowindex"/>