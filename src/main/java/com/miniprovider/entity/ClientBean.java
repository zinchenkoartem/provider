package com.miniprovider.entity;


import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.GrantedAuthority;
import javax.persistence.*;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Date;
import java.util.List;


@Entity
@NamedQuery (name = "Client.getAll", query = "SELECT  c  from ClientBean c  ")
@NamedNativeQueries({
    @NamedNativeQuery(name = "Client.getAvaliableService", query = "SELECT s.Service_ID,s.Name,s.Description,s.Price  FROM service s LEFT OUTER JOIN ( SELECT cs.Client_ID,cs.Service_ID  FROM  client_service cs WHERE cs.Client_ID=? ) AS new ON s.Service_ID= new.Service_ID WHERE new.Service_ID IS NULL",resultClass = ServiceBean.class),
    @NamedNativeQuery(name = "Client.getDuplicateID", query = "SELECT  * FROM client  WHERE Client_ID=?",resultClass = ClientBean.class),
    @NamedNativeQuery(name = "Client.getDuplicateMail", query = "SELECT  * FROM client  WHERE  Email=?",resultClass = ClientBean.class)
})
@Table(name = "client")
public class ClientBean implements GrantedAuthority, Serializable {

    @Id
    @Column(name = "Client_ID")
    private int client_ID;
    @Column(name = "FirstName")
    @NotNull
    @Size(min=3, max=20,  message="В поле должно быть от 3 до 20 символов")
    @Pattern(regexp = "^[A-Za-zА-Яа-яЁё0-9_-]+$" , message = "Только буквы и цифры")
	private String firstName;
    @Column(name = "LastName")
    @NotNull
    @Size(min=3, max=20,  message="В поле должно быть от 3 до 20 символов")
    @Pattern(regexp = "^[A-Za-zА-Яа-яЁё0-9_-]+$" , message = "Только буквы и цифры")
    private String lastName;
    @Column(name = "Email")
    @NotNull
    @Pattern(regexp = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" , message = "Email введен не верно")
	private String email;
    @Column(name = "Phone")
    @NotNull
    @Pattern(regexp = "^[0-9]+$" , message = "Только  цифры")
    @Size(min=6, max=20,  message="В поле должно быть от 6 до 20 символов")
  	private String phone;
    @Column(name = "Password")
    @NotNull
    @Size(min=3, max=40,  message="В поле должно быть от 3 до 40 символов")
	private String password;
    @Column(name = "Address_id")
    @Min(value = 1,message = "Адресс введен не верно")
	private int address_id;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="Address_ID", insertable =false )
  	private AddressBean addressBean;
    @Transient
    private  String address;
    @Column(name = "Room")
//    @NotNull
    @Min(value = 1,message = "Номер квартиры не может быть 0")
	private int room;
    @Column(name = "Account")
//    @NotNull
    @Min(value = 0,message = "Баланс введен не верно")
	private int account;
    @Column(name = "Status")
    @NotNull
	private int status;
    @Column(name = "Credit")
    @NotNull
	private boolean credit;
    @Column(name = "Birthday")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @NotNull
    @Past
	private Date birthday;
    @Column(name = "Role")
	private String role;
    @Transient
	private int tarif;
     @ManyToMany(fetch = FetchType.LAZY)
     @JoinTable(name ="client_service",joinColumns = @JoinColumn(name ="Client_ID" ), inverseJoinColumns = @JoinColumn(name = "Service_ID"))
	private List<ServiceBean> tarifplane;
    @Transient
    private List<ServiceBean> avaliableService;

    public  ClientBean(){
        room=1;
    }

    public List<ServiceBean> getAvaliableService() {
		return avaliableService;
	}
	public void setAvaliableService(List<ServiceBean> avaliableService) {
		this.avaliableService = avaliableService;
	}
	public List<ServiceBean> getTarifplane() {
		return tarifplane;
	}
	public void setTarifplane(List<ServiceBean> tarifplane) {
		this.tarifplane = tarifplane;
	}
	public int getTarif() {
        int sum=0;
        for(ServiceBean sb:getTarifplane()) {
            sum = sum + sb.getServicePrice();
        }
		return sum;
	}
	public void setTarif(int tarif) {
		this.tarif = tarif;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public int getClient_ID() {
		return client_ID;
	}
	public void setClient_ID(int client_ID) {
		this.client_ID = client_ID;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getAccount() {
		return account;
	}
	public void setAccount(int account) {
		this.account = account;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public boolean isCredit() {
		return credit;
	}
	public void setCredit(boolean credit) {
		this.credit = credit;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
    public void setAddressBean(AddressBean address) {
        this.addressBean = address;
    }
    public AddressBean  getAddressBean() {
        return addressBean;
    }
    public String getAddress() {
        return addressBean.getPath();
    }
    public void setAddress(String address_path) {
        this.address = address_path;
    }
	public String statusDesc(){
        if (status==0) return "Отключен";
        else if (status==1) return "Подключено";
        else if (status==2) return  "Приостановлен";
        return "Не активен";


    }
    @Override
	public String toString(){
        return "Абонент №"+getClient_ID()+ ": "+  getFirstName()+ " "+ getLastName() +" "+getBirthday()+" "+getEmail();
	}
    @Override
    public String getAuthority() {
        return getRole();
    }
    @Override
    public int hashCode() {
        return getClient_ID()*37;
    }
    @Override
    public boolean equals(Object o) {
        if (this != o) return false;
        if (o == null || getClass() != o.getClass()) return false;
        if(!(o instanceof ClientBean)) return false;
        ClientBean that = (ClientBean) o;

        if (client_ID != that.client_ID) return false;

        return true;
    }

}
