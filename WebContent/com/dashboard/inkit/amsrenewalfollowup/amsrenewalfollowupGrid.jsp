    <%-- <jsp:include page="../../includes.jsp"></jsp:include>  --%> 
    
  <%@page import="com.dashboard.inkit.amsrenewalfollowup.amsRenewalFollowupDAO"%>
<%
amsRenewalFollowupDAO sd=new amsRenewalFollowupDAO();
%>
    
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <%
String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
  String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();%>

 <script type="text/javascript">
 var data,amcrenewalexcel;
 
 var bb='<%=branchval%>';
	if(bb!='0'){
 data= '<%= sd.loadGridData(uptodate,chkfollowup,followupdate,branchval)%>';
 //alert(data);
 <%-- amcrenewalexcel= '<%= sd.loadGridExcel( uptodate, chkfollowup, followupdate,branchval) %>'; --%>
	}
	else{
		bb=5;
	}
    //alert("==================loadSalikData");
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'dtype', type: 'String'  },
     						{name : 'client', type: 'String' },
     						{name : 'cperson', type: 'String' },
     						{name : 'cpersonid', type: 'int' },
     						{name : 'reftype', type: 'String' },
     						{name : 'refno', type: 'String' },
     						{name : 'sdate', type: 'date' },
     						{name : 'edate', type: 'date' },
     						{name : 'cval', type: 'String' },
     						
     						{name : 'lfee', type: 'String' },
     						{name : 'fdate', type: 'date' },
     						
     						{name : 'brch', type: 'String' },
     						{name : 'tr_no', type: 'String' },
     						{name : 'cldocno', type: 'String' },
     						{name : 'site', type: 'String' },
     						{name : 'siteadd', type: 'String' },
     						
     						{name : 'mob', type: 'String' },
     						{name : 'tel', type: 'String' },
     						{name : 'mail', type: 'String' },
     						{name : 'address', type: 'String' },
     						{name : 'sal_name', type: 'String' },
     						{name : 'enqtype', type: 'String' },
     						{name : 'salid', type: 'String' },
     						{name : 'rate', type: 'number' },
     						{name : 'curid', type: 'String' },
     						
     						{name : 'noofmonths', type: 'int'  },
      						{name : 'amount', type: 'number'  },
      						{name : 'billfrequency', type: 'int'  },
      						{name : 'extrahrsrate', type: 'number'  },
      						{name : 'supporthrs', type: 'number'  },
      						{name : 'carryforwards', type: 'int'  },
      						{name : 'cfmaxper', type: 'number'  },
      						{name : 'cfminper', type: 'number'  }, 
      						{name : 'taxper', type: 'number'  },
      						{name : 'enqdocno', type: 'number'  },
      						{name : 'partnerclient', type: 'String'  },
      						
      						
     					     						
                 ],
                 localdata: data,
                
                
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                showfilterrow:true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                enabletooltips:true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '5%' },
					{ text: 'Doc Type',  datafield: 'dtype', width: '4%' },
					{ text: 'Client', datafield: 'client' },
					{ text: 'Contact Person', datafield: 'cperson', width: '10%' },
					{ text: 'Site', datafield: 'site', width: '10%' },
				//	{ text: 'Site Details', datafield: 'siteadd', width: '15%' },
					{ text: 'Ref Dtype', datafield: 'reftype', width: '5%' },
					{ text: 'Ref No', datafield: 'refno', width: '9%' },
					{ text: 'Start Date', datafield: 'sdate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'End Date', datafield: 'edate', width: '6%',cellsformat:'dd.MM.yyyy' },
					{ text: 'Contract Value',  datafield: 'cval', width: '8%',hidden:true },
					
					{ text: 'Legal Fees',  datafield: 'lfee', width: '5%',hidden:true },
					{ text: 'Followup Date', datafield: 'fdate', width: '7%',cellsformat:'dd.MM.yyyy' },
					
					{ text: 'Branch Id',  datafield: 'brch', width: '10%' ,hidden:true},
					{ text: 'Tr No',  datafield: 'tr_no', width: '10%' ,hidden:true},
					{ text: 'cpersonid',  datafield: 'cpersonid', width: '10%' ,hidden:true},
					{ text: 'Client No',  datafield: 'cldocno', width: '10%' ,hidden:true},
					
					{ text: 'mob',  datafield: 'mob', width: '10%' ,hidden:true},
					{ text: 'tel',  datafield: 'tel', width: '10%' ,hidden:true},
					{ text: 'mail',  datafield: 'mail', width: '10%' ,hidden:true},
					{ text: 'address',  datafield: 'address', width: '10%' ,hidden:true},
					
					{ text: 'Sales Man',  datafield: 'sal_name', width: '10%' },
					
					{ text: 'enqtype',  datafield: 'enqtype', width: '10%' ,hidden:true},
					{ text: 'currency',  datafield: 'curid', width: '10%' ,hidden:true},
					{ text: 'rate',  datafield: 'rate', width: '10%' ,hidden:true},
					
					{ text: 'noofmonths',  datafield: 'noofmonths', width: '10%' ,hidden:true},
					{ text: 'amount',  datafield: 'amount', width: '10%' ,hidden:true},
					{ text: 'billfrequency',  datafield: 'billfrequency', width: '10%' ,hidden:true},
					{ text: 'extrahrsrate',  datafield: 'extrahrsrate', width: '10%' ,hidden:true},
					{ text: 'supporthrs',  datafield: 'supporthrs', width: '10%' ,hidden:true},
					{ text: 'carryforwards',  datafield: 'carryforwards', width: '10%' ,hidden:true},
					{ text: 'cfmaxper',  datafield: 'cfmaxper', width: '10%' ,hidden:true},
					{ text: 'cfminper',  datafield: 'cfminper', width: '10%' ,hidden:true},
					{ text: 'taxper',  datafield: 'taxper', width: '10%' ,hidden:true},
					{ text: 'enqdocno',  datafield: 'enqdocno', width: '10%',hidden:true },
					{ text: 'partnerclient', datafield: 'partnerclient',hidden:true },
					 
					
	              ]
            });
        /*    if(bb==5)
        	{
        	 $("#jqxloaddataGrid").jqxGrid('addrow', null, {});
        	}
	*/
                 $("#overlay, #PleaseWait").hide();
                 
                 $('#jqxloaddataGrid').on('rowdoubleclick', function (event) { 
                 	  var rowindex1=event.args.rowindex;
                 	 $('#btncontract').attr("disabled",false);
                       $('#cmbprocess').attr("disabled",false);$('#txtremarks').attr("readonly",false);
                     //  $('#legno').attr("readonly",false);
                       $('#date').jqxDateTimeInput({disabled: false});$('#btnupdate').attr("disabled",false);
                 		 
                 	document.getElementById("contno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                 	document.getElementById("conttype").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "dtype");
                 	document.getElementById("txtbranch").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "brch");
                 	document.getElementById("txtdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
                 	document.getElementById("txtcldocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
                 	 document.getElementById("txtclient").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "client");	
                 	 document.getElementById("txtcperson").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "cperson");
                 	 document.getElementById("txtcpersonid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "cpersonid");
                     
                 	document.getElementById("txtmob").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "mob");
                	 document.getElementById("txttel").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "tel");	
                	 document.getElementById("txtmail").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "mail");
                	 document.getElementById("txtaddress").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "address");
                	 document.getElementById("txtsalname").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "sal_name");
                	 document.getElementById("txtsalid").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "salid");
                	 
                	  document.getElementById("txtrefno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "refno");
                	 document.getElementById("txttype").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "reftype");
                	 document.getElementById("txtenqtype").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "enqtype");
                	 document.getElementById("cmbcurr").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "curid");
                	 document.getElementById("clientcurrate").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "rate");
                	 
                	 document.getElementById("txtnoofmonths").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "noofmonths");
                	 document.getElementById("txtamount").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "amount");
                	 document.getElementById("cmbbillfrequency").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "billfrequency");
                	 document.getElementById("txtextrahrsrate").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "extrahrsrate");
                	 document.getElementById("txtsupporthrs").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "supporthrs");
                	 document.getElementById("cmbcarryforwards").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "carryforwards"); 
                	 document.getElementById("txtcfmaxper").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "cfmaxper");
                	 document.getElementById("txtcfminper").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "cfminper");
                	 document.getElementById("txttaxper").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "taxper");  
                	 document.getElementById("enqdocno").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "enqdocno");
                	 document.getElementById("txtpartnerclient").value=$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, "partnerclient");
                	 
                 	 $("#detailDiv").load("detailGrid.jsp?trno="+$('#jqxloaddataGrid').jqxGrid('getcellvalue', rowindex1, 'tr_no'));
                    }); 
        });
    </script>
    <div id="jqxloaddataGrid"></div>
