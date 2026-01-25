// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  // ============================================
  // 🌞 LIGHT THEME - CAPY WALLET (COMFY)
  // ============================================
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    
    // Mapeamento das Cores Comfy para o Material 3
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,

      primary: AppColors.lightPrimary,           // Terracota
      onPrimary: AppColors.lightPrimaryForeground, // Creme Claro

      secondary: AppColors.lightSecondary,       // Verde Oliva
      onSecondary: AppColors.lightSecondaryForeground, // Creme Claro

      tertiary: AppColors.lightAccent,           // Verde Sálvia (Accent)
      onTertiary: AppColors.lightAccentForeground, // Verde Escuro

      error: AppColors.lightDestructive,         // Vermelho Suave
      onError: AppColors.lightDestructiveForeground, // Branco

      surface: AppColors.lightCard,              // Creme Card
      onSurface: AppColors.lightCardForeground,  // Marrom Escuro

      outline: AppColors.lightBorder,            // Borda Areia
      surfaceContainerHighest: AppColors.lightInput, // Fundo de Input
      onSurfaceVariant: AppColors.lightMutedForeground, // Texto Muted (Placeholder)
    ),

    // Estilo dos Botões Principais (Terracota)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.lightPrimaryForeground,
        elevation: 0, // Flat design é mais "comfy"
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: AppTextStyles.buttonLabel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Bem arredondado (Capy style)
        ),
      ),
    ),

    // AppBar Limpa e Integrada ao Fundo
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackground, // Mesma cor do fundo
      foregroundColor: AppColors.lightForeground,
      surfaceTintColor: Colors.transparent, // Remove o tint roxo padrão do M3
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.headingMedium.copyWith(
        color: AppColors.lightForeground,
      ),
      iconTheme: IconThemeData(
        color: AppColors.lightForeground,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Ícones escuros
        statusBarBrightness: Brightness.light, // iOS
        systemNavigationBarColor: AppColors.lightBackground,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),

    scaffoldBackgroundColor: AppColors.lightBackground, // Creme Suave (#FDF5E6)

    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 2,
      shadowColor: AppColors.lightForeground.withOpacity(0.05), // Sombra muito suave
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.lightBorder, width: 1), // Borda sutil
      ),
    ),

    // Inputs (Campos de Texto)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightInput,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.lightPrimary, width: 1.5),
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.lightMutedForeground,
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: AppColors.lightPrimaryForeground,
      elevation: 4,
      shape: const CircleBorder(),
    ),

  
  );

  // ============================================
  // 🌙 DARK THEME - CAPY WALLET (COMFY DARK)
  // ============================================
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,

      primary: AppColors.darkPrimary,            // Terracota Vibrante
      onPrimary: AppColors.darkPrimaryForeground,// Café Escuro

      secondary: AppColors.darkSecondary,        // Verde Oliva Escuro
      onSecondary: AppColors.darkSecondaryForeground, // Creme

      tertiary: AppColors.darkAccent,            // Verde Sálvia Escuro
      onTertiary: AppColors.darkAccentForeground,

      error: AppColors.darkDestructive,
      onError: AppColors.darkDestructiveForeground,

      surface: AppColors.darkCard,               // Cinza Café
      onSurface: AppColors.darkCardForeground,   // Creme

      outline: AppColors.darkBorder,
      surfaceContainerHighest: AppColors.darkInput,
      onSurfaceVariant: AppColors.darkMutedForeground,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkPrimaryForeground,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: AppTextStyles.buttonLabel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkForeground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.headingMedium.copyWith(
        color: AppColors.darkForeground,
      ),
      iconTheme: IconThemeData(
        color: AppColors.darkForeground,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Ícones claros
        statusBarBrightness: Brightness.dark, // iOS
        systemNavigationBarColor: AppColors.darkBackground,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),

    scaffoldBackgroundColor: AppColors.darkBackground, // Café Profundo

    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 0, // No dark mode, bordas funcionam melhor que sombras
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.darkBorder, width: 1),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInput,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: AppColors.darkPrimary, width: 1.5),
      ),
      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.darkMutedForeground,
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.darkPrimaryForeground,
      elevation: 4,
      shape: const CircleBorder(),
    ),

     textTheme: ThemeData.light().textTheme.apply(
    bodyColor: AppColors.lightForeground.withOpacity(0.7),
    displayColor: AppColors.lightForeground.withOpacity(0.7),
    
  ),
  );
}