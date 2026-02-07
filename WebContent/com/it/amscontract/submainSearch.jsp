<%@page import="com.it.amscontract.ClsAmsContractDAO" %>
<%ClsAmsContractDAO DAO= new ClsAmsContractDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
String brcid = request.getParameter("brcid")==null?"0":request.getParameter("brcid");
 String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String cno = request.getParameter("dno")==null?"0":request.getParameter("dno");
 String RefNo =request.getParameter("RefNo")==null?"0":request.getParameter("RefNo");
 int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 
 
<script type="text/javascript">
  
  var cno='<%=cno%>';
  var eloaddata='<%=DAO.mainSrearch(session,brcid,sclname,smob,cno,RefNo,id)%>'; 
 
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'refname', type: 'String'  },
     						{name : 'mob', type: 'String'  },
      						{name : 'voc_no', type: 'String'  },
      						{name : 'doc_no', type: 'String'  },
      						{name : 'refno', type: 'String'  },
      						{name : 'reftype', type: 'String'  },
      						{name : 'address', type: 'String'  },
      						{name : 'mob', type: 'String'  },
      						{name : 'tel', type: 'String'  },
      						{name : 'email', type: 'String'  },
      						{name : 'cperson', type: 'String'  },
      						{name : 'cpid', type: 'String'  },
      						{name : 'sal_name', type: 'String'  },
      						{name : 'salid', type: 'String'  },
      						{name : 'date', type: 'date'  },
      						{name : 'fromdt', type: 'date'  },
      						{name : 'todt', type: 'date'  },
      						{name : 'cldocno', type: 'String'  },
      						{name : 'curid', type: 'int'  },
      						{name : 'currate', type: 'number'  },
      						{name : 'txtenqtype', type: 'String'  },
      						{name : 'partnerclient', type: 'String'  },
      						{name : 'noofmonths', type: 'int'  },
      						{name : 'amount', type: 'number'  },
      						{name : 'billfrequency', type: 'int'  },
      						{name : 'extrahrsrate', type: 'number'  },
      						{name : 'supporthrs', type: 'number'  },
      						{name : 'carryforwards', type: 'int'  },
      						{name : 'cfmaxper', type: 'number'  },
      						{name : 'cfminper', type: 'number'  }, 
      						{name : 'taxper', type: 'number'  }, 
      						
                          	],
                          	localdata: eloaddata,
                          
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
    
                columns: [
		                    { text: 'Doc No', datafield: 'voc_no', width: '15%'},
							{ text: 'Client Name', datafield: 'refname', width: '40%' }, 
							{ text: 'Mobile', datafield: 'mob', width: '25%' },
							{ text: 'Ref No', datafield: 'refno', width: '20%' },
							{ text: 'cldocno', datafield: 'cldocno', width: '20%',hidden:true },
							{ text: 'reftype', datafield: 'reftype', width: '20%',hidden:true },
							{ text: 'address', datafield: 'address', width: '20%',hidden:true },
							{ text: 'tel', datafield: 'tel', width: '20%',hidden:true },
							{ text: 'email', datafield: 'email', width: '20%',hidden:true },
							{ text: 'cperson', datafield: 'cperson', width: '20%',hidden:true },
							{ text: 'cpid', datafield: 'cpid', width: '20%',hidden:true },
							{ text: 'sal_name', datafield: 'sal_name', width: '20%',hidden:true },
							{ text: 'salid', datafield: 'salid', width: '20%',hidden:true },
							{ text: 'date', datafield: 'date', width: '20%',hidden:true, cellsformat: 'dd.MM.yyyy'  },
							{ text: 'fromdt', datafield: 'fromdt', width: '20%',hidden:true , cellsformat: 'dd.MM.yyyy' },
							{ text: 'todt', datafield: 'todt', width: '20%',hidden:true , cellsformat: 'dd.MM.yyyy' },
							{ text: 'curid', datafield: 'curid',hidden:true },
							{ text: 'currate', datafield: 'currate',hidden:true },
							{ text: 'txtenqtype', datafield: 'txtenqtype',hidden:true },
						 	{ text: 'partnerclient', datafield: 'partnerclient',hidden:true },
							{ text: 'noofmonths', datafield: 'noofmonths',hidden:true },
							{ text: 'amount', datafield: 'amount',hidden:true },
							{ text: 'billfrequency', datafield: 'billfrequency',hidden:true },
							{ text: 'extrahrsrate', datafield: 'extrahrsrate',hidden:true },
							{ text: 'supporthrs', datafield: 'supporthrs',hidden:true },
							{ text: 'carryforwards', datafield: 'carryforwards',hidden:true },
							{ text: 'cfmaxper', datafield: 'cfmaxper',hidden:true },
							{ text: 'cfminper', datafield: 'cfminper',hidden:true },
							{ text: 'taxper', datafield: 'taxper',hidden:true },

					]
            });
    
		          $('#jqxmainsearch').on('rowdoubleclick', function (event) { 
		        	     var rowindex1=event.args.rowindex;
		        
		                 document.getElementById("masterdoc_no").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
		                 document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "voc_no");
		                 document.getElementById("txtclientname").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
		                 document.getElementById("txtclientdet").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "refname");
		                 document.getElementById("clientid").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
		                 document.getElementById("cmbreftype").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "reftype");
		                 document.getElementById("txtrefno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "refno");
		                 document.getElementById("txtaddress").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "address");
		                 document.getElementById("txtmobile").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "mob");
		                 document.getElementById("txttelno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "tel");
		                 document.getElementById("txtemail").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "email");
		                 document.getElementById("txtcontactperson").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cperson");
		                 document.getElementById("cptrno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cpid");
		                 document.getElementById("txtsalesman").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
		                 document.getElementById("txtsalesmandocno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "salid");
		                 document.getElementById("cmbcurr").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "curid");
		                 document.getElementById("clientcurrate").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "currate");
		                 document.getElementById("txtenqtype").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "txtenqtype");
		                 $('#jqxIenqDate').jqxDateTimeInput('val',$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "date"));
		                 $('#hidjqxIenqDate').jqxDateTimeInput('val',$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "date"));
		                 $('#jqxIfrmDate').jqxDateTimeInput('val',$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "fromdt"));
		                 $('#hidjqxIfrmDate').jqxDateTimeInput('val',$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "fromdt"));
		                 $('#jqxItoDate').jqxDateTimeInput('val',$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "todt"));
		                 $('#hidjqxItoDate').jqxDateTimeInput('val',$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "todt"));
		                 document.getElementById("txtpartnerclient").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "partnerclient");
		                 document.getElementById("txtnoofmonths").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "noofmonths");
		                 document.getElementById("txtamount").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "amount");
		                 document.getElementById("cmbbillfrequency").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "billfrequency");
		                 document.getElementById("txtextrahrsrate").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "extrahrsrate");
		                 document.getElementById("txtsupporthrs").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "supporthrs");
		                 document.getElementById("cmbcarryforwards").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "carryforwards");
		                 document.getElementById("txtcfmaxper").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cfmaxper");
		                 document.getElementById("txtcfminper").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cfminper");
		                 document.getElementById("txttaxper").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "taxper");

		                var indexVal1 = document.getElementById("masterdoc_no").value;
			       		$("#contractDiv").load('amsContractGrid.jsp?docno='+indexVal1);
			       		funchkforedit();
		                // document.getElementById("frmEnquiry").submit();
		                 $('#window').jqxWindow('close');
		               
		            });	 
        
                  }); 
                       
    </script>
    <div id="jqxmainsearch"></div>
    
