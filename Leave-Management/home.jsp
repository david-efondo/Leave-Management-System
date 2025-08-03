<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="java.util.ArrayList"%>    
<%@ page import="com.jdbc.FormDTO"%> 
<%@ page import="com.jdbc.FormDAO"%> 
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="styles.css" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
      crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
      integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    />
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"
      integrity="sha512-STof4xm1wgkfm7heWqFJVn58Hm3EtS31XFaagaa8VMReCXAkQnJZ+jEy8PCC/iT18dFy95WcExNHFTqLyp72eQ=="
      crossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
  </head>
<body>
	<%
	int userId = (int)session.getAttribute("userId");
			String sUserId = Integer.toString(userId);
			
			String name = (String)session.getAttribute("name");
			
			String error = (String)session.getAttribute("error");
			
			 List<FormDTO> list = FormDAO.getAllApplicationById(sUserId);
	%>  
	
	<!-- Navbar -->
    <div class="bg-light">
    <%
    if(error != null){
    %>
    		<div
      class="bg-danger d-flex align-items-center justify-content-between"
      role="alert"
      id="alert"
    >
      <div></div>
      <div class="text-light text-center py-3"><%=error%></div>
      <button
        type="button"
        class="btn-close btn-lg me-3 my-2"
        aria-label="Close"
      ></button>
    </div>
    		
    	<%
    		    	}
    		    	%>
   
      <nav class="navbar navbar-expand-lg navbar-light container-sm">
        <div class="container-fluid">
          <a class="navbar-brand" href="#">L.M.S</a>
          <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarText"
            aria-controls="navbarText"
            aria-expanded="false"
            aria-label="Toggle navigation"
          >
            <span class="navbar-toggler-icon"></span>
          </button>

			<h5><center>Welcome <strong><%=name%></strong>!</center></h5>
              </li>
            </ul>
            <div class="text-end py-2 navbar-text">
            	<form action="signout" method="post">
	        		<button type="submit" class="btn btn-primary">
	        		<i class="fas fa-sign-out-alt"></i>
	                Logout as <strong><%=name%></strong>
	                </button>
	        	</form>
            </div>
          </div>
        </div>
      </nav>
    </div>
    <div class="container-sm">
      <div class="d-flex justify-content-between">
        <div>
          <h1>Leave Applications</h1>
        </div>
        <div class="align-self-end">
        	<form action="createleave" method="post">
	        	<input type="hidden" name="userId" value=<%=sUserId%> />
	        	<button type="submit" class="btn btn-success">  <i class="fa-solid fa-plus"></i> Create Leave</button>
	        </form>
        </div>
      </div>
      <div class="table-responsive-md">
      <table class="table align-middle bg-white m-3 table-hover">
        <thead class="table-light">
          <tr>
          	<th>Form ID</th>
            <th>Reason</th>
            <th>Leave Start</th>
            <th>Leave End</th>
            <th>Actions</th>
           </tr>
          </thead>
         <tbody>
         	<%
         	for(FormDTO app:list){
         	         		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
         	         		        SimpleDateFormat outputFormat = new SimpleDateFormat("MMM d, yyyy");
         	         		        Date leaveStartDate = inputFormat.parse(app.getLeaveStart());
         	         		        Date leaveEndDate = inputFormat.parse(app.getLeaveEnd());
         	         		        String formattedLeaveStart = outputFormat.format(leaveStartDate);
         	         		        String formattedLeaveEnd = outputFormat.format(leaveEndDate);
         	%>
		<tr>
			<td>
				<p class="fw-bold mb-1 text-muted"><%= app.getFormId() %></p></td>
			<td>
				<p class="fw-normal mb-1"><%= app.getReason()%></p>
			</td>
		<td>
			<p class="fw-normal mb-1"><%=formattedLeaveStart%></p>
		</td>
		<td>
			<p class="fw-normal mb-1"><%=formattedLeaveEnd%></p>
		</td>
		
		<td>
              <a href='editleave?userId=<%= sUserId%>&FormId=<%= app.getFormId()%>'>Edit</a>
              <a href='deleteleave?userId=<%= sUserId%>&FormId=<%= app.getFormId()%>'>Delete</a> 
        </td>
            
		</tr>
		
		<%} %>
		
      </tbody>
      
      </table>
      </div>
    </div>
    
    
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
      crossorigin="anonymous"
    ></script>
    <script>
      $('body').on('click', '.btn-close', function (e) {
        $('#alert').remove()
      })
    </script>
</body>
</html>