
  	 <%@page import="com.dashboard.sales.saleinvoice.ClsSaleinvoiceDAO"%>
  	 <% ClsSaleinvoiceDAO searchDAO = new ClsSaleinvoiceDAO(); 
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
        	chkbatch();
        	
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
     							{name : 'foc', type: 'number'},
    							 
     							{name : 'productid', type: 'string' }, 
     							{name : 'unit', type: 'string'  },
     							
     							{name : 'unitprice', type: 'number' },
         						{name : 'total', type: 'number' },
         						{name : 'discper', type: 'number' },
         						{name : 'discount', type: 'number' },
         						{name : 'nettotal', type: 'number' },
         						{name : 'stockid', type: 'number'    },
         						
          					  {name : 'exp_date', type: 'date'    },
        					  {name : 'batch_no', type: 'string'    },
        					  
        					  {name : 'rowno', type: 'int'    },
        					  
        					  {name : 'orddocno', type: 'int'    },
        					  
        						{name : 'chkqty', type: 'number'},
     							{name : 'chkfoc', type: 'number'},
     							
     							
     							 {name : 'taxper', type: 'number'  },  
     	       					 {name : 'taxamount', type: 'number'  },
     	       					{name : 'taxperamt', type: 'number'  }, 
        					  
         						
                          	],
                          	localdata: details,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            var rendererstring2=function (aggregates){
              	var value=aggregates['sum2'];
              	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "  Total" + '</div>';
              }    



            	  var rendererstring1=function (aggregates){
                	var value=aggregates['sum1'];
                	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
                }
            	  
            	  
            	  var rendererstring=function (aggregates){
            			var value=aggregates['sum'];
            			if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
            			   {
            				value=0.0;
            			   }
            			
            			return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
            		}
            	  
            	  
                  $("#duedetailsgrid").on("bindingcomplete", function (event) { 
          			
          			
                     
                  	
                   	 var rows = $("#duedetailsgrid").jqxGrid('getrows');   
       
      	             	  for(var i=0;i<rows.length;i++){
      	             	   		var netotal=$('#duedetailsgrid').jqxGrid('getcellvalue', i, "nettotal"); 
      	                		
      	                		  var taxper= $('#duedetailsgrid').jqxGrid('getcellvalue', i, "taxper"); 
      	                		  
      	                		  
      	                		  
      	                		  
      	                		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
      	                		  
      	                		  
      	                		  $('#duedetailsgrid').jqxGrid('setcellvalue', i, "taxperamt",taxempamount);
      	                		  
      	                		 
      	                		  
      	                		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
      	                		  
      	                		  $('#duedetailsgrid').jqxGrid('setcellvalue', i, "taxamount",taxtotalamount);
      	              	 
      	                		 
      	             	                         }
                                      
                                     
               	         
           
          			
          			
          		}); 
            	  
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
                selectionmode: 'checkbox',
                pagermode: 'default',
                editable:true,
           
                showaggregates:true,
                showstatusbar:true,
                
                statusbarheight: 21,
                handlekeyboardnavigation: function (event) {
                   	
               
                 },
                 
                columns: [

 						{ text: ' Product ID', datafield: 'productid' , width: '8%',editable:false },
                          
							 { text: ' Product Name', datafield: 'productname', width: '20%',editable:false },
							 { text: ' Brand Name', datafield: 'brandname', width: '10%',editable:false },
							
							 { text: 'Unit', datafield: 'unit', width: '3%',editable:false  },
							 { text: ' Quantity', datafield: 'qty', width: '5%',editable:true,cellsformat:'d2' },
							 { text: ' Foc', datafield: 'foc', width: '5%',editable:true,cellsformat:'d2' },
							 
							 { text: ' rowno', datafield: 'rowno', width: '5%' ,hidden:true },
							 
							 { text: ' orddocno', datafield: 'orddocno', width: '5%'  ,hidden:true},
							
							 
		   
								{ text: 'Unit price', datafield: 'unitprice', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false },
								{ text: 'Total', datafield: 'total', width: '7%', cellsformat: 'd2', cellsalign: 'right', align: 'right',editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1   },
							/* 	{ text: 'Discount %', datafield: 'discper', width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right' ,editable:false 	},
								{ text: 'Discount', datafield: 'discount', width: '5%', cellsformat: 'd2', cellsalign: 'right',editable:false , align: 'right',aggregates: ['sum1'],aggregatesrenderer:rendererstring1 }, */
								{ text: 'Net Total', datafield: 'nettotal', width: '7%', cellsformat: 'd2', cellsalign: 'right'  , align: 'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable: false },
						/* 		{text: 'Batch No', datafield: 'batch_no', width: '11%' ,editable:false },
								{text: 'Exp Date', datafield: 'exp_date', width: '6%' ,columntype: 'datetimeinput', align: 'left',editable:false , cellsalign: 'left',cellsformat:'dd.MM.yyyy'},
						 */
								
								{ text: ' maxqty', datafield: 'chkqty', width: '5%',editable:true,cellsformat:'d2',hidden:true },
								{ text: ' maxfoc', datafield: 'chkfoc', width: '5%',editable:true,cellsformat:'d2' ,hidden:true},
							 
								
								{ text: 'Tax %', datafield: 'taxper', width: '5%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false},
								{ text: 'Tax Amount', datafield: 'taxperamt', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname ,editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring },
								
								{ text: 'Net Total', datafield: 'taxamount', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring ,editable:false },
								
        					  
								
								]
            });
            
            
            
            $("#duedetailsgrid").on('cellvaluechanged', function (event) 
                    {
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    if(datafield=="qty")
             		   {
            		    	
            		    var qty=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");	
            		    var chkqty=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "chkqty");
            		    if(qty>chkqty){
            		    	
            		   	 $.messager.alert('Message', 'Quantity should not be greater than available quantity  ' +chkqty);
            		    	
            		   	 
            		   	$('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "qty",chkqty);
            		    	qty=chkqty;
            		    	
            		    
            		    }
            		    
            		    
            		    var unitprice=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "unitprice");	
            		    var discper=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "discper");
            		    
            		    
            		    var total=0;
            		    var discount=0;
            		    
            		    var nettotal=0;
            		    
            		   
            		    
            			total=parseFloat(qty)*parseFloat(unitprice);
            			if(parseFloat(discper)>0)
              			{
              		   
              			  
              			discount=(parseFloat(total)*parseFloat(discper))/100;
              			 $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "discount",discount);      			
              			}
            			
            		  	if(discount==""||typeof(discount)=="undefined"|| typeof(discount)=="NaN")
              		   {
                     		discount=0.0;
              		   }
                     	
            		    	
            		    	
             		   
            		    nettotal=parseFloat(total)-parseFloat(discount);
            		    
            		    $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "total",total);
                        
                    	if(parseFloat(discount)>0 || parseFloat(discount)<0)
                		{
                    	$('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",nettotal);
                		}
                    	else
                    		{
                    		$('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "nettotal",total);
                    		}
                    	
                    	var netotal=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "nettotal"); 
                    	 var taxper= $('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "taxper"); 
	                		  
	                		  
	                		  
	                		  
	                		  var taxempamount=parseFloat(netotal)*(parseFloat(taxper)/100);
	                		  
	                		  
	                		  $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "taxperamt",taxempamount);
	                		  
	                		 
	                		  
	                		  var taxtotalamount=parseFloat(netotal)+parseFloat(taxempamount);
	                		  
	                		  $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "taxamount",taxtotalamount);
                    	
            		    
             		   } 
            		    if(datafield=="foc")
              		   {
            		    	   var foc=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "foc");	
                   		    var chkfoc=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "chkfoc");
                   		    if(foc>chkfoc){
                   		    	
                   		   	 $.messager.alert('Message', 'Foc should not be greater than available Foc   ' +chkfoc);
                   		    	
                   		   	 
                   		   	$('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "foc",chkfoc);
                   		    	 
                   		    	
                   		    
                   		    }
             		    	
              		   }
            		    
            		    
            		    
            		    
            		    
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
    	   
        function chkbatch()
        {
        	 
           var x=new XMLHttpRequest();
           x.onreadystatechange=function(){
           if (x.readyState==4 && x.status==200)
            {
              var items= x.responseText.trim();
              var item = items.split('::');
         
              var batch=item[0];
              var expdate=item[1];
              var pmgt=item[2];
              
              var focvalidate=item[3];
              
              
              if(parseInt(batch)>0) 
               {
            	 
            	  document.getElementById("batchno").value=1;
            
                }
                  else
              {
                	 
              
              }
              
              
              
              if(parseInt(focvalidate)>0)  
               {
            	 
            	  document.getElementById("focvalidate").value=1;
            
                }
                  else
              {
                	 
                	  document.getElementById("focvalidate").value=0;
              }
              
              
              if(parseInt(expdate)>0)
              {
            	  document.getElementById("expdate").value=1;
            	  
               }
                 else
             {
               	 
                	 
             }
             
               
              
               }}
           x.open("GET","checkbatch.jsp?",true);
        	x.send();
         
              
                
        	
        }             
    </script>
    <input type="hidden" id="rowindex">
    <input type="hidden" id="batchno">
     <input type="hidden" id="focvalidate">
    
    
<input type="hidden" id="expdate">
        <div id="duedetailsgrid"></div>