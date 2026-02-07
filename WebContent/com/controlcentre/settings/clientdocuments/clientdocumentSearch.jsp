<%@page import="com.controlcentre.settings.clientdocuments.ClsClientdocumentsDAO"%>
<%ClsClientdocumentsDAO DAO= new ClsClientdocumentsDAO();%>
 <script type="text/javascript">
  		<%-- var data= '<%=DAO.searchDetails() %>'; --%>
  		var crmdurl='getclientdocumentsdata.jsp';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	    {name : 'doc_no' , type: 'number' },
                  	    {name : 'date', type: 'String' },
						{name : 'description', type: 'String'  } ,
                        {name : 'remarks', type: 'String'  }  
       						    
                 ],
                 url: crmdurl,
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
            $("#jqxclientSearch").jqxGrid(
            {
                width: '100%',
                height: 327,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
                	{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%' },
					{ text: 'Documents',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '40%' },
					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '30%' } 
				
	              ]
            });
            $('#jqxclientSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxclientSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("txtdocument").value = $("#jqxclientSearch").jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("remarks").value = $("#jqxclientSearch").jqxGrid('getcellvalue', rowindex1, "remarks");
                $("#date").jqxDateTimeInput('val', $("#jqxclientSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               
                $('#window').jqxWindow('hide');
            }); 
           // $("#jqxclientSearch").jqxGrid('hidecolumn', 'date'); 
        });
    </script>
    <div id="jqxclientSearch"></div>
