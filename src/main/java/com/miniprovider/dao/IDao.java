package com.miniprovider.dao;


import java.util.List;

public interface IDao<T> {

    public List<T> getAll();
    public List<T> getAll(int from, int number);
    public T get (Integer id);
    public  int delete(Integer id);
    public  T add(T obj);
    public T update(T obj);
}
