
 
 <%@page import="com.dashboard.sales.enquiryprocess.ClsenquiryprocessDAO"%>
 <% ClsenquiryprocessDAO searchDAO = new ClsenquiryprocessDAO(); 
 
String rdoc = request.getParameter("rdoc")==null?"0":request.getParameter("rdoc");

String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
String masterdoc_no = request.getParameter("masterdoc_no")==null?"0":request.getParameter("masterdoc_no");
String type = request.getParameter("type")==null?"0":request.getParameter("type");
String clientid = request.getParameter("clientid")==null?"0":request.getParameter("clientid");
 
 
 %>
 <script type="text/javascript">
 


 
 var details; 
 var rdocs='<%=rdoc%>';
 var masterdoc_no='<%=masterdoc_no%>';
       if(rdocs>0)
    	   {
    	   details='<%=searchDAO.listsearch(rdoc)%>';  
    	   }
       else if(masterdoc_no>0)
    	   {
    	   details='<%=searchDAO.gridreloadsearch(masterdoc_no,barchval,type,clientid)%>';  
    	   
    	   
    	   }
       
       
	 else
	 {
		 details; 
	 }
	 
         
        $(document).ready(function () { 
        	chkbrand();
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'productname', type: 'string'  },
                 		     {name : 'productid', type: 'string'  },
     						{name : 'qty', type: 'number'},
     						{name : 'stock', type: 'number'}, 
     						{name : 'costperunit', type: 'number'},
     						{name : 'sellingprice' , type : 'number'},
     						{name : 'discount' , type : 'number'},
     						{name : 'netsellingprice' , type : 'number'},
     						
     						{name : 'rfq', type: 'String'},
     						{name : 'vendor', type: 'String'}, 
     						{name : 'rfqprice', type: 'number'},
     						{name : 'margin', type: 'number'},
     						
     						{name : 'netamount', type: 'number'},   
     						{name : 'sqoute', type: 'number'},
     						 
     						{name : 'prodoc' , type : 'number'},
     						
     						
     						{name : 'rfqmaindoc' , type : 'number'},
     						
     						{name : 'vendordoc' , type : 'number'},
     						 
     						{name : 'rdocno' , type : 'number'},
    						 
     						{name : 'refdocno' , type : 'number'},
   						 
     						
     						{name : 'brandname', type: 'String'}, 
     						
     						{name : 'brdocno' , type : 'number'},
     						 
     						
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
            	
            	
            	width: '99.5%',
                height: 300,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                columnsresize:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:true,
                
                handlekeyboardnavigation: function (event) {
                   	
               	 var cell1 = $('#duedetailsgrid').jqxGrid('getselectedcell');
               	 if (cell1 != undefined && cell1.datafield == 'rfq') {  
               	
                       var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       if (key == 114) {  
                        	 document.getElementById("rowindex").value = cell1.rowindex;
                      
                        	  $('#duedetailsgrid').jqxGrid('clearselection');
                          	   var  brandval=document.getElementById("cmbbranch1").value;
                          	   
                          	   
                          	   var prdid=$('#duedetailsgrid').jqxGrid('getcellvalue', cell1.rowindex, "prodoc");
                          
                          	refinfoSearchContent('Subsearch.jsp?brandval='+brandval+"&prdid="+prdid);
                       }
                       }
                  
           
             
                 }, 
                columns: [


                          { text: ' Product  ', datafield: 'productid', width: '8%',editable:false },
							 { text: ' Product Name', datafield: 'productname',editable:false },
							
			 
							 { text: ' Brand Name', datafield: 'brandname', width: '10%',editable:false },
							 
							 
							 { text: ' Qty', datafield: 'qty', width: '4%',editable:false,cellsformat:'d2' },
							 { text: ' Stock', datafield: 'stock', width: '4%',cellsformat:'d2',editable:false },
							 { text: ' Cost Per Unit', datafield: 'costperunit', width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',editable:false},
							 { text: ' Selling Price', datafield: 'sellingprice', width: '6%',cellsformat:'d2',cellsalign: 'right', align:'right' ,editable:true},
							 { text: ' Discount', datafield: 'discount', width: '5%',cellsformat:'d2' ,cellsalign: 'right', align:'right' ,editable:true},
							 { text: ' Net Selling Price', datafield: 'netsellingprice', width: '8%' ,cellsformat:'d2',cellsalign: 'right', align:'right' ,editable:false},
							 { text: ' RFQ', datafield: 'rfq', width: '5%'  ,editable:false },
							 { text: ' Vendor', datafield: 'vendor', width: '10%' ,editable:false },
							 { text: ' RFQ Price', datafield: 'rfqprice', width: '5%',cellsformat:'d2',cellsalign: 'right', align:'right',editable:true},
							 { text: ' Margin', datafield: 'margin', width: '4%' ,editable:true,cellsformat:'d2',cellsalign: 'right', align:'right'},
							 { text: ' Net/Unit', datafield: 'netamount', width: '6%' ,editable:true,cellsformat:'d2',cellsalign: 'right', align:'right'},
							 { text: ' S-Quote', datafield: 'sqoute', width: '6%' ,cellsformat:'d2',cellsalign: 'right', align:'right',editable:false},
							 { text: ' prodoc', datafield: 'prodoc', width: '6%'  ,editable:true,hidden:true },
							 
							 { text: ' rfqmaindoc', datafield: 'rfqmaindoc', width: '7%'  ,editable:true,hidden:true},
							 { text: ' vendordoc', datafield: 'vendordoc', width: '7%'  ,editable:true,hidden:true},
							 
							 
							 { text: ' rdocno', datafield: 'rdocno', width: '7%'  ,editable:true,hidden:true },
							 
							 { text: ' refdocno', datafield: 'refdocno', width: '7%'  ,editable:true,hidden:true },
							 
							 { text: ' brdocno', datafield: 'brdocno', width: '7%'  ,editable:true,hidden:true  },
	     					
							 
							 
					
					]
            });
              $('#duedetailsgrid').on('celldoubleclick', function (event) {
            
            	var datafield = event.args.datafield;
                	 if(datafield == "rfq")
           		  { 

           	 var rowindextemp = event.args.rowindex;
           	    document.getElementById("rowindex").value = rowindextemp;  
           		  $('#duedetailsgrid').jqxGrid('clearselection');
           	   var  brandval=document.getElementById("cmbbranch1").value;
           	   
           	   
           	   var prdid=$('#duedetailsgrid').jqxGrid('getcellvalue', event.args.rowindex, "prodoc");
           
           	refinfoSearchContent('Subsearch.jsp?brandval='+brandval+"&prdid="+prdid);
           	
           		  } 
           	  
             
                	
                	  
                    }); 
            $("#duedetailsgrid").on('cellvaluechanged', function (event) 
                    {
                 	   
                 	   
                 	   
                    	var datafield = event.args.datafield;
                		
            		    var rowBoundIndex = event.args.rowindex;
            		    
            		    if(datafield=="sellingprice" || datafield=="discount" )
            		    	{
            			   var total= $('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "sellingprice");
         				  
            	   	   		var discount=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "discount");	
            	   	   		     		
            	   	   		var nettotal=parseFloat(total)-parseFloat(discount);
            	   	   		if(discount==""||discount==null||discount=="undefiend")
            	   	   			{
            	   	   		  $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "netsellingprice",total);
            	   	   			}
            	   	   		else{
            	   	   			$('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "netsellingprice",nettotal);
            	   	   		}
            		    	}
            		    if(datafield=="rfqprice" || datafield=="margin" )
        		    	{
        			   var total1= $('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "rfqprice");
     				   var discper=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");	
     				   
     				   
  
			           	var	discount1=(parseFloat(total1)*parseFloat(discper))/100;
        	   	   		     		
        	   	   		var nettotal1=parseFloat(total1)+parseFloat(discount1);
        	   	   		if(discper==""||discper==null||discper=="undefiend")
        	   	   			{
        	   	   		  $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "rfqprice",total1);
        	   	   	      $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "netamount",total1);
        	   	   	      var qty=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
        	   	   	      
        	   	   	total1=parseFloat(qty)*parseFloat(total1);
        	   	   	      
        	   	   	      $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "sqoute",total1);
        	   	   			}
        	   	   		else{
        	  
        	   	   	      $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "netamount",nettotal1);
        	   	   	  var qty=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
        	   	          	nettotal1=parseFloat(qty)*parseFloat(nettotal1);
        	   	   			$('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "sqoute",nettotal1);
        	   	   		}
        		    	}
            		    if(datafield=="netamount")
        		    	{  
            		    	
            		    	
            		    	  var qty=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
            		     var net=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "netamount");
            		     
            		 	if(net==""||net==null||net=="undefiend")
    	   	   			{
            		 		 var total1= $('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "rfqprice");
           				   var discper=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "margin");	
           				   
           				   
        
      			           	var	discount1=(parseFloat(total1)*parseFloat(discper))/100;
              	   	   		     		
              	   	   		 var nettotal1=parseFloat(total1)+parseFloat(discount1);
              	   	   		if(discper==""||discper==null||discper=="undefiend")
              	   	   			{
              	   	   		  $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "rfqprice",total1);
              	   	   	      $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "netamount",total1);
              	   	   	      var qty=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
              	   	   	      
              	   	   	total1=parseFloat(qty)*parseFloat(total1);
              	   	   	      
              	   	   	      $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "sqoute",total1);
    	   	   			}
              	   	   else{
                     	  
         	   	   	      $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "netamount",nettotal1);
         	   	   	  var qty=$('#duedetailsgrid').jqxGrid('getcellvalue', rowBoundIndex, "qty");
         	   	          	nettotal1=parseFloat(qty)*parseFloat(nettotal1);
         	   	   			$('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "sqoute",nettotal1);
         	   	   		}
    	   	   			}
            		 	else
            		 		{
            		     net=parseFloat(qty)*parseFloat(net);
            		        $('#duedetailsgrid').jqxGrid('setcellvalue', rowBoundIndex, "sqoute",net);
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
    	   
				       
                       
    </script>
    <input type="hidden" id="rowindex">
        <div id="duedetailsgrid"></div>