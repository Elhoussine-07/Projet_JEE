package com.example.service;

import com.example.dao.ProductDao;
import com.example.model.Product;
import com.example.util.HibernateUtil;
import org.hibernate.Session;

import java.util.List;

public class ProductService {
    
    private ProductDao productDao;
    
    public ProductService() {
        this.productDao = new ProductDao();
    }
    
    public void save(Product product) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            session.beginTransaction();
            productDao.save(product, session);
            session.getTransaction().commit();
        } catch (Exception e) {
            session.getTransaction().rollback();
            throw e;
        } finally {
            session.close();
        }
    }
    
    public List<Product> findAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            return productDao.findAll(session);
        } finally {
            session.close();
        }
    }
}
