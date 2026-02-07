<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.controlcentre.legacydata.productopening.ClsproductopeningDAO"%>
<% ClsproductopeningDAO searchDAO = new ClsproductopeningDAO();


 
%> 





 
<script type="text/javascript">


var brdata= '<%=searchDAO.branchsearch() %>';  
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [


                             {name : 'doc_no', type: 'String'  },    
      						{name : 'branchname', type: 'String'  },
      				 
                             
                             
                        ],
                		localdata: brdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#brdata").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
          				{ text: 'ID', datafield: 'doc_no', width: '20%',hidden:true},
    					{ text: 'NAME', datafield: 'branchname', width: '100%' }
										
						]
            });
            
             $('#brdata').on('rowdoubleclick', function (event) {
               
                    var rowindex1 = event.args.rowindex;
     
                  var rowindex2=  document.getElementById("rowindex").value;
       

                  $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "brhid",$('#brdata').jqxGrid('getcellvalue', rowindex1, "doc_no"));

                  $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "branch",$('#brdata').jqxGrid('getcellvalue', rowindex1, "branchname"));
                  
                  

                  $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "locid","");

                  $('#purchasedetails').jqxGrid('setcellvalue', rowindex2, "location","");
                  $('#branchwindow').jqxWindow('close');  
            
                }); 
        
       
             
        });
    </script>
    <div id="brdata"></div>