<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.sales.enquiryprocess.ClsenquiryprocessDAO"%>
<% ClsenquiryprocessDAO  forquoteDAO = new ClsenquiryprocessDAO(); %> 


<%
/* String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 

 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa");  */
 
 String prdid = request.getParameter("prdid")==null?"NA":request.getParameter("prdid"); 
 
 
%>
<script type="text/javascript">


var maindata= '<%=forquoteDAO.refmainsearch(session,prdid) %>'; 
        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
                            
                            {name : 'voc_no', type: 'int' },
                         
                            {name : 'date', type: 'date'  },
     						{name : 'netamount', type: 'number' },
     						{name : 'type', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'delterm', type: 'string'   },
     						{name : 'payterm', type: 'string'   },
                        	{name : 'deldate', type: 'date'   },
     						{name : 'desc1', type: 'string'   },
     						{name : 'acno', type: 'string'   },
     						{name : 'curid', type: 'string'   },
     						{name : 'nettotal', type: 'number'   },
     					 
     						
     						
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
                height: 365,
                source: dataAdapter,
           
                selectionmode: 'singlerow',
                
                columns: [
                          
                         
                            { text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Account', datafield: 'account', width: '15%' },
							{ text: 'Account Name', datafield: 'description', width: '50%' },
							{ text: 'Net Total', datafield: 'nettotal', width: '15%',cellsformat: 'd2', cellsalign: 'right', align:'right' },
							{ text: 'type', datafield: 'type', width: '5%',hidden:true },
							{ text: 'refno', datafield: 'refno', width: '5%',hidden:true },
							{ text: 'rate', datafield: 'rate', width: '2%' ,hidden:true},
							{ text: 'delterm', datafield: 'delterm', width: '8%',hidden:true },
							{ text: 'payterm',  datafield: 'payterm', width: '5%' ,hidden:true},
							{ text: 'deldate', datafield: 'deldate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
							{ text: 'Description', datafield: 'desc1', width: '32%',hidden:true },
							{ text: 'acno', datafield: 'acno', width: '2%' ,hidden:true},
							{ text: 'curid', datafield: 'curid', width: '2%',hidden:true },
							{ text: 'doc_no', datafield: 'doc_no', width: '2%',hidden:true },
							
						 
										
								
						]
            });
            
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;
               var rowindex1=$('#rowindex').val();
        	  
                $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "rfq" ,$('#mainsearshgrid').jqxGrid('getcellvalue', rowindex2, "voc_no"));
                $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "vendor" ,$('#mainsearshgrid').jqxGrid('getcellvalue', rowindex2, "description"));
                
                                                                                             
               var qty= $('#duedetailsgrid').jqxGrid('getcellvalue', rowindex1, "qty");
               
               var nettotal= $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex2, "nettotal");
               
              var rfqtotal=parseFloat(nettotal)/parseFloat(qty);
              var sqoute=rfqtotal*parseFloat(qty);
                
                $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "rfqprice" ,rfqtotal);
                
                $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "netamount" ,rfqtotal);
                
                
               var rfqprice= $('#duedetailsgrid').jqxGrid('getcellvalue', rowindex1, "rfqprice" );
               
               var brdocno= $('#duedetailsgrid').jqxGrid('getcellvalue', rowindex1, "brdocno" );
               
               
               var psrno= $('#duedetailsgrid').jqxGrid('getcellvalue', rowindex1, "psrno" );
                
               
               
                
                var x=new XMLHttpRequest();
         		x.onreadystatechange=function(){
         			if (x.readyState==4 && x.status==200)
         				{
         				 var items= x.responseText.trim();
         				 	 
         				 	var itemval=items.split("::");
      
         				 	var salesmargin=itemval[0];
         				 	
         				 	 $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "margin", salesmargin);
         				}		
         	 
         		}
         	x.open("GET","getprice.jsp?std_cost="+rfqprice+'&brandid='+brdocno+"&psrno="+psrno);
         		x.send();
                
               // $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "sqoute" ,sqoute);
                
                
                $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "vendordoc" ,$('#mainsearshgrid').jqxGrid('getcellvalue', rowindex2, "acno"));
                $('#duedetailsgrid').jqxGrid('setcellvalue', rowindex1, "rfqmaindoc" ,$('#mainsearshgrid').jqxGrid('getcellvalue', rowindex2, "doc_no"));
                
                
                
                
                

           

              $('#refnosearchwindow').jqxWindow('close');  
          


            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>