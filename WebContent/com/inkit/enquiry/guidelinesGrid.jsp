<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<% ClsEnquiryDAO ClsEnquiryDAO=new ClsEnquiryDAO();
   String estatusid =request.getParameter("estatusid")==null?"0":request.getParameter("estatusid").trim();%>

<style type="text/css">
        .redClass
        {
            color: red;
            background-color: #FFEBEB;
        }
        .greenClass
        {
            background-color: #B2F0B2;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .greyClass
        {
           background-color: #F6F2FF;
        }
   </style>
<script type="text/javascript">

		var frmdetailcd;
		frmdetailcd='<%=estatusid%>';
        var gldata;
        $(document).ready(function () { 	
        	    
        	gldata='<%=ClsEnquiryDAO.guidlineGridLoad(estatusid) %>';   
           	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'description', type: 'string' },
							{name : 'status_id', type: 'int' },
							{name : 'flag', type: 'int' }
                        ],
                		    localdata: gldata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
            	
                if (data.flag == 1) {
                          return "redClass";
                      } 
                      else{
                       return "greyClass";
                      };
                  };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxGuidelines").jqxGrid(
            {
                width: '95%',
                height: 150,
                source: dataAdapter,
                editable: true,
                theme: theme,
                selectionmode: 'singlerow',
                source: dataAdapter,
                showaggregates:true,
                pagermode: 'default',
                filtermode:'excel',
                    
              //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxGuidelines').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxGuidelines').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxGuidelines").jqxGrid('addrow', null, {});
                            
                            rowlength++;                           
                        }
                    }
                },
                
                columns: [
							{  text: 'Sr. No.', sortable: false, filterable: false, editable: false, cellclassname: cellclassname,
							   groupable: false, draggable: false, resizable: false,datafield: '',
							   columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							   }  
							},  
							{ text: 'Description', datafield: 'description', width: '95%', editable: false, cellclassname: cellclassname},
							{ text: 'Status_id', datafield: 'status_id', width: '95%',hidden:true, cellclassname: cellclassname},
							{ text: 'Flag', datafield: 'flag', width: '95%',hidden:true, cellclassname: cellclassname}
						]
            });
           /*  if(document.getElementById("mode").value=='view')
			{
			$('#jqxGuidelines').jqxGrid({ disabled: true});
			} */
            //$("#jqxGuidelines").jqxGrid('addrow', null, {});
			
        });
    </script>
    <div id="jqxGuidelines"></div>
    <input type="hidden" id="rowindex"/>