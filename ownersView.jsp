<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>
<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Control Panel</title>
    <script type="text/JavaScript">
        function timedRefresh(timeoutPeriod) {
            setTimeout("location.reload(true);", timeoutPeriod);
        }

        window.onload = timedRefresh(20000);
        //This page will refresh every 20 seconds(ms). This is because we're using the 'onload' event to call our function.
    </script>


</head>
<%
    String username = String.valueOf(session.getAttribute("username"));
    String userid = String.valueOf(session.getAttribute("uid"));
    boolean repeatable = Boolean.parseBoolean(String.valueOf(session
            .getAttribute("repeatable")));
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

    ResultSet rs;
%>

<center>this page gets refreshed every 20 seconds</center>

<form method="post" action="edit.jsp">
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>
                <td>User Name</td>
                <td>Email</td>
                <td>Action</td>
            </tr>
            </thead>
            <%
                Statement st = con.createStatement();

                rs = st.executeQuery("select * from users where uname='" + username
                        + "'");
                while (rs.next()) {
            %>
            <tr>
                <td><input type="text" name="uname"
                           value="<%=rs.getString(11)%>"/></td>
                <td><input type="text" name="email"
                           value="<%=rs.getString(6)%>"/></td>
                <td><a href="edit.jsp?id=<%=rs.getString(1)%>">Edit</a></td>
            </tr>
            <tr>
                <td colspan="8"><B>Do you want to Exit? <a
                        href='logout.jsp'>Log out</a></B></td>
            </tr>

            <%
                }
                ;
            %>

            </tbody>
        </table>
    </center>
</form>


<!--******************************** My Items  **************************************  -->
<Br>
<center>
    <B>My Items</B>
</center>
<form method="post" action="preeditStatus.jsp">
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>
                <td COLSPAN=8>Add New Items <a href="addItem.jsp">Here</a></td>
            </tr>
            <tr>

                <td><B>Item ID</B></td>
                <td><B>User ID</B></td>
                <td><B>Item Category</B></td>
                <td><B>Base Price</B></td>
                <td><B>Description</B></td>
                <td><B>Status</B></td>
                <td><B>Auction</B></td>


            </tr>
            </thead>
            <tbody>
            <%
                rs = st.executeQuery("select * from representeditems where id='"
                        + userid + "' And status='0'");
                while (rs.next()) {
            %>
            <tr>
                <td><input type="text" name="itemid"
                           value="<%=rs.getString(1)%>"/></td>
                <td><input type="text" name="uid" value="<%=rs.getString(2)%>"/></td>
                <td><input type="text" name="categoryName"
                           value="<%=rs.getString(3)%>"/></td>
                <td><input type="text" name="currentPrice" id="currentPrice"
                           value="<%=rs.getString(4)%>"/></td>
                <td><input type="text" name="description"
                           value="<%=rs.getString(5)%>"/></td>
                <td><input type="text" name="status"
                           value="<%=rs.getString(6)%>"/></td>
                <td><a href="editStatus.jsp?itemId=<%=rs.getString(1)%>">AUCTION</a></td>

            </tr>
            <%
                }
                ;
            %>
            </tbody>
        </table>

    </center>
</form>
<!--******************************** End of My Items  **************************************  -->

<!--******************************** Items on Auction **************************************  -->

<Br>
<center>
    <B>Items on Auction</B>
</center>
<form method="post" action="preeditStatus.jsp">
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>

                <td><B>Item ID</B></td>
                <td><B>User ID</B></td>
                <td><B>Item Category</B></td>
                <td><B>Base Price</B></td>
                <td><B>Description</B></td>
                <td><B>Status</B></td>
                <td><B>Bid</B></td>

            </tr>
            </thead>
            <tbody>
            <%
                rs = st.executeQuery("select * from representeditems where status='1'");
                while (rs.next()) {
            %>
            <tr>
                <td><input type="text" name="itemid"
                           value="<%=rs.getString(1)%>"/></td>
                <td><input type="text" name="uid" value="<%=rs.getString(2)%>"/></td>
                <td><input type="text" name="categoryName"
                           value="<%=rs.getString(3)%>"/></td>
                <td><input type="text" name="currentPrice" id="currentPrice"
                           value="<%=rs.getString(4)%>"/></td>
                <td><input type="text" name="description"
                           value="<%=rs.getString(5)%>"/></td>
                <td><input type="text" name="status"
                           value="<%=rs.getString(6)%>"/></td>
                <td><a
                        href="bidValidation.jsp?itemid=<%=rs.getString(1)%>&uid=<%=rs.getString(2)%>">BID</a></td>
            </tr>
            <%
                }
                ;
            %>
            </tbody>
        </table>

    </center>
</form>
<!--*******************************************End of Items on Auction*******************************************  -->

<!--*******************************************Bids*******************************************  -->
<Br>
<center>
    <B>All Bids</B>
