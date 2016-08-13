<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty"%>


<%
    String uname = String.valueOf(session.getAttribute("userid"));
    String uid = String.valueOf(session.getAttribute("uid"));

    String url = null;
    Connection conn;
    Connection connection;

    if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) {
		// Connecting from App Engine.
		// Load the class that provides the "jdbc:google:mysql://"
		// prefix.
		Class.forName("com.mysql.jdbc.GoogleDriver");
		//	url = "jdbc:google:mysql://auctionsystem-1137:db?user=root";
		conn = DriverManager
				.getConnection(
						"jdbc:google:mysql://auctionsystem-1137:db/auctionsystem",
						"root", "");
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
		conn = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/auctionsystem", "root",
				"Admin2015");
		connection = DriverManager.getConnection(
				"jdbc:mysql://127.0.0.1:3306/auctionsystem", "root",
				"Admin2015");
	}

    // Class.forName("com.mysql.jdbc.GoogleDriver");
    // Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/auctionsystem",
    //         "root", "Admin2015");
    // Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/auctionsystem",
    //         "root", "Admin2015");
    Statement st = conn.createStatement();
    Statement statement = connection.createStatement();
    ResultSet rs; //result of Query
    ResultSet resultSet; //result of Query
    rs = st.executeQuery("select * from representeditems where id='"
            + uid + "' and status = 1");
    resultSet = statement
            .executeQuery("select bids.uname, max(bids.bid_price) from bids\n"
                    + " inner join representeditems\n"
                    + " on bids.itemid = representeditems.id\n"
                    + " where representeditems.status = 1\n"
                    + " group by bids.itemid");
    //resultset true if the new current row is valid; false if there are no more rows
    if (rs.next()
            || (resultSet.next() && resultSet.getString(1) == uname)) {
        out.println("You have item(s) on auction or you have offered the maximum price on an item,so you are not allowed to exit!");
%>
<a href='ownersView.jsp'>User Control Panel</a>
<%
        rs.close();
        st.close();
        conn.close();
        resultSet.close();
        statement.close();
        connection.close();
    } else {
        session.setAttribute("userid", null);
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
%>
