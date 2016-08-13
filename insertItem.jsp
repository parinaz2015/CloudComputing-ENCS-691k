<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>

<%
    java.util.Date today = new java.util.Date();
    String uid = String.valueOf(session.getAttribute("uid"));
    String category = request.getParameter("categoryName");
    String price = request.getParameter("suggestedPrice");
    String description = request.getParameter("desc");

    String url = null;
    Connection conn = null;
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
    PreparedStatement pstatement = null;
    String queryString = "insert into representeditems( id, category_name, base_price, description, status, insertDate) VALUES (?, ?, ?, ?, ?, ?)";
    pstatement = conn.prepareStatement(queryString);
    pstatement.setString(1, uid);
    pstatement.setString(2, category);
    pstatement.setString(3, price);
    pstatement.setString(4, description);
    pstatement.setInt(5, 0);
    pstatement.setDate(6, new java.sql.Date(today.getTime()));
    int i = pstatement.executeUpdate();
    pstatement.close();
    conn.close();
    if (i > 0) {
        response.sendRedirect("ownersView.jsp");
    } else {
        response.sendRedirect("addItem.jsp");
    }
%>
