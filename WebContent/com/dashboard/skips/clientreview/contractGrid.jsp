<%@page import="com.dashboard.skips.clientreview.*" %>
<%
ClsClientReviewDAO DAO= new ClsClientReviewDAO();
%>
<%  
    String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
     %> 
<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .greyClass
        {
           background-color: #D8D8D8;
        }
</style>
<script type="text/javascript">
      var owneracdata;
      var temp='<%=cldocno%>';
      
	  	if(temp!='0'){ 
	  		   owneracdata='<%=DAO.contractview(cldocno)%>'; 
	  	}    
	  	
  	
        $(document).ready(function () {
        	
        
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'startdt' , type: 'date' },
							{name : 'enddt' , type:'string'},
							{name : 'docno' , type:'int'},
							{name : 'status' , type:'string'},
							{name : 'site' , type:'string'},
						  ],
                          localdata: owneracdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#contractGrid").jqxGrid(
            {
                width: '98%',
                height: 300,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                enabletooltips: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No',  datafield: 'docno',  width: '6%'  },
							{ text: 'Start Date', datafield: 'startdt', width: '6%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'End Date', datafield: 'enddt', width: '6%', cellsformat: 'dd.MM.yyyy' },
							{ text: 'Status', datafield:'status', width:'10%'},
							{ text: 'Site',  datafield: 'site' },
							
							],
            });
            
			$("#overlay, #PleaseWait").hide();
			
        });

</script>
<div id="contractGrid"></div>
