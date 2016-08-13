<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Registration</title>
</head>
<body>
	<form method="post" action="insertItem.jsp">
		<center>
			<table border="1" width="30%" cellpadding="5">
				<thead>
					<tr>
						<th colspan="2">Enter Information Here To Add New Item</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Category Name</td>
						<td><input type="text" name="categoryName" value="" /></td>
					</tr>
					<tr>
						<td>Current Price</td>
						<td><input type="text" name="suggestedPrice" value="" /></td>
					</tr>
					<tr>
						<td>Description</td>
						<td><input type="text" name="desc" value="" /></td>
					</tr>
					<tr>
						<td><input type="submit" value="Submit" /></td>
						<td><input type="reset" value="Reset" /></td>
					</tr>
				</tbody>
			</table>
		</center>
	</form>
</body>
</html>
