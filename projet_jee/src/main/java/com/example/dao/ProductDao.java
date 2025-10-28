package com.example.dao;

import com.example.model.Product;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDao {
    
    public void save(Product product, Session session) {
        session.persist(product);
    }

    public List<Product> findAll(Session session) {
        return session.createQuery(
                "SELECT DISTINCT p FROM Product",
                Product.class
        ).getResultList();
    }

}
