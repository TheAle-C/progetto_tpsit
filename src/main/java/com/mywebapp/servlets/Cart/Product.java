package com.mywebapp.servlets.Cart;

public class Product {
    public int id;
    public String marca;
    public String name;
    public double price;
    public int quantity;
    public String description;
    public String image;
    public String catalog;

    public Product(int _id, String _marca, String _name, double _price, int _quantity, String _description, String _image) {
        id = _id;
        marca = _marca;
        name = _name;
        price = _price;
        quantity = _quantity;
        image = _image;
        description = _description;
    }

    public Product(int _id, String _marca, String _name, double _price, int _quantity, String _description, String _image, String _catalog) {
        id = _id;
        marca = _marca;
        name = _name;
        price = _price;
        quantity = _quantity;
        image = _image;
        description = _description;
        catalog = _catalog;
    }
}
