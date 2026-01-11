import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  // ---------------------------------------------------------------------------
  // HEADINGS (Serif / EB Garamond) - Títulos, Saldos e Destaques
  // ---------------------------------------------------------------------------
  
  // Usado para o "Bem-vindo ao Capy" e Saldo Total Grande
  static TextStyle get displayLarge => GoogleFonts.ebGaramond(
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    height: 1.2,
    letterSpacing: -0.5,
    color: const Color(0xFF4A3B32), // Sugestão de cor baseada no seu tema (Terracota escuro)
  );

  // Usado para títulos de seções ("Minhas Carteiras", "Atividade Recente")
  static TextStyle get headingLarge => GoogleFonts.ebGaramond(
    fontSize: 24,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.3,
  );

  // Usado para subtítulos ou modais
  static TextStyle get headingMedium => GoogleFonts.ebGaramond(
    fontSize: 23,
    fontWeight: FontWeight.w500, // Medium
    height: 1.4,
  );

  // ---------------------------------------------------------------------------
  // BODY (Sans / Lato) - Textos Gerais, Menus e Botões
  // ---------------------------------------------------------------------------

  // Texto padrão de leitura
  static TextStyle get bodyLarge => GoogleFonts.lato(
    fontSize: 23,
    fontWeight: FontWeight.w400, // Regular
    height: 1.5,
  );

  // Texto secundário e labels
  static TextStyle get bodyMedium => GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // Legendas e textos pequenos
  static TextStyle get bodySmall => GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  // Botões (Geralmente precisam de um peso maior)
  static TextStyle get buttonLabel => GoogleFonts.lato(
    fontSize: 23,
    fontWeight: FontWeight.w700, // Bold
    height: 1.0,
  );

  // ---------------------------------------------------------------------------
  // TECH / CRYPTO (Mono / Fira Code) - Seeds, Hashes e Endereços
  // ---------------------------------------------------------------------------

  // Para mostrar as 12/24 palavras da Seed
  static TextStyle get monoSeedWord => GoogleFonts.firaCode(
    fontSize: 23,
    fontWeight: FontWeight.w500, // Medium para legibilidade
    height: 1.6,
    letterSpacing: 0.5,
  );

  // Para endereços de carteira e Hashs
  static TextStyle get monoAddress => GoogleFonts.firaCode(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
  );
  
  // Para valores numéricos em tabelas
  static TextStyle get monoValue => GoogleFonts.firaCode(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}