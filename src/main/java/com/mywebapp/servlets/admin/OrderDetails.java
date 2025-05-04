package com.mywebapp.servlets.admin;

import com.mywebapp.servlets.Cart.Product;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderDetails {
    public String customerName;
    public Timestamp orderDate;
    public String status;
    public double total;

    public List<Product> products;

    public OrderDetails(String _customerName, Timestamp _orderDate, String _status, double _total, List<Product> _products) {
        customerName = _customerName;
        orderDate = _orderDate;
        status = _status;
        total = _total;
        products = _products;
    }
}
