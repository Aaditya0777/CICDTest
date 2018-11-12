<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoanCalculator.aspx.cs" Inherits="sampleforci.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="calculator.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>

    <script>
        $(document).ready(function () {
            $("#res").hide();

        });
        function getValues() {
            debugger;

            var balance = parseFloat(document.getElementById("principal").value);
            var interestRate = parseFloat(document.getElementById("interest").value / 100.0);

            var slider = document.getElementById("myRange");
            var terms = slider.value;
            //set the div string 
            var div = document.getElementById("Result");

            //in case of a re-calc, clear out the div!
            div.innerHTML = "";

            //validate inputs - display error if invalid, otherwise, display table
            var balVal = validateInputs(balance);
            var intrVal = validateInputs(interestRate);
            var errrfound = false;
            if ((document.getElementById("principal").value == "") || (document.getElementById("principal").value == null)) {
                div.innerHTML += "Please Check your inputs and retry - loan amount field cannot be empty.";
                $("#res").hide();
                errrfound = true;
            }
            else if (balance < 0) {
                div.innerHTML += "Please Check your inputs and retry - loan amount cannot be zero";
                $("#res").hide();
                errrfound = true;
            }
            else if (balance == 0) {
                div.innerHTML += "Please Check your inputs and retry - negative numbers are not allowed.";
                $("#res").hide();
                errrfound = true;
            }
            else if (document.getElementById("interest").value == "") {
                div.innerHTML += "Please Check your inputs and retry - interest rate field cannot be empty.";
                $("#res").hide();
                errrfound = true;
            }
            else if (interestRate < 0) {
                div.innerHTML += "Please Check your inputs and retry - interest rate cannot be negative.";
                $("#res").hide();
                errrfound = true;
            }
            else if (interestRate == 0) {
                div.innerHTML += "Please Check your inputs and retry - interest rate cannot be zero.";
                $("#res").hide();
                errrfound = true;
            }
            else {
                div.innerHTML += amort(balance, interestRate, terms);
            }

            var letters = /^[0.00-9.00]+$/;
            if (errrfound == false) { 
            if (document.getElementById("principal").value.match(letters)) {

            }
            else {

                div.innerHTML = "";
                div.innerHTML += "Please Check your inputs and retry - alphabets and negatives are not allowed.";
                $("#res").hide();
            }
            if (document.getElementById("interest").value.match(letters)) {

            }
            else {

                div.innerHTML = "";
                div.innerHTML += "Please Check your inputs and retry - alphabets and negatives are not allowed.";
                $("#res").hide();
            }
        }
            //if (balVal && intrVal) {
            //    //Returns div string if inputs are valid
            //    div.innerHTML += amort(balance, interestRate, terms);
            //}
            //else {
            //    //returns error if inputs are invalid
            //    div.innerHTML += "Please Check your inputs and retry - invalid values.";
            //}
        }

        function amort(balance, interestRate, terms) {
            //Calculate the per month interest rate
            var monthlyRate = interestRate / 12;

            //Calculate the payment
            var payment = balance * (monthlyRate / (1 - Math.pow(
                1 + monthlyRate, -terms)));

            //begin building the return string for the display of the amort table
            document.getElementById("lamt").innerText = "Loan amount: $" + balance.toFixed(2);
            document.getElementById("rate").innerHTML = "Interest rate: " + (interestRate * 100).toFixed(2) + "%";
            document.getElementById("mon").innerHTML = "Number of months: " + terms;
            document.getElementById("mpay").innerHTML = "Monthly payment: $" + payment.toFixed(2);
            document.getElementById("tpay").innerHTML = "Total Repayment: $" + (payment * terms).toFixed(2);

            //var result = "Loan amount: $" + balance.toFixed(2) + "<br />" +
            //    "Interest rate: " + (interestRate * 100).toFixed(2) + "%<br />" +
            //    "Number of months: " + terms + "<br />" +
            //    "Monthly payment: $" + payment.toFixed(2) + "<br />" +
            //    "Total paid: $" + (payment * terms).toFixed(2) + "<br /><br />";

            //add header row for table to return string
           var result = "<table border='1'><tr><th>Month #</th><th>Balance</th>" +
                "<th>Interest</th><th>Principal</th>";

            /**
             * Loop that calculates the monthly Loan amortization amounts then adds 
             * them to the return string 
             */
            for (var count = 0; count < terms; ++count) {
                //in-loop interest amount holder
                var interest = 0;

                //in-loop monthly principal amount holder
                var monthlyPrincipal = 0;

                //start a new table row on each loop iteration
                result += "<tr align=center>";

                //display the month number in col 1 using the loop count variable
                result += "<td>" + (count + 1) + "</td>";


                //code for displaying in loop balance
                result += "<td> $" + balance.toFixed(2) + "</td>";

                //calc the in-loop interest amount and display
                interest = balance * monthlyRate;
                result += "<td> $" + interest.toFixed(2) + "</td>";

                //calc the in-loop monthly principal and display
                monthlyPrincipal = payment - interest;
                result += "<td> $" + monthlyPrincipal.toFixed(2) + "</td>";

                //end the table row on each iteration of the loop	
                result += "</tr>";

                //update the balance for each loop iteration
                balance = balance - monthlyPrincipal;
            }

            //Final piece added to return string before returning it - closes the table
            result += "</table>";
            $("#res").show();
            //returns the concatenated string to the page
            return result;
        }

        function validateInputs(value) {
            //some code here to validate inputs
            if ((value == null) || (value == "")) {
                return false;
            }
            else {
                return true;
            }
        }
    </script>
