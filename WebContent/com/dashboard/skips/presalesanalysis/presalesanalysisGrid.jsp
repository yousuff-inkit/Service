<%@page import="com.dashboard.skips.presalesanalysis.*"%>
<%
ClsPresalesanalysisDAO cmd= new ClsPresalesanalysisDAO();
 %>
 <%
    String chk = request.getParameter("id")==null || request.getParameter("id").equals("")?"0":request.getParameter("id").trim();
    String salid = request.getParameter("salid")==null?"0":request.getParameter("salid").trim();
 	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
 	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
    String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
    String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
    String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
 %> 
           	  
<style type="text/css">
    .colorClass1 {
       background-color: #ff9999; 
    }
    .colorClass2 {
       background-color: #fbe0ff;    
    }
     .colorClass3 {
       background-color: #A4DDFB; 
    }
</style>

<script type="text/javascript">
var temp = '<%=chk%>';
var enqdata,enqfollowupexcel;    
  
$(document).ready(function () {    
	if(parseInt(temp)>0){     
		enqdata='<%=cmd.enquirylistsearch(session, branchval, fromdate, todate, chk, divname, type, salid) %>';
	}

	var rendererstring=function (aggregates){
	               	var value=aggregates['sum'];
	               	if(typeof(value) == "undefined"){
	               		value=0.00;
	               	}
	               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	               }
	        	
	var rendererstring1=function (aggregates){
	                var value1=aggregates['sum1'];
	                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
	               }
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                        { name : 'slno', type: 'number'  },
                        { name : 'doc_no', type: 'String'  },
                        { name : 'voc_no', type: 'number'  },
                        { name : 'qotno', type: 'number'  },
                        { name : 'qottrno', type: 'number'  },
						{ name : 'date', type: 'date'  },
						{ name : 'type', type: 'String'  },
						{ name : 'name', type: 'String'  },
						{ name : 'remarks', type: 'String'  },
						{ name : 'mob', type: 'String'},
						{ name : 'salm', type: 'String'  },
						{ name : 'site', type: 'String' },
						{ name : 'area', type: 'String' },
						{ name : 'fdate', type: 'date' },
						{ name : 'source', type: 'String'  },
						{ name : 'brch', type: 'String'  },
						{ name : 'enqstat', type: 'String'  },
						{ name : 'qotval', type: 'number' },
						{ name : 'age', type: 'String'  },
						{ name : 'enqtype', type: 'String'  },
						{ name : 'telno', type: 'String'  },
						{ name : 'sourceid', type: 'String'  },
						{ name : 'contrmode', type: 'String' },
						{ name : 'sjobtype', type: 'String' },
						
						{ name : 'address', type: 'String'  },
						{ name : 'cpersonid' , type: 'String'},
		                { name : 'cperson' , type: 'String'},  
		                { name : 'cldocno' , type: 'String'},  
		                { name : 'user' , type: 'String'},
		                { name : 'priority' , type: 'String'},
		                { name : 'ftype', type: 'String'  },
		                { name : 'dtype', type: 'String'  },
		                { name : 'qtype', type: 'String'  },
		                { name : 'brhid', type: 'String'},
		                { name : 'surdoc', type: 'String' },
		                { name : 'address', type: 'String'  },
		                { name : 'smapproval', type: 'String'  },
		                { name : 'pertel', type: 'String'},
	 						
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
				        {name : 'details', type: 'String'},
				        {name : 'contrno', type: 'String'},
				        {name : 'status', type: 'String'},
				        {name : 'condocno', type: 'String'},
				        {name : 'designation', type: 'String'}, 
				        {name : 'qotstatus', type: 'String'},
				        
				    	{name : 'payterms', type: 'String'  },
				    	{name : 'groupcompanies', type: 'String'  },
				    	{name : 'billingmethod', type: 'String'  },
				    	{name : 'returned', type: 'number' },
				    	{name : 'flwupremarks', type: 'String'  },
				    	{name : 'cntdate', type: 'date'  },
				    	{name : 'qotdate', type: 'date'  },
				    	{name : 'clienttype', type: 'String'  },
				    	
				    	{name : 'email1', type: 'String'  }, 
				    	{name : 'user1', type: 'String'  },
				    	{name : 'apprstatus', type: 'String'  },
				    	{name : 'qbillmethod', type: 'String'  },
				    	{name : 'cbillmethod', type: 'String'  },
				    	{name : 'contctype', type: 'String'  },
				    	{name : 'contperiod', type: 'String'  },  
				    	{name : 'skipsize', type: 'String'  },  
				    	{name : 'skipqty', type: 'number'  }, 					
						{name : 'noofvisit', type: 'number'  },
						{name : 'rate', type: 'number'  },
						{name : 'rent', type: 'number'  },
						{name : 'tfee', type: 'number'  },
						{name : 'cntvalue', type: 'number'  },  
						{name : 'ucalc', type: 'String'  },
						{name : 'cntdocstatus', type: 'String'  },   
						{name : 'qotrevno', type: 'String'  },    
						{name : 'returnremk', type: 'String'  },  
						
						{name : 'skipsizeqot', type: 'String'  },  
				    	{name : 'skipqtyqot', type: 'number'  }, 					
						{name : 'noofvisitqot', type: 'number'  },
						{name : 'rateqot', type: 'number'  },
						{name : 'rentqot', type: 'number'  },
						{name : 'tfeeqot', type: 'number'  },
						
						{name : 'tfeemethodqot', type: 'String'  },   
						{name : 'tfeemethod', type: 'String'  },
						{name : 'qotdclduser', type: 'String'  },   
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
           var cldocno= $('#enqlistgrid').jqxGrid('getcellvalue', row, "cldocno");
           var qotstatus= $('#enqlistgrid').jqxGrid('getcellvalue', row, "qotstatus");
           var returned= $('#enqlistgrid').jqxGrid('getcellvalue', row, "returned");
    	   if(parseInt(cldocno)==0) {
    		    return "colorClass3";  
    	   } 
    	   if(parseInt(qotstatus)<3) {  
      		   return "colorClass1";  
      	   } 
    	   if(parseInt(returned)>0) {       
      		   return "colorClass2";  
      	   }
     }    
	 $("#enqlistgrid").on('bindingcomplete', function (event) {  
		   var divname = $("#divname").val();
		   if(divname!=""){   
			   if(divname=="enq" || divname=="enqdcld" || divname==""){ 
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'condocno');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotno'); 
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qbillmethod');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'apprstatus');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cbillmethod');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contctype');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contperiod');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsize');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqty');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisit');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rate');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rent');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfee');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntvalue');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'ucalc');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdocstatus');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotrevno');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotval');  
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsizeqot');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqtyqot');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisitqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rateqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rentqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeeqot');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeemethod');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeemethodqot');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdclduser');
			   }else if(divname=="quot" || divname=="qotdcld" || divname=="appr" || divname=="allqot"){     
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'condocno');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cbillmethod');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contctype');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contperiod');  
				  /*$("#enqlistgrid").jqxGrid('hidecolumn', 'skipsize');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqty');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisit');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rate');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rent');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfee');	 */    
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntvalue');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'ucalc');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdocstatus');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'date');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsizeqot');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqtyqot');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisitqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rateqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rentqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeeqot');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeemethodqot');
			   }else if(divname=="newcrm"){  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'condocno');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cbillmethod');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contctype');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contperiod');  
				 /*   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsize');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqty');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisit');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rate');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rent');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfee');	 */
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntvalue');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'ucalc');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdocstatus');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'date');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsizeqot');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqtyqot');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisitqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rateqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rentqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeeqot');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeemethodqot');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdclduser');
			   }else if(divname=="unmgap"){
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'condocno');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cbillmethod');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contctype');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contperiod');  
				   /* $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsize');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqty');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisit');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rate');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rent');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfee');	 */
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntvalue');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'ucalc');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdocstatus');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'date');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsizeqot');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqtyqot');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisitqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rateqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rentqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeeqot');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeemethodqot');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdclduser');
			   }else if(divname=="amc"){
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'date');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'voc_no');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qbillmethod');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'status');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'apprstatus');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'age');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'flwupremarks');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cperson');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotrevno'); 
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotval');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsizeqot');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqtyqot');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisitqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rateqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rentqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeeqot');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeemethodqot');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdclduser');
			   }else if(divname=="chklist"){
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdate');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'condocno');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cbillmethod');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contctype');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'contperiod');  
				   /* $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsize');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqty');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisit');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rate');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rent');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfee');	 */
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntvalue');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'ucalc');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'cntdocstatus');
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'date');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipsizeqot');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'skipqtyqot');			    					
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'noofvisitqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rateqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'rentqot');	
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeeqot');
				   
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'tfeemethodqot');  
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdclduser');  
			   }else if(divname=="allitem"){
				   /* $("#enqlistgrid").jqxGrid('hidecolumn', 'qotval');    */
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdclduser');   
			   }else{}
			   if(divname=="quot" || divname=="appr" || divname=="allqot"){    
				   $("#enqlistgrid").jqxGrid('hidecolumn', 'qotdclduser');   
			   }
		   }
	 }); 
    $("#enqlistgrid").jqxGrid(
    {
        width: '99%',
        height: 400,
        source: dataAdapter,
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
    	showaggregates: true,
     	showstatusbar:true,
     	rowsheight:25,
     	statusbarheight:25,
        columns: [   
                  /* { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '2%',cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    }, */
                    { text: 'Sr No', datafield: 'slno', editable:false, width: '3%',cellsformat:'d0',cellclassname: cellclassname },
                    { text: 'Cont. Date', datafield: 'cntdate', width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
                    { text: 'Contract No',datafield: 'condocno', width: '5%' ,cellclassname: cellclassname },
                    { text: 'Qot Date', datafield: 'qotdate', width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
                    { text: 'Enq No',datafield: 'voc_no', width: '4%' ,cellclassname: cellclassname },  
                    { text: 'Enq Date', datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
                    { text: 'Qot No',datafield: 'qotno', width: '5%' ,cellclassname: cellclassname },
                    { text: 'Qot Rev No',datafield: 'qotrevno', width: '5%' ,cellclassname: cellclassname },
                    { text: 'Salesman', datafield: 'salm', width: '8%',cellclassname: cellclassname }, 
                    { text: 'Type of Quotation', datafield: 'qbillmethod', width: '8%',cellclassname: cellclassname },  
                    { text: 'Existing Client/New', datafield: 'clienttype', width: '7%',cellclassname: cellclassname },
                    { text: 'Group Company', datafield: 'groupcompanies', width: '13%' ,cellclassname: cellclassname },   
                    { text: 'Client',datafield: 'name' ,cellclassname: cellclassname, width: '15%' }, 
                    { text: 'Site',datafield: 'site' ,cellclassname: cellclassname, width: '10%' },
                    { text: 'Area',datafield: 'area' ,cellclassname: cellclassname, width: '8%' },
					{ text: 'Status', datafield: 'status', width: '10%',cellclassname: cellclassname },
					{ text: 'Appr. Status', datafield: 'apprstatus', width: '10%',cellclassname: cellclassname },
					{ text: 'Age (Hrs)', datafield: 'age', width: '4%' , cellsalign:'right',cellclassname: cellclassname },
					{ text: 'Flwup Remarks', datafield: 'flwupremarks', width: '8%',cellclassname: cellclassname },
					{ text: 'Contact person', datafield: 'cperson', width: '9%',cellclassname: cellclassname }, 
					
					{ text: 'Billing Method', datafield: 'cbillmethod', width: '9%',cellclassname: cellclassname },
					{ text: 'Contract Type', datafield: 'contctype', width: '9%',cellclassname: cellclassname },
					{ text: 'Contract Period', datafield: 'contperiod', width: '9%',cellclassname: cellclassname },
					{ text: 'Skip Size(QOT)', datafield: 'skipsizeqot', width: '9%',cellclassname: cellclassname },
					{ text: 'Skip Qty(QOT)', datafield: 'skipqtyqot', width: '4%',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'No of Visits(QOT)', datafield: 'noofvisitqot', width: '3%',cellclassname: cellclassname },  
					{ text: 'Rate per collection(QOT)', datafield: 'rateqot', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname },
					{ text: 'Skip Rent(QOT)', datafield: 'rentqot', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname },  
					{ text: 'Tipping Fee(QOT)', datafield: 'tfeeqot', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname },
					{ text: 'T.Fee Method(QOT)', datafield: 'tfeemethodqot', width: '6%',cellclassname: cellclassname },   
					{ text: 'Skip Size', datafield: 'skipsize', width: '9%',cellclassname: cellclassname },   
					{ text: 'Skip Qty', datafield: 'skipqty', width: '4%',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'No of Visits', datafield: 'noofvisit', width: '3%',cellclassname: cellclassname },  
					{ text: 'Rate per collection', datafield: 'rate', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname },
					{ text: 'Skip Rent', datafield: 'rent', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname },  
					{ text: 'Tipping Fee', datafield: 'tfee', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname }, 
					{ text: 'T.Fee Method', datafield: 'tfeemethod', width: '6%',cellclassname: cellclassname },
					{ text: 'Whole value of quotation',datafield: 'qotval', width: '6%' ,cellclassname: cellclassname,cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'Whole value of contract', datafield: 'cntvalue', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'U column calculation', datafield: 'ucalc', width: '7%',cellsformat:'d2',hidden:true,cellsalign:'right',align:'right',cellclassname: cellclassname },
					{ text: 'Contract Doc Status', datafield: 'cntdocstatus', width: '8%',cellclassname: cellclassname },
					{ text: 'Email', datafield: 'email1', width: '9%',cellclassname: cellclassname },
					{ text: 'User', datafield: 'user1', width: '9%',cellclassname: cellclassname },
					{ text: 'Quote Declined User', datafield: 'qotdclduser', width: '9%',cellclassname: cellclassname },  
					
					{ text: 'Client Details',datafield: 'details', width: '10%' ,cellclassname: cellclassname,hidden:true },
					{ text: 'QOT Flwup Date', datafield: 'fdate', width: '5%',hidden:true,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
				    { text: 'QOT Status', datafield: 'fstatus', width: '5%',hidden:true,cellclassname: cellclassname }, 
					{ text: 'Designation', datafield: 'designation', width: '9%',hidden:true,cellclassname: cellclassname },
				    { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true ,cellclassname: cellclassname },
					{ text: 'Branch', datafield: 'brch', width: '11%',hidden:true,cellclassname: cellclassname },
					{ text: 'contrmode', datafield: 'contrmode', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'sjobtype', datafield: 'sjobtype', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'cldocno', datafield: 'cldocno', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'qottrno', datafield: 'qottrno', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'dtype', datafield: 'dtype', width: '20%',hidden:true ,cellclassname: cellclassname },  
					{ text: 'MOB', datafield: 'per_mob', width: '5%',hidden:true,cellclassname: cellclassname  },
					{ text: 'pertel', datafield: 'pertel', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'address', datafield: 'address', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'salid', datafield: 'sal_id', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'email', datafield: 'mail1', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'sourceid', datafield: 'sourceid', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'brhid', datafield: 'brhid', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'contrno', datafield: 'contrno', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'qotstatus', datafield: 'qotstatus', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'payterms', datafield: 'payterms', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'billingmethod', datafield: 'billingmethod', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'returned', datafield: 'returned', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'Source', datafield: 'source', width: '6%',hidden:true,cellclassname: cellclassname },
					{ text: 'Remarks', datafield: 'remarks', width: '11%',hidden:true,cellclassname: cellclassname }, 
					{ text: 'Branch',datafield: 'branchname', width: '7%' ,hidden:true,cellclassname: cellclassname },
					{ text: 'returnremk',datafield: 'returnremk', width: '7%' ,hidden:true,cellclassname: cellclassname },
			 ]
   
    });
    $('.load-wrapp').hide();
    $('#enqlistgrid').on('rowdoubleclick', function (event) { 
   	  var rowindex1=event.args.rowindex;      
   	  var cldoc=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
  	  document.getElementById("enqdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
      document.getElementById("reftrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
      document.getElementById("qottrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qottrno");
      document.getElementById("qotchkno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qotno");
	  document.getElementById("brhid1").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	  document.getElementById("client").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name");
	  document.getElementById("cldocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
	  document.getElementById("address").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "address");
	  document.getElementById("hidcontrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "contrno"); 
	   
	  document.getElementById('lblselectedrowdetail').innerHTML=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name")+' - '+$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
	  $('.comments-container').html('');  
      });   
});
</script>
<div id="enqlistgrid"></div>