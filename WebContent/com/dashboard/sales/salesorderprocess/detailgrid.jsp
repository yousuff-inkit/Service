<%@page import="com.dashboard.sales.salesorderprocess.ClsSalesorderprocessDAO"%> 
<%  ClsSalesorderprocessDAO searchDAO = new ClsSalesorderprocessDAO(); 
    String rdoc = request.getParameter("rdoc")==null?"0":request.getParameter("rdoc");
	String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
	String masterdoc_no = request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
	String type = request.getParameter("type")==null?"0":request.getParameter("type");
	String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid"); %>
 
 <style>            
	 
  .advanceClass
  {
      
   background-color: #FFEBC2;  
      	
  }
  
 
</style>

<script type="text/javascript">
 
	   var details; 
 	   var rdocs='<%=rdoc%>';
 	   var masterdoc_no='<%=masterdoc_no%>';
       
 	   if(rdocs>0) {
    	   	 details='<%=searchDAO.listsearch(rdoc,barchval)%>';   
       }   else {
		 	  details; 
	   }
	 
         
        $(document).ready(function () { 
        	chkbrand();
        	
        	
        	 var cellclassname =  function (row, column, value, data) {


            	  var ss= $('#duedetailsgrid').jqxGrid('getcellvalue', row, "purchase");
            		          if(parseFloat(ss)>0)
            		  		{
            		  		
            		  		return "advanceClass";
            		  	
            		  		}
            		          
            		        
            		          
             

            		}
     
        	
        	
            var source = 
            {
                datatype: "json",
                datafields: [
                 				{name : 'productname', type: 'String'  },
                 				{name : 'brandname', type: 'String'  },
     							{name : 'qty', type: 'number'},
     							{name : 'delqty', type: 'number'},
     							{name : 'balqty', type: 'number'},
     							{name : 'stock', type: 'number'}, 
     							{name : 'po', type: 'number'},
     							{name : 'purchase' , type : 'number'}
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
		            });
          
            $("#duedetailsgrid").jqxGrid(
            { 
            	width: '99.5%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                handlekeyboardnavigation: function (event) {
                   	
               
                 },
                 
                columns: [
							
							 { text: ' Product Name', datafield: 'productname', width: '22%',editable:false },
							 { text: ' Brand Name', datafield: 'brandname', width: '20%',editable:false },
							 { text: ' Quantity', datafield: 'qty', width: '8%',editable:false,cellsformat:'d2' },
							 { text: ' Delivery Qty', datafield: 'delqty', width: '10%',editable:false,cellsformat:'d2' },
							 { text: ' Balance Qty', datafield: 'balqty', width: '10%',editable:false,cellsformat:'d2' },
							 { text: ' Stock', datafield: 'stock', width: '10%',cellsformat:'d2',editable:false },
							 { text: ' PO', datafield: 'po', width: '8%',cellsformat:'d2',editable:false },
							 { text: ' Purchase', datafield: 'purchase', width: '12%' ,cellsformat:'d2',cellclassname:cellclassname,editable:false },
						]
            });
              
        });
        
        function chkbrand()
        {
         
    	   var x=new XMLHttpRequest();
    	   x.onreadystatechange=function(){
    	   if (x.readyState==4 && x.status==200)
    	    {
    	      var items= x.responseText.trim();
    	     
    	      if(parseInt(items)>0)
    	       {
    	     
    	    	  
    	    	  $('#duedetailsgrid').jqxGrid('showcolumn', 'brandname');
    	    
    	    	  
    	    	  
    	        }
    	          else
    	      {
    	      
    	        	  $('#duedetailsgrid').jqxGrid('hidecolumn', 'brandname');
    	      
    	      }
    	      
    	       }}
    	   x.open("GET","checkbrand.jsp?",true);
    		x.send();
    	 
    	      
    	        
        	
        }
    	   
				       
                       
    </script>
    <input type="hidden" id="rowindex">
        <div id="duedetailsgrid"></div>