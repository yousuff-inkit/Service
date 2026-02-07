<%@page import="com.dashboard.analysis.jobcostdivisionwise.ClsJobCostDivisionwiseDAO" %>
<%
	ClsJobCostDivisionwiseDAO sd=new ClsJobCostDivisionwiseDAO();
%>  
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
  <% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();%>
 <% String docno =request.getParameter("docno")==null?"0":request.getParameter("docno").toString();%>
 <script type="text/javascript">
 var data1;
         data1= '<%= sd.getdivisionwisedetails(docno)%>'; 
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
        $(document).ready(function () { 	        
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
                height: 200,
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
					{ text: 'Budget', datafield: 'budget', width: '7%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring  },   
	              ]               
            });
            if(bb==1)
        	{
        	 $("#jqxsubdivGrid").jqxGrid('addrow', null, {});
        	}

                 $("#overlay, #PleaseWait").hide();     
        });
    </script>
    <div id="jqxsubdivGrid"></div>
