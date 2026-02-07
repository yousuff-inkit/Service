<%@page import="com.finance.nipurchase.nipurchaseorder.ClsnipurchaseorderDAO" %>
<%ClsnipurchaseorderDAO DAO= new ClsnipurchaseorderDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<% String contextPath=request.getContextPath();%>
<%String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String nipureqdate = request.getParameter("nipureqdate")==null?"0":request.getParameter("nipureqdate"); 
 String requestedby = request.getParameter("requestedby")==null?"NA":request.getParameter("requestedby"); 
 String remark = request.getParameter("remark")==null?"NA":request.getParameter("remark"); 
 String desc = request.getParameter("desc")==null?"NA":request.getParameter("desc");  
 String orderdocno = request.getParameter("orderdocno")==null?"0":request.getParameter("orderdocno");
 int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 

 <script type="text/javascript">
 
  var nipureqmasterdata; 

  nipureqmasterdata='<%=DAO.niPurchaseRequestSearch(session, msdocno, nipureqdate, requestedby, remark, desc, orderdocno, id)%>';

  $(document).ready(function () { 	
	 var orderdocno='<%=orderdocno%>';
     
     var num = 0; 
     var source =
     {
    		 
         datatype: "json",
         datafields: [
        	  		{name : 'doc_no', type: 'int'  },
        	  		{name : 'rowno', type: 'int'  },
              		{name : 'voc_no', type: 'int'  },
              		{name : 'date', type: 'date'   },
					{name : 'remark', type: 'string'  },
					{name : 'requestedby', type: 'string'  },
					{name : 'desc1', type: 'string'  },
					{name : 'description', type: 'string'  },
					{name : 'qty', type: 'qty'  },
                   	],
          localdata: nipureqmasterdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,
     		 {
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
	            }		
     );
     $("#niPuReqSearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         selectionmode: 'checkbox',

         columns: [
        	 		{ text: 'master', datafield: 'doc_no',hidden:true},
        	 		{ text: 'rowno', datafield: 'rowno',hidden:true},
             		{ text: 'Doc No', datafield: 'voc_no', width: '5%' },
					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Requested By', datafield: 'requestedby', width: '17%' },
					{ text: 'Remark', datafield: 'remark' },
					{ text: 'Description', datafield: 'description', width: '25%'},
					{ text: 'Quantity', datafield: 'qty', width: '8%'},
				]
     });
     
 });
</script>

<div id="niPuReqSearch"></div>
    
    </body>
</html>
