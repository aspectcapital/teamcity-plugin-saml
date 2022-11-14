<%@ page import="jetbrains.buildServer.auth.saml.plugin.SamlPluginConstants" %>
<%@ taglib prefix="forms" tagdir="/WEB-INF/tags/forms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="samlSettings" scope="request" type="jetbrains.buildServer.auth.saml.plugin.pojo.SamlPluginSettings"/>
<jsp:useBean id="loginUrl" scope="request" type="java.lang.String"/>

<c:if test="${samlSettings.hideLoginForm}">
    <style>
        .loginForm {
            display: none;
        }
    </style>
</c:if>

<div id="sso-login-button">
    <a href="<%=loginUrl%>" class="btn btn_primary">${samlSettings.ssoLoginButtonName}</a>
</div>

<c:if test="${samlSettings.ssoAutoRedirect}">
    <style>
        .loginForm, #sso-login-button {
            display: none;
        }
    </style>

    <div id="sso-redirect-notice">
        <p>Redirecting to SSO... <i class="ring-loader-inline progressRing progressRingSubmitBlock" title="Please wait..."></i></p>
    </div>

    <script>
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        if (!urlParams.has('nosso')) {
            window.location.replace('<%=loginUrl%>');
        } else {
            document.getElementById("sso-redirect-notice").style.display = 'none';
            document.getElementsByClassName('loginForm')[0].style.display = 'block';
            document.getElementById('sso-login-button').style.display = 'block';
        }
    </script>
</c:if>