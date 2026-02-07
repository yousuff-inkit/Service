<%@page import="com.common.ClsCostCenter"%>
<% ClsCostCenter DAO= new ClsCostCenter(); %>
<% String dtype1 = request.getParameter("costtype").toString();%> 
<script type="text/javascript">
  
var costcode= '<%=DAO.costCodeSearch(dtype1) %>';

  	 $(document).ready(function () { 	
        
            var source =
            {
                datatype: "json",  
                datafields: [
							{name : 'doc_no', type: 'string'  },
                            {name : 'code', type: 'string'  },
                            {name : 'name', type: 'string'  },
                            {name : 'namedet', type: 'string'  }
                        ],
                      localdata: costcode,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costcodeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Docno', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'Cost Code', datafield: 'code', width: '20%'},
                              { text: 'Description', datafield: 'name', width: '40%' },
                              { text: 'Cost Group', datafield: 'namedet', width: '40%' },
						]
            });
            
           $('#costcodeSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcostno").value = $('#costcodeSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtcostcode").value = $('#costcodeSearch').jqxGrid('getcellvalue', rowindex1, "name");
                
                $('#costTypeSearchGridWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="costcodeSearch"></div> 