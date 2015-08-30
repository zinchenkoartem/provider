package com.miniprovider.entity;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;

@Entity
@Table(name = "con_request")
@NamedQuery(name = "ConRequest.getAll", query = "SELECT  c  from ConRequestBean  c ")
public class ConRequestBean  implements Serializable{

    @Id
    @Column(name="ID")
    private int id;
    @Column(name = "Address_id")
    @Min(value = 1,message = "Адресс введен не верно")
    private int address_id;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="Address_ID", insertable =false )
    private AddressBean addressBean;
    @Column(name = "FirstName")
    @Size(min=5, max=50,  message="В поле должно быть 5-50 символов")
    private String firstName;
    @Column(name = "LastName")
    @Size(min=5, max=50,  message="В поле должно быть 5-50 символов")
    private String lastName;
    @Column(name = "Email")
    @NotNull
    @Pattern(regexp = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" , message = "Email введен не верно")
    private String email;
    @Column(name = "Phone")
    @Pattern(regexp = "^[0-9]*$" , message = "Только цифры")
    @Size(min=10, max=15,  message="В поле должно быть 10-15 цифр")
    private String phone;
    @Column(name = "Room")
    @Min(value = 1,message = "Укажите номер квартиры")
    private int room=1;

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getAddress_id() {
        return address_id;
    }
    public void setAddress_id(int address_id) {
        this.address_id = address_id;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public AddressBean getAddressBean() {
        return addressBean;
    }
    public void setAddressBean(AddressBean addressBean) {
        this.addressBean = addressBean;
    }
    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public int getRoom() {
        return room;
    }
    public void setRoom(int room) {
        this.room = room;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ConRequestBean that = (ConRequestBean) o;

        if (address_id != that.address_id) return false;
        if (id != that.id) return false;
        if (addressBean != null ? !addressBean.equals(that.addressBean) : that.addressBean != null) return false;
        if (email != null ? !email.equals(that.email) : that.email != null) return false;
        if (firstName != null ? !firstName.equals(that.firstName) : that.firstName != null) return false;
        if (lastName != null ? !lastName.equals(that.lastName) : that.lastName != null) return false;
        if (phone != null ? !phone.equals(that.phone) : that.phone != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return id*37;
    }

    @Override
    public String toString() {
        return "ConRequestBean{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                '}';
    }
}
