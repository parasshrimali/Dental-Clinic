

<%@ page
	import="java.sql.*, java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*"%>
<%
String jdbcURL = "jdbc:mysql://localhost:3306/dental";
String dbUser = "root";
String dbPassword = "sarap@321";

String userEmail = (String) session.getAttribute("email");
if (userEmail == null) {
	response.sendRedirect("user_login.jsp");
	return;
}

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

	// Query to get user details
	String userQuery = "SELECT * FROM users WHERE email=?";
	pstmt = conn.prepareStatement(userQuery);
	pstmt.setString(1, userEmail);
	rs = pstmt.executeQuery();

	String userName = "";
	String userPhone = "";
	if (rs.next()) {
		userName = rs.getString("name");
		userPhone = rs.getString("phone");
	}

	// Query to get medical history
	String query = "SELECT * FROM medical_history WHERE patient_email=?";
	pstmt = conn.prepareStatement(query);
	pstmt.setString(1, userEmail);
	rs = pstmt.executeQuery();

	// Set the response type as PDF
	response.setContentType("application/pdf");
	response.setHeader("Content-Disposition", "attachment; filename=Medical_History.pdf");

	// Create PDF Document
	Document document = new Document(PageSize.A4);
	PdfWriter.getInstance(document, response.getOutputStream());
	document.open();

	// Add Clinic Logo
	String clinicLogo = application.getRealPath("/") + "images/clinic_logo.png"; // Change path as needed
	try {
		Image logo = Image.getInstance(clinicLogo);
		logo.scaleToFit(100, 100);
		logo.setAlignment(Element.ALIGN_CENTER);
		document.add(logo);
	} catch (Exception e) {
		out.println("Error loading logo: " + e.getMessage());
	}

	// Header
	Paragraph header = new Paragraph("Easydent Dental Clinic",
	FontFactory.getFont(FontFactory.HELVETICA_BOLD, 20, BaseColor.BLUE));
	header.setAlignment(Element.ALIGN_CENTER);
	document.add(header);

	document.add(new Paragraph(" "));
	document.add(new Paragraph("Patient Medical History Report", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16)));
	document.add(
	new Paragraph("Generated on: " + new java.util.Date(), FontFactory.getFont(FontFactory.HELVETICA, 10)));
	document.add(new Paragraph(" "));

	// User Info
	document.add(new Paragraph("Patient Name: " + userName, FontFactory.getFont(FontFactory.HELVETICA, 12)));
	document.add(new Paragraph("Email: " + userEmail, FontFactory.getFont(FontFactory.HELVETICA, 12)));
	document.add(new Paragraph("Phone: " + userPhone, FontFactory.getFont(FontFactory.HELVETICA, 12)));
	document.add(new Paragraph(" "));

	// Table for Medical History
	PdfPTable table = new PdfPTable(5); // 5 columns
	table.setWidthPercentage(100);
	table.setSpacingBefore(10f);
	table.setSpacingAfter(10f);

	// Column Headers
	PdfPCell cell;
	String[] headers = { "Date", "Treatment", "Price", "Notes", "Doctor" };
	for (String headerText : headers) {
		cell = new PdfPCell(
		new Phrase(headerText, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE)));
		cell.setBackgroundColor(BaseColor.DARK_GRAY);
		cell.setPadding(5);
		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		table.addCell(cell);
	}

	// Data Rows
	while (rs.next()) {
		table.addCell(new Phrase(rs.getString("created_at")));
		table.addCell(new Phrase(rs.getString("treatment")));
		table.addCell(new Phrase(rs.getString("price")));
		table.addCell(new Phrase(rs.getString("notes")));
		table.addCell(new Phrase("Dr. Smith")); // You can modify to fetch from DB
	}

	document.add(table);

	// Footer
	document.add(new Paragraph(" "));
	document.add(new Paragraph("Thank you for visiting Easydent Dental Clinic!",
	FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
	document.add(new Paragraph("Contact: +1 234 567 890 | Address: Shivaranjani , Ahmedabad , India",
	FontFactory.getFont(FontFactory.HELVETICA, 10)));

	document.close();
} catch (Exception e) {
	out.println("Error: " + e.getMessage());
} finally {
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
}
%>
