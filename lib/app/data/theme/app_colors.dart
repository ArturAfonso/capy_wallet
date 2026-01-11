import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color getTextColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  // Helper para converter os valores do CSS (H, S%, L%) para Color
  static Color hsl(double h, double s, double l) {
    return HSLColor.fromAHSL(1.0, h, s / 100, l / 100).toColor();
  }

  // ============================================
  // 🌞 LIGHT THEME - CAPY WALLET (COMFY)
  // ============================================

  // Core Colors
  static Color lightBackground = hsl(35, 30, 96);       // --background: 35 30% 96% (Creme Suave)
  static Color lightForeground = hsl(25, 20, 15);       // --foreground: 25 20% 15% (Marrom Escuro)

  static Color lightCard = hsl(35, 25, 98);             // --card: 35 25% 98%
  static Color lightCardForeground = hsl(25, 20, 15);   // --card-foreground: 25 20% 15%

  static Color lightPrimary = hsl(25, 75, 50);          // --primary: 25 75% 50% (Terracota)
  static Color lightPrimaryForeground = hsl(35, 30, 98);// --primary-foreground: 35 30% 98%

  static Color lightSecondary = hsl(85, 25, 35);        // --secondary: 85 25% 35% (Verde Oliva)
  static Color lightSecondaryForeground = hsl(85, 15, 95); // --secondary-foreground: 85 15% 95%

  static Color lightMuted = hsl(35, 20, 85);            // --muted: 35 20% 85% (Areia)
  static Color lightMutedForeground = hsl(25, 15, 40);  // --muted-foreground: 25 15% 40%

  static Color lightAccent = hsl(95, 30, 90);           // --accent: 95 30% 90% (Verde Sálvia)
  static Color lightAccentForeground = hsl(85, 35, 30); // --accent-foreground: 85 35% 30%

  static Color lightDestructive = hsl(0, 65, 50);       // --destructive: 0 65% 50%
  static Color lightDestructiveForeground = hsl(0, 0, 98);

  static Color lightBorder = hsl(35, 20, 85);           // --border: 35 20% 85%
  static Color lightInput = hsl(35, 15, 90);            // --input: 35 15% 90%
  static Color lightRing = hsl(25, 75, 50);             // --ring: 25 75% 50%

  // Crypto Specific Colors (Light)
  static Color lightBitcoin = hsl(36, 100, 50);         // --bitcoin: 36 100% 50%
  static Color lightLightning = hsl(270, 70, 55);       // --lightning: 270 70% 55%

  // Sidebar (Adaptado para o tema Capy)
  static Color lightSidebarBackground = hsl(35, 30, 96); // Mesmo do background para continuidade
  static Color lightSidebarForeground = hsl(25, 20, 15);
  static Color lightSidebarAccent = hsl(35, 25, 90);     // Um pouco mais escuro que o bg

  // ============================================
  // 🌙 DARK THEME - CAPY WALLET (COMFY DARK)
  // ============================================

  // Core Colors
  static Color darkBackground = hsl(25, 15, 10);        // --background: 25 15% 10% (Café Profundo)
  static Color darkForeground = hsl(35, 20, 95);        // --foreground: 35 20% 95% (Creme Claro)

  static Color darkCard = hsl(25, 15, 14);              // --card: 25 15% 14%
  static Color darkCardForeground = hsl(35, 20, 95);    // --card-foreground: 35 20% 95%

  static Color darkPrimary = hsl(25, 70, 55);           // --primary: 25 70% 55% (Terracota Vibrante)
  static Color darkPrimaryForeground = hsl(25, 15, 10); // --primary-foreground: 25 15% 10%

  static Color darkSecondary = hsl(85, 20, 30);         // --secondary: 85 20% 30%
  static Color darkSecondaryForeground = hsl(85, 15, 95);

  static Color darkMuted = hsl(25, 10, 25);             // --muted: 25 10% 25%
  static Color darkMutedForeground = hsl(35, 15, 70);

  static Color darkAccent = hsl(95, 20, 20);            // --accent: 95 20% 20%
  static Color darkAccentForeground = hsl(85, 35, 70);

  static Color darkDestructive = hsl(0, 60, 45);        // --destructive: 0 60% 45%
  static Color darkDestructiveForeground = hsl(0, 0, 98);

  static Color darkBorder = hsl(25, 10, 25);            // --border: 25 10% 25%
  static Color darkInput = hsl(25, 10, 20);             // --input: 25 10% 20%
  static Color darkRing = hsl(25, 70, 55);              // --ring: 25 70% 55%

  // Crypto Specific Colors (Dark)
  static Color darkBitcoin = hsl(36, 100, 50);          // --bitcoin: 36 100% 50%
  static Color darkLightning = hsl(270, 65, 60);        // --lightning: 270 65% 60%

  // Sidebar (Adaptado para Dark Mode)
  static Color darkSidebarBackground = hsl(25, 15, 10);
  static Color darkSidebarForeground = hsl(35, 20, 95);
  static Color darkSidebarAccent = hsl(25, 15, 18);

  // ============================================
  // 🔔 NOTIFICATIONS (Adaptadas para tons terrosos/suaves)
  // ============================================

  /* Light mode - Tons pastéis para manter o "Comfy" */
  static Color lightSuccess = hsl(142, 40, 90);          // Verde suave
  static Color lightSuccessForeground = hsl(142, 60, 25);
  static Color lightError = hsl(0, 40, 92);              // Vermelho pálido
  static Color lightErrorForeground = hsl(0, 60, 35);
  static Color lightInfo = hsl(210, 40, 92);             // Azul acinzentado
  static Color lightInfoForeground = hsl(210, 60, 30);
  static Color lightWarning = hsl(38, 60, 90);           // Amarelo quente
  static Color lightWarningForeground = hsl(38, 70, 30);

  /* Dark mode - Tons profundos */
  static Color darkSuccess = hsl(142, 30, 20);
  static Color darkSuccessForeground = hsl(142, 40, 80);
  static Color darkError = hsl(0, 30, 25);
  static Color darkErrorForeground = hsl(0, 40, 80);
  static Color darkInfo = hsl(210, 30, 25);
  static Color darkInfoForeground = hsl(210, 40, 80);
  static Color darkWarning = hsl(38, 30, 25);
  static Color darkWarningForeground = hsl(38, 40, 80);
}