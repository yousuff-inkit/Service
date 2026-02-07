<%@page import="com.it.amscontract.ClsAmsContractDAO"%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 <%ClsAmsContractDAO DAO= new ClsAmsContractDAO(); %>
 <%
 String enqid=request.getParameter("refno")==null || request.getParameter("refno").equals("")?"0":request.getParameter("refno").trim().toString();
 String docno=request.getParameter("docno")==null || request.getParameter("docno").equals("")?"0":request.getParameter("docno").trim().toString();
 String reftype=request.getParameter("reftype")==null?"DIR":request.getParameter("reftype").trim().toString();
 
 %>
    <script type="text/javascript">
    var sitedata;
    var enqid='<%=enqid%>';
    var reftype='<%=reftype%>';
    var docno='<%=docno%>';

    $(document).ready(function () { 
	
			if(reftype=='ENQ'){
				sitedata='<%=DAO.mainGridLoadFromEnq(session,enqid)%>'; 
			}else{
				sitedata='<%=DAO.mainGridLoad(session,docno)%>'; 
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
                   	{name : 'serviceteam', type: 'String'  },
                	{name : 'steamid', type: 'String'  },
               		
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
			
			var cellclassname = function (row, column, value, data) {
            	if(data.invtrno>0){
                	return "orangeClass";
                }
            };
			
		
			  
            $("#jqxcontractDetails").jqxGrid(
            {
                width: '100%',
                height: 340,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                sortable: true,
                editable:true,
                //Add row method
	
                 columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Site', datafield: 'site' },
					{text: 'Service Team', datafield: 'serviceteam', width: '10%' , editable:false  },
					{text: 'steamid',datafield:'steamid',width:'25%',editable:false,hidden:true},
					{ text: 'Area',datafield:'area',width:'20%',editable:false },
					{ text: 'Remarks', datafield: 'remarks', width: '30%' },
					{ text: 'Survey Type', datafield: 'surtype', width: '30%' ,editable:false,hidden:true },  
					{ text: 'Areaid',datafield:'areaid',width:'25%',editable:false,hidden:true },
					{ text: 'surveyid',datafield:'surid',width:'25%',editable:false,hidden:true }
					]
            });

            $('#jqxcontractDetails').on('celldoubleclick', function(event) {
            	var rowBoundIndex = event.args.rowindex;
            	var datafield = event.args.datafield;
            	
            	if((datafield=="area")){
   		    	 	getareas(rowBoundIndex);
  	    		}
            	 if((datafield=="serviceteam"))
  	    	   {
  		    	 getserviceteam(rowBoundIndex);
  	    	   }
            });
			
            if($('#mode').val()=='view'){
                
          		 $("#jqxcontractDetails").jqxGrid({ disabled: true});
            }

            $("#jqxcontractDetails").jqxGrid('addrow', null, {});
        });

    </script>
    
    <div id="jqxcontractDetails"></div>
	

     
