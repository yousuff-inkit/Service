   

  <%@page import="com.realestate.tenancycontract.ClsTenancyContractDAO" %>
<%ClsTenancyContractDAO DAO=new ClsTenancyContractDAO();
 
 
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String tenant = request.getParameter("tenant")==null?"NA":request.getParameter("tenant");
 String pname = request.getParameter("pname")==null?"NA":request.getParameter("pname");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 
 String descriptions = request.getParameter("descriptions")==null?"NA":request.getParameter("descriptions"); 
 
 String refnoss = request.getParameter("refnoss")==null?"NA":request.getParameter("refnoss"); 
 
 
%>
<script type="text/javascript">


var datamain11= '<%=DAO.materearch(session,docnoss,tenant,pname,datess,aa,descriptions,refnoss) %>'; 
        $(document).ready(function () {  
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            
                            {name : 'voc_no', type: 'int'   },
                         
                            {name : 'date', type: 'date'   },
     					 
     						{name : 'refname', type: 'string'   },
     					 
     					 
     						{name : 'pname', type: 'string'   },
     				 
     					 
     						
     					 
     						
     						
     						
     						 
     						  
                        ],
                		localdata: datamain11, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#searshgrid1").jqxGrid(
            {
                width: '100%',
                height: 283,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                
   						
{ text: 'Doc No', datafield: 'doc_no', width: '6%',hidden:true },
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Tenant ', datafield: 'refname', width: '30%'  },
							{ text: 'Property', datafield: 'pname' },
						
							 
								 
								 
						]
            });
            
             $('#searshgrid1').on('rowdoubleclick', function (event) {    
                var rowindex1 = event.args.rowindex;
                
           	 document.getElementById("docno").value = $('#searshgrid1').jqxGrid('getcellvalue',rowindex1, "voc_no");
        	 document.getElementById("masterdoc_no").value = $('#searshgrid1').jqxGrid('getcellvalue',rowindex1, "doc_no");
 
        	   $('#window').jqxWindow('close');  
             	 
            	 funSetlabel();
              
                
             document.getElementById("frmTenancyContract").submit();
           	 
          
             
            }); 
             
        });
    </script>
    <div id="searshgrid1"></div>