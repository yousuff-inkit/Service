<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.nipurchase.nipurchaserequest.ClsnipurchaserequestDAO" %>
	
<%ClsnipurchaserequestDAO viewDAO=new ClsnipurchaserequestDAO();%>

<%
String nipurdoc=request.getParameter("nipurdoc")==null?"0":request.getParameter("nipurdoc").trim();

%>
<script type="text/javascript">
var descdata;

var temp='<%=nipurdoc%>';
if(temp>0)
{
	descdata='<%=viewDAO.reloadnioreder(session,nipurdoc)%>';  
}
        $(document).ready(function () { 	
        
        	  var rendererstring1=function (aggregates){
               	var value=aggregates['sum1'];
               	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
               }    
            
         var rendererstring=function (aggregates){
         	var value=aggregates['sum'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
         }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						
     						{name : 'srno', type: 'int' },
     						{name : 'description', type: 'string' },
     						{name : 'qty', type: 'number' },
     						
                 ],
              
                 localdata: descdata,
                
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
            
            $("#descdetailsGrid").jqxGrid(
            {
                width: '100%',
                height: 302,
                source: dataAdapter,
                showaggregates:true,
                showstatusbar:true,
                editable: true,
                disabled:true,
                statusbarheight: 25,
                selectionmode: 'singlecell',
                pagermode: 'default',
                
                columns: [
                
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },
							{ text: 'Description', datafield: 'description' },
							{ text: 'Quantity', datafield: 'qty',cellsformat:'d2', width: '10%' ,cellsalign: 'left', align:'left'},
							{ text: 'srno', datafield: 'srno', hidden:true}
						
							
	              ]
            });
            
           if(temp==0){
            	$("#descdetailsGrid").jqxGrid('addrow', null, {});
        	}
           
           
           if(($('#mode').val()=='A')||($('#mode').val()=='E')){
	   		  $("#descdetailsGrid").jqxGrid({ disabled: false}); 
   		    }
           
		 $('#descdetailsGrid').on('celldoubleclick', function (event) {
           	 if(event.args.datafield=="description"){
         		var rowindextemp = event.args.rowindex;
                document.getElementById("prdsetrowno").value = rowindextemp;
         		getproductdetails();
         	   }
            });
		 
		 
		 /*Delete Row*/
         $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
         
         // create context menu
            var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
            $("#descdetailsGrid").on('contextmenu', function () {
                return false;
            });
            
         $("#Menu2").on('itemclick', function (event) {
             var rowindex = $("#descdetailsGrid").jqxGrid('getselectedrowindex');
                 
             var rowid = $("#descdetailsGrid").jqxGrid('getrowid', rowindex);
             $("#descdetailsGrid").jqxGrid('deleterow', rowid);
         });
         
         $("#descdetailsGrid").on('cellclick', function (event) {
             if (event.args.rightclick) {
                 $("#descdetailsGrid").jqxGrid('selectrow', event.args.rowindex);
                 var scrollTop = $(window).scrollTop();
                 var scrollLeft = $(window).scrollLeft();
                 contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);

                 return false;
             }
         });
         /*Delete Row Ends*/
         
		   $("#descdetailsGrid").on('cellvaluechanged', function (event)  {
            	var datafield = event.args.datafield;
    		    var rowBoundIndex = event.args.rowindex;
    		     
            	if(datafield=="qty"){
            		$("#descdetailsGrid").jqxGrid('addrow', null, {});
            	}
        	});
        });
        
        </script>
<div id="descdetailsGrid"></div>
<input type="hidden" id="prdsetrowno"/>

<div id='jqxWidget'>
    <div id="popupWindow2">
 
 <div id='Menu2'>
    <ul>
        <li>Delete Selected Row</li>
    </ul>
</div>       
</div>
</div>
