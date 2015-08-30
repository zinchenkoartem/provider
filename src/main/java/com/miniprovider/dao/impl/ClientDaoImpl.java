package com.miniprovider.dao.impl;

import com.miniprovider.exceptions.DuplicateEntryExceptions;
import com.miniprovider.dao.IDao;
import com.miniprovider.entity.ClientBean;
import com.miniprovider.entity.ServiceBean;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.*;
import java.sql.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;


@Service("clientDaoImpl")
public class ClientDaoImpl implements IDao<ClientBean> {


    @Resource(name="entityManagerFactory")
//    @Autowired
    private EntityManagerFactory emf;


    @Override
    public List<ClientBean> getAll() {
           TypedQuery namedQuery =     emf.createEntityManager().createNamedQuery("Client.getAll", ClientBean.class);
        return namedQuery.getResultList();

    }

    @Override
    public List<ClientBean> getAll(int from, int number) {
        TypedQuery namedQuery =     emf.createEntityManager().createNamedQuery("Client.getAll", ClientBean.class);
        return namedQuery.setFirstResult(from).setMaxResults(number).getResultList();
    }

    @Override
    public ClientBean get(Integer id) {
        EntityManager em = emf.createEntityManager();
        ClientBean cl=em.find(ClientBean.class, id);
        if (cl !=null) {
            List<ServiceBean> result = em.createNamedQuery("Client.getAvaliableService", ServiceBean.class).setParameter(1, id).getResultList();
            cl.setAvaliableService(result);
        }
        return  cl;
    }

    @Override
    public int delete(Integer id) {
        EntityManager em=emf.createEntityManager();
        EntityTransaction tx =em.getTransaction();
        ClientBean clientBean= em.find(ClientBean.class,id);
        if (clientBean==null)
            return -1;
        tx.begin();
        em.remove(clientBean);
        tx.commit();
     return 1;
    }

    @Override
    public ClientBean add(ClientBean obj) {
      
        EntityManager em =emf .createEntityManager();
        List<ClientBean> result_id = em.createNamedQuery("Client.getDuplicateID", ClientBean.class).setParameter(1, obj.getClient_ID()).getResultList();
        List<ClientBean> result_mail = em.createNamedQuery("Client.getDuplicateMail", ClientBean.class).setParameter(1, obj.getEmail()).getResultList();
            if(!result_id.isEmpty()){
                throw new DuplicateEntryExceptions("Абонент с таким номером существует");
            }
            if(!result_mail.isEmpty()){
                throw new DuplicateEntryExceptions("Абонент с таким Email существует");
            }
        obj.setPassword((DigestUtils.md5Hex(obj.getPassword()))); //шифрование
        EntityTransaction tx =em.getTransaction();
        tx.begin();
        em.persist(obj);
        tx.commit();
        return obj;
    }

    @Override
    public ClientBean update(ClientBean obj) {

        EntityManager em = emf.createEntityManager();
        List<ClientBean> result = em.createNamedQuery("Client.getDuplicateMail", ClientBean.class).setParameter(1, obj.getEmail()).getResultList();
        if (!(result.isEmpty()) && obj.getClient_ID()!=result.get(0).getClient_ID()){
                throw new DuplicateEntryExceptions("Абонент с таким Email существует");
        }
        EntityTransaction tx =em.getTransaction();
        tx.begin();
        ClientBean existClient  = em.find(ClientBean.class,obj.getClient_ID());
        if (existClient !=null){
            existClient.setAccount(obj.getAccount());
            existClient.setAddress_id(obj.getAddress_id());
            existClient.setBirthday(obj.getBirthday());
            existClient.setCredit(obj.isCredit());
            existClient.setEmail(obj.getEmail());
            existClient.setFirstName(obj.getFirstName());
            existClient.setLastName(obj.getLastName());
            existClient.setPassword((DigestUtils.md5Hex(obj.getPassword())));  //шифрование
            existClient.setPhone(obj.getPhone());
            existClient.setRole(obj.getRole());
            existClient.setRoom(obj.getRoom());
            existClient.setStatus(obj.getStatus());
//        existClient.setTarifplane(obj.getTarifplane());
            em.merge(existClient);
            tx.commit();
        }
        return existClient;
    }


}
