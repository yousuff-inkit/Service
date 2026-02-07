<%@page import="com.skips.enquiry.ClsEnquiryDAO" %>
 <%
 ClsEnquiryDAO DAO=new ClsEnquiryDAO();
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
     						{name : 'tel', type: 'String'  },
     						{name : 'mob', type: 'String'  },
     						{name : 'email', type: 'String'  },
     						
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
					 { text: 'Contact Person', datafield: 'cperson', editable:true },
					 { text: 'activityid', datafield: 'aydocno', width: '20%',hidden:true },
					 { text: 'ay_name', datafield: 'ay_name', width: '20%',hidden:true },
					 { text: 'Tele', datafield: 'tel', width: '30%',hidden:true  },
					 { text: 'Mob', datafield: 'mob', width: '30%' },
					 { text: 'E-mail', datafield: 'email', width: '30%',hidden:true  },
					]
            });
            
           $('#jqxcontactsearch').on('rowdoubleclick', function (event) 
            		{ 
              
                var rowindex1=event.args.rowindex;
                   document.getElementById("txtcontact").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "cperson");
				   document.getElementById("cpersonid").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
				   document.getElementById("txtdesig").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "ay_name");
				   document.getElementById("activityid").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "aydocno");
				   
				   document.getElementById("txtmobile").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "mob");
				   document.getElementById("txttelno").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "tel");
				   document.getElementById("txtemail").value=$('#jqxcontactsearch').jqxGrid('getcellvalue', rowindex1, "email");

     	      document.getElementById("errormsg").innerText="";
                $('#contactinfowindow').jqxWindow('close');
               
            
            		 }); 
      
        });
    </script>
    <div id="jqxcontactsearch"></div>