package com.miniprovider.dao;

public interface IClientService {

    public  int addService(int client_id, int service_id);
    public int deleteService(int client_id, int service_id);
}
