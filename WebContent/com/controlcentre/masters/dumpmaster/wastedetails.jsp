<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.masters.dumpmaster.waste.ClsWasteDAO"%>
<%
ClsWasteDAO DAO = new ClsWasteDAO();
String docno=request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").trim().toString(); 

%>  

 
<script type="text/javascript">


var locdata= '<%=DAO.wastedetailsLoad(docno) %>';     
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                             {name : 'srno', type: 'String'  },    
      						{name : 'wastename', type: 'String'  },
      						{name : 'typeid', type: 'String'  },

                        ],
                		localdata: locdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#wastedetGrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                filterable:true,
                editable: true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                
                columns: [
                	 { text: 'SL#', sortable: false, filterable: false, editable: false,
                         groupable: false, draggable: false, resizable: false,
                         datafield: 'sl', columntype: 'number', width: '4%',
                         cellsrenderer: function (row, column, value) {
                             return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                         }  
                       },
          				{ text: 'Srno', datafield: 'srno', width: '20%',hidden:true},
          				{ text: 'typeid', datafield: 'typeid', width: '20%',hidden:true},

    					{ text: 'Waste Name', datafield: 'wastename', width: '96%',editable:true },
										
						]
            });
            
            $('#wastedetGrid').on('rowdoubleclick', function (event) 
             		{      
            $("#wastedetGrid").jqxGrid('addrow', null, {});
             		 });
        });
    </script>
    <div id="wastedetGrid"></div>