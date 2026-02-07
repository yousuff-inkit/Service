<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<script type="text/javascript">
        var data1;
        $(document).ready(function () { 	
        	
        	 <%-- if(temp>0)
           	 {     
            	  data='<%=com.dashboard.ClsDashBoardDAO.detailSearch(docNo)%>';   
           	 }
             else 
           	 {
            	 data='<%=com.dashboard.ClsDashBoardDAO.detail()%>';
           	 }   --%>
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'date', type: 'date' },
							{name : 'user', type: 'string' },
							{name : 'trade', type: 'string' },
							{name : 'tradeid', type: 'int' },
							{name : 'validfrm', type: 'date' },
							{name : 'validto', type: 'date' },
							{name : 'cername', type: 'string' },
							{name : 'remarks', type: 'string' },
							{name : 'extn', type: 'string' }
                        ],
                		    localdata: data1, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxCerAttachGrid").jqxGrid(
            {
                width: '100%',
                height: 112,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
              //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxCerAttachGrid').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxCerAttachGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'addressed' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxCerAttachGrid").jqxGrid('addrow', null, {});
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
							{ text: 'Date', datafield: 'date',  columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '13%' },
							{ text: 'User', datafield: 'user', width: '15%' },
							{ text: 'Trade', datafield: 'trade', width: '15%' },
							{ text: 'TradeId', datafield: 'tradeid', width: '15%',hidden:true },
							{ text: 'Valid From ', datafield: 'validfrm',  columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '13%' },
							{ text: 'Valid To', datafield: 'validto',  columntype: 'datetimeinput', cellsformat: 'dd.MM.yyyy' , width: '13%' },
							{ text: 'Certificate Name', datafield: 'cername', width: '20%' },
							{ text: 'Remarks', datafield: 'remarks', width: '10%' },
							{ text: 'Extension', datafield: 'extn', width: '10%' },
						]
            });
            $("#jqxCerAttachGrid").jqxGrid('addrow', null, {});
        });
    </script>
    <div id="jqxCerAttachGrid"></div>
    <input type="hidden" id="rowindex"/>