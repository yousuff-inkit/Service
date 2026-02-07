<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<% ClsEnquiryDAO DAO=new ClsEnquiryDAO();
   String enqdocno =request.getParameter("enq_id")==null?"0":request.getParameter("enq_id").trim();%>
<script type="text/javascript">
        
        var fpdata;
        var enqdocno='<%=enqdocno%>'; 
        
        $(document).ready(function () { 	
        	
        	if(enqdocno>0) {     
        		  fpdata='<%=DAO.inspGridLoad (enqdocno)%>';   
           	}
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'inspname', type: 'string' },
							{name : 'priority', type: 'number' },
							{name : 'insp_id', type: 'int' }
                        ],
                		    localdata: fpdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxFieldPersonDetails").jqxGrid(
            {
            	width: '95%',
                height: 80,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                    
				handlekeyboardnavigation: function (event) {
                	
                    //Search Pop-Up
                    var cell1 = $('#jqxFieldPersonDetails').jqxGrid('getselectedcell');
                    if (cell1 != undefined && cell1.datafield == 'inspname') {
                    	var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                    	if (key == 114) { 
                    		var rowindexestemp =cell1.rowindex;
                        	$('#rowindexes').val(rowindexestemp);
                        	getinsp();
                        	$('#jqxFieldPersonDetails').jqxGrid('render');
                          }
                    }
                },
                
                columns: [
							{  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							   groupable: false, draggable: false, resizable: false,datafield: '',
							   columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							   }  
							},  
							{ text: 'Inspector', datafield: 'inspname', width: '70%', editable: false },
							{ text: 'Priority', datafield: 'priority', width: '20%',cellsformat:'d' },
							//{ text: 'Available Date', datafield: 'avldate', width: '40%', editable: false },
							{ text: 'Inspector Id', datafield: 'insp_id', width: '10%', editable: false, hidden: true }
						]
            });
            
           /*  if(document.getElementById("mode").value=='view')
			{
			$('#jqxFieldPersonDetails').jqxGrid({ disabled: true});
			} */
			
			$("#jqxFieldPersonDetails").jqxGrid('addrow', null, {});
			
			$('#jqxFieldPersonDetails').on('celldoubleclick', function (event) {
	           	  if(event.args.columnindex == 1) {
	           			var rowindextemp = event.args.rowindex;
	           			document.getElementById("rowindexes").value = rowindextemp;
	           			getinsp();
	              } 
	          });
			
			$("#jqxFieldPersonDetails").on('cellvaluechanged', function (event) {
	         	   var rowindexestemp = event.args.rowindex;
	         	   $('#rowindexes').val(rowindexestemp);
	            });
			
        });
    </script>
    <div id="jqxFieldPersonDetails"></div>
    <input type="hidden" id="rowindexes"/>