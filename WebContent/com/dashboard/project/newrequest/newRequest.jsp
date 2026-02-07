<!DOCTYPE html>
<html lang="en">

<head>
    <title>New Request Management</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
    <jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />

    <style type="text/css">
        .custompanel {
            border: 1px solid #ccc;
            float: left;
            display: inline-block;
            margin-top: 10px;
            margin-right: 10px;
            padding-right: 10px;
            padding-left: 10px;
            padding-top: 10px;
            padding-bottom: 10px;
            border-radius: 8px;
        }
        /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
        
        .badge-notify {
            position: absolute;
            right: -5px;
            top: -8px;
            z-index: 2;
            background-color: red;
        }
        
        .comment {
            background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
            color: #000;
            clear: both;
            float: right;
            display: block;
            padding-top: 8px;
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 5px;
            border-radius: 12px;
            border-top-right-radius: 0;
            margin-bottom: 8px;
            transition: all 0.5s ease-in;
        }
        
        .msg-details {
            text-align: right;
        }
        
        .comments-container {
            height: 400px;
            overflow-y: auto;
            margin-bottom: 8px;
            padding-right: 5px;
        }
        
        .comments-outer-container {
            width: 100%;
            height: 100%;
        }
        
        .msg {
            word-break: break-all;
        }
        
        .rowgap {
            margin-bottom: 6px;
        }
        
        .textpanel p.h4 {
            margin-top: 8px;
            margin-bottom: 6px;
        }
        
        .load-wrapp {
            float: left;
            width: 100px;
            height: 100px;
            margin: 0 10px 10px 0;
            padding: 20px 20px 20px;
            border-radius: 5px;
            text-align: center;
            background-color: #fff;
            position: absolute;
            z-index: 9999;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            border: 1px solid #000;
        }
        
        .spinner {
            position: relative;
            width: 45px;
            height: 45px;
            margin: 0 auto;
        }
        
        .bubble-1,
        .bubble-2 {
            position: absolute;
            top: 0;
            width: 25px;
            height: 25px;
            border-radius: 100%;
            background-color: #000;
        }
        
        .bubble-2 {
            top: auto;
            bottom: 0;
        }
        
        .load-9 .spinner {
            border: none;
            animation: loadingI 2s linear infinite;
        }
        
        .load-9 .bubble-1,
        .load-9 .bubble-2 {
            animation: bounce 2s ease-in-out infinite;
        }
        
        .load-9 .bubble-2 {
            animation-delay: -1.0s;
        }
        
        @keyframes loadingI {
            100% {
                transform: rotate(360deg);
            }
        }
        
        @keyframes bounce {
            0%,
            100% {
                transform: scale(0.0);
            }
            50% {
                transform: scale(1.0);
            }
        }
    </style>
</head>

