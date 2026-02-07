 <%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.skips.enquiry.ClsEnquiryDAO"%>  
<%
  ClsEnquiryDAO DAO= new ClsEnquiryDAO();
   
  String clname = request.getParameter("clname")==null?"0":request.getParameter("clname");
   String mob = request.getParameter("mob")==null?"0":request.getParameter("mob");
  int id=request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
  %> 

 <script type="text/javascript">
 
 var cldata;

 cldata='<%=DAO.searchClient(session,clname,mob,id)%>';
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                         
     						{name : 'cldocno', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'address', type: 'String'  }, 
     						{name : 'per_mob', type: 'String'  },
     						{name : 'mail1', type: 'String'  },
     						{name : 'pertel', type: 'String'  },
     						{name : 'sal_id', type: 'String'  },
     						{name : 'sal_name', type: 'String'  },
     						{name : 'grpname', type: 'String'  },
     						{name : 'ay_name', type: 'String'  }, 
     						{name : 'aydocno', type: 'String'  }, 
     					    {name : 'scid', type: 'String'  },    
      					    {name : 'txtname', type: 'String'  },
      					    {name : 'cperson', type: 'String'  }, 
   						    {name : 'cprowno', type: 'String'  },
   						    {name : 'cpersonid', type: 'String'  }, 
      					    {name : 'cptel', type: 'String'  },
   						    {name : 'cpmob', type: 'String'  },
   						    {name : 'cpemail', type: 'String'  }, 
                          	], 
                          	localdata: cldata,
                          //	 url: url1,
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
            $("#Jqxclientsearch").jqxGrid(
            {
                width: '100%',
                height: 285,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
						{ text: 'CLIENT NO', datafield: 'cldocno', width: '10%' },
						{ text: 'NAME', datafield: 'refname', width: '30%' },
						{ text: 'ADDRESS', datafield: 'address', width: '40%' }, 
						{ text: 'TEL', datafield: 'pertel', width: '10%' ,hidden:true}, 
						{ text: 'MOB', datafield: 'per_mob', width: '15%' ,hidden:true},
						 { text: 'Mail', datafield: 'mail1', width: '20%',hidden:true },
						 { text: 'Salesman Id', datafield: 'sal_id', width: '20%',hidden:true },
						 { text: 'Salesman', datafield: 'sal_name', width: '20%',hidden:true },
						 { text: 'Contact Person', datafield: 'cperson', width: '20%' },
						 { text: 'cprowno', datafield: 'cprowno', width: '20%',hidden:true },
					//		{ text: 'SCID', datafield: 'scid', width: '20%',hidden:true},
	    			//		{ text: 'SOURCE NAME', datafield: 'txtname', width: '100%',hidden:true }
						 { text: 'grpname', datafield: 'grpname', width: '20%',hidden:true },
						 { text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true },
						 { text: 'activityid', datafield: 'aydocno', width: '20%',hidden:true },
						 { text: 'ay_name', datafield: 'ay_name', width: '20%',hidden:true },

						 { text: 'cptel', datafield: 'cptel', width: '20%',hidden:true },
						 { text: 'cpmob', datafield: 'cpmob', width: '20%',hidden:true },
						 { text: 'cpemail', datafield: 'cpemail', width: '20%',hidden:true },  

					]
            });  
          /*   $("#Jqxclientsearch").jqxGrid('addrow', null, {}); */
				           $('#Jqxclientsearch').on('rowdoubleclick', function (event) 
				            		{ 
				              	var rowindex1=event.args.rowindex;
				               var cldocno=document.getElementById("cmbclient").value= $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
				               document.getElementById("txtclientname").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
				               document.getElementById("txtaddress").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "address");
				               document.getElementById("txtmobile").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cpmob");
				               document.getElementById("txtemail").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cpemail");  
				               document.getElementById("txttelno").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cptel");
				               document.getElementById("txtsalesmandocno").value= $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "sal_id");
							   document.getElementById("txtsalesman").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
							   document.getElementById("txtcontact").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cperson");
							   document.getElementById("cpersonid").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "cpersonid");
							   document.getElementById("txtdesig").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "ay_name");
							   document.getElementById("activityid").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "aydocno");
							   document.getElementById("grpcmp").value=$('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "grpname");
							   document.getElementById("sourceid").value = $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "scid");
					           document.getElementById("txtsource").value = $('#Jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "txtname");
					      	   creditperiod(); 
					      	 $('#txtcontact').dblclick(function(){
					   		  $('#contactinfowindow').jqxWindow('open');
					   	      contactSearchContent('Searchcontact.jsp?cldocno='+cldocno);

					   		  });

					           $('#clientsearch1').jqxWindow('close');
				            		 }); 	 
        
                  }); 
				          
                       
    </script>
    <div id="Jqxclientsearch"></div>
    