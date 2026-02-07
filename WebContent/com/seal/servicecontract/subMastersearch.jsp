<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.seal.servicecontract.ClsServiceContractDAO" %>
<%ClsServiceContractDAO DAO= new ClsServiceContractDAO();%>  
<%
 String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
 String surdate = request.getParameter("surdate")==null?"0":request.getParameter("surdate");
 int id = request.getParameter("id")==null || request.getParameter("id").trim().equals("")?0:Integer.parseInt(request.getParameter("id").toString());
%> 

 <script type="text/javascript">
 
  var searchdata; 
  searchdata='<%=DAO.searchMaster(session, msdocno, Cl_names, surdate, id)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                  	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'cldocno' , type: 'String' },
                   	{name : 'refname' , type: 'String' },  
                    {name : 'tr_no' , type: 'number'}, 
                    ],
          localdata: searchdata,   
         
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
     $("#subsearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         selectionmode: 'singlerow',
         pagermode: 'default',

         columns: [
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
				{ text: 'Cldocno', datafield: 'cldocno', width: '20%',hidden:true },
				{ text: 'Name', datafield: 'refname'},
				{ text: 'trno', datafield: 'tr_no', width: '20%',hidden:true },
				] 
     });
     
     $('#subsearch').on('celldoubleclick', function (event) {
         
    	 var rowindex1=event.args.rowindex;
    	 
    	 $('#docno').attr('disabled', false);
 		 $('#masterdoc_no').attr('disabled', false);
 		 $('#mode').attr('disabled', false);
    	 $('#date').jqxDateTimeInput({ disabled: false}); 
         
         document.getElementById("txtclient").value= $('#subsearch').jqxGrid('getcellvalue', rowindex1, "refname");
         document.getElementById("clientid").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
         $('#date').jqxDateTimeInput('val',$('#subsearch').jqxGrid('getcellvalue', rowindex1, "date"));
         document.getElementById("masterdoc_no").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
         document.getElementById("docno").value=$('#subsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
         var docno=$('#masterdoc_no').val();
 		 if(docno>0){
 			  $("#seryeardiv").load("serviceyearlyGrid.jsp?id="+1+"&trno="+docno);         
 			  $("#seronediv").load("serviceonetimeGrid.jsp?id="+2+"&trno="+docno);    
 		 }
 		 funSetlabel();   
         $('#frmservicecontract').submit();  
         $('#window').jqxWindow('close');
     });
 });
</script>
<div id="subsearch"></div>
    
    </body>
</html>
