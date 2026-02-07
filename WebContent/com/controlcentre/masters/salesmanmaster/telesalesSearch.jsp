<%@page import="com.controlcentre.masters.salesmanmaster.telesales.ClsTelesalesAction" %>
<%ClsTelesalesAction cha =new ClsTelesalesAction(); %>
<script type="text/javascript">
  		
  	var data= '<%=cha.searchDetails() %>';
        
  		$(document).ready(function () { 	

  			var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'sal_code', type: 'String'  },
                          	{name : 'sal_name', type: 'String'  },
                          	{name : 'date', type: 'String'  },
                          	{name : 'acc_no', type: 'String'  },
                          	{name : 'description', type: 'String'  },
                          	{name : 'mobile',type:'String'},
                          	{name : 'mail',type:'String'},
                          	{name : 'user',type:'String'},
                          	{name : 'user_id',type:'int'}
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
            
            $("#jqxTelesalesSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'DOC_NO', width: '10%' },
					{ text: 'Code', datafield: 'sal_code', width: '15%' },
					{ text: 'Name', datafield: 'sal_name', width: '30%' },
					{ text: 'Acc No', datafield: 'acc_no', width: '40%',hidden:true },
					{ text: 'Account Name', datafield: 'description', width: '30%' },
					{ text: 'Mobile',datafield:'mobile', width: '40%',hidden:true },
					{ text: 'Mail',datafield:'mail', width: '40%',hidden:true },
					{ text: 'User', datafield: 'user', width: '15%' },
					{ text: 'user_id',datafield:'user_id', width: '40%',hidden:true }
					]
            });
            
            $('#jqxTelesalesSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxTelesalesSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("txtaccno").value = $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");
                document.getElementById("txtaccname").value = $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("code").value = $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "sal_code");
                document.getElementById("name").value = $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");
                document.getElementById("mobile").value = $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "mobile");
                document.getElementById("mail").value = $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "mail");
                $("#telesalesdate").jqxDateTimeInput('val', $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                var user = $("#jqxTelesalesSearch").jqxGrid('getcellvalue', rowindex1, "user_id");
                if(user!=0){
                	document.getElementById("cmbuser").value = user
                }
                else{
                	document.getElementById("cmbuser").value = ''
                }
                
                $('#window').jqxWindow('close');
            }); 
         
        });
    </script>
    <div id="jqxTelesalesSearch"></div>
