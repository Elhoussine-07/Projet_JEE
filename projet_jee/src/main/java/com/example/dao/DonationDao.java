package com.example.dao;

import com.example.model.Donation;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class DonationDao {
    
    public void save(Donation donation, Session session) {
        session.persist(donation);
    }
    
    public List<Donation> findAll(Session session) {
        Query<Donation> query = session.createQuery("FROM Donation", Donation.class);
        return query.list();
    }
}