package com.miniprovider.dao.impl;

import com.miniprovider.dao.IClientService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Query;

@Service("clientServiceImpl")
public class ClientServiceImpl implements IClientService {

    @Resource(name="entityManagerFactory")
    private EntityManagerFactory emf;

    @Override
    public int addService(int client_id, int service_id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
                Query query=em.createNativeQuery("INSERT INTO client_service (Client_ID, Service_ID) VALUES (?,?)")
                .setParameter(1,client_id)
                .setParameter(2,service_id);
        tx.begin();
        int result = query.executeUpdate();
        tx.commit();
        return result;
    }

    @Override
    public int deleteService(int client_id, int service_id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        Query query=em.createNativeQuery("DELETE   FROM client_service WHERE Client_ID=? and Service_ID =?")
                .setParameter(1,client_id)
                .setParameter(2,service_id);
        tx.begin();
        int result = query.executeUpdate();
        tx.commit();
        return result;

    }
}
