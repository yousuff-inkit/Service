<%@page import="javax.servlet.http.HttpServletRequest" %>
                <%@page import="javax.servlet.http.HttpSession" %>
                <%@page import="com.controlcentre.legacydata.productopening.ClsproductopeningDAO"%>
                <% ClsproductopeningDAO searchDAO = new ClsproductopeningDAO(); %>
<script type="text/javascript">


var maindata= '<%=searchDAO.mainsearch() %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                        
                            {name : 'date', type: 'date'   },
     					
     				 
     						{name : 'description', type: 'string'   },
     					 
     						
                        ],
                		localdata: maindata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                         
                         
                            { text: 'Doc No', datafield: 'doc_no', width: '50%'  },
							{ text: 'Date', datafield: 'date', width: '50%',cellsformat:'dd.MM.yyyy' },
						  
										{ text: 'Description', datafield: 'description', width: '65%' ,hidden:true},
										 
										
						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           	 $('#date').jqxDateTimeInput({ disabled: false});
        	  
        	 document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
        	 document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
 
                $('#date').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "date")) ;
               
           	 $('#date').jqxDateTimeInput({ disabled: true});
           	 
        	 var indexVal2 = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
    		 

        	    $("#overlay, #PleaseWait").show();
             $("#prdgriddiv").load("prdgrid.jsp?reqdoc="+indexVal2);
              $('#window').jqxWindow('close');  
         
        	 funSetlabel();
        	 
        	 
        	 
        	 //document.getElementById("frmprdopn").submit();
        	 
        	 
           
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>