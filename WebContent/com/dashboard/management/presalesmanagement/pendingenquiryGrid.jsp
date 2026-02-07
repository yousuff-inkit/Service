<%@page import="com.dashboard.management.presalesmanagement.ClsPresalesManagementDAO"%>   
<%
ClsPresalesManagementDAO sd=new ClsPresalesManagementDAO();  
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>   
   
 <%
     String id=request.getParameter("id")==null?"":request.getParameter("id").toString();
 %>        
<script type="text/javascript">    
var data;
                                            
$(document).ready(function(){           
	data='<%=sd.presalesENQData(session,id) %>';  
    var source =
    {             
            datatype: "json",
            datafields: [ 
            	
                {name : 'date',type:'date'},
                {name : 'vocno' , type: 'string'},
              	{name : 'name' , type: 'string'},           
				{name : 'description', type: 'string'},
				{name : 'productid', type:'string'},             
				{name : 'productname',type:'string'},
				{name : 'unit', type: 'string'},
				{name : 'qty', type: 'number'},
				{name : 'doc_no', type: 'string'},
				{name : 'brhid', type: 'string'},
             ],                  
             localdata: data,    
              
            
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



        $("#jqxEnquiryGrid").jqxGrid(
                {
                	width: '100%',
                    height: 350,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    sortable: true,
                     columnsresize: true,
                    //Add row method
                    columns: [  
                        { text: 'Date',datafield: 'date', width: '6%',cellsformat:'dd.MM.yyyy'},   
						{ text: 'Doc No',datafield: 'vocno', width: '6%'},
    					{ text: 'client',datafield: 'name', width: '6%'}, 
    					{ text: 'description',datafield: 'description', width: '6%'},
    					{ text: 'Product', datafield: 'productid', width: '20%'},
    					{ text: 'Product Name', datafield: 'productname'} ,
						{ text: 'unit', datafield: 'unit' }, 
						{ text: 'qty', datafield: 'qty', width: '14%'}, 
						{ text: 'docno', datafield: 'doc_no', width: '14%',hidden:true}, 
						{ text: 'brhid', datafield: 'brhid', width: '14%',hidden:true}, 
						
					   ]                                              
                });  
                $("#overlay, #PleaseWait").hide();
                $('#jqxEnquiryGrid').on('rowdoubleclick', function (event) {       
	                   var rowindex = event.args.rowindex;
	                       
	                   document.getElementById("enqdocno").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "doc_no");   
	                   document.getElementById("enqbrhid").value=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "brhid"); 
	                   
	                   var docno=$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "doc_no"); 
	                   var rdtype='ENQ'; 
	                   
	                   $("#flwupdiv").load("followupGrid.jsp?docno="+docno+"&reftype="+rdtype);  
	                   
	                   $('.textpanel p').text('ENQ No '+$('#jqxEnquiryGrid').jqxGrid('getcellvalue',rowindex,'vocno')+' - '+$('#jqxEnquiryGrid').jqxGrid('getcellvalue', rowindex, "name"));
	                     
                });     
	});     
</script>
<div id="jqxEnquiryGrid"></div>  