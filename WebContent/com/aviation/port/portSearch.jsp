<%@page import="com.aviation.port.ClsPortAction"%>
<%ClsPortAction DAO= new ClsPortAction();%>    
    <script type="text/javascript">
  		var data= '<%=DAO.searchDetails()%>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'PORT', type: 'String'  },
     						{name : 'PORT_NAME', type: 'String'  },
     						{name : 'COUNTRY', type: 'String'  },
                          	{name : 'DATE', type: 'String'  }
                 ],
               localdata: data,
                //url: "/searchDetails",
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
            $("#jqxPortSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
               filterable:true,
               showfilterrow:true,
               altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
					{ text: 'DOC NO',filtertype:'number', datafield: 'DOC_NO', width: '6%' },
					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'DATE', width: '10%' },
					{ text: 'PORT',columntype: 'textbox', filtertype: 'input', datafield: 'PORT', width: '15%' },
					{ text: 'PORT_NAME',columntype: 'textbox', filtertype: 'input', datafield: 'PORT_NAME', width: '25%' },
					{ text: 'COUNTRY',columntype: 'textbox', filtertype: 'input', datafield: 'COUNTRY' }
					
	              ]
            });
            $('#jqxPortSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxPortSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("port").value = $("#jqxPortSearch").jqxGrid('getcellvalue', rowindex1, "PORT");
                document.getElementById("portname").value = $("#jqxPortSearch").jqxGrid('getcellvalue', rowindex1, "PORT_NAME");
                document.getElementById("country").value = $("#jqxPortSearch").jqxGrid('getcellvalue', rowindex1, "COUNTRY");
                $("#PortDate").jqxDateTimeInput('val', $("#jqxPortSearch").jqxGrid('getcellvalue', rowindex1, "DATE"));
                //document.getElementById("search").style.display="none";
                $('#window').jqxWindow('hide');
            }); 
         
        });
    </script>
    <div id="jqxPortSearch"></div>
