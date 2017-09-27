package listener;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import util.CountMessageUtil;
import entity.Student;

public class CountListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent se) {

		ServletContext application = se.getSession().getServletContext();

		int num = 0;
		if (application.getAttribute("num") != null) {

			num = (Integer) application.getAttribute("num");
		}

		if (se.getSession().isNew()) {
			num++;
		}
		CountMessageUtil.sendCountMessage(num);
		application.setAttribute("num", num);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		ServletContext application = se.getSession().getServletContext();

		int num = (Integer) application.getAttribute("num");
		num--;
		application.setAttribute("num", num);
		CountMessageUtil.sendCountMessage(num);
		System.out.println("sessionÏú»Ù");
	}

}
