<%@page import="java.util.List"%>
<%@page import="dao.DentistDAO"%>
<%@page import="model.Dentist"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if(session.getAttribute("user")==null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dentists</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="assets/css/style.css">
</head>

<body class="<%= session.getAttribute("theme") != null ? session.getAttribute("theme") : "light" %>">

<jsp:include page="includes/sidebar.jsp"/>
<jsp:include page="includes/navbar.jsp"/>

<div class="main-content">

<div class="container-fluid p-4">

<div class="page-header mb-4">

    <div>

        <h2>

            <i class="bi bi-person-vcard-fill"></i>

            Dentists

        </h2>

        <p>

            Manage all dentists and specializations.

        </p>

    </div>

</div>

<% if(request.getParameter("success")!=null){ %>

<div class="alert alert-success">

    Dentist added successfully.

</div>

<% } %>

<% if(request.getParameter("updated")!=null){ %>

<div class="alert alert-warning">

    Dentist updated successfully.

</div>

<% } %>

<% if(request.getParameter("deleted")!=null){ %>

<div class="alert alert-danger">

    Dentist deleted successfully.

</div>

<% } %>

<div class="table-card mb-4">

<h4 class="mb-4">

<i class="bi bi-person-plus-fill text-info"></i>

Add New Dentist

</h4>

<form action="AddDentistServlet" method="post">

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">

First Name

</label>

<input
type="text"
name="firstName"
class="form-control"
required>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Last Name

</label>

<input
type="text"
name="lastName"
class="form-control"
required>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Specialization

</label>

<input
type="text"
name="specialization"
class="form-control"
required>

</div>

<div class="col-md-6 mb-3">

<label class="form-label">

Phone

</label>

<input
type="text"
name="phone"
class="form-control">

</div>

<div class="col-12 mb-3">

<label class="form-label">

Email

</label>

<input
type="email"
name="email"
class="form-control">

</div>

<div class="col-12">

<button class="save-btn">

<i class="bi bi-check2-circle"></i>

Save Dentist

</button>

</div>

</div>

</form>

</div>

<%
DentistDAO dao = new DentistDAO();

String keyword = request.getParameter("search");

List<Dentist> list;

if(keyword != null && !keyword.trim().isEmpty()){

    list = dao.searchDentists(keyword);

}else{

    list = dao.getAllDentists();

}
%>
<div class="table-card">

    <div class="d-flex justify-content-between align-items-center mb-4">

        <h4>

            <i class="bi bi-person-lines-fill text-info"></i>

            Dentist Records

        </h4>

        <span class="badge bg-info">

            <%= list.size() %> Dentists

        </span>

    </div>

    <form method="get">

        <div class="row g-3 align-items-center">

            <div class="col-lg-10">

                <div class="input-group">

                    <span class="input-group-text bg-dark border-info text-info">

                        <i class="bi bi-search"></i>

                    </span>

                    <input
                        type="text"
                        name="search"
                        class="form-control search-input"
                        placeholder="Search Dentist by Name, Specialization, Phone or Email..."
                        value="<%= keyword == null ? "" : keyword %>">

                </div>

            </div>

            <div class="col-lg-2 d-grid">

                <button class="btn btn-info fw-bold">

                    <i class="bi bi-search"></i>

                    Search

                </button>

            </div>

        </div>

    </form>

    <div class="mt-3">

        <a href="dentists.jsp" class="btn btn-outline-light">

            <i class="bi bi-arrow-clockwise"></i>

            Reset

        </a>

    </div>

    <hr class="my-4">

    <div class="table-responsive">

        <table class="table patient-table align-middle">

            <thead>

            <tr>

                <th>ID</th>

                <th>Dentist</th>

                <th>Specialization</th>

                <th>Phone</th>

                <th>Email</th>

                <th class="text-center">Actions</th>

            </tr>

            </thead>

            <tbody>

            <%
            for(Dentist d : list){
            %>

            <tr>

                <td>

                    <span class="patient-id">

                        #<%= d.getDentistId() %>

                    </span>

                </td>

                <td>

                    <div class="d-flex align-items-center">

                        <div class="patient-avatar">

                            <i class="bi bi-person-badge-fill"></i>

                        </div>

                        <div class="ms-3">

                            <strong>

                                Dr. <%= d.getFirstName() %> <%= d.getLastName() %>

                            </strong>

                        </div>

                    </div>

                </td>

                <td>

                    <span class="badge bg-primary">

                        <%= d.getSpecialization() %>

                    </span>

                </td>

                <td>

                    <%= d.getPhone() %>

                </td>

                <td>

                    <%= d.getEmail() %>

                </td>

                <td class="text-center">

                    <a href="edit-dentist.jsp?id=<%=d.getDentistId()%>"
                       class="btn btn-warning btn-sm rounded-circle me-2">

                        <i class="bi bi-pencil"></i>

                    </a>

                    <a href="DeleteDentistServlet?id=<%=d.getDentistId()%>"
                       class="btn btn-danger btn-sm rounded-circle"
                       onclick="return confirm('Delete this dentist?');">

                        <i class="bi bi-trash"></i>

                    </a>

                </td>

            </tr>

            <%
            }
            %>

            </tbody>

        </table>

    </div>

</div>

</div>

</div>

</body>

</html>