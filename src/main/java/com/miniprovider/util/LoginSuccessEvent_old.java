package com.miniprovider.util;

import com.miniprovider.entity.ClientBean;
import org.apache.log4j.Logger;
import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.InteractiveAuthenticationSuccessEvent;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Set;

//@Service
public class LoginSuccessEvent_old implements ApplicationListener<InteractiveAuthenticationSuccessEvent> {

    private static final Logger logger = Logger.getLogger(LoginSuccessEvent_old.class);
    @Override
    public void onApplicationEvent(InteractiveAuthenticationSuccessEvent event) {

        ClientBean cl = null;
        Object obj = event.getAuthentication().getPrincipal();
        if (obj instanceof UserDetails) {
            UserDetails userDetails = (UserDetails) obj;
            Set<GrantedAuthority> set = (Set<GrantedAuthority>) userDetails.getAuthorities();
            for (GrantedAuthority ga : set) {
                if (ga instanceof ClientBean) {
                    cl = (ClientBean) ga;
                }
            }
        }
        logger.info("Logged In:  ->"+cl.toString());
    }
}
