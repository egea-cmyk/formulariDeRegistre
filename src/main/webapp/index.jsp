<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays, java.time.LocalDate, java.time.Period" %>
<!DOCTYPE html>
<% 
String nom="";
String errorNom="";
String cognom="";
String errorCognom="";
String email="";
String errorEmail="";
String contra1="";
String contra2="";
String errorContra1="";
String errorContra2="";
String errorDataNaixement="";

String sexe="home"; 
String dataNaixement="";
String tipus="pelicules"; 
String[] generesTriats = new String[0]; 

if (request.getParameter("Guardar") != null) 
{
	nom = request.getParameter("nom");
	cognom = request.getParameter("cognom");
	email = request.getParameter("email");
	contra1 = request.getParameter("Contrasenya");
	contra2 = request.getParameter("RepetiContrasenya");
	sexe = request.getParameter("sexe");
	dataNaixement = request.getParameter("DataNaixement"); 
	tipus = request.getParameter("Tipus");
	
	if (nom == null || nom.trim().length() == 0) errorNom = "No pot estar buit";
	if (cognom == null || cognom.trim().length() == 0) errorCognom = "No pot estar buit";
	
	if (email == null || email.trim().length() == 0) {
		errorEmail = "No pot estar buit";
	} else if (!email.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$")) {
		errorEmail = "El format del correu electrònic no és vàlid";
	}
	
	if (dataNaixement != null && dataNaixement.trim().length() > 0) {
		try {
			LocalDate dataNaix = LocalDate.parse(dataNaixement);
			LocalDate dataActual = LocalDate.now();
			
			if (dataNaix.isAfter(dataActual)) {
				errorDataNaixement = "La data de naixement no pot ser una data futura";
			} else {
				int anys = Period.between(dataNaix, dataActual).getYears();
				if (anys < 5) {
					errorDataNaixement = "Ha de ser com a mínim 5 anys anterior a l'actual";
				}
			}
		} catch (Exception e) {
			errorDataNaixement = "La data introduïda no és una data vàlida";
		}
	}
	
	if (contra1 == null || contra1.length() == 0) {
		errorContra1 = "No pot estar buit";
	} else if (contra1.length() < 8) {
		errorContra1 = "La contrasenya ha de tenir com a mínim 8 caràcters";
	}
	
	if (contra2 != null && !contra2.equals(contra1)) {
		errorContra2 = "No són iguals";
		contra2 = ""; 
	}
	
	String[] temporalGeneres = request.getParameterValues("Generes");
	if (temporalGeneres != null) {
		generesTriats = temporalGeneres;
	} else {
		generesTriats = new String[0];
	}
	
	if (nom == null) nom = "";
	if (cognom == null) cognom = "";
	if (email == null) email = "";
	if (contra1 == null) contra1 = "";
	if (contra2 == null) contra2 = "";
	if (dataNaixement == null) dataNaixement = "";
	if (tipus == null) tipus = "pelicules";
	
    if (errorNom.length() == 0 && errorCognom.length() == 0 && errorEmail.length() == 0 && 
        errorContra1.length() == 0 && errorContra2.length() == 0 && errorDataNaixement.length() == 0)
    {
        pageContext.forward("benvingut.jsp");
        return;
    }
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Formulari de Registre</title>
</head>
<body>

<form method="post" action="#">
		
	<div>
		<p>
			<label for="nom">Nom:</label> 
			<input type="text" id="nom" name="nom" value="<%= nom %>"><span style="color:#ff0000"><%= errorNom %></span>
		</p>
	</div>
	
	<div>
		<p>
			<label for="cognom">Cognom:</label> 	
			<input type="text" id="cognom" name="cognom" value="<%= cognom %>"><span style="color:#ff0000"><%= errorCognom %></span>
		</p>
	</div>
	
	<div>
		<p>
			<label for="email">Email:</label> 	
			<input type="text" id="email" name="email" value="<%= email %>"><span style="color:#ff0000"><%= errorEmail %></span>
		</p>
	</div>
		
	<div>
		<p>
      		<label for="Contrasenya">Contrasenya:</label> 
        	<input type="password" id="Contrasenya" name="Contrasenya" minlength="8" value="<%= contra1 %>"> <span style="color:#ff0000"><%= errorContra1 %></span> 
        </p>
	</div>
	
	<div>
		<p>
			<label for="contra1">Repeteix la Contrasenya:</label>
			<input type="password" id="contra1" name="RepetiContrasenya" minlength="8" value="<%= contra2 %>"><span style="color:#ff0000"><%= errorContra2 %></span>
		</p>
	</div>
	
	<div>
		<p>
			<label for="sexe">Sexe:</label>
			<select id="sexe" name="sexe">
				<option value="home" <%= "home".equals(sexe) ? "selected" : "" %>>Home</option>
				<option value="dona" <%= "dona".equals(sexe) ? "selected" : "" %>>Dona</option>
				<option value="noDeclarat" <%= "noDeclarat".equals(sexe) ? "selected" : "" %>>No declarat</option>
			</select>
		</p>
	</div>
     
	<div>
		<p> 
			<label for="dataN">Data naixement:</label> 
			<input type="date" id="dataN" name="DataNaixement" value="<%= dataNaixement %>"><span style="color:#ff0000"><%= errorDataNaixement %></span>
		</p>
	</div>
	
	<div>
		<p>		
			Tipus: 
			<input type="radio" name="Tipus" value="pelicules" <%= "pelicules".equals(tipus) ? "checked" : "" %>> Pel·lícules 
			<input type="radio" name="Tipus" value="series" <%= "series".equals(tipus) ? "checked" : "" %>> Sèries
		</p>
	</div>

	<div>
		<p>
			Gèneres: 
			<input type="checkbox" name="Generes" value="accion" <%= Arrays.asList(generesTriats).contains("accion") ? "checked" : "" %>/> Acció
			<input type="checkbox" name="Generes" value="cienciaFiccio" <%= Arrays.asList(generesTriats).contains("cienciaFiccio") ? "checked" : "" %>/> Ciència i ficció
			<input type="checkbox" name="Generes" value="històrica" <%= Arrays.asList(generesTriats).contains("històrica") ? "checked" : "" %>/> Històrica
			<input type="checkbox" name="Generes" value="drama" <%= Arrays.asList(generesTriats).contains("drama") ? "checked" : "" %>/> Drama
			<input type="checkbox" name="Generes" value="comedia" <%= Arrays.asList(generesTriats).contains("comedia") ? "checked" : "" %>/> Comèdia
		</p>
	</div>
	
	<p>	<input type="submit" name="Guardar" value="Guardar"> </p>
	
</form>

</body>
</html>
