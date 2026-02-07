<%@page import="com.skips.invoice.ClsManualInvoiceDAO1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String client = request.getParameter("client")==null?"":request.getParameter("client");
String cmbagmttype = request.getParameter("cmbagmttype")==null?"":request.getParameter("cmbagmttype");
String agmtno = request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String date = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
String docno = request.getParameter("docno")==null?"":request.getParameter("docno");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String site = request.getParameter("site")==null?"":request.getParameter("site");
ClsManualInvoiceDAO1 invdao=new ClsManualInvoiceDAO1(); 
System.out.println("date="+date);  
%> 
 <script type="text/javascript">
 var  loaddata='<%=invdao.mainSearch(client,cmbagmttype,agmtno,date,docno,branch,id,site)%>';    
        $(document).ready(function () { 
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                         	{name : 'doc_no', type: 'String'  },
                         	{name : 'voc_no',type:'string'},
                        	{name : 'cnttrno',type:'string'},
                        	{name : 'reftype',type:'string'},
     						{name : 'refname', type: 'String'  },
     						{name : 'cntdocno', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },  
     						{name : 'date', type: 'date'  },
     						{name : 'cldocno', type: 'String'  },  
     						{name : 'site', type: 'String'  },  
                          	],
                          	localdata: loaddata,
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
					{ text: 'MASTER DOC NO', datafield: 'doc_no', width: '10%',hidden:true },//Invoice Doc No
					{ text: 'DOC NO', datafield: 'voc_no', width: '10%' },//Invoice Voucher No
					{ text: 'REF TYPE', datafield: 'reftype', width: '10%' }, 
					{ text: 'CNT NO', datafield: 'cntdocno', width: '10%' },
					{ text: 'Contract No', datafield: 'cnttrno', width: '10%',hidden:true  }, 
					{ text: 'CLDOCNO', datafield: 'cldocno', width: '10%',hidden:true  }, 
					{ text: 'DATE', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
					{ text: 'CLIENT', datafield: 'refname' },
					{ text: 'Site', datafield: 'site', width: '20%' }  
					]
            });
    
            $("#jqxmainsearch").jqxGrid('addrow', null, {});  
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) { 
				        		var row2=event.args.rowindex;
				            	document.getElementById("masterdoc_no").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "doc_no");
				            	document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "voc_no");
				            	document.getElementById("txtcontract").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "cntdocno");  
				            	document.getElementById("hidcntrno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "cnttrno");
				            	document.getElementById("hidcldocno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "cldocno");
				            	document.getElementById("txtclient").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "refname");
				            	document.getElementById("cmbreftype").value=$('#jqxmainsearch').jqxGrid('getcellvalue', row2, "reftype"); 
				            	$('#frmSkipInvoice select').attr('disabled', false);  
				        		$("#fromdate").jqxDateTimeInput({ disabled: false});
				                $("#todate").jqxDateTimeInput({ disabled: false}); 
				                funSetlabel();
				            	document.getElementById("frmSkipInvoice").submit();
				                $('#window').jqxWindow('close');
				        });	 
        
                  }); 
    </script>
    <div id="jqxmainsearch"></div>