import 'package:flutter/material.dart';

class IntroSliderModel {
  String imageAssetPath;
  String title;
  String description;

  IntroSliderModel({this.imageAssetPath, this.title, this.description});

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }
}

List<IntroSliderModel> getSlides() {
  List<IntroSliderModel> slides = new List<IntroSliderModel>();
  IntroSliderModel sliderModel = new IntroSliderModel();

  //1
  sliderModel.setDescription(
      "A place offering the best laptop at best price for you.");
  sliderModel.setTitle("Welcome to Eshop");
  sliderModel.setImageAssetPath("assets/intro1.png");
  slides.add(sliderModel);

  sliderModel = new IntroSliderModel();

  //2
  sliderModel.setDescription(
      "Just click buy and we will deliver it to you as fast as posible.");
  sliderModel.setTitle("Fast, reliable, convenient shopping");
  sliderModel.setImageAssetPath("assets/intro2.png");
  slides.add(sliderModel);

  sliderModel = new IntroSliderModel();

  //3
  sliderModel.setDescription(
      "With new vouchers, you can enjoy to buy discount laptop.");
  sliderModel.setTitle("Lots of Promotion everyweek");
  sliderModel.setImageAssetPath("assets/intro3.png");
  slides.add(sliderModel);

  sliderModel = new IntroSliderModel();

  return slides;
}