<body>
    <div class="load-wrapp">
        <div class="load-9">
            <div class="spinner">
                <div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row rowgap">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            	<div class="custompanel" style="border:none;">
            		<h4>New Request Dashboard</h4>
            	</div>
                <div class="primarypanel custompanel">
                    <button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
                    <button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
                </div>
                <div class="actionpanel custompanel">
                    <button type="button" class="btn btn-default" id="btnstatusupdatemodal" data-target="#modalstatusupdate"><i class="fa fa-pencil" aria-hidden="true" data-toggle="tooltip" title="Status Update" data-placement="bottom"></i></button>
                </div>

                <div class="otherpanel custompanel">
                    <button type="button" class="btn btn-default" id="btncomment" data-target="#modalcomments"><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
                </div>
                <div class="textpanel custompanel">
                    <p class="h4">&nbsp;</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div id="newrequestdiv">
                    <jsp:include page="newRequestGrid.jsp"></jsp:include>
                </div>
                <div id="followupdiv">
                	<jsp:include page="followupGrid.jsp"></jsp:include>
                </div>
            </div>
        </div>

        <!-- Status update Modal-->
        <div id="modalstatusupdate" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Status Update</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-horizontal">
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="cmbstatus">Status</label>
                    			<div class="col-sm-10">
                        			<select class="form-control" name="cmbstatus" id="cmbstatus" style="width: 100%">
                                    </select>
                                    <span class="help-block hidden"></span>
                    			</div>
                    			
                  			</div>
                  			<div class="form-group">
                    			<label class="col-sm-2 control-label" for="remarks" >Remarks</label>
                    			<div class="col-sm-10">
                    				<input type="text" name="statusupdateremarks" id="statusupdateremarks" class="form-control">
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
                		</div>
                    </div>
                	<div class="modal-footer">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	                	<button type="button" class="btn btn-default btn-primary" name="btnstatuspdate" id="btnstatuspdate">Save changes</button>
	          		</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Comments Modal-->
    <div id="modalcomments" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Comments</h4>
                </div>
                <div class="modal-body">
                    <div class="comments-outer-container container-fluid">
                        <div class="comments-container">

                        </div>
                        <div class="create-msg-container">
                            <!-- <div class="container-fluid"> -->
                            <div class="row">
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                                        <div class="input-group-btn">
                                            <button type="button" id="btncommentsend" class="btn btn-default">
                                                <i class="fa fa-paper-plane"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- </div> -->
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div> -->
            </div>
        </div>
    </div>
    <input type="hidden" name="jobcarddocno" id="jobcarddocno">
    
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.24.4/dist/sweetalert2.all.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('[data-toggle="tooltip"]').tooltip();
            $("#cmbstatus").select2({
			    placeholder: "Select Status",
			    allowClear: true,
			    width: '100%'
			});
            getInitData();
            $('.load-wrapp').hide();
            $('#btnsubmit').click(function() {
                $('#assignSubGridDetails').jqxGrid('clear');
                $('#newrequestdiv').load('newRequestGrid.jsp?id=1');
            });
            $('#btnexcel').click(function() {

            });

            $('.actionpanel button,.otherpanel button').click(function() {
                var jobcarddocno = $('#jobcarddocno').val();
                if (jobcarddocno == "") {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select a document'
                    });
                    return false;
                }
                var modaltarget = $(this).attr('data-target');
                $(modaltarget).modal('show');
            });
            $('#btnstatuspdate').click(function() {
                var jobcarddocno = $('#jobcarddocno').val();
                var cmbstatus = $('#cmbstatus').val();
                var statusupdateremarks=$('#statusupdateremarks').val();
                if (jobcarddocno == "") {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select a document'
                    });
                    return false;
                }
                if (cmbstatus == "") {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select status'
                    });
                    return false;
                }
                statusupdateremarks=encodeURIComponent(statusupdateremarks);
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if (items == "0") {
                        swal({
                            type: 'success',
                            title: 'Message',
                            text: 'Status Updated'
                        });
                        $('#btnsubmit').trigger('click');
                        $('#modalstatusupdate').modal('hide');
                        $('#assignSubGridDetails').jqxGrid('clear');
                    } else {
                        swal({
                            type: 'error',
                            title: 'Warning',
                            text: 'Not Updated'
                        });
                    }

                } else {}
            }
            x.open("GET", "statusUpdate.jsp?jobcarddocno=" + jobcarddocno + "&cmbstatus=" + cmbstatus + "&statusupdateremarks=" + statusupdateremarks, true);
            x.send();
            });
            $('#btncommentsend').click(function() {
                var txtcomment = $('#txtcomment').val();
                var jobcarddocno = $('#jobcarddocno').val();
                if (txtcomment == "") {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please type in comment'
                    });
                    return false;
                }
                if (jobcarddocno == "") {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select a document'
                    });
                    return false;
                }

                saveComment();
            });

            $('#btnbaymovupdate').click(function() {
                if ($('#jobcarddocno').val() == '') {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select a document'
                    });
                    return false;
                }
                if ($('.cmbbaymovupdate').val() == '') {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select a zone'
                    });
                    return false;
                }
                funUpdateBayMov();
            });

            $('#btnbaystatusupdate').click(function() {
                if ($('#jobcarddocno').val() == '') {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select a document'
                    });
                    return false;
                }
                if ($('.cmbstatus').val() == '') {
                    swal({
                        type: 'error',
                        title: 'Warning',
                        text: 'Please select a status'
                    });
                    return false;
                }
                funUpdateBayStatus();
            });
            
        });

		function getInitData() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var data=x.responseText.trim();
                    data=JSON.parse(data);
                    var htmldata='<option value="">--Select--</option>';
                    $.each(data.statusdata, function( index, value ) {
	  					htmldata+='<option value="'+value.id+'">'+value.name+'</option>';
					});
					$('#cmbstatus').html($.parseHTML(htmldata));
                } else {}
            }
            x.open("GET", "getInitData.jsp", true);
            x.send();
        }
        function saveComment() {
            var comment = $('#txtcomment').val();
            var jobcarddocno = $('#jobcarddocno').val();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim().split(",");
                    getComments();
                } else {}
            }
            x.open("GET", "saveComment.jsp?comment=" + comment.replace(/ /g, "%20") + "&jobcarddocno=" + jobcarddocno, true);
            x.send();
        }

        function getComments() {
            var jobcarddocno = $('#jobcarddocno').val();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    $('.comments-container').html('');
                    if (x.responseText.trim() != "") {
                        var items = x.responseText.trim().split(",");
                        var str = '';
                        for (var i = 0; i < items.length; i++) {
                            str += '<div class="comment"><div class="msg"><p>' + items[i].split("::")[0] + '</p></div><div class="msg-details"><p>' + items[i].split("::")[1] + ' - ' + items[i].split("::")[2] + '</p></div></div>';
                        }
                        $('.comments-container').html($.parseHTML(str));
                    }

                } else {}
            }
            x.open("GET", "getComments.jsp?jobcarddocno=" + jobcarddocno, true);
            x.send();
        }


        function funUpdateBayStatus() {
            var jobcarddocno = $('#jobcarddocno').val();
            var cmbbaystatusupdate = $('.cmbbaystatusupdate').val();
            var cmbbaystatus = $('#cmbbaystatus').val();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if (items == "0") {
                        swal({
                            type: 'success',
                            title: 'Message',
                            text: 'Zone Status Updated'
                        });
                        $('#btnsubmit').trigger('click');
                    } else {
                        swal({
                            type: 'error',
                            title: 'Warning',
                            text: 'Not Updated'
                        });
                    }

                } else {}
            }
            x.open("GET", "bayStatusUpdate.jsp?jobcarddocno=" + jobcarddocno + "&cmbbaystatusupdate=" + cmbbaystatusupdate + "&cmbbaystatus=" + cmbbaystatus, true);
            x.send();
        }

        function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

            var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;

            // alert("arrData");
            var CSV = '';
            //Set Report title in first row or line

            CSV += ReportTitle + '\r\n\n';

            //This condition will generate the Label/Header
            if (ShowLabel) {
                var row = "";

                //This loop will extract the label from 1st index of on array
                for (var index in arrData[0]) {

                    //Now convert each value to string and comma-seprated
                    row += index + ',';
                }

                row = row.slice(0, -1);

                //append Label row with line break
                CSV += row + '\r\n';
            }

            //1st loop is to extract each row
            for (var i = 0; i < arrData.length; i++) {
                var row = "";

                //2nd loop will extract each column and convert it in string comma-seprated
                for (var index in arrData[i]) {
                    row += '"' + arrData[i][index] + '",';
                }

                row.slice(0, row.length - 1);

                //add a line break after each row
                CSV += row + '\r\n';
            }

            if (CSV == '') {
                alert("Invalid data");
                return;
            }

            //Generate a file name
            var fileName = "";
            //this will remove the blank-spaces from the title and replace it with an underscore
            fileName += ReportTitle.replace(/ /g, "_");

            //Initialize file format you want csv or xls
            var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);

            // Now the little tricky part.
            // you can use either>> window.open(uri);
            // but this will not work in some browsers
            // or you will not get the correct file extension    

            //this trick will generate a temp <a /> tag
            var link = document.createElement("a");
            link.href = uri;

            //set the visibility hidden so it will not effect on your web-layout
            link.style = "visibility:hidden";
            link.download = fileName + ".csv";

            //this part will append the anchor tag and remove it after automatic click
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    </script>
</body>

</html>