<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.seal.expensesinvoice.ClsExpensesInvoiceDAO"%>
<%ClsExpensesInvoiceDAO DAO = new ClsExpensesInvoiceDAO();%>
<%
String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
 String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 

 <script type="text/javascript">
 
 var cldata;
        $(document).ready(function () {  
        	 cldata='<%=DAO.searchClient(session,clname,mob,id)%>';
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
     						 {name : 'cldocno', type: 'String'  },
     						 {name : 'refname', type: 'String'  },
     						 {name : 'acno', type: 'String'  }, 
     						 {name : 'tax', type: 'String'  }, 
     						 {name : 'rate', type: 'String'  }, 
     						 {name : 'curid', type: 'String'  }, 
                          	],
                          	localdata: cldata,
                          //	 url: url1,
                
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
            $("#Jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
     					
                columns: [
						{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
						{ text: 'NAME', datafield: 'refname' },
						{ text: 'ACNO', datafield: 'acno', width: '1%',hidden:true }, 
						{ text: 'TAX', datafield: 'tax', width: '1%',hidden:true }, 
						{ text: 'curid', datafield: 'curid', width: '1%',hidden:true }, 
						{ text: 'rate', datafield: 'rate', width: '1%',hidden:true }, 
					]        
            });
				            
		    $('#Jqxclientsearch').on('rowdoubleclick', function (event) { 
				              	var rowindex1=event.args.rowindex;
				              	var rate = $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "rate");
				              	var curid = $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "curid");
				                $("#hidcltax").val($('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "tax"));
				                $("#hidacno").val($('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "acno"));
				                $("#hidcldocno").val($('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno"));
				                $("#txtclient").val($('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname"));
				                $("#currencyid").val(curid);
				                $("#hidcurid").val(curid);
				                $("#txtrate").val($('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "rate"));
				                setGrid(rate);   
				                $('#clientsearch').jqxWindow('close');     
		   }); 	       
      }); 
    </script>
    <div id="Jqxclientsearch"></div>