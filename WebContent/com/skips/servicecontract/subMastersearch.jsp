<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%@page import="com.skips.servicecontract.ClsServiceContractDAO"%> 
<%
   ClsServiceContractDAO DAO= new ClsServiceContractDAO();
   String msenqno = request.getParameter("msenqno")==null?"":request.getParameter("msenqno");
   String msdocno = request.getParameter("msdocno")==null?"":request.getParameter("msdocno");
   String Cl_names = request.getParameter("Cl_names")==null?"":request.getParameter("Cl_names");
   String enqdate = request.getParameter("enqdate")==null?"":request.getParameter("enqdate");
   String id = request.getParameter("id")==null || request.getParameter("id")==""?"0":request.getParameter("id").trim(); 
   String remarks = request.getParameter("remarks")==null?"":request.getParameter("remarks");  
 %>  

 <script type="text/javascript">
 
 var enqmasterdata; 
  enqmasterdata='<%=DAO.searchMaster(session, msdocno, msenqno, Cl_names, enqdate, remarks, id)%>';              
		
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
						{name : 'startdt', type: 'Date'  },
						{name : 'enddt', type: 'Date'  },
						{name : 'witheffect', type: 'Date'  },
						{name : 'typeid', type: 'String'  },
						{name : 'groupcompanies', type: 'String'  }, 
						{name : 'billingmethod', type: 'String'  },
						{name : 'payterms', type: 'String'  },
						{name : 'refdtype', type: 'String'  },
						{name : 'advinvmethod', type: 'String'  },  
						{name : 'advinvvalue', type: 'String'  },   
						{name : 'revision_no', type: 'String'  },
						{name : 'refno', type: 'String'  },
						{name : 'mergedinvoice', type: 'String'  },
						{name : 'cperson', type: 'String'  }, 
						{name : 'cpersonid', type: 'String'  }, 
						{name : 'advtype', type: 'String'  }, 
						{name : 'inctipfee', type: 'String'  }, 
						{name : 'invstart', type: 'String'  },  
						{name : 'cpemail', type: 'String'  },
						{name : 'intremarks', type: 'String'  },
						{name : 'extremarks', type: 'String'  },   
						{name : 'manualinv', type: 'String'  },   
						{name : 'cctype', type: 'String'  },   
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
         filterable: true,
         showfilterrow: true,
         enabletooltips:true,
         columnsresize: true,
         columns: [
        	    { text: 'Date', datafield: 'date', width: '9%',cellsformat:'dd.MM.yyyy' },    
        	    { text: 'Doc No', datafield: 'doc_no', width: '8%' },  
        	    { text: 'Revision No', datafield: 'revision_no', width: '8%'},  
        	    { text: 'Enq. No', datafield: 'enqvocno', width: '8%'  },  
				{ text: 'Name', datafield: 'refname', width: '25%'},
				{ text: 'Contact Person', datafield: 'cperson', width: '10%' },   
				{ text: 'Source', datafield: 'source', width: '10%' ,hidden:true}, 
				{ text: 'Salesman', datafield: 'sal_name', width: '15%' },        
				{ text: 'sourceid', datafield: 'source_id', width: '5%' ,hidden:true},
			    { text: 'doc_no', datafield: 'tr_no', width: '5%',hidden:true },
			    { text: 'Salesman Id', datafield: 'sal_id', width: '5%',hidden:true },  
			    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true }, 
			    { text: 'Enq Doc No', datafield: 'enqdocno', width: '5%',hidden:true }, 
			    { text: 'Remarks', datafield: 'remarks' },
			    { text: 'com_add1', datafield: 'com_add1', width: '5%',hidden:true }, 
			    { text: 'mob', datafield: 'mob', width: '5%',hidden:true }, 
			    { text: 'telno', datafield: 'telno', width: '5%',hidden:true }, 
			    { text: 'email', datafield: 'email', width: '5%',hidden:true },
			    { text: 'startdt', datafield: 'startdt', width: '5%',hidden:true,cellsformat:'dd.MM.yyyy' },
			    { text: 'enddt', datafield: 'enddt', width: '5%',hidden:true,cellsformat:'dd.MM.yyyy' },  
			    { text: 'typeid', datafield: 'typeid', width: '5%',hidden:true },
			    { text: 'groupcompanies', datafield: 'groupcompanies', width: '5%',hidden:true }, 
			    { text: 'billingmethod', datafield: 'billingmethod', width: '5%',hidden:true },
			    { text: 'payterms', datafield: 'payterms', width: '5%',hidden:true },
			    { text: 'reftype', datafield: 'refdtype', width: '5%',hidden:true }, 
			    { text: 'advinvmethod', datafield: 'advinvmethod', width: '5%',hidden:true },
			    { text: 'advinvvalue', datafield: 'advinvvalue', width: '5%',hidden:true },
			    { text: 'refno', datafield: 'refno', width: '5%',hidden:true },
			    { text: 'mergedinvoice', datafield: 'mergedinvoice', width: '5%',hidden:true },
			    { text: 'advtype', datafield: 'advtype', width: '5%',hidden:true },
			    { text: 'inctipfee', datafield: 'inctipfee', width: '5%',hidden:true },
			    { text: 'invstart', datafield: 'invstart', width: '5%',hidden:true },  
			    { text: 'cpemail', datafield: 'cpemail', width: '5%',hidden:true }, 
			    { text: 'witheffect', datafield: 'witheffect', width: '5%',cellsformat:'dd.MM.yyyy',hidden:true }, 
			    { text: 'intremarks', datafield: 'intremarks', width: '5%',hidden:true }, 
			    { text: 'extremarks', datafield: 'extremarks', width: '5%',hidden:true }, 
			    { text: 'manualinv', datafield: 'manualinv', width: '5%',hidden:true },
			    { text: 'cctype', datafield: 'cctype', width: '5%',hidden:true },
				]  
     });
     

     $('#jqxsubMasterSearch').on('rowdoubleclick', function (event) { 
 	       var rowindex1 = event.args.rowindex;
   	       var startdate = $("#jqxsubMasterSearch").jqxGrid('getcelltext', rowindex1, "startdt").split('.');    
	       var endDate = $("#jqxsubMasterSearch").jqxGrid('getcelltext', rowindex1, "enddt").split('.');
	       var quoteDate = $("#jqxsubMasterSearch").jqxGrid('getcelltext', rowindex1, "date").split('.');
	       var witheffect = $("#jqxsubMasterSearch").jqxGrid('getcelltext', rowindex1, "witheffect").split('.');
	       $('#startDate').jqxDateTimeInput('setDate',new Date(startdate[2],startdate[1]-1,startdate[0]));    
	       $('#endDate').jqxDateTimeInput('setDate',new Date(endDate[2],endDate[1]-1,endDate[0]));
	       $('#quoteDate').jqxDateTimeInput('setDate',new Date(quoteDate[2],quoteDate[1]-1,quoteDate[0])); 
	       $('#witheffectDate').jqxDateTimeInput('setDate',new Date(witheffect[2],witheffect[1]-1,witheffect[0])); 
	       document.getElementById("txtrefno").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "refno");  
           document.getElementById("hidcldocno").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
           document.getElementById("txtclient").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "refname");
           document.getElementById("txtenquiry").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "enqvocno");   
           document.getElementById("hidenqdocno").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "enqdocno"); 
           document.getElementById("docno").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
           document.getElementById("masterdoc_no").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
           document.getElementById("txtsalesmandocno").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "sal_id");
		   document.getElementById("txtsalesman").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
		   document.getElementById("txtdesc").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "remarks");
		   document.getElementById("txtmail").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cpemail");
		   document.getElementById("txtaddress").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "com_add1");
		   document.getElementById("txtmob").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "mob");
		   document.getElementById("txttele").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "telno"); 
		   document.getElementById("hidcmbtype").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "typeid"); 
		   document.getElementById("cmbtype").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "typeid");   
		   document.getElementById("txtgroupcompanies").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "groupcompanies");    
		   document.getElementById("cmbbillingmethod").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "billingmethod");  
		   document.getElementById("cmbpayterm").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "payterms");  
		   document.getElementById("cmbreftype").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "refdtype");  
		   document.getElementById("cmbinvmethod").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "advinvmethod");   
		   document.getElementById("txtadvinvvalue").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "advinvvalue");   
		   document.getElementById("hidcmbpayterm").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "payterms");
		   document.getElementById("txtrevise").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "revision_no"); 
		   document.getElementById("hidchkmergedinv").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "mergedinvoice");
		   document.getElementById("txtcperson").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cperson");
           document.getElementById("hidcpersonid").value =$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
           document.getElementById("hidcmbadvtype").value =$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "advtype");
           document.getElementById("hidcmbinctipfee").value =$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "inctipfee");
           document.getElementById("hidcmbinvstart").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "invstart");
           document.getElementById("cmbadvtype").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "advtype");
           document.getElementById("cmbinctipfee").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "inctipfee");
           document.getElementById("cmbinvstart").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "invstart");    
           document.getElementById("txttobeinvoicedmail").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "email");
           document.getElementById("txtintremarks").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "intremarks");
           document.getElementById("txtextremarks").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "extremarks");
           document.getElementById("hidchkmanualinv").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "manualinv");    
           document.getElementById("cmbcctype").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cctype");    
           document.getElementById("hidcmbcctype").value = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "cctype");
           getPayterms();      
		   
		   var chkmerged = document.getElementById("hidchkmergedinv").value;    
		   if(parseInt(chkmerged)==1){      
				  document.getElementById("chkmergedinv").checked = true;  
		   }else{
				  document.getElementById("chkmergedinv").checked = false;  
		   }
			  
		   var chkmanualinv = document.getElementById("hidchkmanualinv").value;       
		   if(parseInt(chkmanualinv)==1){      
				  document.getElementById("chkmanualinv").checked = true;  
		   }else{
				  document.getElementById("chkmanualinv").checked = false;  
		   }  
		   
		    var indexVal2 = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");  
		    var txtrevise = $('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "revision_no");   
		    $("#quotdiv").load("quoteDetails.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);  
            $("#sitediv").load("siteGrid.jsp?trno="+indexVal2+"&revisionno="+txtrevise+"&id="+2);
            $("#clcondiv").load("clientConfirmGrid.jsp?trno="+indexVal2+"&id="+1+"&revisionno="+txtrevise);        
            $("#termsdiv").load("termDetails.jsp?trno="+indexVal2+"&id="+1);  
            var type=$('#jqxsubMasterSearch').jqxGrid('getcellvalue', rowindex1, "typeid");   
    		if(type=="2"){
    			$("#clconfirmlbl").show(); 
    		}else{
    			$("#clconfirmlbl").hide();
    		}
    		getPayterms();
    		funadvtypechange();
    		editstatuscheck();
    		funDtype();
			getapprcount();
			apprCheck();  
			enquiryAlert()
    		$('#quoteDate').jqxDateTimeInput({ disabled: false});
    		/*  document.getElementById("frmContract").submit();   */
            $('#window').jqxWindow('close');
     	 });	 
 });
</script>
<div id="jqxsubMasterSearch"></div>
    </body>
</html>
