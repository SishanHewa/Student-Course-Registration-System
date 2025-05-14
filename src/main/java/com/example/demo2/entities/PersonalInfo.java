package com.example.demo2.entities;

public class PersonalInfo {
    private String username;
    private String address;
    private String email;
    private String phone;
    private String nic;
    private String dob;
    private String gender;
    private String nationality;
    private String name;

    public PersonalInfo(String username, String address, String email, String phone,
                        String nic, String dob, String gender, String nationality, String name) {
        this.username = username;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.nic = nic;
        this.dob = dob;
        this.gender = gender;
        this.nationality = nationality;
        this.name = name;
    }

    public String getUsername() { return username; }
    public String getAddress() { return address; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getNic() { return nic; }
    public String getDob() { return dob; }
    public String getGender() { return gender; }
    public String getNationality() { return nationality; }
    public String getName() { return name; }
}