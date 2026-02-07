<%@page import="com.cargo.place.ClsPlaceAction"%>
<%ClsPlaceAction DAO= new ClsPlaceAction();%>    
    <script type="text/javascript">
  		var data= '<%=DAO.searchDetails()%>';
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'CODE', type: 'String'  },
     						{name : 'NAME', type: 'String'  },
     						{name : 'COUNTRY', type: 'String'  },
     						{name : 'COUNTRY_ID', type: 'String'  },
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
            $("#jqxPlaceSearch").jqxGrid(
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
					{ text: 'CODE',columntype: 'textbox', filtertype: 'input', datafield: 'CODE', width: '15%' },
					{ text: 'NAME',columntype: 'textbox', filtertype: 'input', datafield: 'NAME', width: '25%' },
					{ text: 'COUNTRY',columntype: 'textbox', filtertype: 'input', datafield: 'COUNTRY' }
					
	              ]
            });
            $('#jqxPlaceSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxPlaceSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("code").value = $("#jqxPlaceSearch").jqxGrid('getcellvalue', rowindex1, "CODE");
                document.getElementById("name").value = $("#jqxPlaceSearch").jqxGrid('getcellvalue', rowindex1, "NAME");
                document.getElementById("hidcmbcountry").value = $("#jqxPlaceSearch").jqxGrid('getcellvalue', rowindex1, "COUNTRY_ID");
                $("#PlaceDate").jqxDateTimeInput('val', $("#jqxPlaceSearch").jqxGrid('getcellvalue', rowindex1, "DATE"));
                //document.getElementById("search").style.display="none";
                getCountry();
                $('#window').jqxWindow('hide');
            }); 
         
        });
    </script>
    <div id="jqxPlaceSearch"></div>
