<%@page import="com.skips.nafithdownload.*" %>
<%ClsNaifithDownloadDAO dao=new ClsNaifithDownloadDAO();%>
<% String xdoc =request.getParameter("xdocs")==null?"0":request.getParameter("xdocs").toString();%>

 <script type="text/javascript">
 var downloaddata=[];
 var xdoc='<%=xdoc%>';
 if(xdoc!="" && xdoc!="0"){
 	downloaddata='<%=dao.getNafithData(xdoc)%>';
 }
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'trip', type: 'String'  },
     						{name : 'plate', type: 'String'  },
     						{name : 'indatetime', type: 'date' },
     						{name : 'outdatetime', type: 'date' },
     						{name : 'displocation', type: 'String' },
     						{name : 'actualweight', type: 'number' },
     						{name : 'entry', type: 'String' }
                 ],
                 localdata: downloaddata,
                
                
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Trip',columntype: 'textbox', datafield: 'trip', width: '10%' },
					{ text: 'Plate',columntype: 'textbox', datafield: 'plate', width: '10%' },
					{ text: 'In datetime',columntype: 'textbox', datafield: 'indatetime', width: '10%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'Out datetime',columntype: 'textbox', datafield: 'outdatetime', width: '10%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'Disposal Location',columntype: 'textbox',  datafield: 'displocation', width: '10%' },
					{ text: 'Actual Weight',columntype: 'textbox',  datafield: 'actualweight', width: '10%',cellsformat:'d2' },
					{ text: 'Entry',columntype: 'textbox',  datafield: 'entry', width: '10%' },
					
	              ]
            }); 
           
        });
    </script>
    <div id="jqxloaddataGrid"></div>
