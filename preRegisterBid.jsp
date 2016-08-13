<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.JavaReminder" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>
<%
    String userId = request.getParameter("uid");
    String itemId = request.getParameter("itemid");
    JavaReminder javaReminder = new JavaReminder();
    //Maximum bid price offered
    Connection connection = null;

    if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
		// Connecting from App Engine.
		// Load the class that provides the "jdbc:google:mysql://"
		// prefix.
		Class.forName("com.mysql.jdbc.GoogleDriver");
		//	url = "jdbc:google:mysql://auctionsystem-1137:db?user=root";
		connection = DriverManager
				.getConnection(
						"jdbc:google:mysql://auctionsystem-1137:db/auctionsystem",
						"root", "");
		//"jdbc:google:mysql://<your-project-id>:<your-instance-name>/<your-database-name>?user=root";
	} else {
		// You may also assign an IP Address from the access control
		// page and use it to connect from an external network.
		// Local MySQL instance to use during development.
		Class.forName("com.mysql.jdbc.Driver");
		//url = "jdbc:mysql://127.0.0.1:3306/auctionsystem?user=root,password=Admin2015";
		connection = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/auctionsystem", "root",
				"Admin2015");
	}
    Statement statement = connection.createStatement();
    ResultSet resultSet = statement
            .executeQuery("select max(bid_price) from bids WHERE itemid = '"
                    + itemId + "'");
    resultSet.next();
    int maximumLastPrice = resultSet.getInt(1);
    resultSet.close();
    statement.close();
    connection.close();


    //basePrice
    Connection con1 = null;

    // You may also assign an IP Address from the access control
    // page and use it to connect from an external network.
    // Local MySQL instance to use during development.
    int basePrice = 0;

	if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
		// Connecting from App Engine.
		// Load the class that provides the "jdbc:google:mysql://"
		// prefix.
		Class.forName("com.mysql.jdbc.GoogleDriver");
		//	url = "jdbc:google:mysql://auctionsystem-1137:db?user=root";
		con1 = DriverManager
				.getConnection(
						"jdbc:google:mysql://auctionsystem-1137:db/auctionsystem",
						"root", "");
		//"jdbc:google:mysql://<your-project-id>:<your-instance-name>/<your-database-name>?user=root";
	} else {
		// You may also assign an IP Address from the access control
		// page and use it to connect from an external network.
		// Local MySQL instance to use during development.
		Class.forName("com.mysql.jdbc.Driver");
		//url = "jdbc:mysql://127.0.0.1:3306/auctionsystem?user=root,password=Admin2015";
		con1 = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/auctionsystem", "root",
				"Admin2015");
	}
    Statement st1 = con1.createStatement();
    ResultSet rs1 = st1
            .executeQuery("select base_price from representeditems WHERE itemid = " + itemId);
    if (rs1.next())
        basePrice = rs1.getInt(1);

    //
    Connection con = null;
    if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
		// Connecting from App Engine.
		// Load the class that provides the "jdbc:google:mysql://"
		// prefix.
		Class.forName("com.mysql.jdbc.GoogleDriver");
		//	url = "jdbc:google:mysql://auctionsystem-1137:db?user=root";
		con = DriverManager
				.getConnection(
						"jdbc:google:mysql://auctionsystem-1137:db/auctionsystem",
						"root", "");
		//"jdbc:google:mysql://<your-project-id>:<your-instance-name>/<your-database-name>?user=root";
	} else {
		// You may also assign an IP Address from the access control
		// page and use it to connect from an external network.
		// Local MySQL instance to use during development.
		Class.forName("com.mysql.jdbc.Driver");
		//url = "jdbc:mysql://127.0.0.1:3306/auctionsystem?user=root,password=Admin2015";
		con = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/auctionsystem", "root",
				"Admin2015");
	}
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("select * from users WHERE id = " + userId + "");
    while (rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Preregister bids</title>
</head>
<body>

<script type="text/javascript">
    function compare(lastPrice, curPrice) {
        if (lastPrice >= curPrice) {
            alert("You have to suggest a greater price!!");
        } else
            document.getElementById("registerBid").submit();
    }
</script>

<form method="post" id="registerBid" action="registerBid.jsp">
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>
                <th colspan="2">Do You Want to BID?</th>
            </tr>
            </thead>
            <tbody>
            <td><input type="hidden" name="uid" value="<%=userId%>"/></td>
            <tr>
                <td>Item Id</td>
                <td><input type="text" name="itemId" value="<%=itemId%>"/></td>
            </tr>
            <tr>
                <%
                    if (maximumLastPrice == 0)
                        maximumLastPrice = basePrice;
                %>
                <td>BID Price</td>
                <td><input type="text" name="bidPrice" id="bidPrice"
                           value="<%=maximumLastPrice%>"/></td>
            </tr>
            <tr>
                <td>User Name</td>
                <td><input type="text" name="uname"
                           value="<%=rs.getString(11)%>"/></td>
            </tr>
            <tr>
            <tr>
                <td><input type="button" value="Edit Price"
                           onclick="compare(<%=maximumLastPrice%>, document.getElementById('bidPrice').value);"/>
                </td>
                <td><input type="reset" value="Reset"/></td>
            </tr>
            <%
                }
                ;
            %>
            </tbody>
        </table>
    </center>
</form>
</body>
</html>
