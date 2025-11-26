**Aplicativo Flutter profissional para gerenciamento completo de atendimentos com captura de imagens, armazenamento local e controle de status.**

[Recursos](#-recursos) • [Instalação](#-instalação) • [Arquitetura](#-arquitetura) • [Uso](#-uso) • [Testes](#-testes) • [Contribuir](#-contribuindo)

</div>

---

## 📋 Índice

- [Sobre o Projeto](#-sobre-o-projeto)
- [Recursos](#-recursos)
- [Screenshots](#-screenshots)
- [Tecnologias](#-tecnologias)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Configuração](#-configuração)
- [Uso](#-uso)
- [Arquitetura](#-arquitetura)
- [Estrutura de Pastas](#-estrutura-de-pastas)
- [Testes](#-testes)
- [Build](#-build)
- [Troubleshooting](#-troubleshooting)
- [Roadmap](#-roadmap)
- [Contribuindo](#-contribuindo)
- [Licença](#-licença)
- [Autores](#-autores)

---

## 🎯 Sobre o Projeto

O **Attendance Manager** é um aplicativo mobile desenvolvido em Flutter que permite gerenciar atendimentos de forma completa e profissional. Ideal para empresas de serviços, técnicos de campo, profissionais autônomos e equipes que precisam documentar e acompanhar seus atendimentos.

### Problema que Resolve

- ✅ Documentação fotográfica de serviços realizados
- ✅ Controle de status dos atendimentos (Pendente, Em Andamento, Finalizado)
- ✅ Histórico completo com datas e observações
- ✅ Funciona 100% offline com armazenamento local
- ✅ Interface intuitiva e moderna

### Casos de Uso

- 🔧 Técnicos de manutenção
- 🏥 Profissionais de saúde (visitas domiciliares)
- 📦 Entregas e logística
- 🏠 Serviços domésticos
- 🚗 Inspeções veiculares
- 🏗️ Obras e construção

---

## ✨ Recursos

### Funcionalidades Principais

#### 📋 Gestão de Atendimentos
- **Criar** novos atendimentos com título e descrição
- **Editar** atendimentos existentes
- **Visualizar** lista completa com filtros
- **Excluir** atendimentos (soft delete - não remove do banco)
- **Ativar/Desativar** atendimentos temporariamente

#### 🔍 Filtros e Organização
- Filtrar por status:
  - 🟠 Pendente
  - 🔵 Em Andamento
  - 🟢 Finalizado
- Visualizar todos ou apenas ativos
- Ordenação por data de criação (mais recentes primeiro)

#### 📸 Execução de Atendimentos
- **Captura de foto** direto da câmera
- **Seleção de foto** da galeria
- **Preview da imagem** antes de finalizar
- **Campo de observações** para registros detalhados
- **Validação**: obrigatório ter foto para finalizar

#### 💾 Armazenamento
- Banco de dados SQLite local
- Imagens armazenadas no filesystem do dispositivo
- Soft delete (dados nunca são perdidos permanentemente)
- Timestamps automáticos (criação, atualização, finalização)

#### 🎨 Interface
- Material Design 3
- Tema claro moderno
- Componentes responsivos
- Feedback visual para todas as ações
- Animações suaves
- Cards com informações claras

---


## 🛠️ Tecnologias

### Core
- **[Flutter](https://flutter.dev/)** 3.0+ - Framework multiplataforma
- **[Dart](https://dart.dev/)** 3.0+ - Linguagem de programação

### State Management
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** 8.1.3 - Gerenciamento de estado com Cubit
- **[equatable](https://pub.dev/packages/equatable)** 2.0.5 - Comparação de objetos

### Persistência
- **[sqflite](https://pub.dev/packages/sqflite)** 2.3.0 - SQLite para Flutter
- **[path_provider](https://pub.dev/packages/path_provider)** 2.1.1 - Acesso a diretórios do sistema
- **[path](https://pub.dev/packages/path)** 1.8.3 - Manipulação de caminhos

### Captura de Imagens
- **[image_picker](https://pub.dev/packages/image_picker)** 1.0.4 - Câmera e galeria

### Dependency Injection
- **[get_it](https://pub.dev/packages/get_it)** 7.6.4 - Service locator
- **[injectable](https://pub.dev/packages/injectable)** 2.3.2 - Geração automática de DI

### Utilitários
- **[intl](https://pub.dev/packages/intl)** 0.18.1 - Formatação de datas

### Desenvolvimento
- **[build_runner](https://pub.dev/packages/build_runner)** 2.4.6 - Geração de código
- **[injectable_generator](https://pub.dev/packages/injectable_generator)** 2.4.1 - Gerador de DI
- **[flutter_lints](https://pub.dev/packages/flutter_lints)** 3.0.0 - Regras de linting

### Testes
- **[bloc_test](https://pub.dev/packages/bloc_test)** 9.1.5 - Testes de Bloc/Cubit
- **[mocktail](https://pub.dev/packages/mocktail)** 1.0.1 - Mocking

---

## 📦 Pré-requisitos

### Software Necessário

- **Flutter SDK** >= 3.0.0
- **Dart SDK** >= 3.0.0
- **Android Studio** ou **VS Code**
- **Xcode** (apenas para iOS, no macOS)
- **Git**

### Verificar Instalação

```bash
flutter --version
dart --version
flutter doctor -v
```

### Resolva Problemas Antes de Começar

```bash
flutter doctor
```

Certifique-se de que todos os itens estão ✓ (especialmente Android toolchain e IDE).

---

## 🚀 Instalação

### 1. Clone o Repositório

```bash
git clone https://github.com/CassianoRichato/attendance-manager.git
cd attendance-manager
```

### 2. Instale as Dependências

```bash
flutter pub get
```

### 3. Gere o Código de Injeção de Dependência

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Execute o Aplicativo

```bash
# Android
flutter run

# iOS (requer macOS)
flutter run

# Web
flutter run -d chrome

# Dispositivo específico
flutter devices
flutter run -d <device-id>
```

---

## ⚙️ Configuração

### Permissões Android

O arquivo `android/app/src/main/AndroidManifest.xml` já está configurado com:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
```

#### Alterar Nome do App

**Android:** `android/app/src/main/AndroidManifest.xml`
```xml
<application android:label="Seu Nome Aqui">
```

**iOS:** `ios/Runner/Info.plist`
```xml
<key>CFBundleDisplayName</key>
<string>Seu Nome Aqui</string>
```

#### Alterar Ícone

Use o pacote [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons):

```bash
flutter pub add flutter_launcher_icons
```

---

## 📱 Uso

### Fluxo Principal

#### 1. Criar Atendimento
1. Abra o app
2. Toque no botão **+** (FAB)
3. Preencha título e descrição
4. Toque em **Salvar**

#### 2. Filtrar Atendimentos
1. Na tela inicial, use os chips de filtro:
   - **Todos** - Mostra todos os atendimentos
   - **Pendente** - Apenas pendentes
   - **Em Andamento** - Apenas em andamento
   - **Finalizado** - Apenas finalizados

#### 3. Executar Atendimento
1. Toque em um atendimento da lista
2. Escolha uma opção:
   - **Tirar Foto** - Abre a câmera
   - **Galeria** - Seleciona foto existente
3. Adicione observações (opcional)
4. Toque em **Finalizar Atendimento**

#### 4. Editar Atendimento
1. Toque no ícone ✏️ no card do atendimento
2. Modifique título ou descrição
3. Toque em **Salvar**

#### 5. Excluir Atendimento
1. Toque no ícone 🗑️ no card do atendimento
2. Confirme a exclusão
3. O atendimento é removido da lista (soft delete)

#### 6. Ativar/Desativar
1. Use o **Switch** no card do atendimento
2. Atendimentos inativos aparecem com opacidade reduzida
3. Ainda podem ser reativados a qualquer momento

---

## 🏗️ Arquitetura

O projeto segue **Clean Architecture** com separação em 3 camadas:

```
┌─────────────────────────────────────────┐
│      PRESENTATION LAYER (UI)            │
│  ┌────────────────────────────────┐     │
│  │  Screens (Flutter Widgets)     │     │
│  └────────────────────────────────┘     │
│  ┌────────────────────────────────┐     │
│  │  Cubits (State Management)     │     │
│  └────────────────────────────────┘     │
└─────────────────────────────────────────┘
                  ↓ ↑
┌─────────────────────────────────────────┐
│      DOMAIN LAYER (Business Logic)      │
│  ┌────────────────────────────────┐     │
│  │  Entities (Models)             │     │
│  └────────────────────────────────┘     │
│  ┌────────────────────────────────┐     │
│  │  Use Cases (Business Rules)    │     │
│  └────────────────────────────────┘     │
│  ┌────────────────────────────────┐     │
│  │  Repository Interfaces         │     │
│  └────────────────────────────────┘     │
└─────────────────────────────────────────┘
                  ↓ ↑
┌─────────────────────────────────────────┐
│      DATA LAYER (Data Sources)          │
│  ┌────────────────────────────────┐     │
│  │  Repository Implementations    │     │
│  └────────────────────────────────┘     │
│  ┌────────────────────────────────┐     │
│  │  Data Sources (SQLite, Files)  │     │
│  └────────────────────────────────┘     │
│  ┌────────────────────────────────┐     │
│  │  Models (Data Transfer)        │     │
│  └────────────────────────────────┘     │
└─────────────────────────────────────────┘
```

### Princípios Aplicados

- ✅ **Separation of Concerns** - Cada camada tem responsabilidade única
- ✅ **Dependency Inversion** - Camadas superiores não dependem de detalhes
- ✅ **Single Responsibility** - Uma classe, uma responsabilidade
- ✅ **Dependency Injection** - Injeção automática com GetIt/Injectable
- ✅ **Testability** - Fácil criar mocks e testar isoladamente

### Design Patterns

- **Repository Pattern** - Abstração de acesso a dados
- **Cubit Pattern** - Gerenciamento de estado simplificado
- **Use Case Pattern** - Encapsulamento de regras de negócio
- **Dependency Injection** - Inversão de controle

---

## 📂 Estrutura de Pastas

```
lib/
├── core/                           # Funcionalidades compartilhadas
│   └── injection/                  # Configuração de DI
│       ├── injection.dart          # Setup do GetIt
│       ├── injection.config.dart   # Gerado automaticamente
│       └── injection_module.dart   # Módulos customizados
│
├── data/                           # Camada de Dados
│   ├── datasources/                # Fontes de dados
│   │   ├── database_helper.dart    # SQLite setup
│   │   ├── local_data_source.dart  # Operações de DB
│   │   └── image_storage_service.dart # Gerenciamento de imagens
│   ├── models/                     # Modelos de dados
│   │   └── attendance_model.dart   # Modelo com fromMap/toMap
│   └── repositories/               # Implementações
│       └── attendance_repository_impl.dart
│
├── domain/                         # Camada de Domínio
│   ├── entities/                   # Entidades de negócio
│   │   ├── attendance.dart         # Entidade principal
│   │   └── attendance_status.dart  # Enum de status
│   ├── repositories/               # Interfaces
│   │   └── attendance_repository.dart
│   └── usecases/                   # Casos de uso
│       ├── create_attendance_usecase.dart
│       ├── delete_attendance_usecase.dart
│       ├── finish_attendance_usecase.dart
│       ├── get_attendance_by_id_usecase.dart
│       ├── get_attendances_usecase.dart
│       ├── toggle_attendance_status_usecase.dart
│       └── update_attendance_usecase.dart
│
├── presentation/                   # Camada de Apresentação
│   ├── cubits/                     # State management
│   │   ├── attendance_list/        # Lista
│   │   │   ├── attendance_list_cubit.dart
│   │   │   └── attendance_list_state.dart
│   │   ├── attendance_form/        # Formulário
│   │   │   ├── attendance_form_cubit.dart
│   │   │   └── attendance_form_state.dart
│   │   └── attendance_execution/   # Execução
│   │       ├── attendance_execution_cubit.dart
│   │       └── attendance_execution_state.dart
│   ├── screens/                    # Telas
│   │   ├── attendance_list_screen.dart
│   │   ├── attendance_form_screen.dart
│   │   └── attendance_execution_screen.dart
│   └── widgets/                    # Componentes reutilizáveis
│       ├── attendance_card.dart
│       └── status_filter_chip.dart
│
└── main.dart                       # Entry point

test/                               # Testes
├── domain/
│   └── entities/
├── data/
│   └── models/
└── presentation/
    └── cubits/
```

---

## 🧪 Testes

### Executar Todos os Testes

```bash
flutter test
```

### Testes com Coverage

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Testes Unitários

```bash
flutter test test/domain/
flutter test test/data/
```

### Testes de Widget

```bash
flutter test test/presentation/
```

### Exemplo de Teste

```dart
test('should create an attendance with required fields', () {
  final attendance = Attendance(
    title: 'Test Attendance',
    status: AttendanceStatus.pending,
    createdAt: DateTime(2024, 1, 1),
  );

  expect(attendance.title, 'Test Attendance');
  expect(attendance.status, AttendanceStatus.pending);
  expect(attendance.isActive, true);
});
```

---

## 📦 Build

### Debug Build

```bash
# Android
flutter build apk --debug

# iOS
flutter build ios --debug
```

### Release Build

#### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### Android App Bundle (Play Store)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

#### iOS
```bash
flutter build ios --release
# Depois abra no Xcode para distribuir
```

### Assinatura Android

1. Crie um keystore:
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. Configure `android/key.properties`:
```properties
storePassword=<senha>
keyPassword=<senha>
keyAlias=upload
storeFile=<caminho-do-keystore>
```

3. Build:
```bash
flutter build appbundle --release
```

---

## 🐛 Troubleshooting

### Problema: Erro ao gerar código

```bash
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Problema: "No implementation was registered"

**Causa:** Injeção de dependência não foi gerada.

**Solução:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Problema: Permissões negadas no Android

**Causa:** Usuário negou permissões de câmera/galeria.

**Solução:**
1. Vá em Configurações > Apps > Attendance Manager > Permissões
2. Habilite Câmera e Armazenamento

### Problema: Erro de pods no iOS

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter run
```

### Problema: Imagens não aparecem

**Causa:** Caminho da imagem incorreto ou arquivo deletado.

**Solução:**
1. Verifique o caminho salvo no banco
2. Confirme que o arquivo existe no filesystem
3. Confira permissões de leitura

### Problema: Build falha no Android

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### Logs e Debug

```bash
# Ver logs detalhados
flutter run -v

# Logs do Android
adb logcat

# Limpar cache do Flutter
flutter clean
```

---

## 🗺️ Roadmap

### Versão 1.1 (Em Breve)
- [ ] Sincronização com backend (Firebase/API REST)
- [ ] Login e autenticação
- [ ] Múltiplas fotos por atendimento
- [ ] Assinatura digital do cliente
- [ ] Exportar relatórios em PDF

### Versão 1.2
- [ ] Geolocalização do atendimento
- [ ] Notificações push
- [ ] Busca avançada por texto
- [ ] Filtros por data
- [ ] Estatísticas e dashboards

### Versão 2.0
- [ ] Modo offline completo com sync
- [ ] Compartilhamento de atendimentos
- [ ] Categorias personalizadas
- [ ] Temas escuro/claro
- [ ] Multi-idioma (i18n)

---

## 🤝 Contribuindo

Contribuições são muito bem-vindas! Siga estes passos:

### 1. Fork o Projeto

```bash
# Clique em "Fork" no GitHub
```

### 2. Crie uma Branch

```bash
git checkout -b feature/MinhaNovaFeature
```

### 3. Faça Commit das Mudanças

```bash
git commit -m 'feat: adiciona nova funcionalidade X'
```

### 4. Push para a Branch

```bash
git push origin feature/MinhaNovaFeature
```

### 5. Abra um Pull Request

Descreva suas mudanças detalhadamente.

### Padrão de Commits

Seguimos [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Documentação
- `style:` Formatação
- `refactor:` Refatoração de código
- `test:` Testes
- `chore:` Manutenção

### Code Review

Todos os PRs passam por revisão. Certifique-se de:

- ✅ Testes passando
- ✅ Código formatado (`dart format`)
- ✅ Sem warnings (`flutter analyze`)
- ✅ Documentação atualizada

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

---

## 👥 Autores

**Seu Nome**
- GitHub: [@seu-usuario](https://github.com/seu-usuario)
- LinkedIn: [seu-perfil](https://linkedin.com/in/seu-perfil)
- Email: seu.email@exemplo.com

---

## 🙏 Agradecimentos

- [Flutter Team](https://flutter.dev/) - Framework incrível
- [Bloc Library](https://bloclibrary.dev/) - State management
- [GetIt](https://pub.dev/packages/get_it) - Dependency injection
- [Comunidade Flutter Brasil](https://flutterbrasil.com/)

---

## 📞 Suporte

Encontrou um problema? Precisa de ajuda?

- 🐛 [Reportar Bug](https://github.com/seu-usuario/attendance-manager/issues)
- 💡 [Solicitar Feature](https://github.com/seu-usuario/attendance-manager/issues)
- 📧 Email: suporte@exemplo.com

---

<div align="center">

**Desenvolvido com ❤️ usando Flutter**

⭐ Se este projeto te ajudou, considere dar uma estrela!

</div>nd a full API reference.
