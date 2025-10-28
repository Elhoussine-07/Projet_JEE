package com.example.web.servlets;
import com.example.model.Product;
import com.example.model.Student;
import com.example.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.List;

@WebServlet("/products/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ProductServlet extends HttpServlet {
    
    private ProductService productService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Afficher la liste des produits
            List<Product> products = productService.findAll();
            request.setAttribute("products", products);
            request.getRequestDispatcher("/products.jsp").forward(request, response);
            return;
        }
        
        switch (pathInfo) {
            case "/add":
                // Afficher le formulaire d'ajout
                request.getRequestDispatcher("/productForm.jsp").forward(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        switch (pathInfo) {
            case "/add":
                handleAddProduct(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Student currentUser = (Student) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        
        if (name == null || description == null || priceStr == null ||
            name.trim().isEmpty() || description.trim().isEmpty() || priceStr.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs obligatoires");
            request.getRequestDispatcher("/productForm.jsp").forward(request, response);
            return;
        }
        
        try {
            double price = Double.parseDouble(priceStr);
            
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setOwner(currentUser);
            
            productService.save(product);
            
            request.setAttribute("success", "Produit ajouté avec succès !");
            request.getRequestDispatcher("/productForm.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Le prix doit être un nombre valide");
            request.getRequestDispatcher("/productForm.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de l'ajout du produit");
            request.getRequestDispatcher("/productForm.jsp").forward(request, response);
        }
    }
}
