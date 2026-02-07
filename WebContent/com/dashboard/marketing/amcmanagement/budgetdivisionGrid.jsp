<%@page import="com.dashboard.marketing.amcmanagement.ClsAmcManagementDAO"%>   
<% ClsAmcManagementDAO DAO=new ClsAmcManagementDAO(); %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
  <% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();%>
 <% String docno =request.getParameter("docno")==null || request.getParameter("docno")==""?"0":request.getParameter("docno").toString();%>
 <script type="text/javascript">
 var data1;
        data1= '<%= DAO.subGridData(id,docno)%>';   
        
        $(document).ready(function () {
        	var rendererstring=function (aggregates){
        	  	var value=aggregates['sum'];
        	  	
        	  	if(typeof(value)=='undefined'){
        	  		value=0;
        	  	}
        	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
        		}
        	  	var rendererstring1=function (aggregates){
        	  	var value1=aggregates['sum1'];
        	  	return '<div style="float: left; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
        	  }
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String'  },
     						{name : 'name', type: 'String'  },
     						{name : 'budget', type: 'number'  },      
     					     						
                 ],
                 localdata: data1,
                
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
            $("#jqxsubdivGrid").jqxGrid(
            {
                width: '99%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                enabletooltips:true,
                altRows: true,
                sortable: true,
                editable: true,     
                selectionmode: 'checkbox',             
                showfilterrow:true,
                filterable: true,
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '5%',hidden:true },  
					{ text: 'Name',  datafield: 'name',editable: false},
					{ text: 'Budget', datafield: 'budget', width: '10%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring  },   
	              ]               
            });
            /* if(bb==1)
        	{
        	 $("#jqxsubdivGrid").jqxGrid('addrow', null, {});  
        	} */

                 $("#overlay, #PleaseWait").hide();     
        });
    </script>
    <div id="jqxsubdivGrid"></div>
