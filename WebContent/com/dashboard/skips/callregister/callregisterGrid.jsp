<%@page import="com.dashboard.skips.callregister.ClsCallRegisterDAO" %>
<% ClsCallRegisterDAO DAO= new ClsCallRegisterDAO();  %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 String barchval=request.getParameter("barchval")==null || request.getParameter("barchval")==""?"0":request.getParameter("barchval").trim().toString(); 
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 %> 
 <style type="text/css">
  .redClass {
       background-color: #FE9892; 
    }
    .blueClass {
       background-color: #B0E2FF; 
    }
     .pinkClass {
       background-color: #FBC4EC; 
    }
</style>
    <script type="text/javascript">
    var ccdata;  
    var id='<%=id%>';

    $(document).ready(function () { 
    	 var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	if(typeof(value) == "undefined"){
         		value=0.00;
         	}
         	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
         }
  	
    var rendererstring1=function (aggregates){
          var value1=aggregates['sum1'];
          return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
         }
  	  
    	ccdata='<%=DAO.callregisterData(session,id,barchval)%>';     
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'doc_no', type: 'String'  },
		      	       	    {name : 'date', type: 'date'  },
		                  	{name : 'wastetype', type: 'string'  },
		                	{name : 'time', type: 'String'  }, 
                          	],
                 localdata: ccdata,
                
                
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
            
            $("#jqxCallRegisterGrid").jqxGrid(
            {
                width: '100%',
                height: 560,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable:true,
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                showfilterrow:true,
                //Add row method
                columns: [{ text: 'SL#', sortable: false, filterable: false, editable: false,
                    groupable: false, draggable: false, resizable: false,
                    datafield: '', columntype: 'number', width: '4%',
                    cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
		                    }
					},
					{ text: 'Contract No', datafield: 'doc_no', width: '8%',editable:false},	
					{ text: 'Date', datafield: 'date', width: '7%',editable:false,cellsformat:'dd.MM.yyyy'},
					{ text: 'Time', datafield: 'time', width: '7%',editable:false,cellsformat:'HH:mm'},	
					{ text: 'Waste Type', datafield: 'wastetype',editable:false},      
					]    
            });
       	 $("#overlay, #PleaseWait").hide();
            $("#jqxCallRegisterGrid").jqxGrid('addrow', null, {});
      });
    </script>
    <div id="jqxCallRegisterGrid"></div>        