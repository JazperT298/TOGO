// ignore_for_file: depend_on_referenced_packages

import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';
import 'package:ibank/app/data/models/shop.dart';

List<ShopProductCategory> categories = [
  ShopProductCategory(
      name: 'Credit',
      description: 'Purchase of call and message packages.',
      icon: FluIcons.creditCardUnicon,
      color: Colors.green),
  ShopProductCategory(
      name: 'Internet package',
      description: 'Purchase an internet packages.',
      icon: FluIcons.cloudConnection,
      color: Colors.orange),
  ShopProductCategory(
      name: 'Voice package',
      description: 'Purchase a voice packages',
      icon: FluIcons.microphone2,
      color: Colors.blue),
  // ShopProductCategory(name: 'Electronique', description: 'Routeurs et équipements.', icon: FluIcons.devices, color: Colors.purple),
  // ShopProductCategory(name: 'Style de vie', description: 'Soyez swag façon Mooooov!', icon: FluIcons.buy, color: Colors.pink),
  // ShopProductCategory(name: 'Autres', description: 'No limit. On en a toujours plus!!!', icon: FluIcons.more2, color: Colors.cyanAccent),
];

List<ShopProduct> products = [
  ShopProduct(
    id: "1",
    name: "Esim",
    description: "Esim is the future",
    images: [
      ShopProductImage(
        url:
            "https://t4.ftcdn.net/jpg/03/98/23/17/360_F_398231758_6dclqrQdYd5hdOCo3M2G2stekJ8JGAZC.jpg",
        createdAt: "2020-01-01T00:00:00.000Z",
        updatedAt: "2020-01-01T00:00:00.000Z",
      ),
    ],
    price: 10.0,
    quantity: 10,
    category: "category 1",
    createdAt: "2020-01-01T00:00:00.000Z",
    updatedAt: "2020-01-01T00:00:00.000Z",
  ),
  ShopProduct(
    id: "2",
    name: "5G",
    description: "Smartphone by moov",
    images: [
      ShopProductImage(
        url:
            "https://scitechdaily.com/images/5G-6G-Beam-Steering-Antenna-Technology.jpg",
        createdAt: "2020-01-01T00:00:00.000Z",
        updatedAt: "2020-01-01T00:00:00.000Z",
      ),
    ],
    price: 10.0,
    quantity: 10,
    category: "category 1",
    createdAt: "2020-01-01T00:00:00.000Z",
    updatedAt: "2020-01-01T00:00:00.000Z",
  ),
  ShopProduct(
    id: "2",
    name: "Smartphone",
    description: "Smartphone by moov",
    images: [
      ShopProductImage(
        url:
            "https://images.unsplash.com/photo-1610664921890-ebad05086414?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDZ8fHNtYXJ0cGhvbmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
        createdAt: "2020-01-01T00:00:00.000Z",
        updatedAt: "2020-01-01T00:00:00.000Z",
      ),
    ],
    price: 10.0,
    quantity: 10,
    category: "category 1",
    createdAt: "2020-01-01T00:00:00.000Z",
    updatedAt: "2020-01-01T00:00:00.000Z",
  ),
  ShopProduct(
    id: "2",
    name: "Router",
    description: "Smartphone by moov",
    images: [
      ShopProductImage(
        url:
            "https://designwanted.com/wp-content/uploads/2022/02/Wi-Fi-routers-Rosenthal-PorceLAN.jpg",
        createdAt: "2020-01-01T00:00:00.000Z",
        updatedAt: "2020-01-01T00:00:00.000Z",
      ),
    ],
    price: 10.0,
    quantity: 10,
    category: "category 1",
    createdAt: "2020-01-01T00:00:00.000Z",
    updatedAt: "2020-01-01T00:00:00.000Z",
  )
];
