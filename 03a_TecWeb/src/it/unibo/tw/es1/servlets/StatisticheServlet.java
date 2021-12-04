
package it.unibo.tw.es1.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import it.unibo.tw.es1.beans.Articolo;
import it.unibo.tw.es1.beans.InsiemeDiArticoli;

public class StatisticheServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String id = null;
		int firstDay = 0;
		int lastDay = 0;

		String request = req.getParameter("req");

		if (request != null) {
			id = req.getParameter("id");
			firstDay = Integer.parseInt(req.getParameter("firstDay"));
			lastDay = Integer.parseInt(req.getParameter("lastDay"));
		}

		InsiemeDiArticoli articoli = (InsiemeDiArticoli) this.getServletContext().getAttribute("merceVenduta");

		float totale=0;

		for(Articolo a: articoli.getMerce()){
			if(a.getDay() >= firstDay && a.getDay() <= lastDay){
				totale+=a.getPrice()*a.getAmount();
			}
		}

		req.setAttribute("guadagnoRichiestaAttuale", totale);

		this.getServletContext().getRequestDispatcher("/statistiche.jsp").forward(req, resp);
	}
}
