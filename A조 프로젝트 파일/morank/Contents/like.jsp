<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.io.PrintWriter"%>
<%@ page import="searchdao.informationDAO" %>
<%@ page import="searchdto.informationVO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import = "user.UserDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	// ���� ���� �˻� ���� ���̵�, �˻���, total = ī�װ�(��)+ī�װ�(��) ������ ������ ����
	// �α��� ���� ����
		String userid = null;
		if(session.getAttribute("userid") != null) {
			userid = (String)session.getAttribute("userid");
			boolean emailChecked = new UserDAO().getUserEmailChecked(userid); //�̸��� ���� �ȵɽ�
			if(emailChecked==false){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'join3.jsp'");
				script.println("</script>");
				script.close();
				return;
			}
		}
		// �� �α��� �ø� ���� �ϱ� ����
	if (userid ==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�α��� �� �����մϴ�.')");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	} // �α��ν� ��õ ����
	else{
		String info_id = request.getParameter("info_id");
		informationDAO iDao = new informationDAO();
		String search = (String)session.getAttribute("search");
		String total = request.getParameter("total");
		//���ƿ� ������ �����ͺ��̽��� ����
		iDao.likeplus(info_id);
		PrintWriter script  = response.getWriter();
		script.println("<script>");
		//���� �������� total = ī�װ�(��)+ī�װ�(��) ������ ��������
		script.println("location.href='ranking.jsp?showcate="+total+"'");
		script.println("</script>");
		script.close();
	}
	
						
%>
</body>
</html>