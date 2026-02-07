<%@page import="com.skips.clientskip.ClsClientskipDAO" %>
 <%
 ClsClientskipDAO DAO=new ClsClientskipDAO();
 %>
 
 <script type="text/javascript">

 var datasal= '<%=DAO.groupcompaniesSearch()%>'; 
   // alert(data);
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'grpid', type: 'String'  },    
     						{name : 'grpcmp', type: 'String'  }
     						
     					
     					
                          	
                          	],
                 localdata: datasal,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxgrpcmpsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                /* showfilterrow:true, */
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                		
     			columns: [
					{ text: 'DocNo', datafield: 'grpid',   columntype: 'textbox', filtertype: 'input',width: '20%'},
					{ text: 'Group Companies', datafield: 'grpcmp',  columntype: 'textbox', filtertype: 'input', width: '80%' }
					
					
					
					]
            });
    
           
      
            
           $('#jqxgrpcmpsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
               document.getElementById("cmbgroupcmp").value=$('#jqxgrpcmpsearch').jqxGrid('getcellvalue', rowindex1, "grpcmp");
               document.getElementById("groupcmpid").value=$('#jqxgrpcmpsearch').jqxGrid('getcellvalue', rowindex1, "grpid");
              

     	      document.getElementById("errormsg").innerText="";
                $('#grpcmpinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxgrpcmpsearch"></div>