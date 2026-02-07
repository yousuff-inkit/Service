<%@page import="com.it.staffingcontract.ClsStaffingContractDAO"%>

 <%ClsStaffingContractDAO DAO=new ClsStaffingContractDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String service = request.getParameter("service")==null?"0":request.getParameter("service");
 String discipline = request.getParameter("discipline")==null?"0":request.getParameter("discipline");
 String comodities = request.getParameter("comodities")==null?"0":request.getParameter("comodities");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
 
 	   var data= '<%=DAO.comodityDetailsSearch(docno,service,discipline,comodities,chk) %>';
   
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'service', type: 'String'  },
     						{name : 'discipline', type: 'String'  },
     						{name : 'comodity', type: 'String'  },
     						{name : 'serid', type: 'int'  },
     						{name : 'tradeid', type: 'int'  }
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
            $("#jqxspecDetGrid").jqxGrid(
            {
                width: '100%',
                height: 336,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:true,
                
                columns: [
							{ text: 'Doc No',columntype: 'int',editable:false, filtertype: 'input', datafield: 'doc_no', width: '10%' },
							{ text: 'Service',columntype: 'String',editable:false, filtertype: 'input', datafield: 'service', width: '20%' },
							{ text: 'Discipline',columntype: 'String',editable:false, filtertype: 'input', datafield: 'discipline', width: '30%' },
							{ text: 'Skills',columntype: 'String',editable:false, filtertype: 'input', datafield: 'comodity', width: '40%' },
							{ text: 'Tradeid',columntype: 'int',editable:false, filtertype: 'input',hidden: true, datafield: 'tradeid', width: '10%' },
							{ text: 'SerId',columntype: 'int',editable:false, filtertype: 'input',hidden: true, datafield: 'serid', width: '10%' }
	              		]
            });
            
            $("#jqxspecDetGrid").bind('cellendedit', function (event) {
                if (event.args.value) {
                    $("#jqxspecDetGrid").jqxGrid('selectrow', event.args.rowindex);
                }
                else {
                    $("#jqxspecDetGrid").jqxGrid('unselectrow', event.args.rowindex);
                }
            });
           
            $('#jqxspecDetGrid').on('rowdoubleclick', function (event) { 
            	
        	 	var rowIndex =$('#rowindex').val();
       	    	var rowindex1=event.args.rowindex;
     	  
        	    $('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "comodityid",$('#jqxspecDetGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
        		$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "services",$('#jqxspecDetGrid').jqxGrid('getcellvalue', rowindex1, "service"));
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "discipline",$('#jqxspecDetGrid').jqxGrid('getcellvalue', rowindex1, "discipline"));
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "commodity",$('#jqxspecDetGrid').jqxGrid('getcellvalue', rowindex1, "comodity"));
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "tradeid",$('#jqxspecDetGrid').jqxGrid('getcellvalue', rowindex1, "tradeid"));
				$('#jqxcontractDetails').jqxGrid('setcellvalue', rowIndex, "serviceid",$('#jqxspecDetGrid').jqxGrid('getcellvalue', rowindex1, "serid"));
                
                $('#specdetinfowindow').jqxWindow('close'); 
        	});
          
        });

</script>
<div id=jqxspecDetGrid></div>