package com.neighbourhood.search;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.neighbourhood.user.User;

/**
 * Servlet implementation class Search
 */
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		List<User> searchResult=new ArrayList<User>();
		/*System.out.println("In Search.java");*/
		String attribute=request.getParameter("attribute");
		request.getSession().setAttribute("attribute", attribute);
		String searchQuery=request.getParameter("searchValue");
		/*System.out.println(attribute+"     "+searchQuery);*/
		searchResult=SearchNeighbours.search(searchQuery, attribute);
			request.getSession().setAttribute("searchResult", searchResult);
		
		response.sendRedirect("search.jsp");
		
	}

}