</head>
<body>
    <br />
    <br />
    <br />
   <br />
    <br />
   <h1 style="text-align: center; color:#cc0066; font-family:sans-serif"><U>CHECK YOUR LOAN SCHEDULE:</U></h1> 
   
   <%-- <hr />--%>
    <div class="container">
        <form>
            <fieldset>
                <legend>Loan Details</legend>
                <label for="principal"><b>Requested Loan Amount:</b></label>
                <input type="text" id="principal" required="required" />
                
                <label for="interest"><b>Annual Percentage Rate:</b></label>
                <input type="text" id="interest"  required="required"/>
               
                <label for="terms"><b>Number of Months:</b></label>
               <%--<input type="range" min="1" max="24" value="50" class="slider" id="myRange" />--%>
              <div class="range-slider">
                    <input class="range-slider__range" type="range" value="100" min="1" max="36"  id="myRange"  />
                    <span class="range-slider__value" id="demo">0</span>
                </div>
                <%--<p>Month Selected: <span id="demo"></span></p>--%>
               
                <input type="button" value="Calculate" onclick="getValues()" />
                
            </fieldset>
        </form>
        <br />
        <form>
            <fieldset>
                <legend>Your Calculated Schedule</legend> 
                <br />
                <div id="res">
                    <label style="background-color: #cc0066; color: white; padding: 10px 20px; margin: 8px 0; font-size: 16px; border: none; border-radius: 0px; cursor: pointer" id="lamt"></label>
                    <label style="background-color: #cc0066; color: white; padding: 10px 20px; margin: 8px 0; font-size: 16px; border: none; border-radius: 0px; cursor: pointer" id="rate"></label>
                    <label style="background-color: #cc0066; color: white; padding: 10px 20px; margin: 8px 0; font-size: 16px; border: none; border-radius: 0px; cursor: pointer" id="mon"></label>
                    <label style="background-color: #cc0066; color: white; padding: 10px 20px; margin: 8px 0; font-size: 16px; border: none; border-radius: 0px; cursor: pointer" id="mpay"></label>
                    <label style="background-color: #cc0066; color: white; padding: 10px 20px; margin: 8px 0; font-size: 16px; border: none; border-radius: 0px; cursor: pointer" id="tpay"></label>
             </div>
                    <div><br /></div>
                <div id="Result">
             
                </div>
            </fieldset>
        </form>
    </div>
    <script>
        var slider = document.getElementById("myRange");
        var output = document.getElementById("demo");
        output.innerHTML = slider.value;

        slider.oninput = function () {
            output.innerHTML = this.value;
        }
    </script>
</body>

</html>
