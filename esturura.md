

lib/
├── app/
│   ├── data/
│   │   ├── models/           # WalletInfo, TransactionModel, etc.
│   │   ├── providers/        # API calls (se houver), LDK Service
│   │   ├── services/         # StorageService, BiometricService
│   │   └── repositories/     # Abstração de dados
│   │
│   ├── modules/
│   │   ├── splash/           # Decide para onde ir (OnChain ou Lightning)
│   │   ├── onboarding/       # Criação de seed + Escolha do Modo
│   │   │
│   │   ├── home_onchain/     # MÓDULO A (Cenário Simplificado)
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/        # Visual "Cofre", lista simples, botão enviar/receber
│   │   │
│   │   ├── home_lightning/   # MÓDULO B (Cenário Completo)
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   └── views/        # Visual "Dashboard", Abas (Cofre vs Lightning), Canais
│   │   │
│   │   └── shared/           # Widgets reutilizáveis (Botões, Inputs, QrCodeScanner)
│   │
│   ├── routes/
│   │   ├── app_pages.dart    # Mapa de rotas
│   │   └── app_routes.dart   # Nomes das rotas (/home-onchain, /home-lightning)
│   │
│   └── theme/                # Cores, Estilos (Baseado no Lovable)
└── main.dart