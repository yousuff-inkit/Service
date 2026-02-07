
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.sales.ClsSalesReportsDAO"%>
 <% ClsSalesReportsDAO searchDAO = new ClsSalesReportsDAO(); 
 
String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String Cl_enqno = request.getParameter("Cl_enqno")==null?"0":request.getParameter("Cl_enqno");
 String qotdate = request.getParameter("qotdate")==null?"0":request.getParameter("qotdate");
 String qottype = request.getParameter("qottype")==null?"0":request.getParameter("qottype").trim(); 

%> 

 <script type="text/javascript">
 
 var qotmasterdata; 
 

  qotmasterdata='<%=searchDAO.searchMaster(session,msdocno,Cl_names,Cl_enqno,qotdate,qottype)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
					{name : 'voc_no' , type: 'number' },
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                	{name : 'dtype' , type: 'String' },
                	{name : 'brhid' , type: 'String' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'name' , type: 'String' },
                   	{name : 'cladd' , type: 'String' },
                 	{name : 'ref_type' , type: 'String' },
                 	{name : 'rrefno' , type: 'String' },
                   	],
          localdata: qotmasterdata,
         
         
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
     $("#subquotationSearch").jqxGrid(
     {
         width: '100%',
         height: 320,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
        selectionmode: 'singlerow',
         pagermode: 'default',
        

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
				{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Dtype', datafield: 'dtype', width: '10%'},
				{ text: 'Brhid', datafield: 'brhid', width: '20%',hidden:true},
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'cladd', datafield: 'cladd', width: '20%',hidden:true },
				{ text: 'Client', datafield: 'name', width: '55%' },
				{ text: 'Ref.type', datafield: 'ref_type', width: '10%' },
				{ text: 'Enquiry', datafield: 'rrefno', width: '10%',hidden:true },
				
				]
     });
     
     $('#subquotationSearch').on('celldoubleclick', function (event) {
         
      var  rowindex1=event.args.rowindex;
 
        document.getElementById("quotdocno").value= $('#subquotationSearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
       
        $('#Searchwindow').jqxWindow('close');
        
     	 });
     
     

 });
</script>
<div id="subquotationSearch"></div>

    
    </body>
</html>
