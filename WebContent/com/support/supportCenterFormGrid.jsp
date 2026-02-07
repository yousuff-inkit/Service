<%@page import="com.support.ClsSupport" %>
<%ClsSupport cs=new ClsSupport(); %>
<%-- <%@page import="com.operations.setup.jobprocessguideline.ClsProcessGuidelineDAO"%> --%>
<%@page import="javax.servlet.http.HttpSession" %>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>

<%String contextPath=request.getContextPath();
//System.out.println("==requesstttt=eeeeee=="+request.getAttribute("usertoid"));

String userfrmid=request.getParameter("userfrmid")==null?"0":request.getParameter("userfrmid").toString().trim();

String usertoid=request.getParameter("usertoid")==null?"0":request.getParameter("usertoid").toString().trim();

//System.out.println("==userfrmid=grid=="+userfrmid+"===usertoid==grid=="+usertoid);

%>


<style type="text/css">
    .jqx-widget-metro .jqx-grid-cell-selected-metro, .jqx-grid-cell-selected-metro{ background-color:#DCEBFC; border-color: #DCEBFC; font-size: 12px;color: black; }
    .jqx-widget .jqx-grid-cell, .jqx-widget .jqx-grid-column-header, .jqx-widget .jqx-grid-group-cell {
        border-color: transparent;
    }
    .jqx-widget .jqx-grid-cell-selected div { margin-top: 3px !important; margin-bottom: 3px !important; }
    .jqx-grid-cell-selected {
        top: 1px;
        border-top: solid 1px blue !important;
        border-bottom: solid 1px blue !important;
        height: auto !important;
    }
    
    .supportClass
     {
             color: #FE2E2E;
             background-color: #ECF8E0;
            font-size:12px;
            font-style: bold;
     }
    .clientClass
     {
             color: #2E2EFE;
             background-color: #ECF8E0;
            font-size:12px;
            font-style: bold;
     }
     
     .column
{
   /* background-color: #ECF8E0; */ 
   background-color: #ECF8E0;         
}
   
      
</style>

<script type="text/javascript">
        var data;
        
         data='<%=cs.msghistoryload(userfrmid,usertoid)%>';
        
        $(document).ready(function () { 	
        	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'is_read', type: 'number' },
							{name : 'image', type: 'string' },
							{name : 'user', type: 'string' },
							{name : 'mesg', type: 'string' },
							{name : 'date', type: 'string' },
							{name : 'path', type: 'string' }
							
                        ],
                		    localdata: data, 
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var imagerenderer = function (row, datafield, value) {
                return '<img style="margin-left: 0px;" height="18" width="30" src="'+ value +'"/>';
            }
            
            var msgrenderer = function (row, datafield, value) {
                return '<img style="margin-left: 5px;" height="40" width="40"/>'; 
            }

            var cellclassname = function (row, column, value, data) {
        		if (data.is_read ==0) {
                    return "supportClass";
                }else{
                	return "clientClass";
                };
            };
            

            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSupportCenterGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                editable: false,
                theme: 'energyblue',
                //selectionmode: 'singlecell',
                enabletooltips: true,
                //autorowheight:true,
                enablehover: false,
                sortable: true,
                 scrollmode: 'deferred',
                scrollfeedback: function(row)
                {
                    return '<table style="height: 25px;"><tr><td>' +row.date + '</td></tr></table>';
                }, 
               
  
                columns: [
							{ text: '', datafield: 'image', width: '3%', cellclassname: cellclassname, cellsrenderer: imagerenderer },                     
							{ text: '', datafield: 'user', width: '8%', cellclassname: cellclassname },
							{ text: '', datafield: 'mesg', width: '80.5%', cellclassname: cellclassname },
							{ text: '', datafield: 'date', cellsformat: 'dd/MM/yy' , width: '10%',cellclassname: cellclassname},
							{ text: '', datafield: 'path', width: '95%',hidden:true , cellclassname: cellclassname },
							{ text: '', datafield: 'is_read', width: '5%',hidden:true , cellclassname: cellclassname },
							
						]
            });
            
            $('#jqxSupportCenterGrid').on('celldoubleclick', function (event) {
            
                var row1=event.args.rowindex; 
                
                SaveToDisk($('#jqxSupportCenterGrid').jqxGrid('getcellvalue', row1, "path"),$('#jqxSupportCenterGrid').jqxGrid('getcellvalue', row1, "mesg")); 

               });
            
            
            /*$("#jqxSupportCenterGrid").jqxGrid('addrow', null, {"images":"../../../icons/user.png","user_name": "Operator","user_id": "Hoe Are You ?","date": "09.09.2015"});
            $("#jqxSupportCenterGrid").jqxGrid('addrow', null, {"images":"../../../icons/user.png","user_name": "Vishakh","user_id": "Hello..","date": "08.09.2015"});
            $("#jqxSupportCenterGrid").jqxGrid('addrow', null, {"images":"../../../icons/user.png","user_name": "Operator","user_id": "Hi..","date": "08.09.2015"}); */
        });
    </script>
    
    <div id="jqxSupportCenterGrid"></div>
    <input type="hidden" id="rowindex"/>
    
    