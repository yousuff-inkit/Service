<%@page import="com.skips.enquiry.ClsEnquiryDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsEnquiryDAO DAO= new ClsEnquiryDAO();
 %>
 <%
 int rowIndex=request.getParameter("rowBoundIndex")==null || request.getParameter("rowBoundIndex")==""?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 

 String cldocno=request.getParameter("cldocno")==""?"0":request.getParameter("cldocno").trim().toString();
 %>
    <script type="text/javascript">
    var sitedata;
    var cldocno='<%=cldocno%>';
    var rowIndex='<%=rowIndex%>';

    $(document).ready(function () { 
    	
    	if(cldocno>0){
    		sitedata='<%=DAO.siteGridLoad1(session,cldocno)%>';
    	}	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'srno' , type: 'number' },
					{name : 'site', type: 'String'  },
                  	{name : 'area', type: 'String'  },
                  	{name : 'areaid', type: 'String'  },
                  	{name : 'remarks', type: 'String'  },
                  	{name : 'surtype', type: 'String'  },
                  	{name : 'surid', type: 'String'  },
                  	{name : 'rowno', type: 'String'  },
                	{name : 'route', type: 'String'  },
                	{name : 'gpsx', type: 'String'  },
                	{name : 'gpsy', type: 'String'  },
                	{name : 'description', type: 'String'  },
                  	{name : 'cdocno', type: 'String'  },

                ],
                 localdata: sitedata,
                
                
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
            $("#site1Grid").jqxGrid(
            {
                width: '100%',
                height: '90%',
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
              //  sortable: true,
                selectionmode: 'singlecell',
               // sortable: true,
                editable:true,
                filterable:true,
                showfilterrow:true,
                selectionmode: 'singlerow',
            
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site',width:'30%',editable:false},
					{ text: 'Area',datafield:'area',width:'25%',editable:false},
					{ text: 'Remarks', datafield: 'remarks', width: '30%' },
					{ text: 'Survey Type', datafield: 'surtype', width: '5%' ,editable:false,hidden:true},  
					{ text: 'Areaid',datafield:'areaid',width:'5%',editable:false,hidden:true},
					{ text: 'surveyid',datafield:'surid',width:'5%',editable:false,hidden:true},
					{ text: 'rowno',datafield:'rowno',width:'5%',editable:false,hidden:true},
					{ text: 'route',datafield:'route',width:'5%',editable:false,hidden:true},
					{ text: 'gpsx',datafield:'gpsx',width:'5%',editable:false,hidden:true},
					{ text: 'gpsy',datafield:'gpsy',width:'5%',editable:false,hidden:true},
					{ text: 'description',datafield:'description',width:'5%',editable:false,hidden:true},
					{ text: 'Contract No',datafield:'cdocno',editable:false},

					]
            });
            
            
        	$('#site1Grid').on('rowdoubleclick', function (event)  { 
              	var rowindex1=event.args.rowindex;  
             	$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "siteid",$('#site1Grid').jqxGrid('getcellvalue', rowindex1, "siteid"));
              	$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "site",$('#site1Grid').jqxGrid('getcellvalue', rowindex1, "site"));
              	$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "areaid",$('#site1Grid').jqxGrid('getcellvalue', rowindex1, "areaid"));
              	$('#siteGrid').jqxGrid('setcellvalue', rowIndex, "area",$('#site1Grid').jqxGrid('getcellvalue', rowindex1, "area"));
	        	
              	$('#site1infowindow').jqxWindow('close');            
}); 
           
            $("#siteGrid").jqxGrid('addrow', null, {});

          
       
           $('#window').jqxWindow('close');
            		
        });
    </script>
    <div id="site1Grid"></div>
