<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@include file = "enquiryStatus.jsp" %>
<%ClsStatusDAO sd= new ClsStatusDAO(); 
 String cldocno=request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim().toString();
System.out.println("in names=="+cldocno);
 %>
 
 
<style>
#jqxInput{
	background-color:#fff;    
	height: 20px;
	
}
</style>
 
  <script type="text/javascript"> 
            $(document).ready(function () {
               var ndata= '<%=sd.searchjob(session,cldocno)%>';
               //alert("sdata"+ndata);  
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",  
                    datafields: [
                                 {name : 'jobno', type: 'String'  },
                                 {name : 'jobnoid', type: 'String'  },   
                                 
                    ],
                    localdata: ndata,  
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
               $("#jqxInputName").jqxInput({ source: dataAdapter, displayMember: "jobnoid",items: 20 , valueMember: "jobno", width: 150, height: 20});
                                  $("#jqxInputName").on('select', function (event) {
                                  	  if (event.args) {
                                            var item = event.args.item;   
                                            if (item) {
                                                for (var i = 0; i < dataAdapter.records.length; i++) {   
                                                    if (item.value == dataAdapter.records[i].jobno) {
                                	  document.getElementById("jobno").value=dataAdapter.records[i].jobno;
                                     // document.getElementById("setbtn").focus();  
                                      break;      
                                                    }  
                                                }
                                            }
                                        }    
                     });  
            });   
        </script>
         <input id="jqxInputName" />
         <br/>
     