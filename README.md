<div align="center">
  <h1>BlockWallet</h1>
  <p>Carteira de criptomoedas para iOS, construída com SwiftUI.</p>

  ![Swift](https://img.shields.io/badge/Swift-5.9+-FA7343?style=flat&logo=swift&logoColor=white)
  ![iOS](https://img.shields.io/badge/iOS-17.0+-000000?style=flat&logo=apple&logoColor=white)
  ![SwiftUI](https://img.shields.io/badge/SwiftUI-blue?style=flat&logo=swift&logoColor=white)
  ![SwiftData](https://img.shields.io/badge/SwiftData-orange?style=flat)
  ![Architecture](https://img.shields.io/badge/Architecture-MVVM-green?style=flat)
</div>

---

## Sobre o Projeto

**BlockWallet** é um aplicativo iOS de carteira de criptomoedas desenvolvido com SwiftUI. A aplicação permite que usuários acompanhem seus ativos digitais, visualizem o mercado em tempo real, realizem trocas (swap) entre criptomoedas e gerenciem sua conta de forma segura com suporte a autenticação biométrica.

---

## Funcionalidades

- **Autenticação** — Login com e-mail e senha, com opção de habilitar biometria (Face ID / Touch ID)
- **Cadastro** — Registro de novos usuários integrado à API REST
- **Dashboard** — Visão geral do saldo, ações rápidas, card de compra de cripto e moedas em destaque
- **Mercado** — Listagem de destaques, novidades e ativos com maior movimentação
- **Ativos** — Lista de criptomoedas com busca e detalhamento de cada ativo
- **Swap** — Troca entre criptomoedas com seleção de token e confirmação de operação
- **Menu** — Navegação lateral com acesso às seções do app

### Criptomoedas Suportadas

| Símbolo | Nome     |
|---------|----------|
| BTC     | Bitcoin  |
| ETH     | Ethereum |
| BNB     | BNB      |
| MATIC   | Polygon  |
| XRP     | XRP      |

---

## Tecnologias

| Tecnologia   | Uso                                       |
|--------------|-------------------------------------------|
| **SwiftUI**  | Construção de interfaces declarativas     |
| **SwiftData**| Persistência local de dados               |
| **Combine**  | Programação reativa no ViewModel          |
| **URLSession**| Comunicação com a API REST               |
| **MVVM**     | Padrão arquitetural do projeto            |

---

## Estrutura do Projeto

```
BlockWallet/
├── Models/
│   ├── Coin.swift              # Model de criptomoeda (SwiftData)
│   ├── User.swift              # Model de usuário
│   ├── ResponseData.swift      # Model de resposta da API
│   └── Enums/
│       ├── TabBarItem.swift    # Itens da tab bar
│       └── MenuRoute.swift     # Rotas do menu
├── View/
│   ├── LoginView.swift         # Tela de login
│   ├── RegisterView.swift      # Tela de cadastro
│   ├── DashboardView.swift     # Tela principal
│   ├── MarketView.swift        # Tela de mercado
│   ├── AssetsView.swift        # Tela de ativos
│   ├── SwapView.swift          # Tela de swap
│   ├── DetailCoinView.swift    # Detalhe de criptomoeda
│   ├── MenuView.swift          # Menu lateral
│   └── Components/             # Componentes reutilizáveis
├── ViewModels/
│   └── RegisterViewModel.swift # ViewModel de cadastro
├── Services/
│   └── UserService.swift       # Serviço de autenticação/usuário
├── Utils/
│   └── Constants.swift         # Constantes globais (URL da API)
└── Resources/
    └── Assets.xcassets/        # Imagens e ícones
```

---

## API

A aplicação consome uma API REST hospedada em:

```
https://blockwallet-api.onrender.com
```

| Método | Endpoint               | Descrição           |
|--------|------------------------|---------------------|
| `POST` | `/api/v1/auth/sign-up` | Cadastro de usuário |

---

## Como Executar

### Pré-requisitos

- Xcode 15.0 ou superior
- iOS 17.0+ (simulador ou dispositivo físico)
- macOS Sonoma ou superior

### Passos

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/BlockWallet.git
   ```

2. Abra o projeto no Xcode:
   ```bash
   cd BlockWallet-main
   open BlockWallet.xcodeproj
   ```

3. Selecione um simulador ou dispositivo iOS no Xcode.

4. Execute com `⌘ + R`.

---

## Membros

| Nome | Responsabilidade |
|------|-----------------|
| Aecio Pereira Santiago Junior                 |  Backend/API  |
| Arthur Vinicius Gomes Santos Mendes Oliveira  |  Backend/API  |
| Ed Wilson Luciano Junior                      |  Views        |
| Jonathan Bach dos Santos                      |               |
| Silas Nunes Cardoso                           |               |
| Wyllian Fonseca Sales                         |  Integração   |

---

## Licença

Este projeto foi desenvolvido para fins acadêmicos/educacionais.
