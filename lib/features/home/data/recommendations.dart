import 'package:flutter/material.dart';
import 'package:meditation_app/features/home/model/recommendation_model.dart';

class RecommendationsData {
  static RecommendationModel mindfulMoments = RecommendationModel(
    title: 'Momen Penuh Kesadaran',
    color: Colors.blue,
    duration: '10 - 20 menit',
    slogan:
        "Bangunkan kesadaran Anda dan sadari pikiran, emosi, serta sensasi Anda di saat ini.",
    author: "Dr. Sarah Mitchell",
    season: "assets/audio/Summer.mp3",
  );

  static RecommendationModel zenHarmony = RecommendationModel(
    title: 'Harmoni Zen',
    color: Colors.green,
    duration: '15 - 20 menit',
    slogan:
        "Temukan kedamaian batin dan keseimbangan melalui aliran napas dan kesadaran tubuh yang harmonis.",
    author: "Master Kenji Yamamoto",
    season: "assets/audio/Summer.mp3",
  );

  static RecommendationModel serenitySessions = RecommendationModel(
    title: 'Sesi Ketenangan',
    color: Colors.purple,
    duration: '20 - 25 menit',
    slogan:
        "Celupkan diri Anda dalam visualisasi terpandu untuk menemukan ketenangan dan keheningan batin yang mendalam.",
    author: "Elena Rodriguez",
    season: "assets/audio/Summer.mp3",
  );

  static RecommendationModel calmOasis = RecommendationModel(
    title: 'Oasis Tenang',
    color: Colors.brown,
    duration: '10 - 15 menit',
    slogan:
        "Masuki tempat suci pribadi Anda untuk meremajakan pikiran, tubuh, dan jiwa dengan sempurna.",
    author: "Michael Chen",
    season: "assets/audio/Summer.mp3",
  );

  static RecommendationModel eternalBliss = RecommendationModel(
    title: 'Kebahagiaan Abadi',
    color: Colors.pink,
    duration: '25 - 30 menit',
    slogan:
        "Rasakan kegembiraan transendental saat Anda terhubung dalam dengan diri sejati dan esensi Anda.",
    author: "Sophie Williams",
    season: "assets/audio/Summer.mp3",
  );

  static RecommendationModel tranquilSunset = RecommendationModel(
    title: 'Matahari Terbenam Tenang',
    color: Colors.orange,
    duration: '15 - 20 menit',
    slogan:
        "Bersantai dan lepaskan ketegangan dalam cahaya emas yang hangat dari pengalaman meditasi matahari terbenam.",
    author: "Aiden Thompson",
    season: "assets/audio/Summer.mp3",
  );

  static RecommendationModel deepRelaxation = RecommendationModel(
    title: 'Relaksasi Mendalam',
    color: Colors.cyan,
    duration: '20 - 30 menit',
    slogan:
        "Lepaskan ketegangan dan stres melalui relaksasi otot progresif dan meditasi terpandu yang menenangkan.",
    author: "Dr. Lisa Chen",
    season: "assets/audio/Summer.mp3",
  );

  static RecommendationModel morningVitality = RecommendationModel(
    title: 'Vitalitas Pagi',
    color: Colors.teal,
    duration: '10 - 15 menit',
    slogan:
        "Mulai hari Anda dengan teknik pernapasan dan meditasi yang memberikan energi untuk meningkatkan fokus dan kejelasan.",
    author: "James Wilson",
    season: "assets/audio/winter.mp3",
  );

  static List<RecommendationModel> all = [
    mindfulMoments,
    zenHarmony,
    serenitySessions,
    calmOasis,
    eternalBliss,
    tranquilSunset,
    deepRelaxation,
    morningVitality,
  ];
}