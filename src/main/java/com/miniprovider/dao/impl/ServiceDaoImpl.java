package com.miniprovider.dao.impl;

import com.miniprovider.dao.IDao;
import com.miniprovider.entity.ServiceBean;
import com.miniprovider.exceptions.DuplicateEntryExceptions;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

@Service("serviceDaoImpl")
public class ServiceDaoImpl implements IDao<ServiceBean> {

    @Resource(name="entityManagerFactory")  //попробуй через @autoware
    private EntityManagerFactory emf;


    @Override
    public List<ServiceBean> getAll() {
        TypedQuery namedQuery = emf.createEntityManager().createNamedQuery("Service.getAll",ServiceBean.class);
        return namedQuery.getResultList();
    }

    @Override
    public List<ServiceBean> getAll(int from, int number) {
        TypedQuery namedQuery =     emf.createEntityManager().createNamedQuery("Service.getAll", ServiceBean.class);
        return namedQuery.setFirstResult(from).setMaxResults(number).getResultList();
    }

    @Override
    public ServiceBean get(Integer id) {
        EntityManager em = emf.createEntityManager();
        return  em.find(ServiceBean.class,id);
    }

    @Override
    public int delete(Integer id) {
        EntityManager em=emf.createEntityManager();
        EntityTransaction tx =em.getTransaction();
        ServiceBean serviceBean= em.find(ServiceBean.class,id);
        if (serviceBean==null)
            return -1;
        tx.begin();
        em.remove(serviceBean);
        tx.commit();
        return 1;
    }

    @Override
    public ServiceBean add(ServiceBean obj) {
        EntityManager em =emf .createEntityManager();
        EntityTransaction tx =em.getTransaction();
        List<ServiceBean> result_id = em.createNamedQuery("Service.getDuplicate", ServiceBean.class).setParameter(1, obj.getService_ID()).getResultList();;
        if(!result_id.isEmpty()){
            throw new DuplicateEntryExceptions("Услуга с таким номером существует");
        }
        tx.begin();
        em.persist(obj);
        tx.commit();
        return obj;
    }

    @Override
    public ServiceBean update(ServiceBean obj) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx =em.getTransaction();

        tx.begin();
        ServiceBean serviceBean  = em.find(ServiceBean.class,obj.getService_ID());
        serviceBean.setService_ID(obj.getService_ID());
        serviceBean.setServiceDescription(obj.getServiceDescription());
        serviceBean.setServicePrice(obj.getServicePrice());
        serviceBean.setServiceName(obj.getServiceName());
        em.merge(serviceBean);
        tx.commit();
        return serviceBean;
    }
}
