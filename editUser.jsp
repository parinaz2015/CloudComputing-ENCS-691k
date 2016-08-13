<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.Object" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>

<%
    java.util.Date today = new java.util.Date();
    String itemId = request.getParameter("itemId");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String birthdate = request.getParameter("tranferedDate");
    String gender = request.getParameter("gender");
    int sex = 1;
    if (gender.equals("0"))
        sex = 0;
    String email = request.getParameter("email");
    String phone_number = request.getParameter("phone_number");
    String payment_type = request.getParameter("payment_type");
    String pay_acc_num = request.getParameter("pay_acc_num");
    String bank_name = request.getParameter("bank_name");
    String user = request.getParameter("uname");
    String pwd = request.getParameter("pass");
    String zipcode = request.getParameter("zipcode");
    String country = request.getParameter("country");
    String city = request.getParameter("city");
    String street = request.getParameter("street");
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
    String queryString = "UPDATE users set first_name =?, last_name =?, birthdate=?, gender=?, email=?, phone_num=?, payment_type=?, payment_account_num=?, bank_name=?, uname=?, pass=?, zip_code=?, country=?, city=?, street_name=?, regdate=? where id = ?";
    PreparedStatement pstatement = conn.prepareStatement(queryString);
    pstatement.setString(1, fname);
    pstatement.setString(2, lname);
    pstatement.setString(3, birthdate);
    pstatement.setInt(4, sex);
    pstatement.setString(5, email);
    pstatement.setString(6, phone_number);
    pstatement.setString(7, payment_type);
    pstatement.setString(8, pay_acc_num);
    pstatement.setString(9, bank_name);
    pstatement.setString(10, user);
    pstatement.setString(11, pwd);
    pstatement.setString(12, zipcode);
    pstatement.setString(13, country);
    pstatement.setString(14, city);
    pstatement.setString(15, street);
    pstatement.setDate(16, new java.sql.Date(today.getTime()));
    pstatement.setString(17, itemId);
    int i = pstatement.executeUpdate();
    pstatement.close();
    conn.close();
    if (i > 0) {
        response.sendRedirect("ownersView.jsp");
    } else {
        response.sendRedirect("index.jsp");
    }
%>
