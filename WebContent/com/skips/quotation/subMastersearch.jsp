<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%@page import="com.skips.quotation.ClsQuotationDAO"%> 
<%
   ClsQuotationDAO DAO= new ClsQuotationDAO();
   String msenqno = request.getParameter("msenqno")==null?"0":request.getParameter("msenqno");
   String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
   String Cl_names = request.getParameter("Cl_names")==null?"0":request.getParameter("Cl_names");
   String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate");
   String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").trim(); 
 %>  

 <script type="text/javascript">
 
 var enqmasterdata; 
  enqmasterdata='<%=DAO.searchMaster(session,msdocno,msenqno,Cl_names,enqdate,id)%>' ;     
		
  $(document).ready(function () {  	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
		        	    {name : 'cldocno', type: 'String'  },
						{name : 'refname', type: 'String'  },
						{name : 'source', type: 'String'  }, 
						{name : 'source_id', type: 'String'  },
						{name : 'tr_no', type: 'String'  },
						{name : 'sal_id', type: 'String'  },
						{name : 'sal_name', type: 'String'  },
						{name : 'doc_no', type: 'String'  },  
						{name : 'enqvocno', type: 'String'  }, 
						{name : 'enqdocno', type: 'String'  }, 
						{name : 'remarks', type: 'String'  },
						{name : 'com_add1', type: 'String'  }, 
						{name : 'mob', type: 'String'  }, 
						{name : 'telno', type: 'String'  }, 
						{name : 'email', type: 'String'  },
						{name : 'date', type: 'Date'  }, 
						{name : 'netamount', type: 'number'  }, 
						{name : 'groupcompanies', type: 'String'  }, 
						{name : 'billingmethod', type: 'String'  },
						{name : 'payterms', type: 'String'  },
						{name : 'revision_no', type: 'String'  },
						{name : 'cperson', type: 'String'  }, 
						{name : 'cpersonid', type: 'String'  }, 
						{name : 'ay_name', type: 'String'  },    
                   	],
          localdata: enqmasterdata,
         
         
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
     $("#jqxsubMasterSearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
         altRows: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
         columns: [
        	    { text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' },        
        	    { text: 'Doc No', datafield: 'doc_no', width: '8%' },  
        	    { text: 'Enq. No', datafield: 'enqvocno', width: '8%'  },  
        	    { text: 'Revision No', datafield: 'revision_no', width: '8%'},
				{ text: 'Name', datafield: 'refname', width: '36%'},
				{ text: 'Contact Person', datafield: 'cperson', width: '10%' },   
				{ text: 'Source', datafield: 'source', width: '10%' }, 
				{ text: 'Salesman', datafield: 'sal_name'},      
				{ text: 'Net Amount', datafield: 'netamount', width: '8%',hidden:true}, 
				{ text: 'sourceid', datafield: 'source_id', width: '5%' ,hidden:true},
			    { text: 'doc_no', datafield: 'tr_no', width: '5%',hidden:true },
			    { text: 'Salesman Id', datafield: 'sal_id', width: '5%',hidden:true },  
			    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true }, 
			    { text: 'Enq Doc No', datafield: 'enqdocno', width: '5%',hidden:true }, 
			    { text: 'Remarks', datafield: 'remarks', width: '5%',hidden:true },
			    { text: 'com_add1', datafield: 'com_add1', width: '5%',hidden:true }, 
			    { text: 'mob', datafield: 'mob', width: '5%',hidden:true }, 
			    { text: 'telno', datafield: 'telno', width: '5%',hidden:true }, 
			    { text: 'email', datafield: 'email', width: '5%',hidden:true },
			    { text: 'groupcompanies', datafield: 'groupcompanies', width: '5%',hidden:true }, 
			    { text: 'billingmethod', datafield: 'billingmethod', width: '5%',hidden:true },
			    { text: 'payterms', datafield: 'payterms', width: '5%',hidden:true },
			    { text: 'cpersonid', datafield: 'cpersonid', width: '5%',hidden:true },
			    { text: 'ay_name', datafield: 'ay_name', width: '5%',hidden:true },
				]
     });
     

     $('#jqxsubMasterSearch').on('rowdoubleclick', function (event) { 
 	       var rowindex1=event.args.rowindex;
 	       $("#revbtn").attr('value', 'Revise');
 	       $("#revbtn").attr('disabled', false ); 
 	       $("#btnothercontracts").attr('disabled', false );
		   $("#btnpendingquotes").attr('disabled', false );
   	       $('#quoteDate').jqxDateTimeInput({ disabled: false});   
   	       dateformatchanger("quoteDate",$('#jqxsubMasterSearch').jqxGrid('getcelltext', rowindex1, "date"));          
           //$('#quoteDate').val($("#jqxsubMasterSearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
           document.getElementById("hidcldocno").value= $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
           document.getElementById("txtclient").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
           document.getElementById("txtenquiry").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "enqvocno");   
           document.getElementById("hidenqdocno").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "enqdocno"); 
           document.getElementById("docno").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
           document.getElementById("masterdoc_no").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
           document.getElementById("txtsalesmandocno").value= $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "sal_id");
		   document.getElementById("txtsalesman").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
		   document.getElementById("txtsource").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "source");
		   document.getElementById("sourceid").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "source_id");
		   document.getElementById("txtdesc").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
		   document.getElementById("txtmail").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "email");
		   document.getElementById("txtaddress").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "com_add1");
		   document.getElementById("txtmob").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "mob");
		   document.getElementById("txttele").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "telno"); 
		   document.getElementById("netamount").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "netamount");   
		   document.getElementById("txtgroupcompanies").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "groupcompanies"); 
		   document.getElementById("cmbbillingmethod").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "billingmethod");
		   document.getElementById("hidcmbpayterm").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "payterms");
		   document.getElementById("txtrevise").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "revision_no"); 
		   document.getElementById("txtcperson").value= $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cperson");
           document.getElementById("hidcpersonid").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");   
           document.getElementById("txtdesig").value=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "ay_name");
           
		   getPayterms();     
		   document.getElementById("cmbpayterm").value= $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "payterms");     
		    var indexVal2 = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");  
            var txtrevise = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "revision_no");   
            $("#quotdiv").load("quoteDetails.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);  
            $("#sitediv").load("siteGrid.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);    
            funDtype();
			getapprcount();
			apprCheck();
            $('#quoteDate').jqxDateTimeInput({ disabled: false}); 
            enquiryAlert();
           /*  document.getElementById("frmQuotation").submit(); */
            $('#window').jqxWindow('close');
     	 });	 
 });
</script>
<div id="jqxsubMasterSearch"></div>
    </body>
</html>
