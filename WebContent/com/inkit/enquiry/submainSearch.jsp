<%@page import="com.inkit.enquiry.ClsEnquiryDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 ClsEnquiryDAO DAO=new ClsEnquiryDAO();
 String sclname = request.getParameter("sclname")==null?"0":request.getParameter("sclname");
 String smob = request.getParameter("smob")==null?"0":request.getParameter("smob");
 String cno = request.getParameter("dno")==null?"0":request.getParameter("dno");
 String RefNo =request.getParameter("RefNo")==null?"0":request.getParameter("RefNo");
 int id =request.getParameter("id")==null?0:Integer.parseInt(request.getParameter("id"));
%> 
 
<script type="text/javascript">
  
  var cno='<%=cno%>';
  var eloaddata='<%=DAO.mainSrearch(session,sclname,smob,cno,RefNo,id)%>';
 
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'clname', type: 'String'  },
     						{name : 'com_mob', type: 'String'  },
      						{name : 'edocno', type: 'String'  },
      						{name : 'refno', type: 'String'  },
      						{name : 'cldocno', type: 'String'  }
      						
      						
                          	],
                          	localdata: eloaddata,
                          
          
				
                
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
            $("#jqxmainsearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
    
                columns: [
		                    { text: 'Doc No', datafield: 'edocno', width: '15%'},
							{ text: 'Client Name', datafield: 'clname', width: '40%' }, 
							{ text: 'Mobile', datafield: 'com_mob', width: '25%' },
							{ text: 'Ref No', datafield: 'refno', width: '20%' },
							{ text: 'cldocno', datafield: 'cldocno', width: '20%',hidden:true }
					]
            });
    
            //$("#jqxmainsearch").jqxGrid('addrow', null, {});
      
				            
		          $('#jqxmainsearch').on('rowdoubleclick', function (event) { 
		        	     var rowindex1=event.args.rowindex;
		        
		                 document.getElementById("docno").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "edocno");
		                 document.getElementById("txtclientname").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "clname");
		                 var chkcldoc=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
		                 if(parseInt(chkcldoc)==0){
		               	  document.getElementById("custid").checked=true;
		                     $('#txtclientname').hide();
		                 }
		                 if(parseInt(chkcldoc)>0){
		               	  document.getElementById("custid").checked=false;
		               	  $('#txtclientname').show();
		                 }
		                 
		                 $('#frmEnquiry docno').attr('disabled', false);
		                 $('#frmEnquiry txtclientname').attr('disabled', false);
		                
		                 funSetlabel();
		                
		                 document.getElementById("frmEnquiry").submit();
		                 $('#window').jqxWindow('close');
		               
		            });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
