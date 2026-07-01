# Mirage AR

Aplicativo Flutter de visualização de modelos 3D com suporte a Realidade Aumentada (RA). Permite carregar e visualizar modelos `.glb` diretamente no ambiente real usando ARCore (Android).

---

## Pré-requisitos

Antes de executar o projeto, certifique-se de ter instalado:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) versão **3.11.0 ou superior**
- [Android Studio](https://developer.android.com/studio) com o plugin Flutter configurado
- [Android SDK](https://developer.android.com/studio) com `minSdk 24` (Android 7.0+)
- Um dispositivo físico Android com suporte a **ARCore**, ou um emulador com API 24+
- [Git](https://git-scm.com/) para clonar o repositório

---

## Instalação

**1. Clone o repositório**

```bash
git clone https://github.com/seu-usuario/mirage_ar_ofc.git
cd mirage_ar_ofc
```

**2. Instale as dependências**

```bash
flutter pub get
```

---

## Executando o projeto

**Em dispositivo físico Android (recomendado para AR)**

Conecte o dispositivo via USB com depuração USB ativada e execute:

```bash
flutter run
```

**Em emulador**

```bash
flutter emulators --launch <nome-do-emulador>
flutter run
```

> **Atenção:** a funcionalidade de Realidade Aumentada exige um dispositivo físico com ARCore. No emulador, o modelo 3D é exibido normalmente, mas o botão AR pode não funcionar.

**Gerando APK de release**

```bash
flutter build apk --release
```

O arquivo gerado ficará em `build/app/outputs/flutter-apk/app-release.apk`.

---

## Como usar o app

1. Abra o aplicativo — o modelo 3D é exibido na tela com rotação automática.
2. Use os dedos para girar e aproximar o modelo.
3. Toque no **ícone AR** (canto inferior esquerdo) para abrir o Scene Viewer e posicionar o objeto no mundo real.
4. Use os botões na parte inferior da tela para alternar entre os modelos disponíveis.

---

## Estrutura do projeto

```
mirage_ar_ofc/
├── lib/
│   └── main.dart          # Código principal do aplicativo
├── assets/
│   └── models/
│       ├── modelAR.glb    # Modelo 3D 1
│       └── modelo2.glb    # Modelo 3D 2
├── android/               # Configurações nativas Android
└── pubspec.yaml           # Dependências e configurações do projeto
```

---

## Dependências principais

| Pacote | Versão | Descrição |
|---|---|---|
| `model_viewer_plus` | ^1.10.0 | Renderização de modelos 3D e integração com ARCore |

---

## Problemas comuns

**`flutter pub get` falha**
Verifique se a versão do Flutter SDK é 3.11.0 ou superior com `flutter --version`.

**O botão AR não aparece**
O dispositivo precisa ter ARCore instalado e compatível. Verifique na [lista de dispositivos suportados pelo ARCore](https://developers.google.com/ar/devices).

**Modelo não carrega**
Confirme que os arquivos `.glb` estão presentes em `assets/models/` e declarados no `pubspec.yaml`.
