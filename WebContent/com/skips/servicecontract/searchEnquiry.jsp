<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.servicecontract.ClsServiceContractDAO"%>  
<%
ClsServiceContractDAO DAO= new ClsServiceContractDAO();
     
    String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
    String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
    int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
  %> 

 <script type="text/javascript">
 
 var cldata;

 cldata='<%=DAO.searchEnquiry(session,clname,docno,id)%>';       
 
        $(document).ready(function () { 
            var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
	                	    {name : 'cldocno', type: 'String'  },
							{name : 'refname', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
							{name : 'sal_id', type: 'String'  },
							{name : 'sal_name', type: 'String'  },
							{name : 'voc_no', type: 'String'  },  
							{name : 'com_add1', type: 'String'  }, 
							{name : 'mob', type: 'String'  }, 
							{name : 'telno', type: 'String'  }, 
							{name : 'email', type: 'String'  }, 
							{name : 'qottrno', type: 'String'  }, 
							{name : 'qotrevno', type: 'String'  }, 
							{name : 'groupcompanies', type: 'String'  }, 
							{name : 'billingmethod', type: 'String'  },
							{name : 'payterms', type: 'String'  },
							{name : 'cperson', type: 'String'  }, 
							{name : 'cpersonid', type: 'String'  }, 
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
            $("#jqxEnquirySearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'voc_no', width: '8%' },  
							{ text: 'Name', datafield: 'refname'},
							{ text: 'Contact Person', datafield: 'cperson', width: '20%' },  
							{ text: 'Salesman', datafield: 'sal_name', width: '20%' }, 
						    { text: 'doc_no', datafield: 'doc_no', width: '5%',hidden:true },
						    { text: 'Salesman Id', datafield: 'sal_id', width: '5%',hidden:true },  
						    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true },
						    { text: 'com_add1', datafield: 'com_add1', width: '5%',hidden:true }, 
						    { text: 'mob', datafield: 'mob', width: '5%',hidden:true }, 
						    { text: 'telno', datafield: 'telno', width: '5%',hidden:true }, 
						    { text: 'email', datafield: 'email', width: '5%',hidden:true },
						    { text: 'qottrno', datafield: 'qottrno', width: '5%',hidden:true },
						    { text: 'qotrevno', datafield: 'qotrevno', width: '5%',hidden:true },
						    { text: 'groupcompanies', datafield: 'groupcompanies', width: '5%',hidden:true }, 
						    { text: 'billingmethod', datafield: 'billingmethod', width: '5%',hidden:true }, 
						    { text: 'payterms', datafield: 'payterms', width: '5%',hidden:true }, 
						    { text: 'cpersonid', datafield: 'cpersonid', width: '5%',hidden:true },   
					]
            });  
			 $('#jqxEnquirySearch').on('rowdoubleclick', function (event) {     
				               var rowindex1=event.args.rowindex;
				               document.getElementById("hidcldocno").value= $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("txtclient").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "refname");
				               document.getElementById("txtenquiry").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
				               document.getElementById("hidenqdocno").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               document.getElementById("txtsalesmandocno").value= $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "sal_id");
							   document.getElementById("txtsalesman").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
							   document.getElementById("txtmail").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "email");
							   document.getElementById("txtaddress").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "com_add1");
							   document.getElementById("txtmob").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "mob");
							   document.getElementById("txttele").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "telno");  
							   document.getElementById("txtgroupcompanies").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "groupcompanies"); 
							   document.getElementById("cmbbillingmethod").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "billingmethod");
							   document.getElementById("cmbpayterm").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "payterms");
							   document.getElementById("hidcmbpayterm").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "payterms");
							   document.getElementById("txtcperson").value= $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "cperson");
				               document.getElementById("hidcpersonid").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");   
							   getPayterms();    
							   var indexVal2 = $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "qottrno"); 
							   var qotrevno = $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "qotrevno"); 
					            $("#quotdiv").load("quoteDetails.jsp?enqdocno="+indexVal2+"&id="+1+"&revisionno="+qotrevno);  
					            $("#sitediv").load("siteGrid.jsp?enqdocno="+indexVal2+"&id="+1+"&revisionno="+qotrevno);            
					            getPayterms();  
					            funnoofmonthval();
					            fuchangetodate();
					            $('#enqsearch').jqxWindow('close');      
		  }); 	 
        
      }); 
    </script>
    <div id="jqxEnquirySearch"></div>  
    