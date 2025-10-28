package com.example.dao;

import com.example.model.LostAndFound;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

public class LostAndFoundDao {
    
    public void save(LostAndFound lostAndFound, Session session) {
        session.persist(lostAndFound);
    }
    
    public List<LostAndFound> findAll(Session session) {
        Query<LostAndFound> query = session.createQuery("FROM LostAndFound", LostAndFound.class);
        return query.list();
    }
}
