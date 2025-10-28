package com.example.web.servlets;

import com.example.model.Donation;
import com.example.model.Student;
import com.example.service.DonationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/donations/*")
public class DonationServlet extends HttpServlet {
    
    private DonationService donationService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        donationService = new DonationService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Afficher la liste des dons
            List<Donation> donations = donationService.findAll();
            request.setAttribute("donations", donations);
            request.getRequestDispatcher("/donations.jsp").forward(request, response);
            return;
        }
        
        switch (pathInfo) {
            case "/add":
                // Afficher le formulaire d'ajout
                request.getRequestDispatcher("/donationForm.jsp").forward(request, response);
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
                handleAddDonation(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    private void handleAddDonation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Student currentUser = (Student) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        
        if (title == null || description == null ||
            title.trim().isEmpty() || description.trim().isEmpty()) {
            request.setAttribute("error", "Veuillez remplir tous les champs obligatoires");
            request.getRequestDispatcher("/donationForm.jsp").forward(request, response);
            return;
        }
        
        try {
            Donation donation = new Donation();
            donation.setTitle(title);
            donation.setDescription(description);
            donation.setOwner(currentUser);
            
            donationService.save(donation);
            
            request.setAttribute("success", "Don ajouté avec succès !");
            request.getRequestDispatcher("/donationForm.jsp").forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Une erreur est survenue lors de l'ajout du don");
            request.getRequestDispatcher("/donationForm.jsp").forward(request, response);
        }
    }
}
