<%@page import="com.cargo.enquiry.ClscargoEnquiryDAO" %>

<%ClscargoEnquiryDAO cargoEnquiryDAO=new ClscargoEnquiryDAO(); %>
 <script type="text/javascript">
			 
		  	 var barnddata='<%=cargoEnquiryDAO.placesearch()%>';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                             
                            {name : 'code', type: 'string'  },
                            {name : 'place', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxpodSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
                            
                              { text: 'PLACE ', datafield: 'place', width: '100%' }
						
			
	             
						]
            });
            
          $('#jqxpodSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "pod" ,$('#jqxpodSearch').jqxGrid('getcellvalue', rowindex2, "place"));
                $('#jqxEnquiry').jqxGrid('setcellvalue', rowindex1, "podid" ,$('#jqxpodSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                var rows = $('#jqxEnquiry').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                	  $("#jqxEnquiry").jqxGrid('addrow', null, {});	
                }
              
                document.getElementById("errormsg").innerText="";
                
                
              $('#podsearchwndow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="jqxpodSearch"></div>