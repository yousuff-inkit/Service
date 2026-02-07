<%@page import="com.dashboard.skips.nafithlist.*" %>
<%ClsNafithListDAO dao=new ClsNafithListDAO();%>
<% String fromdate =request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString();
String brhid =request.getParameter("brhid")==null?"":request.getParameter("brhid").toString();
String id =request.getParameter("id")==null?"":request.getParameter("id").toString();
%>

 <script type="text/javascript">
 var downloaddata=[];
 var id='<%=id%>';
 if(id=="1"){
 	downloaddata='<%=dao.getNafithData(fromdate, todate, brhid, id)%>';
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
            $("#nafithGrid").jqxGrid(
            {
                width: '100%',
                height: 490,
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
					{ text: 'Trip',columntype: 'textbox', datafield: 'trip', width: '12%' },
					{ text: 'Plate',columntype: 'textbox', datafield: 'plate', width: '12%' },
					{ text: 'In datetime',columntype: 'textbox', datafield: 'indatetime', width: '20%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'Out datetime',columntype: 'textbox', datafield: 'outdatetime', width: '20%',cellsformat:'dd.MM.yyyy HH:mm:ss' },
					{ text: 'Disposal Location',columntype: 'textbox',  datafield: 'displocation', width: '16%' },
					{ text: 'Actual Weight',columntype: 'textbox',  datafield: 'actualweight', width: '10%',cellsformat:'d2' },
					{ text: 'Entry',columntype: 'textbox',  datafield: 'entry', width: '10%' },
					
	              ]
            }); 
           $('#overlay,#PleaseWait').hide();
        });
    </script>
    <div id="nafithGrid"></div>
