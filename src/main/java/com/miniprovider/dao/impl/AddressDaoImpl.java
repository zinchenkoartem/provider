package com.miniprovider.dao.impl;

import com.miniprovider.dao.IDao;
import com.miniprovider.entity.AddressBean;
import com.miniprovider.exceptions.DuplicateEntryExceptions;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;
import java.util.List;

@Service("addressDaoImpl")
public class AddressDaoImpl implements IDao<AddressBean> {

    @Resource(name="entityManagerFactory")  //попробуй через @autoware
    private EntityManagerFactory emf;

    @Override
    public List<AddressBean> getAll() {
        TypedQuery namedQuery = emf.createEntityManager().createNamedQuery("Address.getAll",AddressBean.class);
        return namedQuery.getResultList();
    }

    @Override
    public List<AddressBean> getAll(int from, int number) {
        TypedQuery namedQuery =     emf.createEntityManager().createNamedQuery("Address.getAll", AddressBean.class);
        return namedQuery.setFirstResult(from).setMaxResults(number).getResultList();
    }

    @Override
    public AddressBean get(Integer id) {
        EntityManager em = emf.createEntityManager();
        return em.find(AddressBean.class,id);
    }

    @Override
    public int delete(Integer id) {
        EntityManager em=emf.createEntityManager();
        EntityTransaction tx =em.getTransaction();
        AddressBean addressBean= em.find(AddressBean.class,id);
        if (addressBean==null)
            return -1;
        tx.begin();
        em.remove(addressBean);
        tx.commit();
        return 1;
    }

    @Override
    public AddressBean add(AddressBean obj) {
        EntityManager em =emf .createEntityManager();
        EntityTransaction tx =em.getTransaction();
        List<AddressBean> result_id = em.createNamedQuery("Address.getDuplicate", AddressBean.class).setParameter(1, obj.getAddress_ID()).getResultList();;
        if(!result_id.isEmpty()){
            throw new DuplicateEntryExceptions("Адрес с таким номером существует");
        }
        tx.begin();
        em.persist(obj);
        tx.commit();
        return obj;
    }

    @Override
    public AddressBean update(AddressBean obj) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx =em.getTransaction();
        tx.begin();
        AddressBean existAddress  = em.find(AddressBean.class,obj.getAddress_ID());
        existAddress.setAddress_ID(obj.getAddress_ID());
        existAddress.setPath(obj.getPath());
        em.merge(existAddress);
        tx.commit();

        return existAddress;
    }
}
