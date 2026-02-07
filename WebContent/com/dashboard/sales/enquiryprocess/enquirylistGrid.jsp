
 
 <%@page import="com.dashboard.sales.enquiryprocess.ClsenquiryprocessDAO"%>
 <% ClsenquiryprocessDAO searchDAO = new ClsenquiryprocessDAO(); 
 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  
  	
 
 %> 
       
<style>
 		 .redClass
        {
            background-color: #FFEBEB;
        }
        .blueClass
	    {
	        background-color: #E0F8F1;
	    }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
         .greenClass
        {
           background-color: #F1F8E0;
        }
	    .darkRedClass
	    {
	       background-color: #FFD3D5;
	    }
	    .whiteClass
        {
           background-color: #FFF;
        }
            .toBeProcessedClass
        {
           
           color: #000000;
           font-weight: bold;
        }
</style>
<script type="text/javascript">


 var temp4='<%=barchval%>';
var datas;

 if(temp4!='NA')
{ 
	
   datas='<%=searchDAO.mastersearch(barchval,fromdate,todate)%>';    
  
  
 
		// alert(enqdata); --%>
} 
else
{ 
	
	datas;
	
	}  

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     {name : 'doc_no', type: 'int'  },
 
                        {name : 'voc_no', type: 'int'  },
						 
                        {name : 'client', type: 'string'  },
                        {name : 'category', type: 'string'  },
                        {name : 'update', type: 'string'  },
			 
                        {name : 'purreq', type: 'string'  },
                        {name : 'purreqqot', type: 'string'  },
                        {name : 'sqot', type: 'string'  },
                        
                        {name : 'sorder', type: 'string'  },
                        {name : 'porder', type: 'string'  },
                        {name : 'pinv', type: 'string'  },
                        
                        {name : 'del', type: 'string'  },
                        {name : 'sinv', type: 'string'  },
                        {name : 'clientid', type: 'number'  },
                        
                        {name : 'branchvals', type: 'string'  },
                       
                     
                        
                        
						],
				    localdata: datas,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
 
    var cellclassname = function (row, column, value, data) {
		if (column != '') {
            return "toBeProcessedClass";
        }  
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
   
   
    
    $("#enquirylist").jqxGrid(
    {
        width: '99.5%',
        height: 250,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  
                   
                      { text: 'Doc No',datafield: 'doc_no', width: '6%',hidden:true },
                      { text: 'Doc No',datafield: 'voc_no', width: '8%' ,columngroup:'minf',cellclassname: cellclassname},
                      { text: 'Client',datafield: 'client', width: '32%',columngroup:'minf' ,cellclassname: cellclassname},
                      { text: 'Type',datafield: 'category', width: '10%',columngroup:'minf' ,cellclassname: cellclassname},
                      { text: 'Process ',datafield: 'update', width: '14%',columngroup:'minf'  },
         		 
          
                      
           	         { text: ' P- Req.for Quote', datafield: 'purreq',  width: '12%',columngroup:'pr',cellclassname: 'blueClass' }, 
           	      { text: 'P- Vendor Quote', datafield: 'purreqqot',  width: '12%',columngroup:'pr' , cellclassname: 'blueClass'},
           	      { text: 'S-Quotet', datafield: 'sqot',  width: '12%',columngroup:'pr', cellclassname: 'blueClass' },
           	      
/*            	      { text: 'S-Order', datafield: 'sorder',  width: '7%' ,columngroup:'or', cellclassname: 'redClass'},
           	      { text: 'P-Order', datafield: 'porder',  width: '7%' ,columngroup:'or', cellclassname: 'redClass'},
           	      { text: 'P-Invoice', datafield: 'pinv',  width: '8%' ,columngroup:'or', cellclassname: 'redClass'},
           	       { text: 'Delivery Note', datafield: 'del',  width: '8%',columngroup:'or', cellclassname: 'redClass' },
           	    { text: 'Sales Invoice', datafield: 'sinv',  width: '8%',columngroup:'or', cellclassname: 'redClass' },
            */
           	  { text: 'clientid', datafield: 'clientid',  width: '8%',hidden:true },
           	  { text: 'branchvals', datafield: 'branchvals',  width: '8%',hidden:true },
					
					], columngroups: 
	                     [
	                      

                           { text: 'Sales Enquiry Minimum Info', align: 'center', name: 'minf',width: '20%' },
	                       { text: 'Enquiry process (Sourcing)', align: 'center', name: 'pr',width: '20%' },
	                    /*    { text: 'Sales Order Process', align: 'center', name: 'or',width: '10%' }, */
	                        
	                     ]
   
    });
    
    $('#enquirylist').on('cellclick', function (event) 
    		{ 
    
		  var rowindex1=event.args.rowindex;
		  $('#cmbbranch1').attr('disabled', false);
		  $('#searchgrid').attr('disabled', false);
		  $('#create').attr('disabled', true);
		  document.getElementById("type").value=$('#enquirylist').jqxGrid('getcellvalue', rowindex1, "category");
		   document.getElementById("masterdoc_no").value=$('#enquirylist').jqxGrid('getcellvalue', rowindex1, "doc_no");
		   document.getElementById("clientid").value=$('#enquirylist').jqxGrid('getcellvalue', rowindex1, "clientid");
		   
		   
		   document.getElementById("branchvals").value=$('#enquirylist').jqxGrid('getcellvalue', rowindex1, "branchvals");
		   
		   
		   
		
		   
	       $("#detaildiv").load("detailgrid.jsp?rdoc="+$('#enquirylist').jqxGrid('getcellvalue', rowindex1, "doc_no"));
	    
	 
    	
    		});
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="enquirylist"></div>