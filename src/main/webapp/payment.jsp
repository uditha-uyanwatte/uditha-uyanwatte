<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.Billing" %>

<%

    if (session.getAttribute("user") == null) {

        response.sendRedirect("login.jsp");
        return;
    }


    Billing bill =
            (Billing) request.getAttribute("bill");


    if (bill == null) {

        response.sendRedirect(
                "PatientBillingServlet"
        );

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
        Secure Payment | Sunrise Dental Clinic
    </title>


    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <link
        rel="stylesheet"
        href="assets/css/style.css">


    <style>

        body {

            background:
                linear-gradient(
                    135deg,
                    #eefcff,
                    #f7fbff
                );

        }


        .payment-container {

            max-width: 850px;

            margin: 50px auto;

        }


        .payment-card {

            background: white;

            border-radius: 22px;

            padding: 35px;

            box-shadow:
                0 15px 40px
                rgba(0, 0, 0, 0.08);

        }


        .payment-header {

            text-align: center;

            margin-bottom: 30px;

        }


        .payment-icon {

            width: 70px;

            height: 70px;

            margin: auto;

            border-radius: 20px;

            background: #e4faff;

            color: #12bce0;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 30px;

            margin-bottom: 15px;

        }


        .payment-header h2 {

            font-weight: 700;

            color: #092b3a;

        }


        .bill-summary {

            background: #f6fbfd;

            border-radius: 15px;

            padding: 20px;

            margin-bottom: 25px;

        }


        .bill-summary-row {

            display: flex;

            justify-content:
                space-between;

            padding: 8px 0;

        }


        .bill-summary-row span {

            color: #718096;

        }


        .bill-summary-row strong {

            color: #092b3a;

        }


        .payment-amount {

            color: #0aa678 !important;

            font-size: 23px;

        }


        .form-label {

            font-weight: 600;

            color: #34495e;

        }


        .form-control {

            border-radius: 10px;

            padding: 12px;

        }


        .card-input {

            letter-spacing: 2px;

        }


        .pay-button {

            width: 100%;

            border: none;

            border-radius: 12px;

            padding: 14px;

            background: #16c1e5;

            color: white;

            font-size: 17px;

            font-weight: 700;

            margin-top: 10px;

        }


        .pay-button:hover {

            background: #0eafd0;

        }


        .secure-text {

            text-align: center;

            color: #718096;

            font-size: 13px;

            margin-top: 15px;

        }


        .back-btn {

            display: inline-block;

            margin-bottom: 20px;

            text-decoration: none;

            color: #0aaed0;

            font-weight: 600;

        }

    </style>

</head>


<body>


<div class="container payment-container">


    <a href="PatientBillingServlet"
       class="back-btn">

        <i class="bi bi-arrow-left"></i>

        Back to My Bills

    </a>


    <div class="payment-card">


        <!-- HEADER -->

        <div class="payment-header">

            <div class="payment-icon">

                <i class="bi bi-credit-card-2-front-fill"></i>

            </div>


            <h2>

                Secure Payment

            </h2>


            <p class="text-muted">

                Complete your payment securely.

            </p>

        </div>



        <!-- BILL SUMMARY -->

        <div class="bill-summary">


            <div class="bill-summary-row">

                <span>

                    Invoice Number

                </span>

                <strong>

                    #<%= bill.getBillId() %>

                </strong>

            </div>


            <div class="bill-summary-row">

                <span>

                    Patient

                </span>

                <strong>

                    <%= bill.getPatientName() %>

                </strong>

            </div>


            <div class="bill-summary-row">

                <span>

                    Treatment

                </span>

                <strong>

                    <%= bill.getTreatmentName() %>

                </strong>

            </div>


            <hr>


            <div class="bill-summary-row">

                <span>

                    Amount to Pay

                </span>

                <strong class="payment-amount">

                    Rs.
                    <%= String.format(
                            "%,.2f",
                            bill.getAmount()
                    ) %>

                </strong>

            </div>


        </div>



        <!-- PAYMENT FORM -->

        <form
            action="PaymentProcessServlet"
            method="post"
            onsubmit="return validatePayment();">


            <input
                type="hidden"
                name="billId"
                value="<%= bill.getBillId() %>">


            <!-- CARD HOLDER -->

            <div class="mb-3">

                <label class="form-label">

                    Card Holder Name

                </label>

                <input
                    type="text"
                    name="cardHolder"
                    id="cardHolder"
                    class="form-control"
                    placeholder="Enter card holder name"
                    autocomplete="cc-name"
                    required>

            </div>



            <!-- CARD NUMBER -->

            <div class="mb-3">

                <label class="form-label">

                    Card Number

                </label>

                <div class="input-group">

                    <span class="input-group-text">

                        <i class="bi bi-credit-card"></i>

                    </span>

                    <input
                        type="text"
                        name="cardNumber"
                        id="cardNumber"
                        class="form-control card-input"
                        placeholder="1234 5678 9012 3456"
                        maxlength="19"
                        inputmode="numeric"
                        autocomplete="cc-number"
                        required>

                </div>

                <small class="text-muted">

                    Enter 16 digit card number.

                </small>

            </div>



            <!-- EXPIRY + CVV -->

            <div class="row">


                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        Expiry Date

                    </label>

                    <input
                        type="text"
                        name="expiry"
                        id="expiry"
                        class="form-control"
                        placeholder="MM/YY"
                        maxlength="5"
                        autocomplete="cc-exp"
                        required>

                </div>


                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        CVV

                    </label>

                    <input
                        type="password"
                        name="cvv"
                        id="cvv"
                        class="form-control"
                        placeholder="•••"
                        maxlength="3"
                        inputmode="numeric"
                        autocomplete="cc-csc"
                        required>

                </div>


            </div>



            <!-- PAY -->

            <button
                type="submit"
                class="pay-button">

                <i class="bi bi-lock-fill"></i>

                Pay Rs.
                <%= String.format(
                        "%,.2f",
                        bill.getAmount()
                ) %>

            </button>


            <div class="secure-text">

                <i class="bi bi-shield-lock-fill"></i>

                Secure payment simulation.
                Your card details are not stored.

            </div>


        </form>


    </div>

</div>



<script>

    // =========================
    // CARD NUMBER FORMAT
    // =========================

    document.getElementById("cardNumber")
        .addEventListener("input", function () {

            let value =
                this.value.replace(/\D/g, "");

            value =
                value.substring(0, 16);

            let formatted =
                value.match(/.{1,4}/g);

            this.value =
                formatted
                    ? formatted.join(" ")
                    : "";

        });



    // =========================
    // EXPIRY FORMAT
    // =========================

    document.getElementById("expiry")
        .addEventListener("input", function () {

            let value =
                this.value.replace(/\D/g, "");

            value =
                value.substring(0, 4);

            if (value.length >= 3) {

                value =
                    value.substring(0, 2)
                    + "/"
                    + value.substring(2);

            }

            this.value = value;

        });



    // =========================
    // CVV ONLY NUMBERS
    // =========================

    document.getElementById("cvv")
        .addEventListener("input", function () {

            this.value =
                this.value
                    .replace(/\D/g, "")
                    .substring(0, 3);

        });



    // =========================
    // VALIDATION
    // =========================

    function validatePayment() {

        let cardNumber =
            document.getElementById(
                "cardNumber"
            ).value.replace(/\s/g, "");


        let expiry =
            document.getElementById(
                "expiry"
            ).value;


        let cvv =
            document.getElementById(
                "cvv"
            ).value;


        if (!/^\d{16}$/.test(cardNumber)) {

            alert(
                "Please enter a valid 16 digit card number."
            );

            return false;
        }


        if (!/^(0[1-9]|1[0-2])\/\d{2}$/
                .test(expiry)) {

            alert(
                "Please enter expiry date as MM/YY."
            );

            return false;
        }


        if (!/^\d{3}$/.test(cvv)) {

            alert(
                "Please enter a valid 3 digit CVV."
            );

            return false;
        }


        return confirm(
            "Confirm payment?"
        );

    }

</script>


</body>

</html>