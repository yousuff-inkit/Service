<%@page import="com.cargo.transportmasters.servicetype.ClsServiceTypeDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsServiceTypeDAO cd=new ClsServiceTypeDAO(); %>
<% String contextPath=request.getContextPath();%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">
		 var data;  
        $(document).ready(function () { 
           
            var temp='<%=check%>';
             
             if(temp>0){   
            	 data='<%=cd.getServiceTypeGrid(check)%>';    
           	 }
                                
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date' }, 
     						{name : 'srvtype', type: 'string'   },
     						{name : 'modename', type: 'string'  },
     						{name : 'submode', type: 'string'   },
     						{name : 'shipment', type: 'String'   },
     						{name : 'modeid', type: 'int'  },
     						{name : 'smodeid', type: 'int'  },
     						{name : 'shipid', type: 'int'  },
     						{name : 'inacno', type: 'int'  },
     						{name : 'exacno', type: 'int'  },
     						{name : 'indesc', type: 'string'   },
     						{name : 'exdesc', type: 'String'   },
     						{name : 'tax', type: 'String'   },
     						{name : 'seqno', type: 'int'   }
     					
                        ],
                         localdata: data,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxServiceType").jqxGrid(
            {
                 width: '99.5%',
                 height:310,
	             source: dataAdapter,
	             showfilterrow: true,
	             filterable: true,
	             selectionmode: 'singlerow',
	             sortable: true,
	             altrows:true,
              
                columns: [
							{ text: 'Doc No', datafield: 'doc_no',filtertype: 'number', editable: false, width: '4%' },
							{ text: 'Seq No', datafield: 'seqno',filtertype: 'number', editable: false, width: '4%' },
                            { text: 'Date', datafield: 'date',filtertype: 'date', cellsformat: 'dd.MM.yyyy',  editable: false, width: '6%' },	
							{ text: 'Service Type', datafield: 'srvtype',filtertype: 'textbox', editable: false, width: '19%' },
							{ text: 'Mode', datafield: 'modename',filtertype: 'list', editable: false, width: '7%' },
							{ text: 'Mode Id', datafield: 'modeid',filtertype: 'number', width: '20%',hidden: true,editable: false },
							{ text: 'Submode', datafield: 'submode',filtertype: 'list', editable: false, width: '10%' },
							{ text: 'SubMode Id', datafield: 'smodeid',filtertype: 'number', width: '20%',hidden: true,editable: false },
							{ text: 'Shipment', datafield: 'shipment', filtertype: 'list',width: '10%',editable: false },
							{ text: 'Shipment Id', datafield: 'shipid', filtertype: 'number',width: '20%',hidden: true,editable: false },
							{ text: 'Income Account', datafield: 'inacno', filtertype: 'number',width: '6%',editable: false },
							{ text: 'Description', datafield: 'indesc', filtertype: 'list',width: '14%',editable: false },
							{ text: 'Expense Account', datafield: 'exacno', filtertype: 'number',width: '6%',editable: false },
							{ text: 'Description', datafield: 'exdesc', filtertype: 'list',width: '14%',editable: false },
							]
            });
            $('#jqxServiceType').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxServiceType').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                $("#servicedate").jqxDateTimeInput('val', $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("servicetype").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "srvtype");
                document.getElementById("hidcmbmode").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "modeid");
                document.getElementById("hidcmbsubmode").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "smodeid");
                document.getElementById("cmbsubmode").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "submode");
                document.getElementById("hidcmbshipment").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "shipid");
                document.getElementById("inaccid").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "inacno");
                document.getElementById("inaccname").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "indesc");
                document.getElementById("exaccid").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "exacno");
                document.getElementById("exaccname").value = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "exdesc");
                document.getElementById("seqno").value= $('#jqxServiceType').jqxGrid('getcellvalue', rowindex1, "seqno");
                var chk = $("#jqxServiceType").jqxGrid('getcellvalue', rowindex1, "tax");
                if(parseFloat(chk)==1){
        			document.getElementById("chktaxable").checked = true;
        			document.getElementById("chktaxable").value=1; 
        		}else{
        			document.getElementById("chktaxable").checked = false;
        			document.getElementById("chktaxable").value=0; 
        		}
                getMode();getShipment();
               
                $('#window').jqxWindow('hide');
            }); 
            
        });
    </script>
    <div id="jqxServiceType"></div>
    
