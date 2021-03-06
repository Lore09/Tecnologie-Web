<!-- pagina per la gestione di errori -->
<%@ page errorPage="../errors/failure.jsp"%>

<!-- accesso alla sessione -->
<%@ page session="true"%>

<!-- import di classi Java -->
<%@ page import="it.unibo.tw.web.beans.*"%>
<%@ page import="it.unibo.tw.web.beans.Item"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>

<!-- metodi richiamati nel seguito -->
<%!
void add(Cart cart, Item item) {

	boolean alreadyInCart = false;
	
	for(Item i:cart.getItems()){
        if(i.getDescription().equals(item.getDescription())){
            alreadyInCart=true;
            int q=item.getQuantity();
            item.setQuantity(q+item.getQuantity());
            break;
        }
    }
	
	
	if ( ! alreadyInCart ) {
		cart.put(item,1);
	}
	
}

void remove(Cart cart, Item item) {
	
	Set<Item> tmp=cart.getItems();
    cart.empty();

    for(Item i:tmp){
        if(!i.getDescription().equals(item.getDescription()))
        	cart.put(i, 1);
    }
}
%>

<!-- codice html restituito al client -->
<html>
	<head>
		<meta name="Author" content="pisi79">
		<title>Cart JSP</title>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/styles/default.css" type="text/css"/>
	</head>

	<body>	

		<%@ include file="../fragments/header.jsp" %>
		<%@ include file="../fragments/menu.jsp" %>
	
		<div id="main" class="clear">

			<jsp:useBean id="cart" class="it.unibo.tw.web.beans.Cart" scope="session" />
			<jsp:useBean id="catalogue" class="it.unibo.tw.web.beans.Catalogue" scope="application" />
						
		<%
			String description = request.getParameter("description");
	
				if ( description != null && ! description.equals("") ) {

					if ( description.contains(" ") ) {
						throw new Exception("Blanks are not allowed in the description field!"); 					
					}
					
					if ( request.getParameter("add") != null && request.getParameter("add").equals("true") ) {
						Item item = new Item();
						item.setDescription( description );
						item.setPrice( Double.parseDouble( request.getParameter("price") ) );
						item.setQuantity( Integer.parseInt(request.getParameter("quantity") ) );
						add(cart,item);
					}
					if ( request.getParameter("remove") != null && request.getParameter("remove").equals("true") ) {
						Item item = new Item();
						item.setDescription( description );
						item.setPrice( Double.parseDouble( request.getParameter("price") ) );
						item.setQuantity( Integer.parseInt(request.getParameter("quantity") ) );
						remove(cart,item);
					}
				}
			%>
			
			
			<div id="left" style="float: left; width: 48%; border-right: 1px solid grey">
			
				<p>Add an item to the cart:</p>
				<form>
                    <% 
                        for(Item i: catalogue.getItems()){
                    %>
					<table>
						<tr>
							<td><%= i.getDescription() %></td>
							<td><%= i.getPrice() %> &#8364;</td>
							<td><%= i.getQuantity() %></td>
							<td>
								<a href="?add=true&remove=false&description=<%= i.getDescription() %>&price=<%= i.getPrice() %>&quantity=<%= i.getQuantity() %>">
								<img src="../images/michele.png" alt="add"/>
								</a>
							</td>
						</tr>
					</table>
					
                    <% } %>


				</form>
		
			</div>
			
			<div id="right" style="float: right; width: 48%">

				<p>Current cart:</p>
				<table class="formdata">
					<tr>
						<th style="width: 31%">Description</th>
						<th style="width: 31%">Price</th>
						<th style="width: 31%">Available quantity</th>
						<th style="width: 7%"></th>
					</tr>
					<% 
                        for(Item i: cart.getItems()){
                    %>
					<table>
						<tr>
							<td><%= i.getDescription() %></td>
							<td><%= i.getPrice() %> &#8364;</td>
							<td><%= i.getQuantity() %></td>
							<td>
							<a href="?add=false&remove=true&description=<%= i.getDescription() %>&price=<%= i.getPrice() %>&quantity=<%= i.getQuantity() %>">
								<img src="../images/remove.gif" alt="remove"/>
							</a>
							</td>
						</tr>
					</table>
					
                    <% } %>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>			
			</div>
			
		
			<div class="clear">
				<p>&nbsp;</p>
			</div>

			
		</div>
	
		<%@ include file="../fragments/footer.jsp" %>

	</body>
</html>
