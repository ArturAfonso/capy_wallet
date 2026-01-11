lib/
├── app/
│   ├── data/                 <-- CAMADA DE DADOS (GLOBAL)
│   │   ├── models/           
│   │   │   └── wallet_info.dart  (Seu modelo atualizado com Enum)
│   │   ├── services/         
│   │   │   ├── wallet_storage_service.dart (Gerencia CRUD de carteiras)
│   │   │   ├── bitcoin_node_service.dart   (O LDK Node - também é global!)
│   │   │   └── biometric_service.dart      (Opcional, futuro)
│   │   └── providers/        (Se tiver chamadas de API externas)
│   │
│   ├── modules/              <-- CAMADA VISUAL (TELAS)
│   │   ├── splash/
│   │   ├── onboarding/       (Criação, escolha de modo)
│   │   ├── auth/             (Aqui entra o PIN e o RecoverWallet)
│   │   │   ├── pin/          
│   │   │   └── recover/      
│   │   │
│   │   ├── home_onchain/     (Fluxo A - "O Cofre")
│   │   └── home_lightning/   (Fluxo B - "O Banco")
│   │
│   ├── routes/               (Navegação)
│   └── theme/
└── main.dart