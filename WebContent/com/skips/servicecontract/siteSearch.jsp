<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
<%
 int rowIndex=request.getParameter("rowBoundIndex")==null || request.getParameter("rowBoundIndex")==""?0:Integer.parseInt(request.getParameter("rowBoundIndex").trim()); 
 String gridtextbox = request.getParameter("gridtextbox")==null?"0":request.getParameter("gridtextbox");    
%>

 <script type="text/javascript">
 var servicesite;
 var rowIndex='<%=rowIndex%>';
 var gridtextbox='<%=gridtextbox%>';
        $(document).ready(function () { 
        	servicesite=getSites();
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
							{name : 'docno', type: 'String'  },
							{name : 'site', type: 'String'  },
                          	],
                          	localdata: servicesite,
                          //	 url: url1,
          
				
                
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
            $("#jqxsitesearch").jqxGrid(
            {
                width: '100%',
                height: 420,
                source: dataAdapter,  
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: '', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					{ text: 'Doc No', datafield: 'docno', width: '19%' },
					{ text: 'Site', datafield: 'site', width: '75%' }
					]
            });
    		            
			$('#jqxsitesearch').on('rowdoubleclick', function (event)  {    
				              	var rowindex1=event.args.rowindex;  
				              	$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "siteid",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "docno"));
				              	$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "site",$('#jqxsitesearch').jqxGrid('getcellvalue', rowindex1, "site"));
				              	
				              	$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "ctypeid",1);
				              	$('#jqxQuote').jqxGrid('setcellvalue', rowIndex, "ctype","RENT");    
				              	
					        	$('#siteinfowindow').jqxWindow('close');            
			}); 	 
         });   

          function getSites(){
        	 var rows1 = $("#siteGrid").jqxGrid('getrows');  
        	 var jasond = '{"theTeam":[]}';
        	 for(var i=0 ; i < rows1.length ; i++){
        		 if(typeof(rows1[i].site) != "undefined" && typeof(rows1[i].site) != "NaN" && rows1[i].site != ""){  
        		 var obj = JSON.parse(jasond);
        		 obj['theTeam'].push({"site":rows1[i].site,"docno":i+1});    
        		 jasond = JSON.stringify(obj);  
        		 }  
			}	 
        	return jasond;  
        }
    </script>
    <div id="jqxsitesearch"></div>
    </body>
</html>