<%@page import="com.dashboard.gwinternal.menupath.ClsMenupathDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<% ClsMenupathDAO mnp = new ClsMenupathDAO(); 

String id = request.getParameter("id")==null || request.getParameter("id").equals("")?"0":request.getParameter("id").toString();
%>   
 <script type="text/javascript">
 var data='<%=mnp.loadGrid(id) %>';  
 //alert(data);
        $(document).ready(function () { 	
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'mno', type: 'String'  },
     						{name : 'menuname', type: 'String'  },
     						{name : 'pmenu', type: 'String'  },
     						{name : 'path', type: 'String' },
     						{name :'printpath1', type: 'String' },
     						{name : 'printpath2', type: 'String' },
     						{name : 'gate', type: 'String' },
     						{name : 'save', type: 'String' },
     					     						
                 ],
                 localdata: data,
                
                
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
            $("#jqxmnpGrid").jqxGrid(  
            {
                width: '99%',
                height: 520,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                editable: true,
                //Add row method
                columns: [
					{ text: 'MENUNO', datafield: 'mno', width: '5%',editable: false },
					{ text: 'MENU NAME',  datafield: 'menuname', width: '15%' },
					{ text: 'PMENU', datafield: 'pmenu', width: '10%'},
					{ text: 'PATH', datafield: 'path', width: '20%'},
					{ text: 'PRINTPATH1', datafield: 'printpath1', width: '25%' },
					{ text: 'PRINTPATH2', datafield: 'printpath2', width: '15%' },
					{ text: 'GATE', datafield: 'gate', width: '5%' },
					{ text: '', datafield: 'save', width: '5%',columntype: 'button' },
	              ]
            });
            $('#jqxmnpGrid').on('cellclick', function (event) { 
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
 		        if(datafield=="save"){
 		        	funsave(rowBoundIndex);
 		        }  
            });
        });
    </script>
    <div id="jqxmnpGrid"></div>
  