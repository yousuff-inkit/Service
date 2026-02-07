<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="com.callibration.enquiry.ClsEnquiryDAO"%>
<% ClsEnquiryDAO ClsEnquiryDAO = new ClsEnquiryDAO(); %>  
<%
String prodsearchtype=request.getParameter("prodsearchtype")==null?"0":request.getParameter("prodsearchtype").trim();
String rrefno=request.getParameter("enqmasterdocno")==null?"0":request.getParameter("enqmasterdocno").trim();
String cmbprice=request.getParameter("cmbprice")==null?"0":request.getParameter("cmbprice").trim();

String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").trim();
 
String reftypes=request.getParameter("reftypes")==null?"0":request.getParameter("reftypes").trim();


String clientcaid=request.getParameter("clientcaid")==null?"0":request.getParameter("clientcaid").trim();

String dates=request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
String cmbbilltype=request.getParameter("cmbbilltype")==null?"0":request.getParameter("cmbbilltype").trim();

String acno=request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
String brandids=request.getParameter("brandids")==null?"0":request.getParameter("brandids").trim();

String gridunit = request.getParameter("gridunit")==null?"0":request.getParameter("gridunit");
String gridprdname = request.getParameter("gridprdname")==null?"0":request.getParameter("gridprdname");
String scope = request.getParameter("scopeid")==null?"0":request.getParameter("scopeid");
String scopeproduct = request.getParameter("scopeproduct")==null?"0":request.getParameter("scopeproduct");
String gridcategory = request.getParameter("gridcategory")==null?"0":request.getParameter("gridcategory");
String gridssubcategory = request.getParameter("gridssubcategory")==null?"0":request.getParameter("gridssubcategory");
String id = request.getParameter("id")==null?"0":request.getParameter("id");

%>
 
<style>
#jqxInput{
	background-color:#fff;
	height: 20px;
	
}
</style>
 
  <script type="text/javascript"> 
	 
 
            $(document).ready(function () {
             
           	 var aa1= '<%=ClsEnquiryDAO.searchProduct(session,acno,cmbbilltype,dates,"","","","",id,"","","","","")%>';
 
            	 
                // prepare the data
                var source =
                {
                    datatype: "json",
                    datafields: [
                                 {name : 'part_no', type: 'string'  },
                                 {name : 'productname', type: 'string'  },
                                 {name : 'doc_no', type: 'string'  },
                                 {name : 'unit', type: 'string'  },
                                 {name : 'unitdocno', type: 'string'  },
                                 {name : 'psrno', type: 'string'  },
                                 {name : 'specid', type: 'string'  },
                                  
                                 {name : 'unitprice', type: 'string'  },
                               
                              
                                 
                                 {name : 'brandname', type: 'string'  },
                                 {name : 'brandid', type: 'string'  },
                                 {name : 'catid', type: 'string'  },
                                 {name : 'scatid', type: 'string'  },
                                 {name : 'category', type: 'string'  },
                                 {name : 'subcategory', type: 'string'  },
                                 {name : 'taxper', type: 'number'  },
                                 
                                 
                                 
                                 
                                 
                    ],
                    localdata: aa1,
                };
                var dataAdapter = new $.jqx.dataAdapter(source);
                // Create a jqxInput
                 
                $("#jqxInput").jqxInput({ source: dataAdapter, displayMember: "productname", valueMember: "psrno", width: 240, height: 20});
                
            $("#jqxInput").on('select', function (event) {
            	  if (event.args) {
                      var item = event.args.item;
                      if (item) {
                          

                          for (var i = 0; i < dataAdapter.records.length; i++) { 
                              if (item.value == dataAdapter.records[i].psrno) {
                            	  
                            	  
                            	 
                                  document.getElementById("jqxInput").value=dataAdapter.records[i].productname;
                                  document.getElementById("temppsrno").value=dataAdapter.records[i].psrno;
                                  document.getElementById("tempspecid").value=dataAdapter.records[i].specid;
                                 /*  getunit(dataAdapter.records[i].psrno);
                                  document.getElementById("unit").value=dataAdapter.records[i].unitdocno; */
                                  document.getElementById("make").value=dataAdapter.records[i].brandname;
                                  document.getElementById("model").value=dataAdapter.records[i].category;
                                  document.getElementById("range").value=dataAdapter.records[i].subcategory;
                                  document.getElementById("hidcatid").value=dataAdapter.records[i].catid;
                                  document.getElementById("hidscatid").value=dataAdapter.records[i].scatid;
                                  document.getElementById("hidbrndid").value=dataAdapter.records[i].brandid;
                                /*   funRoundAmt(dataAdapter.records[i].taxper,"taxpers");
                                  funRoundAmt(dataAdapter.records[i].unitprice,"uprice");
                                  
                                   
                                  document.getElementById("prddesc").focus(); */
                                  
                                  break;
                              }
                          }
                          

                           
                      }
                  }
                });  
            });
        </script>
         <input id="jqxInput" />
     