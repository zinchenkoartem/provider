package com.miniprovider.util;

import com.miniprovider.dao.IDao;
import com.miniprovider.entity.ClientBean;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import  org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;




@Service("userDetailsServiceLogin")
public class UserDetailsServiceLogin implements UserDetailsService {

    @Resource(name="clientDaoImpl")
    private IDao<ClientBean> clientDao;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        ClientBean clientBean=clientDao.get(Integer.valueOf(username));
        if (clientBean ==null) {
            throw new UsernameNotFoundException("Пользователя не существует");
        }
        List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        roles.add(clientBean);
        User user = new User(String.valueOf(clientBean.getClient_ID()),clientBean.getPassword(),roles);
        return user;
    }
}
