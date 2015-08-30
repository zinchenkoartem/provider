package com.miniprovider.entity;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.List;


@Entity
@Table(name="address")
@NamedQuery(name = "Address.getAll", query = "SELECT  a  from AddressBean a ")
@NamedNativeQuery(name = "Address.getDuplicate", query = "SELECT  * FROM address  WHERE Address_ID=?",resultClass = AddressBean.class)
public class AddressBean implements Serializable {
	@Id
	@Column(name="Address_ID")
	private int address_ID;
	@Column(name="Path")
    @Size(min=1, max=50,  message="В поле должно быть от 1 до 50 символов")
	private String path;
    @OneToMany(mappedBy ="addressBean", fetch = FetchType.LAZY)
    private List<ClientBean> clientBean;
    @OneToMany(mappedBy ="addressBean", fetch = FetchType.LAZY)
    private  List<ConRequestBean> conRequestBeans;
	public int getAddress_ID() {
		return address_ID;
	}
	public void setAddress_ID(int address_ID) {
		this.address_ID = address_ID;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	@Override
	public String toString() {
		return "Адрес №"+getAddress_ID()+": "+getPath();
	}
    @Override
    public int hashCode() {
        return address_ID*37;
    }
    @Override
    public boolean equals(Object o) {
        if (this != o) return false;
        if (o == null || getClass() != o.getClass()) return false;
        if(!(o instanceof AddressBean)) return false;
        AddressBean that = (AddressBean) o;

        if (address_ID != that.address_ID) return false;

        return true;
    }

}
