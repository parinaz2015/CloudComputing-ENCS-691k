<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>
<%
    String itemId = request.getParameter("id");
    String url = null;
    Connection conn = null;
    // You may also assign an IP Address from the access control
    // page and use it to connect from an external network.
    // Local MySQL instance to use during development.
    //Class.forName("com.mysql.jdbc.Driver");
    //url = "jdbc:mysql://127.0.0.1:3306/auctionsystem?user=root,password=Admin2015";
 if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
  		// Connecting from App Engine.
  		// Load the class that provides the "jdbc:google:mysql://"
  		// prefix.
  		Class.forName("com.mysql.jdbc.GoogleDriver");
  	//	url = "jdbc:google:mysql://auctionsystem-1137:db?user=root";
  		conn = DriverManager.getConnection("jdbc:google:mysql://auctionsystem-1137:db/auctionsystem", "root","");
  		//"jdbc:google:mysql://<your-project-id>:<your-instance-name>/<your-database-name>?user=root";
  	} else {
  		// You may also assign an IP Address from the access control
  		// page and use it to connect from an external network.
  		// Local MySQL instance to use during development.
  		Class.forName("com.mysql.jdbc.Driver");
  		//url = "jdbc:mysql://127.0.0.1:3306/auctionsystem?user=root,password=Admin2015";
  		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/auctionsystem", "root","Admin2015");
  	}
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("select * from users WHERE id = '"
            + itemId + "'");
    while (rs.next()) {
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Registration</title>
</head>
<body>
<form method="post" action="editUser.jsp">
    <center>
        <table border="1" width="30%" cellpadding="5">
            <thead>
            <tr>
                <th colspan="2">Update User's Information'</th>
            </tr>
            </thead>
            <tbody>
            <input type="hidden" name="itemId" value="<%=itemId%>"/>
            </td>
            <tr>
                <td>First Name</td>
                <td><input type="text" name="fname"
                           value="<%=rs.getString(2)%>"/></td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td><input type="text" name="lname"
                           value="<%=rs.getString(3)%>"/></td>
            </tr>
            <tr>
                <td>Birth date</td>
                <td><input type="text" name="tranferedDate"
                           value="<%=rs.getString(4)%>"/></td>
            </tr>
            <tr>
                <td>Gender</td>
                <%
                    String sex = "";
                    if (rs.getString(5).equals("0"))
                        sex = "Male";
                    else if (rs.getString(5).equals("1"))
                        sex = "Female";
                %>
                <td><select name="gender">
                    <option value="<%=sex%>"><%=sex%>
                    </option>
                    <option name=Male value=0>Male</option>
                    <option name=Female value=1>Female</option>
                </select></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><input type="text" name="email"
                           value="<%=rs.getString(6)%>"/></td>
            </tr>
            <tr>
                <td>Phone Number</td>
                <td><input type="text" name="phone_number"
                           value="<%=rs.getString(7)%>"/></td>
            </tr>
            <tr>
                <td>Payment Type</td>
                <td><input type="text" name="payment_type"
                           value="<%=rs.getString(8)%>"/></td>
            </tr>
            <tr>
                <td>Payment Account Number</td>
                <td><input type="text" name="pay_acc_num"
                           value="<%=rs.getString(9)%>"/></td>
            </tr>
            <tr>
                <td>Bank Name</td>
                <td><input type="text" name="bank_name"
                           value="<%=rs.getString(10)%>"/></td>
            </tr>

            <tr>
                <td>User Name</td>
                <td><input type="text" name="uname"
                           value="<%=rs.getString(11)%>"/></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" name="pass"
                           value="<%=rs.getString(12)%>"/></td>
            </tr>
            <tr>
                <td>ZIP Code</td>
                <td><input type="text" name="zipcode"
                           value="<%=rs.getString(13)%>"/></td>
            </tr>
            <tr>
                <td>Country</td>
                <td><input type="text" name="country"
                           value="<%=rs.getString(14)%>"/></td>
            </tr>
            <tr>
                <td>City</td>
                <td><input type="text" name="city"
                           value="<%=rs.getString(15)%>"/></td>
            </tr>
            <tr>
                <td>Street</td>
                <td><input type="text" name="street"
                           value="<%=rs.getString(16)%>"/></td>
            </tr>
            <tr>
                <td><input type="submit" value="Submit"/></td>
                <td><input type="reset" value="Reset"/></td>
            </tr>
            <%
                }
                ;
                rs.close();
                st.close();
                conn.close();
            %>
            </tbody>
        </table>
    </center>
</form>
</body>
</html>

