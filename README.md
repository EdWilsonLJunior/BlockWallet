<div align="center">
  <h1>BlockWallet</h1>
  <p>Carteira de criptomoedas para iOS, construída com SwiftUI.</p>

  ![Swift](https://img.shields.io/badge/Swift-6.0+-FA7343?style=flat&logo=swift&logoColor=white)
  ![iOS](https://img.shields.io/badge/iOS-18.0+-000000?style=flat&logo=apple&logoColor=white)
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
- **Dashboard** — Visão geral do saldo, ações rápidas e moedas em destaque com maior movimentação
- **Mercado** — Listagem de criptomoedas com variação de preço e acesso ao detalhe de cada ativo
- **Carteira (Wallet)** — Saldo total do portfólio em R$, lista de ativos adquiridos com quantidade, valor e variação 24h calculados a partir do histórico de transações
- **Swap** — Troca entre criptomoedas com seleção de token e confirmação de operação
- **Histórico** — Visualização de transações filtradas por tipo (Comprado / Vendido / Todos)
- **Menu** — Navegação com acesso a todas as seções do app e opção de logout

### Criptomoedas Suportadas

| Símbolo | Nome     |
|---------|----------|
| BTC     | Bitcoin  |
| ETH     | Ethereum |
| SOL     | Solana   |
| BNB     | BNB      |
| MATIC   | Polygon  |
| XRP     | XRP      |

---

## Tecnologias

| Tecnologia    | Uso                                       |
|---------------|-------------------------------------------|
| **SwiftUI**   | Construção de interfaces declarativas     |
| **SwiftData** | Persistência local de dados               |
| **Combine**   | Programação reativa nos ViewModels        |
| **URLSession**| Comunicação com a API REST                |
| **Keychain**  | Armazenamento seguro de tokens            |
| **MVVM**      | Padrão arquitetural do projeto            |

---

## Estrutura do Projeto

```
BlockWallet/
├── Models/
│   ├── CryptoCoin.swift            # Model de criptomoeda (SwiftData)
│   ├── Transaction.swift           # Model de transação (compra/venda)
│   ├── User.swift                  # Model de usuário
│   ├── Login.swift                 # Model de login
│   ├── ResponseData.swift          # Model de resposta da API
│   ├── Enums/
│   │   ├── TabBarItem.swift        # Itens da tab bar
│   │   └── MenuRoute.swift         # Rotas do menu
│   └── Responses/
│       ├── CryptoCoinResponse.swift
│       ├── CryptoCoinDetailResponse.swift
│       └── CoinChartResponse.swift
├── View/
│   ├── LoginView.swift             # Tela de login
│   ├── RegisterView.swift          # Tela de cadastro
│   ├── DashboardView.swift         # Tela principal
│   ├── MarketView.swift            # Tela de mercado
│   ├── AssetsView.swift            # Carteira — portfólio e ativos adquiridos
│   ├── SwapView.swift              # Tela de swap
│   ├── DetailCoinView.swift        # Detalhe de criptomoeda
│   ├── MenuView.swift              # Menu de navegação
│   └── Components/                 # Componentes reutilizáveis
│       ├── BottomBarView.swift
│       ├── HeaderView.swift
│       ├── WalletHeaderView.swift
│       ├── BalanceView.swift
│       ├── ActionsView.swift
│       ├── TopMoversView.swift
│       ├── TransactionHistoryView.swift
│       ├── AssetRow.swift
│       ├── CandleChartView.swift
│       ├── PriceLineChartView.swift
│       └── ...
├── ViewModels/
│   ├── DashboardViewModel.swift
│   ├── DetailCoinViewModel.swift
│   └── RegisterViewModel.swift
├── Repositories/
│   ├── CoinRepository.swift
│   ├── Local/CryptoCoinLocalService.swift
│   └── Remote/CryptoCoinService.swift
├── Services/
│   ├── KeychainService.swift       # Armazenamento seguro de tokens
│   ├── SessionManager.swift        # Gerenciamento de sessão do usuário
│   └── UserService.swift           # Serviço de autenticação
├── Utils/
│   ├── AppGradient.swift           # Gradientes globais
│   └── Constants.swift             # Constantes globais (URL da API)
└── Resources/
    └── Assets.xcassets/            # Imagens e ícones das moedas
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
| `POST` | `/api/v1/auth/sign-in` | Login com credencias|
| `POST` | `/api/v1/auth/me`      | Dados do usuário    |
| `POST` | `/api/v1/auth/sign-out`| Encerrar sessão     |
| `GET`  | `/profile`             | Retornar Perfil     |

---

## Como Executar

### Pré-requisitos

- Xcode 16.0 ou superior
- iOS 18.0+ (simulador ou dispositivo físico)
- macOS Sequoia ou superior

### Passos

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/BlockWallet.git
   ```

2. Abra o projeto no Xcode:
   ```bash
   cd BlockWallet
   open BlockWallet.xcodeproj
   ```

3. Selecione um simulador ou dispositivo iOS no Xcode.

4. Execute com `⌘ + R`.

---

## Membros

| Nome | Responsabilidade |
|------|-----------------|
| Aecio Pereira Santiago Junior                 | Backend / API   |
| Arthur Vinicius Gomes Santos Mendes Oliveira  | Backend / API   |
| Ed Wilson Luciano Junior                      | Views           |
| Jonathan Bach dos Santos                      | Views           |
| Silas Nunes Cardoso                           | Integração      |
| Wyllian Fonseca Sales                         | Integração      |

---

## Licença

Este projeto foi desenvolvido para fins acadêmicos/educacionais.
