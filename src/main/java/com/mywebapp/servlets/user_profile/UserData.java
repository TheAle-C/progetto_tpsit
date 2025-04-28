package com.mywebapp.servlets.user_profile;

import java.sql.Date;

public class UserData {
    public int id;
    public String first_name;
    public String last_name;
    public String email;
    public Date birth_date;


    public UserData(int _id, String _first_name, String _last_name, String _email, Date _birth_date) {
        id = _id;
        first_name = _first_name;
        last_name = _last_name;
        email = _email;
        birth_date = _birth_date;
    }
}
