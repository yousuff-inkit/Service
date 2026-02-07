<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.skips.contractreview.ClsContractReviewDAO" %>
<% ClsContractReviewDAO DAO= new ClsContractReviewDAO(); 
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno"); %> 

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

$(document).ready(function () {   	
             var num = 1; 
             var griddata;
             griddata='<%=DAO.contractrenewalGrid(session,docno)%>';    
             
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'doc_no', type: 'number'  }, 
                	{name : 'startdt', type: 'date'  }, 
                	{name : 'enddt', type: 'date'  },  
					{name : 'wastetype', type: 'string'   },
					{name : 'skiptype', type: 'string'  },
					{name : 'ownership', type: 'string'  },
					{name : 'nos', type: 'int'   },
                  	{name : 'serviceterm', type: 'string'  },
                  	{name : 'days', type: 'string'  },   
     											
                 ],
                 localdata: griddata,  
                
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
            
            $("#contractrenewalgrid").jqxGrid(
            {
                width: '99.8%',
                height: 230,
                source: dataAdapter,
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                editable:false ,
            	/* showaggregates: true,
             	showstatusbar:true,
             	statusbarheight:25, */  
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '7%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Doc No', datafield: 'doc_no',width:'7%'},  
                        	{ text: 'Start Date', datafield: 'startdt',width:'8%',cellsformat:'dd.MM.yyyy' },
                        	{ text: 'End Date', datafield: 'enddt',width:'8%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Waste Type', datafield: 'wastetype' },	
							{ text: 'Skip Size', datafield: 'skiptype', width: '10%' },	
							{ text: 'Ownership', datafield: 'ownership', width: '10%'},
				            { text: 'Skip Qty', datafield: 'nos', width: '6%'},
				            { text: 'Service Term', datafield: 'serviceterm', width: '12%'},  
							{ text: 'No of Visit', datafield: 'days', width: '10%'},   
							]  
            });

        });
     
    </script>
    <div id="contractrenewalgrid"></div> 