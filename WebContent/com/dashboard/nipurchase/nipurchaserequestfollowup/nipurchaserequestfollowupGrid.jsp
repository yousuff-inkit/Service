<%@page import="com.dashboard.nipurchase.nipurchaserequestfollowup.ClsnipurchaserequestfollowupDAO"%>
<%ClsnipurchaserequestfollowupDAO sd=new ClsnipurchaserequestfollowupDAO();%>
    
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <%
     String branchval =request.getParameter("branchval")==null?"0":request.getParameter("branchval").toString();
     int check=request.getParameter("check")==null?0:Integer.parseInt(request.getParameter("check"));
 %>

<style type="text/css">
   .colorClass
    {
        background-color: #F9E79F;
    }
</style>

 <script type="text/javascript">
 	var data;
 
 	var flchk='<%=check%>';

	if(flchk!='0'){
 		data= '<%= sd.niPurchaseRequestSearch(branchval,check)%>';
	}

	$(document).ready(function () { 	
            
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'String' },
							{name : 'voc_no', type: 'String' },
     						{name : 'brhid', type: 'String' },
     						{name : 'date', type: 'date' },    
     	                   	{name : 'requestedby' , type: 'String' },
     	                	{name : 'remark' , type: 'String' },
                 ],
                 localdata: data,
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
            var cellclassname = function (row, column, value, data) {
                	if(data.rowcolor=="1"){
                		return "colorClass";
                    }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxNiPuReqGrid").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                //pagermode: 'default',
                sortable: true,
                selectionmode: 'checkbox',
                columns: [ 
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
    				groupable: false, draggable: false, resizable: false,datafield: '',
    				columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',cellclassname: cellclassname,
    				cellsrenderer: function (row, column, value) {return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";}  
					},
	    
					{ text: 'Doc No', datafield: 'voc_no', width: '6%',cellclassname:cellclassname },
					{ text: 'Date', datafield: 'date', width: '7%' ,cellclassname:cellclassname,cellsformat:'dd.MM.yyyy'},
					{ text: 'Requested By', datafield: 'requestedby', width: '20%',cellclassname:cellclassname },
					{ text: 'Remark', datafield: 'remark',cellclassname:cellclassname },
					{ text: 'doc_no',  datafield: 'doc_no', hidden:true}, 
					{ text: 'brhid',  datafield: 'brhid', hidden:true}, 
					
	              ]
            });
      
            $("#overlay, #PleaseWait").hide();
                       
        });
    </script>
    <div id="jqxNiPuReqGrid"></div>
