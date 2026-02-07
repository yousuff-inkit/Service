
 <%@page import="com.dashboard.sales.ClsSalesReportsDAO"%>
 <%
 ClsSalesReportsDAO searchDAO = new ClsSalesReportsDAO(); 
  
 String rdoc = request.getParameter("rdoc")==null?"0":request.getParameter("rdoc");

 System.out.println("---rdoc---"+rdoc);
 String specno = request.getParameter("specno")==null?"0":request.getParameter("specno");

 String prodoc = request.getParameter("prodoc")==null?"0":request.getParameter("prodoc");
 %>
 <script type="text/javascript">
 


 
 var details; 
 var rdocs='<%=rdoc%>';
       if(rdocs>0)
    	   {
    	   details='<%=searchDAO.Detailsenq(rdoc,prodoc,specno)%>';
    	   }
	 else
	 {
		 details; 
	 }
	 
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'detdate', type: 'date'  },
                 		
     						{name : 'user', type: 'String'},
     						
     						 {name : 'remk', type: 'String'},
     						{name : 'fdate' , type : 'date'}
     						
                          	],
                          	localdata: details,
                          	       
          
				
                
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
            $("#duedetailsgrid").jqxGrid(
            { 
            	
            	
            	width: '98%',
                height: 110,
                source: dataAdapter,
                
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
                columns: [
						
							{ text: 'Date', datafield: 'detdate', width: '10%',cellsformat:'dd.MM.yyyy'},
							
							 { text: 'User', datafield: 'user', width: '18%' },
				
							 { text: 'Follow-Up Date', datafield: 'fdate', width: '10%',cellsformat:'dd.MM.yyyy'},	
							 
							 { text: 'Remarks', datafield: 'remk', width: '62%' },
							
					
					]
            });
         
        
           
        });
        
        
				       
                       
    </script>
    <div id="duedetailsgrid"></div>