package com.miniprovider.dao.impl;

import com.miniprovider.dao.IDao;
import com.miniprovider.entity.ConRequestBean;
import com.miniprovider.exceptions.DuplicateEntryExceptions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

@Service("conRequestDaoImpl")
public class ConRequestDaoImpl implements IDao<ConRequestBean> {

    @Resource(name="entityManagerFactory")
    private EntityManagerFactory emf;

    @Override
    public List<ConRequestBean> getAll() {
        TypedQuery namedQuery = emf.createEntityManager().createNamedQuery("ConRequest.getAll",ConRequestBean.class);
        return namedQuery.getResultList();
    }

    @Override
    public List<ConRequestBean> getAll(int from, int number) {
        TypedQuery namedQuery =     emf.createEntityManager().createNamedQuery("ConRequest.getAll", ConRequestBean.class);
        return namedQuery.setFirstResult(from).setMaxResults(number).getResultList();
    }

    @Override
    public ConRequestBean get(Integer id) {
        EntityManager em = emf.createEntityManager();
        return em.find(ConRequestBean.class,id);
    }

    @Override
    public int delete(Integer id) {
        EntityManager em=emf.createEntityManager();
        EntityTransaction tx =em.getTransaction();
        ConRequestBean conRequestBean= em.find(ConRequestBean.class,id);
        if (conRequestBean==null)
            return -1;
        tx.begin();
        em.remove(conRequestBean);
        tx.commit();
        return 1;
    }

    @Override
    public ConRequestBean add(ConRequestBean obj) {
        EntityManager em =emf .createEntityManager();
        EntityTransaction tx =em.getTransaction();
//        List<ConRequestBean> result_id = em.createNamedQuery("Address.getDuplicate", ConRequestBean.class).setParameter(1, obj.getAddress_ID()).getResultList();;
//        if(!result_id.isEmpty()){
//            throw new DuplicateEntryExceptions("Адрес с таким номером существует");
//        }
        tx.begin();
        em.persist(obj);
        tx.commit();
        return obj;
    }

    @Override
    public ConRequestBean update(ConRequestBean obj) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx =em.getTransaction();
        tx.begin();
        ConRequestBean existConRequestBean  = em.find(ConRequestBean.class,obj.getAddress_id());
        existConRequestBean.setAddress_id(obj.getAddress_id());
        existConRequestBean.setFirstName(obj.getFirstName());
        existConRequestBean.setLastName(obj.getLastName());
        existConRequestBean.setPhone(obj.getPhone());
        existConRequestBean.setRoom(obj.getRoom());
        existConRequestBean.setEmail(obj.getEmail());
        existConRequestBean.setId(obj.getId());
        em.merge(existConRequestBean);
        tx.commit();

        return existConRequestBean;
    }
}
