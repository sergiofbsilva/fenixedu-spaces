<%--

    Copyright © 2014 Instituto Superior Técnico

    This file is part of FenixEdu Spaces.

    FenixEdu Spaces is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FenixEdu Spaces is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with FenixEdu Spaces.  If not, see <http://www.gnu.org/licenses/>.

--%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="page-header">
	<h1>
		<spring:message code="title.space.classification.management" text="Space Classification Management" />
		<small>${information.name}</small>
	</h1>
</div>

<div class="panel panel-primary">
	<div class="panel-heading">
		<h3 class="panel-title"><spring:message code="title.space.classification" text="Classifications" /></h3>
	</div>
	<div class="panel-body">
	<c:choose>
	<c:when test="${not empty classifications}">
		<table class="table">
			<thead>
				<tr>
					<th><spring:message code="label.spaces.name" text="Name"/></th>
					<th><spring:message code="label.spaces.operations" text="Operations"/></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="classification" items="${classifications}">
					<spring:url value="/classification/edit/${classification.externalId}" var="editUrl" />
					<spring:url value="/classification/remove/${classification.externalId}" var="removeUrl" />
					<tr>
						<td>${classification.name.content}</td>
						<td>
							<a href="${editUrl}" class="btn btn-default" title="Edit"><span class="glyphicon glyphicon-pencil"></span></a>
							<button data-classification-id="${classification.externalId}" data-classification-name="${classification.name.content}" data-toggle="modal" data-target="#confirmDelete" class="btn btn-default" title="delete"><span class="glyphicon glyphicon-remove"></span></button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:when>
	<c:otherwise>
		<spring:message code="label.empty.spaces" text="No available spaces." />
	</c:otherwise>
</c:choose>
	</div>
</div>
<spring:url value="/classification/edit/" var="createUrl" />
<a href="${createUrl}" class="btn btn-success">Create Classification</a>
<spring:url value="/classification/remove/" var="removeUrlBase" />
<script type="text/javascript">
<!--

//-->
$(document).ready(function() {
	var deleteUrl = "${removeUrlBase}";
	$('#confirmDelete').on('show.bs.modal', function (e) {
		      var $spaceName = $(e.relatedTarget).attr('data-classification-name');
		      var $message = "Are you sure you want to delete '" + $spaceName + "' ?";
		      $(this).find('.modal-body p').text($message);
		      var $title = "Delete '" + $spaceName + "'";
		      var $spaceId = $(e.relatedTarget).attr('data-classification-id');
		      $(this).find('.modal-title').text($title);
		      $('#confirmDelete').find('.modal-footer #confirm').show(0);
  			$('#confirmDelete').find('.modal-footer #cancel').show(0);
  			$('#confirmDelete').find('.modal-footer #hide').hide(0);
		      $('#confirmDelete').find('.modal-footer #hide').on('click', function(){
		    	  $('#confirmDelete').modal('hide');
		      });

		      $('#confirmDelete').find('.modal-footer #confirm').on('click', function(){
		    	  $.ajax({
					    url: deleteUrl + $spaceId,
					    type: 'DELETE',
					    success: function(result) {
					    	if(result == "ok"){
						    	location.reload();
						    	return;
					    	}else{
					    		var resultJSON = JSON.parse(result);
					    		if(resultJSON["message"]!= null){
					    			$("#confirmDelete").find('.modal-body p').text(resultJSON["message"]);
					    			$('#confirmDelete').find('.modal-footer #confirm').hide(0);
					    			$('#confirmDelete').find('.modal-footer #cancel').hide(0);
					    			$('#confirmDelete').find('.modal-footer #hide').show(0);
					    			
					    		}
					    	}
					    },
					});
			  });
		  });
	});   
</script>


<!-- Modal Dialog -->
<div class="modal fade" id="confirmDelete" role="dialog" aria-labelledby="confirmDeleteLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Delete Permanently</h4>
      </div>
      <div class="modal-body bg-danger">
        <p style="text-align:center">Are you sure you want to delete <b> this </b>?</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal" id="cancel">Cancel</button>
        <button type="button" class="btn btn-danger" id="confirm">Delete</button>
        <button type="button" class="btn btn-default" id="hide">Ok</button>
      </div>
    </div>
  </div>
</div>