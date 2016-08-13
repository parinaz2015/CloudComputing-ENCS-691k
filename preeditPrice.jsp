<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%
    String amount = request.getParameter("currentPrice");
    String itemId = request.getParameter("id");
%>

<script type="text/javascript">
    function compare(lastPrice, curPrice) {
        if (lastPrice >= curPrice) {
            alert("You have to suggest a greater price!!");
        } else
            document.getElementById("editPrice").submit();
    }
</script>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Example</title>
</head>
<body>
<form method="post" id="editPrice" action="editPrice.jsp">
    <input type="hidden" name="itemId" value="<%=itemId%>"/></td>
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>
                <th colspan="2">Suggest A New Price</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Last Suggestion</td>
                <td><input type="text" name="lastPrice" id="lastPrice" value="<%=amount%>"/></td>
            </tr>
            <tr>
                <td>Your New Suggestion</td>
                <td><input type="text" name="suggestedPrice" id="suggestedPrice" value=""/></td>
            </tr>
            <tr>
                <td><input type="button" value="Edit Price"
                           onclick="compare(document.getElementById('lastPrice').value, document.getElementById('suggestedPrice').value);"/>
                </td>
                <td><input type="reset" value="Reset"/></td>
            </tr>
            </tbody>
        </table>
    </center>
</form>
</body>
</html>
