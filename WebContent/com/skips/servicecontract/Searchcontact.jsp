<%@page import="com.skips.servicecontract.ClsServiceContractDAO" %> 
 <%
 ClsServiceContractDAO DAO=new ClsServiceContractDAO();                  
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno");
 %>
 
 <script type="text/javascript"> 

 var datasal= '<%=DAO.contactSearch(cldocno)%>';   
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'cperson', type: 'String'  },
     						{name : 'cpersonid', type: 'String'  }, 
     						{name : 'ay_name', type: 'String'  }, 
     						{name : 'aydocno', type: 'String'  }, 
     						{name : 'mob', type: 'String'  }, 
     						{name : 'email', type: 'String'  }, 
     						{name : 'tel', type: 'String'  },              
                          	],
                 localdata: datasal,
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxcontactsearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                 showfilterrow:true, 
                altRows: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                		
     			columns: [
					 { text: 'ID', datafield: 'cpersonid', width: '10%' },
					 { text: 'Contact Person', datafield: 'cperson', width: '45%',editable:true },
					 { text: 'Mobile', datafield: 'mob', width: '15%',editable:true },
					 { text: 'Email', datafield: 'email', width: '15%',editable:true },
					 { text: 'Telephone', datafield: 'tel', width: '15%',editable:true },  
					 { text: 'activityid', datafield: 'aydocno', width: '20%',hidden:true },
					 { text: 'ay_name', datafield: 'ay_name', width: '20%',hidden:true }, 
					]
            });
    
           $('#jqxcontactsearch').on('rowdoubleclick', function (event)  {        
                var rowindex1=event.args.rowindex;   
                document.getElementById("txtcperson").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "cperson");
				document.getElementById("hidcpersonid").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
				document.getElementById("txtmob").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "mob");
				document.getElementById("txtmail").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "email");
				document.getElementById("txttele").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "tel");      
				
     	        document.getElementById("errormsg").innerText="";    
                $('#contactinfowindow').jqxWindow('close'); 
           }); 
      
        });
    </script>
    <div id="jqxcontactsearch"></div>