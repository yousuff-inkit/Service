<%@page import="com.skips.quotation.ClsQuotationDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 	ClsQuotationDAO DAO= new ClsQuotationDAO();
 %>
 <%
 String trno=request.getParameter("trno")==null || request.getParameter("trno")==""?"0":request.getParameter("trno").trim().toString(); 
 String enqdocno=request.getParameter("enqdocno")==null || request.getParameter("enqdocno")==""?"0":request.getParameter("enqdocno").trim().toString(); 
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
 String revisionno=request.getParameter("revisionno")==null || request.getParameter("revisionno")==""?"999999":request.getParameter("revisionno").trim().toString(); 
 %> 
    <script type="text/javascript">
    var sitedata;  
    var id='<%=id%>';
    $(document).ready(function () { 
    	
    	 if(id==1){   
    		 sitedata='<%=DAO.siteGridLoad(session,enqdocno,id,revisionno)%>';      
    	 }else if(id==2){
    		 sitedata='<%=DAO.siteGridLoad(session,trno,id,revisionno)%>'; 
    	 }else{}     
            
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
                          	{name : 'route', type: 'String'  },
                        	{name : 'gpsx', type: 'String'  },
                        	{name : 'gpsy', type: 'String'  },
                        	{name : 'description', type: 'String'  },
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
            $("#siteGrid").jqxGrid(
            {
                width: '100%',
                height: 120,
                source: dataAdapter,
                columnsresize: true,
                //altRows: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site'},
					{ text: 'Area',datafield:'area',width:'25%',editable:false},      
					{ text: 'Remarks', datafield: 'remarks', width: '35%' },
					{ text: 'Survey Type', datafield: 'surtype', width: '4%' ,editable:false,hidden:true},  
					{ text: 'Areaid',datafield:'areaid',width:'5%',editable:false,hidden:true},
					{ text: 'surveyid',datafield:'surid',width:'6%',editable:false,hidden:true},
					{ text: 'route',datafield:'route',width:'7%',editable:false,hidden:true},
					{ text: 'gpsx',datafield:'gpsx',width:'8%',editable:false,hidden:true},
					{ text: 'gpsy',datafield:'gpsy',width:'9%',editable:false,hidden:true},
					{ text: 'description',datafield:'description',width:'10%',editable:false,hidden:true},
					]
            });
            
            $('#siteGrid').on('celldoubleclick', function(event) {
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
 		      
 		        if((datafield=="area")) {
 		    	 	getareas(rowBoundIndex); 
	    	    }
 		    });
            
            if($('#mode').val()=='view'){
          		 $("#siteGrid").jqxGrid({ disabled: true});
            }else{
            	 $("#siteGrid").jqxGrid({ disabled: false});
            }
            $("#siteGrid").jqxGrid('addrow', null, {});
        });
    </script>
    <div id="siteGrid"></div>