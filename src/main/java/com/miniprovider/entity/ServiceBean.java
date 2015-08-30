package com.miniprovider.entity;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name ="service" )
@NamedQuery(name = "Service.getAll", query = "SELECT  s  from ServiceBean  s ")
@NamedNativeQuery(name = "Service.getDuplicate", query = "SELECT  * FROM service  WHERE Service_ID=?",resultClass = ServiceBean.class)
public class ServiceBean  implements Serializable {
    @Id
    @Column(name = "Service_ID")
	private int service_ID;
    @Column(name = "Name")
    @Size(min=5, max=50,  message="В поле должно быть от 5 до 50 символов")
	private String serviceName;
    @Column(name = "Description")
    @Size(min=5, max=50,  message="В поле должно быть от 5 до 50 символов")
	private String serviceDescription;
    @Column(name = "Price")
    private int servicePrice;

//    @ManyToOne(fetch = FetchType.LAZY,optional = true )
//    @JoinTable(name = "client_service", joinColumns = @JoinColumn(name = "Client_ID"), inverseJoinColumns = @JoinColumn(name = "Service_ID"))
//@Transient
@ManyToMany(fetch = FetchType.LAZY)
@JoinTable(name ="client_service",joinColumns = @JoinColumn(name ="Service_ID" ), inverseJoinColumns = @JoinColumn(name = "Client_ID"))
    private List<ClientBean> client;


	public int getService_ID() {
		return service_ID;
	}
	public void setService_ID(int service_ID) {
		this.service_ID = service_ID;
	}
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getServiceDescription() {
		return serviceDescription;
	}
	public void setServiceDescription(String serviceDescription) {
		this.serviceDescription = serviceDescription;
	}
	public int getServicePrice() {
		return servicePrice;
	}
	public void setServicePrice(int servicePrice) {
		this.servicePrice = servicePrice;
	}
	@Override
	public String toString() {
		return "Услуга №"+getService_ID()+": "+ getServiceName() +"(" + getServicePrice() + "грн)";
	}

    public List<ClientBean> getClient() {
        return client;
    }

    public void setClient(List<ClientBean> client) {
        this.client = client;
    }

    @Override
    public boolean equals(Object o) {
        if (this != o) return false;
        if (o == null || getClass() != o.getClass()) return false;
        if(!(o instanceof ServiceBean)) return false;
        ServiceBean that = (ServiceBean) o;

        if (service_ID != that.service_ID) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return service_ID*37;
    }

}