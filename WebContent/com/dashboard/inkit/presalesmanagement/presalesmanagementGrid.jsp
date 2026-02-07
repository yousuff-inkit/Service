
   <%@page import="com.dashboard.inkit.presalesmanagement.*"%>
     <%
     ClsPresalesmanagementDAO cmd= new ClsPresalesmanagementDAO();
     %>
 
 
 <%
 String chk = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    String salesmanid = request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").trim();
 	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	 String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
     String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
     String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
     System.out.println("brchva========="+branchval+fromdate+todate+chkfollowup);
 %> 
           	  
<style type="text/css">

  .yellowClass
        {
        
       
       background-color: #FFEBEB; 
        /*   background-color: #eedd82;  */
        }
</style>

<script type="text/javascript">
 var temp4='<%=branchval%>';
var enqdata,enqfollowupexcel;

 
	 
	 enqdata='<%=cmd.enquirylistsearch(session,branchval,chkfollowup,followupdate,fromdate,todate,areaid,salesmanid,chk) %>';
	// alert(enqdata); 
	<%--  enqfollowupexcel='<%=cmd.enquirylistExcel(session,branchval,chkfollowup,followupdate,fromdate,todate,areaid,salesmanid) %>'; --%>
	

$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'number'  },
                        {name : 'qotno', type: 'number'  },
                        {name : 'qottrno', type: 'number'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'salm', type: 'String'  },
						{name : 'site', type: 'String' },
						{name : 'area', type: 'String' },
						{name : 'fdate', type: 'date' },
						{name : 'source', type: 'String'  },
						{name : 'brch', type: 'String'  },
						{name : 'enqstat', type: 'String'  },
						{name : 'qotval', type: 'number' },
						{name : 'age', type: 'String'  },
						{name : 'enqtype', type: 'String'  },
						{name : 'telno', type: 'String'  },
						{name : 'sourceid', type: 'String'  },
						{name : 'contrmode', type: 'String' },
						{name : 'sjobtype', type: 'String' },
						
						{name : 'addr', type: 'String'  },
						 {name : 'cpersonid' , type: 'String'},
		                    {name : 'cperson' , type: 'String'},  
		                    {name : 'cldocno' , type: 'String'},  
		                    {name : 'email' , type: 'String'}, 
		                    {name : 'user' , type: 'String'},
		                    {name : 'priority' , type: 'String'},
		                    {name : 'ftype', type: 'String'  },
		                    {name : 'dtype', type: 'String'  },
		                    {name : 'qtype', type: 'String'  },
		                    {name : 'brhid', type: 'String'},
		                    {name : 'surdoc', type: 'String' },
		                    {name : 'address', type: 'String'  },
		                    {name : 'smapproval', type: 'String'  },
		                    {name : 'pertel', type: 'String'},
	 						
			                  {name : 'per_mob', type: 'String' },
			                  {name : 'mail1', type: 'String' },
			                  {name : 'salname', type: 'String' },
			                  {name : 'sal_id', type: 'String' },
			                  {name : 'surtrno', type: 'number' },
			                  {name : 'enqstatus', type: 'String' },
				                  {name : 'contrtype', type: 'String' },
				                  {name : 'contactdet', type: 'String' },
				                  {name : 'taxper', type: 'number' },
				                  {name : 'branchname', type: 'number' },
				                  {name : 'enqtypenw', type: 'number' },
				                  {name : 'industry', type: 'number' },
				                  {name : 'fdate', type: 'date'  },
				                    {name : 'fstatus', type: 'String'},
				                    {name : 'email', type: 'String'},
						],
				    localdata: enqdata,
        
        
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
		var cellclassname =  function (row, column, value, data) {


    	/*   var ss= $('#enqlistgrid').jqxGrid('getcellvalue', row, "age");
    		          if(parseInt(ss)>48)
    		  		{
    		  		
    		  		return "yellowClass";
    		  	
    		  		} */
    	    
    

    		}   
    $("#enqlistgrid").jqxGrid(
    {
        width: '99%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips: true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '2%',cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                    { text: 'Enq.Reg.By', datafield: 'user',  width: '3%' ,cellclassname: cellclassname },
                    { text: 'Enq No',datafield: 'voc_no', width: '2%' ,cellclassname: cellclassname },
                    { text: 'Branch',datafield: 'branchname', width: '4%' ,cellclassname: cellclassname },
					 { text: 'Enq Date', datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
					  { text: 'Enq type',datafield: 'enqtypenw', width: '5%' ,cellclassname: cellclassname },
					  { text: 'Industry',datafield: 'industry', width: '5%' ,cellclassname: cellclassname },
					 { text: 'Customer',datafield: 'name', width: '10%' ,cellclassname: cellclassname },
					 { text: 'Flwp Date', datafield: 'fdate', width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
					 { text: 'QOT Status', datafield: 'fstatus', width: '5%',cellclassname: cellclassname },
					 { text: 'MOB', datafield: 'mob', width: '5%',cellclassname: cellclassname  },
					 { text: 'Age (Hrs)', datafield: 'age', width: '4%' , cellsalign:'right',cellclassname: cellclassname },
					 { text: 'Salesman', datafield: 'salm', width: '6%',cellclassname: cellclassname },
					 { text: 'Source', datafield: 'source', width: '5%',cellclassname: cellclassname },
					 { text: 'ENQ Status', datafield: 'priority', width: '4%',cellclassname: cellclassname },
					 { text: 'Current Status', datafield: 'type', width: '3%',cellclassname: cellclassname },
					 { text: 'Site', datafield: 'site', width: '5%',cellclassname: cellclassname },
					 { text: 'Area', datafield: 'area', width: '5%',cellclassname: cellclassname },
					 { text: 'Remarks', datafield: 'remarks', width: '11%',cellclassname: cellclassname },
					 { text: 'Enq Type', datafield: 'qtype',  width: '5%' ,cellclassname: cellclassname,hidden:true },
					// { text: 'enqtype', datafield: 'enqtype', width: '20%' ,cellclassname: cellclassname },
					 { text: 'Qot No',datafield: 'qotno', width: '3%' ,cellclassname: cellclassname },
					 { text: 'Qot Value',datafield: 'qotval', width: '3%' ,cellclassname: cellclassname,cellsalign:'right',align:'right',cellsformat:'d2' },
					 
					
				     { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:false ,cellclassname: cellclassname },
				     
				     
					
					 
					 
					
					 { text: 'Branch', datafield: 'brch', width: '11%',hidden:true,cellclassname: cellclassname },
					 
					 
					
					
						{ text: 'telno', datafield: 'telno', width: '20%',hidden:true ,cellclassname: cellclassname },
				
						{ text: 'sourceid', datafield: 'sourceid', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'contrmode', datafield: 'contrmode', width: '20%',hidden:true ,cellclassname: cellclassname },
						
						{ text: 'sjobtype', datafield: 'sjobtype', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'address', datafield: 'addr', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'cperson', datafield: 'cperson', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'salid', datafield: 'sal_id', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'cldocno', datafield: 'cldocno', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'email', datafield: 'email', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'qottrno', datafield: 'qottrno', width: '20%',hidden:true ,cellclassname: cellclassname },
						{ text: 'dtype', datafield: 'dtype', width: '20%',hidden:true ,cellclassname: cellclassname },
					]
   
    });
    $('.load-wrapp').hide();
    $('#enqlistgrid').on('rowdoubleclick', function (event) { 
   	  var rowindex1=event.args.rowindex;
   
   	 var cldoc=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
   	 if(parseInt(cldoc)==0){
   		 $('#btncreateclient').attr("disabled",false);
   		 document.getElementById("txtclientnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name");
   		document.getElementById("txtsource").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "source");
   		document.getElementById("sourceid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sourceid");
   	   document.getElementById("txtaddressnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "address");
	  document.getElementById("txtmobnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "per_mob");	  
	  document.getElementById("txtemailnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "mail1");
	  document.getElementById("salmanid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sal_id"); 
   	 }
   	 else{
   		 $('#btncreateclient').attr("disabled",true);
   	 }
   	
  	document.getElementById("enqdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
	
    document.getElementById("reftrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    document.getElementById("qottrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qottrno");
    document.getElementById("qotchkno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qotno");
    var qottrno=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qottrno");
    $('#wrkdiv').load('preSalesLogGrid.jsp?id=1'+'&work='+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));
    if(parseInt(qottrno)>0){
    	 $("#detailDiv").load("detailGrid.jsp?doc="+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, 'qottrno'));
    }
    $('.textpanel p').text($('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name")+' - '+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"));
   	  document.getElementById("surveydocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "surdoc"); 
  	  document.getElementById("reportdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
  
   document.getElementById("surtrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "surtrno");
   document.getElementById("esttrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "esttrno");
   document.getElementById("refdtype").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "ftype");
	  document.getElementById("brhid1").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	  
	  document.getElementById("client").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name");
	  document.getElementById("cldocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
	  document.getElementById("address").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "address");
	
	  document.getElementById("pertel").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "pertel");
	  document.getElementById("per_mob").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
	  
	  document.getElementById("mail1").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "mail1");
	  document.getElementById("salname").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "salm");
	  document.getElementById("salid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sal_id"); 
	  document.getElementById("contrtype").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "contrmode");
	  document.getElementById("txtcpersonid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cpersonid");
	  document.getElementById("txtcperson").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cperson");
	  document.getElementById("txtcpersondet").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "contactdet");
	  document.getElementById("txtsjobtype").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sjobtype");
	  document.getElementById("txtclienttaxper").value=$('#enqlistgrid').jqxGrid('getcelltext', rowindex1, "taxper"); 
		document.getElementById("conttype").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "dtype");
		
		
      }); 
    
    $('#enqlistgrid').on('cellclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
            	var datafield = event.args.datafield;
            	
            	 if(datafield=="view"){
            		 var enqdocno=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
            			var brch=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brch");
            			 var path1="com/operations/marketing/enquirynew/enquiry.jsp";
            				 var name="Enquiry";
            				 var url=document.URL;
            				var reurl=url.split("/com/");

            			  window.parent.formName.value="Enquiry";
            			  window.parent.formCode.value="ENQ";
            			  var detName="Enquiry";
            			  
            			  var path= path1+"?modes=view&enqdocno="+enqdocno+"&brhid="+brch;
            			 
            			   top.addTab( detName,reurl[0]+"/"+path);
     				
                 	
                 }

            	
              
    		 });
    
    
   
});


</script>
<div id="enqlistgrid"></div>

