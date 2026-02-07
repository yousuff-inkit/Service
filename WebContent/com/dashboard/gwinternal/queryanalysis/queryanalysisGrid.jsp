<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.dashboard.gwinternal.queryanalysis.ClsQueryAnalysisDAO"%>
<% ClsQueryAnalysisDAO DAO=new ClsQueryAnalysisDAO(); %>
<% 
	String statusdocno =request.getParameter("statusdocno")==null?"":request.getParameter("statusdocno").toString();
	String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
	String id = request.getParameter("id")==null?"":request.getParameter("id").trim();
	String type = request.getParameter("type")==null?"":request.getParameter("type").trim();
	String comprefid = request.getParameter("comprefid")==null?"":request.getParameter("comprefid").trim();  
%>  

<style type="text/css">
.redClass {
	background-color: #FFEBEB;
}

.yellowClass {
	background-color: #FFFF00;
}

.orangeClass {
	background-color: #FFEBC2;
}
</style>
<script type="text/javascript">  
 var data;  
 data= '<%=DAO.queryLoad(session,fromdate,todate,id,type,statusdocno,comprefid) %>';                   
    
        $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
	                	    {name : 'dtype', type: 'String'  },
							{name : 'doc_no', type: 'String'  },
							{name : 'formname', type: 'String' },
							{name : 'shortdesc', type: 'String' },
							{name : 'query', type: 'String' },
							{name : 'status', type: 'String' },
							{name : 'postdate', type: 'date' },
							{name : 'username', type: 'String' },
							{name : 'usermobile', type: 'String' },
							{name : 'usermail', type: 'String' },
							{name : 'deployedtime', type: 'date' },
							{name : 'totaltime', type: 'String' },    
     						
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
            $("#jqxqueryGrid").jqxGrid(
            {
                width: '99.5%',
                height: 530,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filterable: true,
                //pagermode: 'default',
		        filterable: true,
		        showfilterrow: true,
                sortable: true,
                enabletooltips:true,  
                //Add row method
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Date',  datafield: 'postdate', width: '12%', cellsformat: 'dd.MM.yyyy HH:mm:ss'  },  
                            { text: 'Ticket No',  datafield: 'doc_no', width: '6%' },     
                            { text: 'Form Name',  datafield: 'formname', width: '13%' },   
                            { text: 'Short Description',  datafield: 'shortdesc', width: '13%' },   
                            { text: 'Query',  datafield: 'query', width: '10%'},   
                            { text: 'Assigned Status',  datafield: 'status', width: '10%' },   
                            { text: 'User Name',  datafield: 'username', width: '10%' },   
                            { text: 'User Mobile',  datafield: 'usermobile', width: '10%' },   
                            { text: 'User Mail',  datafield: 'usermail', width: '10%' },   
                            { text: 'Deployed Time',  datafield: 'deployedtime', width: '12%', cellsformat: 'dd.MM.yyyy HH:mm:ss'  },    
                            { text: 'Total Time',  datafield: 'totaltime', width: '5%' },         
	              ]
            });
       
            $("#overlay, #PleaseWait").hide();
        });
    </script>
<div id="jqxqueryGrid"></div>
