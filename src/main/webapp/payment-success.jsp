<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    if (session.getAttribute("user") == null) {

        response.sendRedirect("login.jsp");
        return;
    }

%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Payment Successful | Sunrise Dental Clinic
    </title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        body {

            background:
                linear-gradient(
                    135deg,
                    #eefcff,
                    #f7fbff
                );

        }


        .success-container {

            min-height: 100vh;

            display: flex;

            align-items: center;

            justify-content: center;

        }


        .success-card {

            background: white;

            max-width: 500px;

            width: 100%;

            text-align: center;

            padding: 50px 35px;

            border-radius: 25px;

            box-shadow:
                0 15px 40px
                rgba(0,0,0,0.08);

        }


        .success-icon {

            width: 85px;

            height: 85px;

            border-radius: 50%;

            background: #d1fae5;

            color: #16a34a;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 42px;

            margin: 0 auto 25px;

        }


        .success-card h2 {

            font-weight: 700;

            color: #092b3a;

        }


        .success-card p {

            color: #718096;

        }


        .success-btn {

            background: #16c1e5;

            color: white;

            border: none;

            border-radius: 10px;

            padding: 12px 25px;

            font-weight: 700;

            text-decoration: none;

            display: inline-block;

            margin-top: 15px;

        }


        .success-btn:hover {

            color: white;

            background: #0eafd0;

        }

    </style>

</head>


<body>


<div class="success-container">


    <div class="success-card">


        <div class="success-icon">

            <i class="bi bi-check-lg"></i>

        </div>


        <h2>

            Payment Successful!

        </h2>


        <p>

            Your payment has been successfully processed.

            Your invoice has been marked as paid.

        </p>


        <div class="alert alert-success">

            <i class="bi bi-check-circle-fill"></i>

            Payment Status: <strong>PAID</strong>

        </div>


        <a href="PatientBillingServlet"
           class="success-btn">

            <i class="bi bi-receipt"></i>

            View My Bills

        </a>


        <br>


        <a href="dashboard.jsp"
           class="btn btn-outline-secondary mt-3">

            Back to Dashboard

        </a>


    </div>

</div>


</body>

</html>