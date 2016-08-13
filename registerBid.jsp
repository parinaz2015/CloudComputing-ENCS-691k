<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>

<%
    java.util.Date today = new java.util.Date();
    String itemId = request.getParameter("itemId");
    String bidPrice = request.getParameter("bidPrice");
    String uname = request.getParameter("uname");
    //Class.forName("com.mysql.jdbc.GoogleDriver");
    //Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/auctionsystem",
    //        "root", "Admin2015");

    Connection connection = null;
	if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
		// Connecting from App Engine.
		// Load the class that provides the "jdbc:google:mysql://"
		// prefix.
		Class.forName("com.mysql.jdbc.GoogleDriver");
	//	url = "jdbc:google:mysql://auctionsystem-1137:db?user=root";
		connection = DriverManager.getConnection("jdbc:google:mysql://auctionsystem-1137:db/auctionsystem", "root","");
		//"jdbc:google:mysql://<your-project-id>:<your-instance-name>/<your-database-name>?user=root";
	} else {
		// You may also assign an IP Address from the access control
		// page and use it to connect from an external network.
		// Local MySQL instance to use during development.
		Class.forName("com.mysql.jdbc.Driver");
		//url = "jdbc:mysql://127.0.0.1:3306/auctionsystem?user=root,password=Admin2015";
		connection = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/auctionsystem", "root","Admin2015");
	}


    String queryString = "insert into bids(itemid, bid_price, uname, insertDate ) values (?, ?, ?, ?)";
    PreparedStatement pstatement = connection.prepareStatement(queryString);
    pstatement.setString(1, itemId);
    pstatement.setString(2, bidPrice);
    pstatement.setString(3, uname);
    pstatement.setDate(4, new java.sql.Date(today.getTime()));
    int i = pstatement.executeUpdate();
    pstatement.close();
    connection.close();
    if (i > 0) {
        response.sendRedirect("ownersView.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>
