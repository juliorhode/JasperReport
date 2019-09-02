<%@page contentType="application/pdf"%>
<%@page trimDirectiveWhitespaces="true"%>

<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>

<%@page import="javax.servlet.ServletResponse"%>

<%
	Connection con = null;
	String username = "juferrer";
	String password = "j13802982f";
	String hostname = "@cl-oradtbcv01:";
	String port = "1521";
	String database = "/orabdd02";
	String jdbc = "jdbc:oracle:thin:";
	String classname = "oracle.jdbc.driver.OracleDriver";
	String url = jdbc + hostname + port +  database;
	
	try{
		
		Class.forName(classname);
		con = DriverManager.getConnection(url,username,password);
        
      	//Ruta del reporte
        File reporteFile = new File("/applcert/SSCM/domains/SSCMdomain" + File.separator + "resources" + File.separator + "Reporte_Agenda.jasper");
    	//Crearemos un objeto HashMap
    	Map<String, Object> parametros = new HashMap<String,Object>();
    	//parametros.put("cedula",request.getParameter("cedula"));
    	parametros.put("fecha","21/01/2019");
    	//crearemos un arreglo byte
    	byte[] bytes = JasperRunManager.runReportToPdf(reporteFile.getPath(), parametros, con);
    	//indicamos la salida que es en formato pdf
    	response.setContentType("application/pdf");
    	//creamos un objeto de salida
    	ServletOutputStream salida = response.getOutputStream();
    	//escribimos la salida
    	salida.write(bytes);
    	//limpiamos el flujo de salida
    	salida.flush();
    	salida.close();
	}catch (Exception e){
		e.printStackTrace();
	}finally{
		if(con!=null){
			con.close();
		}
	}

%>