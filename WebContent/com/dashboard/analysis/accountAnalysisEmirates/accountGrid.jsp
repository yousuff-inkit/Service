<%@page import="com.dashboard.analysis.accountAnalysisEmirates.ClsAccountAnalysisDAO"%>
<% ClsAccountAnalysisDAO DAO= new ClsAccountAnalysisDAO(); %>   
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%
    String id =request.getParameter("id")==null?"":request.getParameter("id").toString(); 
	String fromdate =request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString(); 
	String todate =request.getParameter("todate")==null?"":request.getParameter("todate").toString(); 
	String brhid =request.getParameter("barchval")==null?"":request.getParameter("barchval").toString();
%>
    <script type="text/javascript">
    var servdata;
    	servdata = '<%=DAO.dataLoad(session,id,fromdate,todate,brhid) %>';              
     
        $(document).ready(function () { 	
         var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'head' , type: 'String' },
							{name : 'grpname' , type: 'String' }, 
		                  	{name : 'accname' , type: 'String' },
		                  	{name : 'account' , type: 'String' },
		                  	{name : 'dramt' , type: 'number' },
		                  	{name : 'dtype' , type: 'String' },
							{name : 'docno', type: 'String'  },
							{name : 'date', type: 'date'  },
							{name : 'description', type: 'String'  },
							{name : 'branch', type: 'String'  },
							{name : 'costtype', type: 'String'  },
							{name : 'costcode', type: 'String'  },
							{name : 'refname', type: 'String'  },
							{name : 'site', type: 'String'  },   
                          	],
                 localdata: servdata,
                
                
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
            $("#accountGrid").jqxGrid(
            {
                width: '99%',
                height:500,
                source: dataAdapter,
                columnsresize: true,
                sortable: true,
             	selectionmode: 'singlerow',
                editable: false,
                sortable: true,
                showfilterrow:true,
                filterable:true,
                enabletooltips:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";    
                              }
					},
					
					{ text: 'Head', datafield: 'head', width: '15%' },
					{ text: 'Group Name', datafield: 'grpname', width: '13%' },
					{ text: 'Account Name', datafield: 'accname', width: '15%'},
					{ text: 'Account', datafield: 'account', width: '8%'  },
					{ text: 'Dr.Amount', datafield: 'dramt', width: '7%',cellsformat: 'd2', width: '10%', cellsalign: 'right', align: 'right' },
					{ text: 'Dtype', datafield: 'dtype', width: '7%' },
					{ text: 'Doc No', datafield: 'docno', width: '7%' },
					{ text: 'Date', datafield: 'date', width: '7%' ,cellsformat: 'dd.MM.yyyy'},  
					{ text: 'Description', datafield: 'description', width: '23%'},
					{ text: 'Branch', datafield: 'branch', width: '15%'  },
					{ text: 'Cost Type', datafield: 'costtype', width: '9%' },
					{ text: 'Cost Code', datafield: 'costcode', width: '9%' },
					{ text: 'Client', datafield: 'refname', width: '22%'},
					{ text: 'Site', datafield: 'site', width: '20%'  },  
					]  
            });
            $("#overlay, #PleaseWait").hide();   
        });
    </script>
 
   <div id="accountGrid"></div>  
    