</center>
<form method="post" action="">
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>
                <td><B>Bid ID</B></td>
                <td><B>Item ID</B></td>
                <td><B>Bid price</B></td>
                <td><B>User Name</B></td>
                <td><B>Date</B></td>

            </tr>
            </thead>
            <tbody>
            <%
                rs = st.executeQuery("SELECT bids.bidid,bids.itemid,bids.bid_price,bids.uname,bids.insertDate "
                        + "FROM bids "
                        + "INNER JOIN representeditems "
                        + "ON bids.itemid=representeditems.itemid "
                        + "where representeditems.status = 1;");

                while (rs.next()) {
                    ResultSet resultSet;
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
								"jdbc:mysql://127.0.0.1:3306/auctionsystem",
								"root", "Admin2015");
					}
                    Statement statement = connection.createStatement();
                    resultSet = statement
                            .executeQuery("SELECT max(bids.bid_price) "
                                    + "FROM bids " + "INNER JOIN representeditems "
                                    + "ON bids.itemid=representeditems.itemid "
                                    + "where representeditems.status = 1 "
                                    + "and representeditems.itemid = '"
                                    + rs.getString(2) + "'");
                    resultSet.next();
                    if (Integer.parseInt(rs.getString(3)) == Integer
                            .parseInt(resultSet.getString(1))) {
            %>
            <tr bgcolor="pink">
                <td><input type="text" name="bidid"
                           value="<%=rs.getString(1)%>"/></td>
                <td><input type="text" name="itemid"
                           value="<%=rs.getString(2)%>"/></td>
                <td><input type="text" name="bid_price"
                           value="<%=rs.getString(3)%>"/></td>
                <td><input type="text" name="uname" id="currentPrice"
                           value="<%=rs.getString(4)%>"/></td>
                <td><input type="text" name="insertDate"
                           value="<%=rs.getString(5)%>"/></td>
            </tr>
            <%
                resultSet.close();
                statement.close();
                connection.close();
            } else {
            %>
            <tr>
                <td><input type="text" name="bidid"
                           value="<%=rs.getString(1)%>"/></td>
                <td><input type="text" name="itemid"
                           value="<%=rs.getString(2)%>"/></td>
                <td><input type="text" name="bid_price"
                           value="<%=rs.getString(3)%>"/></td>
                <td><input type="text" name="uname" id="currentPrice"
                           value="<%=rs.getString(4)%>"/></td>
                <td><input type="text" name="insertDate"
                           value="<%=rs.getString(5)%>"/></td>
            </tr>
            <%
                    }
                }
                ;
            %>
            </tbody>
        </table>
    </center>
</form>

<!--*******************************************End of Bid*******************************************  -->

<!--******************************** Sold Items **************************************  -->

<Br>
<center>
    <B>Sold Items</B>
</center>
<form method="post" action="preeditStatus.jsp">
    <center>
        <table border="1" width="30%" cellpadding="3">
            <thead>
            <tr>

                <td><B>Item ID</B></td>
                <td><B>Category</B></td>
                <td><B>Sold Price</B></td>
                <td><B>buyer Name</B></td>
                <td><B>Date</B></td>


            </tr>
            </thead>
            <tbody>
            <%
                rs = st.executeQuery("SELECT bids.itemid,representeditems.category_name,max(bids.bid_price),bids.uname,bids.insertDate "
                        + "FROM bids "
                        + "INNER JOIN representeditems "
                        + "ON bids.itemid=representeditems.itemid "
                        + "where representeditems.status = 2 "
                        + "group by bids.itemid;");

                while (rs.next()) {
                    ResultSet soldItemResultSet;
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
								"jdbc:mysql://127.0.0.1:3306/auctionsystem",
								"root", "Admin2015");
					}
                    Statement soldItelStatement = connection.createStatement();
                    soldItemResultSet = soldItelStatement
                            .executeQuery("select DISTINCT itemid, uname, max(bid_price) from bids WHERE itemid = '"
                                    + rs.getString(1) + "'");

                    while (soldItemResultSet.next()) {
            %>
            <tr>
                <td><input type="text" name="itemid"
                           value="<%=rs.getString(1)%>"/></td>
                <td><input type="text" name="category_name"
                           value="<%=rs.getString(2)%>"/></td>
                <td><input type="text" name="bid_price"
                           value="<%=rs.getString(3)%>"/></td>
                <td><input type="text" name="uname"
                           value="<%=rs.getString(4)%>"/></td>
                <td><input type="text" name="insertDate"
                           value="<%=rs.getString(5)%>"/></td>

            </tr>
            <%
                    }
                    soldItemResultSet.close();
                    soldItelStatement.close();
                    connection.close();
                }
                ;
                rs.close();
                st.close();
                con.close();
                ;
            %>
            </tbody>
        </table>

    </center>
</form>

<!--*******************************************End of Sold Items*******************************************  -->
</html>



