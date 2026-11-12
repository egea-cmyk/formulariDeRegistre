<%@ page language="java" contentType="application/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%
String nom = request.getParameter("nom");
String cognom = request.getParameter("cognom");
String email = request.getParameter("email");
String contrasenya1 = request.getParameter("Contrasenya"); 
String sexe = request.getParameter("sexe");
String data_naixement = request.getParameter("DataNaixement"); 
String tipus = request.getParameter("Tipus"); 


String[] generesArray = request.getParameterValues("Generes");
String generes = "";
if (generesArray != null) {
    generes = String.join(", ", generesArray); 
}

if (nom == null) nom = "";
if (cognom == null) cognom = "";
if (email == null) email = "";
if (contrasenya1 == null) contrasenya1 = "";
if (sexe == null) sexe = "";
if (data_naixement == null) data_naixement = "";
if (tipus == null) tipus = "";
%>

<persona>
    <nom><%= nom %></nom>
    <cognom><%= cognom %></cognom>
    <email><%= email %></email>
    <contrasenya1><%= contrasenya1 %></contrasenya1> 
    <sexe><%= sexe %></sexe>   
    <data_naixement><%= data_naixement %></data_naixement>
    <tipus><%= tipus %></tipus>
    <generes><%= generes %></generes>  
</persona>
