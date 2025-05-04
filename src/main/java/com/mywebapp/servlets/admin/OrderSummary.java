package com.mywebapp.servlets.admin;

import java.sql.Timestamp;

public class OrderSummary {
    public int orderId;
    public String customerName;
    public Timestamp orderDate;
    public double total;
    public String status;

    // Costruttore
    public OrderSummary(int orderId, String customerName, Timestamp orderDate, double total, String status) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.orderDate = orderDate;
        this.total = total;
        this.status = status;
    }
}
