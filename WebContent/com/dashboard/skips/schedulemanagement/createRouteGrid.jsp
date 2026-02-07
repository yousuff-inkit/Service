 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <%@page import="com.dashboard.pricemanagement.pricemanagementreview.ClsPriceManagementReviewDAO"%>
 <% ClsPriceManagementReviewDAO searchDAO = new ClsPriceManagementReviewDAO(); 
  String contextPath=request.getContextPath();%>
<% 
String psrno=request.getParameter("psrno")==null?"0":request.getParameter("psrno").toString();
%>
<script type="text/javascript">
 
 
  var psrno='<%=psrno%>';
if(psrno>0){
	var pmdata='<%=searchDAO.pricelistgridsearch(psrno)%>'; 
 
	 
}
else{  
	var pmdata;
  }   

        $(document).ready(function () { 
        
     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						 {name : 'jobno', type: 'number' }, 
     						{name : 'skipno', type: 'number' }, 
     						{name : 'site', type: 'string'  },        
     						{name : 'skipname', type: 'string'   },
     						{name : 'cordinate', type: 'string'   },
     						{name : 'desc', type: 'string'   },
     						
							
							
                        ],
                         localdata: pmdata,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
           
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxcreateroutegrid").jqxGrid(
            {
                width: '100%',
                height: 150,
                source: dataAdapter,
                editable: true,
                
                selectionmode: 'singlecell',  
                 filterable:true,
                 showfilterrow:true,
                 enabletooltips:true,
                       
                columns: [
							{ text: 'Seq. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
	                               return "<div style='margin:4px;'>" + (value + 1) + "</div>";
                            }   },
							{ text: 'Contract No', datafield: 'jobno', width: '10%', editable: true  },
			 
							
							{ text: 'Skip No', datafield: 'skipno', editable: false  },
							{ text: 'Skip Name', datafield: 'skipname',  width: '20%', editable: false  },
							
							{ text: 'Site', datafield: 'site',  width: '20%', editable: false },
							{ text: 'Coordinates', datafield: 'cordinates',  width: '20%', editable: false }, 
							{ text: 'Description', datafield: 'desc',  width: '20%', editable: false }, 
							
							
				 
						]
            });
         
      
            $("#overlay, #PleaseWait").hide(); 
            
        });
</script>
<div id="jqxcreateroutegrid"></div>
 