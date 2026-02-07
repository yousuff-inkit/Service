 <%@page import="com.skips.nafithdownload.*" %>
 
 <% ClsNaifithDownloadDAO DAO=new ClsNaifithDownloadDAO(); 
 String id=request.getParameter("id")==null?"":request.getParameter("id");
 %>
<script type="text/javascript">
var datauser=[];
var id='<%=id%>';
if(id=="1"){
	datauser= '<%=DAO.getUsernames(id)%>';
}


        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'username', type: 'String'  },
     						{name : 'iscaptcha', type: 'number'  }
                 ],
                 localdata: datauser,
                
                
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
            $("#jqxUsernameGrid").jqxGrid(
            {
            	 width: '98%',
                 height: 240,
                 source: dataAdapter,
                 editable: true,
                 selectionmode: 'singlecell',
                columns: [
					{  text: 'Sr. No.', sortable: false, filterable: false, editable: false,
						   groupable: false, draggable: false, resizable: false,datafield: '',
						   columntype: 'number', width: '10%',cellsalign: 'center', align: 'center',
						   cellsrenderer: function (row, column, value) {
						   return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						   }  
						},  
					
					{ text: 'User Name',columntype: 'textbox', filtertype: 'input', datafield: 'username', width: '90%',editable:false },
					{ text: 'Is Captcha',columntype: 'textbox', filtertype: 'input', datafield: 'iscaptcha', width: '10%',hidden:true}
	              ]
            });

            $('#jqxUsernameGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("username").value= $('#jqxUsernameGrid').jqxGrid('getcellvalue', rowindex1, "username");
		              $('#unameWindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxUsernameGrid"></div>
