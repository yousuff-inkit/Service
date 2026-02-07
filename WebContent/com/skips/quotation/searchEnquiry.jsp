<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.quotation.ClsQuotationDAO"%>  
<%
  	ClsQuotationDAO DAO= new ClsQuotationDAO();
     
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
							{name : 'source', type: 'String'  }, 
							{name : 'sourceid', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
							{name : 'sal_id', type: 'String'  },
							{name : 'sal_name', type: 'String'  },
							{name : 'voc_no', type: 'String'  },  
							{name : 'com_add1', type: 'String'  }, 
							{name : 'mob', type: 'String'  }, 
							{name : 'telno', type: 'String'  }, 
							{name : 'email', type: 'String'  }, 
							{name : 'groupcompanies', type: 'String'  }, 
							{name : 'cperson', type: 'String'  }, 
							{name : 'cpersonid', type: 'String'  }, 
							{name : 'ay_name', type: 'String'  }, 
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
							{ text: 'Name', datafield: 'refname', width: '42%'},
							{ text: 'Contact Person', datafield: 'cperson', width: '20%' },   
							{ text: 'Source', datafield: 'source', width: '10%' }, 
							{ text: 'Salesman', datafield: 'sal_name', width: '20%' }, 
							{ text: 'sourceid', datafield: 'sourceid', width: '5%' ,hidden:true},
						    { text: 'doc_no', datafield: 'doc_no', width: '5%',hidden:true },
						    { text: 'Salesman Id', datafield: 'sal_id', width: '5%',hidden:true },  
						    { text: 'CLIENT NO', datafield: 'cldocno', width: '5%',hidden:true },
						    { text: 'com_add1', datafield: 'com_add1', width: '5%',hidden:true }, 
						    { text: 'mob', datafield: 'mob', width: '5%',hidden:true }, 
						    { text: 'telno', datafield: 'telno', width: '5%',hidden:true }, 
						    { text: 'email', datafield: 'email', width: '5%',hidden:true }, 
						    { text: 'groupcompanies', datafield: 'groupcompanies', width: '5%',hidden:true }, 
						    { text: 'cpersonid', datafield: 'cpersonid', width: '5%',hidden:true },  
						    { text: 'ay_name', datafield: 'ay_name', width: '5%',hidden:true },
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
							   document.getElementById("txtsource").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "source");
							   document.getElementById("sourceid").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "sourceid");
							   document.getElementById("txtmail").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "email");
							   document.getElementById("txtaddress").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "com_add1");
							   document.getElementById("txtmob").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "mob");
							   document.getElementById("txttele").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "telno"); 
							   document.getElementById("txtgroupcompanies").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "groupcompanies"); 
							   document.getElementById("txtcperson").value= $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "cperson");
				               document.getElementById("hidcpersonid").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");  
				               document.getElementById("txtdesig").value=$('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "ay_name");     
				               
							   var indexVal2 = $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
					           $("#quotdiv").load("quoteDetails.jsp?enqdocno="+indexVal2+"&id="+1);  
					           $("#sitediv").load("siteGrid.jsp?enqdocno="+indexVal2+"&id="+1);
					            
					           var cldocno = $('#jqxEnquirySearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
					           if(cldocno=="" || cldocno=="0"){  
						        	$('#txtmail').attr('readonly', false);
						       		$('#txtmob').attr('readonly', false);
						       		$('#txttele').attr('readonly', false);  
						            $('#txtcperson').attr('readonly', false);
					           }else{
					        	    $('#txtmail').attr('readonly', true);
						       		$('#txtmob').attr('readonly', true);
						       		$('#txttele').attr('readonly', true);  
						            $('#txtcperson').attr('readonly', true);  
					           }
					           document.getElementById("errormsg").innerText="";
					           $('#enqsearch').jqxWindow('close');      
		  }); 	 
        
      }); 
    </script>
    <div id="jqxEnquirySearch"></div>  
    