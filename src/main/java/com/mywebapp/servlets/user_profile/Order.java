package com.mywebapp.servlets.user_profile;


import com.mywebapp.servlets.Cart.Product;

import java.time.LocalDateTime;
import java.util.ArrayList;

public class Order {
    public int id;
    public LocalDateTime order_date;
    public String status;
    public ArrayList<Product> products;

    public Order(int _id, LocalDateTime _order_date, String _status, ArrayList<Product> _products) {
        id = _id;
        order_date = _order_date;
        status = _status;
        products = _products;
    }
}
