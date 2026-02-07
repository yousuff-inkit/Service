 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.finance.nipurchase.suppliers.ClsVendorDetailsDAO"%>
<%
ClsVendorDetailsDAO VendorDetailsDAO=new ClsVendorDetailsDAO();

%>

 <%
           	String rdocno = request.getParameter("rdocno")==null?"0":request.getParameter("rdocno").trim();
 
           	  %> 
<script type="text/javascript">

           	
           	var temp1='<%=rdocno%>';
            var hide;
            if(temp1>0)
          	 {
           	 var enqdata1= '<%=VendorDetailsDAO.gridreload(rdocno)%>'; 
           	 
          	   hide=2; 
          	 } 
            else
          	 { 
            	var enqdata1;
              	 } 
  
  
        $(document).ready(function () { 	
        
             var num = 1; 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'brandname', type: 'string'  },
     						{name : 'doc_no', type: 'int'   },
     						{name : 'srno', type: 'string'   },
     						{name : 'desc1', type: 'string'   },
     						 
     											
                 ],
                 localdata: enqdata1,
                
                
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

            
            
            $("#brandgrid").jqxGrid(
            {
                width: '100%',
                height: 200,
                source: dataAdapter,
            
                disabled:true,
                editable: true,
                altRows: true,
             
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                //Add row method
               
                handlekeyboardnavigation: function (event) {
               	
                	 var cell1 = $('#brandgrid').jqxGrid('getselectedcell');
                	 if (cell1 != undefined && cell1.datafield == 'brandname') {  
                	
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 114) {  
                         	 document.getElementById("rowindex").value = cell1.rowindex;
                       
                        	brandinfoSearchContent('brandsearch.jsp');
                        	 $('#brandgrid').jqxGrid('render');
                        }
                        }
                   
       
              
                  }, 
              
                       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                              }  
                            },	
                            
							{ text: 'Brand Name', datafield: 'brandname', width: '30%' },	
							{ text: 'doc_no', datafield: 'doc_no', width: '2%',hidden:true },
							
							{ text: 'Description', datafield: 'desc1', width: '65%' },
							 
			              ]
               
            });
           
            $("#brandgrid").jqxGrid('addrow', null, {});
            
            
            if(($('#mode').val()=='A')||($('#mode').val()=='E'))
    		{
    		  $("#brandgrid").jqxGrid({ disabled: false}); 
    		}
            
            	
           
            $("#brandgrid").on('cellclick', function (event) 
             		{
         
         	   var rowindextemp2 = event.args.rowindex;
                document.getElementById("rowindex").value = rowindextemp2;
               
                var datafield = event.args.datafield;
  		       
   		       
   		      if(datafield=="brandname")
 		           {
             	
                $("#brandgrid").jqxGrid('clearselection');
             	   }
      
                     }); 

            $('#brandgrid').on('celldoubleclick', function (event) {
            	 
                var datafield = event.args.datafield;
  		       
   		       
   		      if(datafield=="brandname")
 		           {
            		
              	 var rowindextemp = event.args.rowindex;
              	    document.getElementById("rowindex").value = rowindextemp;  
              	  $('#brandgrid').jqxGrid('clearselection');
              	brandinfoSearchContent('brandsearch.jsp');
              	
              		  } 
              	  
    
        	  
              	
              	  
                  }); 
            
            
        });
    </script>
    <div id="brandgrid"></div>
  <input type="hidden" id="rowindex"/> 